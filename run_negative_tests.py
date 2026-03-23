#!/usr/bin/env python3
import argparse
import ast
import importlib.util
import json
import multiprocessing
import signal
import sys
import traceback
from pathlib import Path


if hasattr(sys, "set_int_max_str_digits"):
    sys.set_int_max_str_digits(0)


def load_module(module_path: Path, module_name: str):
    spec = importlib.util.spec_from_file_location(module_name, module_path)
    if spec is None or spec.loader is None:
        raise RuntimeError(f"Failed to load module from {module_path}")
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


def parse_range(range_expr: str):
    if ":" not in range_expr:
        raise ValueError("Range must use the form a:b")
    start_text, end_text = range_expr.split(":", 1)
    if not start_text or not end_text:
        raise ValueError("Range must use the form a:b")
    start = int(start_text)
    end = int(end_text)
    if start < 0 or end < start:
        raise ValueError("Range must satisfy 0 <= a <= b")
    return start, end


def select_indices(total: int, range_expr: str | None, explicit_indices: list[int] | None):
    if range_expr and explicit_indices:
        raise ValueError("Use either --range or --idx, not both")
    if explicit_indices:
        seen = set()
        ordered = []
        for idx in explicit_indices:
            if idx < 0 or idx >= total:
                raise IndexError(f"Index out of range: {idx}")
            if idx not in seen:
                seen.add(idx)
                ordered.append(idx)
        return ordered
    if range_expr:
        start, end = parse_range(range_expr)
        if end > total:
            raise IndexError(f"Range end {end} exceeds dataset size {total}")
        return list(range(start, end))
    return list(range(total))


def available_generated_indices(output_dir: Path):
    indices = []
    for path in output_dir.glob("HumanEval_*.py"):
        suffix = path.stem.split("_", 1)[-1]
        if suffix.isdigit():
            indices.append(int(suffix))
    return sorted(set(indices))


def list_timestamped_runs(root: Path):
    if not root.exists():
        return []
    dirs = [path for path in root.iterdir() if path.is_dir() and not path.name.startswith("__")]
    return sorted(dirs, key=lambda path: path.name)


def infer_latest_output_dir(output_root: Path):
    runs = list_timestamped_runs(output_root)
    if not runs:
        raise FileNotFoundError(f"No generated output directories found under {output_root}")
    return runs[-1]


def infer_report_dir(report_root: Path, output_dir: Path):
    return report_root / output_dir.name


def load_cases(task: dict):
    test_globals = {}
    exec(task["test"], test_globals)
    mod = ast.parse(task["test"])
    check_func = next(
        (node for node in mod.body if isinstance(node, ast.FunctionDef) and node.name == "check"),
        None,
    )
    if check_func is None:
        raise RuntimeError(f"Missing check(candidate) for {task['task_id']}")
    inputs = None
    for node in check_func.body:
        if not isinstance(node, ast.Assign) or len(node.targets) != 1:
            continue
        target = node.targets[0]
        if isinstance(target, ast.Name) and target.id == "inputs":
            inputs = ast.literal_eval(node.value)
            break
    if inputs is None:
        raise RuntimeError(f"Missing inputs in check(candidate) for {task['task_id']}")
    return inputs


def normalize_args(inp):
    if isinstance(inp, list):
        return tuple(inp)
    if isinstance(inp, tuple):
        return inp
    return (inp,)


def safe_call(fn, args):
    try:
        return True, fn(*args)
    except Exception as exc:
        return False, {
            "error_type": type(exc).__name__,
            "error": str(exc),
            "traceback": traceback.format_exc(),
        }


class CallTimeout(Exception):
    pass


def _alarm_handler(signum, frame):
    raise CallTimeout()


def safe_call_with_timeout(fn, args, call_timeout: int):
    if call_timeout <= 0:
        return safe_call(fn, args)
    previous = signal.getsignal(signal.SIGALRM)
    signal.signal(signal.SIGALRM, _alarm_handler)
    try:
        signal.alarm(call_timeout)
        return safe_call(fn, args)
    except CallTimeout:
        return False, {
            "error_type": "CallTimeout",
            "error": f"call exceeded {call_timeout}s",
            "traceback": None,
            "timed_out": True,
        }
    finally:
        signal.alarm(0)
        signal.signal(signal.SIGALRM, previous)


def evaluate_spec(module, args, output, spec_call_timeout: int):
    if not hasattr(module, "precondition") or not hasattr(module, "postcondition"):
        return {
            "status": "failed",
            "failure_type": "missing_spec_functions",
            "details": "Generated module is missing precondition or postcondition",
        }

    pre_ok_result, pre_value = safe_call_with_timeout(module.precondition, args, spec_call_timeout)
    if not pre_ok_result:
        if pre_value.get("timed_out"):
            return {
                "status": "failed",
                "failure_type": "precondition_call_timeout",
                "details": pre_value["error"],
            }
        return {
            "status": "failed",
            "failure_type": "precondition_evaluation_error",
            "details": f"{pre_value['error_type']}: {pre_value['error']}",
            "traceback": pre_value["traceback"],
        }
    pre_ok = bool(pre_value)

    post_ok_result, post_value = safe_call_with_timeout(
        lambda *call_args: module.postcondition(*call_args, output=output),
        args,
        spec_call_timeout,
    )
    if not post_ok_result:
        if post_value.get("timed_out"):
            return {
                "status": "failed",
                "failure_type": "postcondition_call_timeout",
                "details": post_value["error"],
                "precondition_result": pre_ok,
            }
        return {
            "status": "failed",
            "failure_type": "postcondition_evaluation_error",
            "details": f"{post_value['error_type']}: {post_value['error']}",
            "traceback": post_value["traceback"],
            "precondition_result": pre_ok,
        }
    post_ok = bool(post_value)

    if pre_ok and not post_ok:
        return {
            "status": "passed",
            "failure_type": "killed_mutation",
            "precondition_result": True,
            "postcondition_result": False,
        }
    if not pre_ok and not post_ok:
        return {
            "status": "failed",
            "failure_type": "precondition_failed_then_postcondition_failed",
            "precondition_result": False,
            "postcondition_result": False,
        }
    if pre_ok and post_ok:
        return {
            "status": "failed",
            "failure_type": "postcondition_survived",
            "precondition_result": True,
            "postcondition_result": True,
        }
    return {
        "status": "failed",
        "failure_type": "precondition_failed_but_postcondition_passed",
        "precondition_result": False,
        "postcondition_result": True,
    }


def describe_failure(case_report: dict):
    failure_type = case_report.get("failure_type", "unknown")
    if failure_type == "killed_mutation":
        return "precondition passed and postcondition rejected the mutated output"
    if failure_type == "precondition_failed_then_postcondition_failed":
        return "both precondition and postcondition failed, so the mutation was not killed by postcondition alone"
    if failure_type == "precondition_failed_but_postcondition_passed":
        return "precondition failed but postcondition passed on the mutated output"
    if failure_type == "postcondition_survived":
        return "precondition passed and postcondition also passed, so the mutation survived"
    if failure_type == "mutation_runtime_error":
        return "mutation implementation raised an exception before spec checking; this still counts as a killed mutation"
    if failure_type == "original_runtime_error":
        return "original implementation raised an exception before comparison"
    if failure_type == "precondition_evaluation_error":
        return "precondition raised an exception while checking the mutated output"
    if failure_type == "postcondition_evaluation_error":
        return "postcondition raised an exception while checking the mutated output"
    if failure_type == "precondition_call_timeout":
        return "precondition exceeded the configured per-call timeout"
    if failure_type == "postcondition_call_timeout":
        return "postcondition exceeded the configured per-call timeout"
    if failure_type == "mutation_syntax_error":
        return "mutation file has a syntax error"
    if failure_type == "mutation_load_error":
        return "mutation file failed to load"
    if failure_type == "missing_mutation_entry_point":
        return "mutation file is missing the expected entry point"
    if failure_type == "mutation_call_timeout":
        return "mutation call exceeded the configured per-call timeout; mutation skipped"
    if failure_type == "original_call_timeout":
        return "original call exceeded the configured per-call timeout; mutation skipped"
    return failure_type


def run_negative_case(module, original_func, mutation_func, args, case_index, mutation_path: Path, impl_call_timeout: int, spec_call_timeout: int):
    original_ok, original_value = safe_call_with_timeout(original_func, args, impl_call_timeout)
    mutation_ok, mutation_value = safe_call_with_timeout(mutation_func, args, impl_call_timeout)

    if not original_ok and original_value.get("timed_out"):
        return {
            "status": "skipped",
            "failure_type": "original_call_timeout",
            "case_index": case_index,
            "input": list(args),
            "mutation_file": str(mutation_path),
            "details": original_value["error"],
        }

    if not mutation_ok and mutation_value.get("timed_out"):
        return {
            "status": "skipped",
            "failure_type": "mutation_call_timeout",
            "case_index": case_index,
            "input": list(args),
            "mutation_file": str(mutation_path),
            "details": mutation_value["error"],
        }

    if not original_ok:
        return {
            "status": "failed",
            "failure_type": "original_runtime_error",
            "case_index": case_index,
            "input": list(args),
            "mutation_file": str(mutation_path),
            "details": original_value["error"],
            "traceback": original_value["traceback"],
        }

    if not mutation_ok:
        return {
            "status": "passed",
            "failure_type": "mutation_runtime_error",
            "case_index": case_index,
            "input": list(args),
            "mutation_file": str(mutation_path),
            "original_output": original_value,
            "details": mutation_value["error"],
            "traceback": mutation_value["traceback"],
        }

    if mutation_value == original_value:
        return None

    spec_eval = evaluate_spec(module, args, mutation_value, spec_call_timeout)
    report = {
        "status": spec_eval["status"],
        "failure_type": spec_eval["failure_type"],
        "case_index": case_index,
        "input": list(args),
        "mutation_file": str(mutation_path),
        "original_output": original_value,
        "mutation_output": mutation_value,
    }
    if "details" in spec_eval:
        report["details"] = spec_eval["details"]
    if "traceback" in spec_eval:
        report["traceback"] = spec_eval["traceback"]
    if "precondition_result" in spec_eval:
        report["precondition_result"] = spec_eval["precondition_result"]
    if "postcondition_result" in spec_eval:
        report["postcondition_result"] = spec_eval["postcondition_result"]
    return report


def run_task(task: dict, output_dir: Path, mutation_root: Path, impl_call_timeout: int, spec_call_timeout: int):
    task_name = task["task_id"].replace("/", "_")
    module_path = output_dir / f"{task_name}.py"
    mutation_dir = mutation_root / task_name
    if not module_path.exists():
        return {
            "task_id": task["task_id"],
            "task_name": task_name,
            "status": "failed",
            "failure_type": "missing_generated_file",
            "module_path": str(module_path),
            "mutation_dir": str(mutation_dir),
            "passed_cases": 0,
            "failed_cases": 0,
            "total_cases": 0,
            "accuracy": 0.0,
            "same_output_cases": 0,
            "mutation_files": 0,
            "syntax_correct": False,
            "spec_correct": False,
        }

    if not mutation_dir.exists():
        return {
            "task_id": task["task_id"],
            "task_name": task_name,
            "status": "failed",
            "failure_type": "missing_mutation_dir",
            "module_path": str(module_path),
            "mutation_dir": str(mutation_dir),
            "passed_cases": 0,
            "failed_cases": 0,
            "total_cases": 0,
            "accuracy": 0.0,
            "same_output_cases": 0,
            "mutation_files": 0,
            "syntax_correct": False,
            "spec_correct": False,
        }

    try:
        module = load_module(module_path, f"negative_generated_{task_name}")
    except SyntaxError as exc:
        return {
            "task_id": task["task_id"],
            "task_name": task_name,
            "status": "failed",
            "failure_type": "syntax_error",
            "module_path": str(module_path),
            "mutation_dir": str(mutation_dir),
            "details": f"{type(exc).__name__}: {exc}",
            "traceback": traceback.format_exc(),
            "passed_cases": 0,
            "failed_cases": 0,
            "total_cases": 0,
            "accuracy": 0.0,
            "same_output_cases": 0,
            "mutation_files": len(list(mutation_dir.glob('mutation_*.py'))),
            "syntax_correct": False,
            "spec_correct": False,
        }
    except Exception as exc:
        return {
            "task_id": task["task_id"],
            "task_name": task_name,
            "status": "failed",
            "failure_type": "module_load_error",
            "module_path": str(module_path),
            "mutation_dir": str(mutation_dir),
            "details": f"{type(exc).__name__}: {exc}",
            "traceback": traceback.format_exc(),
            "passed_cases": 0,
            "failed_cases": 0,
            "total_cases": 0,
            "accuracy": 0.0,
            "same_output_cases": 0,
            "mutation_files": len(list(mutation_dir.glob('mutation_*.py'))),
            "syntax_correct": False,
            "spec_correct": False,
        }

    original_path = mutation_dir / "original.py"
    if not original_path.exists():
        return {
            "task_id": task["task_id"],
            "task_name": task_name,
            "status": "failed",
            "failure_type": "missing_original_impl",
            "module_path": str(module_path),
            "mutation_dir": str(mutation_dir),
            "passed_cases": 0,
            "failed_cases": 0,
            "total_cases": 0,
            "accuracy": 0.0,
            "same_output_cases": 0,
            "mutation_files": len(list(mutation_dir.glob('mutation_*.py'))),
            "syntax_correct": True,
            "spec_correct": False,
        }

    try:
        original_module = load_module(original_path, f"negative_original_{task_name}")
    except SyntaxError as exc:
        return {
            "task_id": task["task_id"],
            "task_name": task_name,
            "status": "failed",
            "failure_type": "original_syntax_error",
            "module_path": str(module_path),
            "mutation_dir": str(mutation_dir),
            "details": f"{type(exc).__name__}: {exc}",
            "traceback": traceback.format_exc(),
            "passed_cases": 0,
            "failed_cases": 0,
            "total_cases": 0,
            "accuracy": 0.0,
            "same_output_cases": 0,
            "mutation_files": len(list(mutation_dir.glob('mutation_*.py'))),
            "syntax_correct": False,
            "spec_correct": False,
        }

    original_func = getattr(original_module, task["entry_point"], None)
    if original_func is None:
        return {
            "task_id": task["task_id"],
            "task_name": task_name,
            "status": "failed",
            "failure_type": "missing_original_entry_point",
            "module_path": str(module_path),
            "mutation_dir": str(mutation_dir),
            "entry_point": task["entry_point"],
            "passed_cases": 0,
            "failed_cases": 0,
            "total_cases": 0,
            "accuracy": 0.0,
            "same_output_cases": 0,
            "mutation_files": len(list(mutation_dir.glob('mutation_*.py'))),
            "syntax_correct": True,
            "spec_correct": False,
        }

    try:
        inputs = load_cases(task)
    except Exception as exc:
        return {
            "task_id": task["task_id"],
            "task_name": task_name,
            "status": "failed",
            "failure_type": "unsupported_test_structure",
            "module_path": str(module_path),
            "mutation_dir": str(mutation_dir),
            "details": f"{type(exc).__name__}: {exc}",
            "traceback": traceback.format_exc(),
            "passed_cases": 0,
            "failed_cases": 0,
            "total_cases": 0,
            "accuracy": 0.0,
            "same_output_cases": 0,
            "mutation_files": len(list(mutation_dir.glob('mutation_*.py'))),
            "syntax_correct": True,
            "spec_correct": False,
        }

    mutation_paths = sorted(mutation_dir.glob("mutation_*.py"))
    first_failure = None
    passed_cases = 0
    failed_cases = 0
    same_output_cases = 0
    failure_breakdown = {}
    mutation_reports = []
    task_failure_examples = []

    for mutation_path in mutation_paths:
        try:
            mutation_module = load_module(
                mutation_path,
                f"negative_mutation_{task_name}_{mutation_path.stem}",
            )
        except SyntaxError as exc:
            failure = {
                "status": "failed",
                "failure_type": "mutation_syntax_error",
                "mutation_file": str(mutation_path),
                "details": f"{type(exc).__name__}: {exc}",
                "traceback": traceback.format_exc(),
            }
            failure["reason"] = describe_failure(failure)
            failure_breakdown[failure["failure_type"]] = failure_breakdown.get(failure["failure_type"], 0) + 1
            if first_failure is None:
                first_failure = failure
            failed_cases += 1
            if len(task_failure_examples) < 10:
                task_failure_examples.append(failure)
            mutation_reports.append(
                {
                    "mutation_file": str(mutation_path),
                    "status": "failed",
                    "failure_type": failure["failure_type"],
                    "passed_cases": 0,
                    "failed_cases": 1,
                    "total_cases": 1,
                    "different_output_cases": 1,
                    "same_output_cases": 0,
                    "accuracy": 0.0,
                    "first_failure": failure,
                    "failure_examples": [failure],
                }
            )
            continue
        except Exception as exc:
            failure = {
                "status": "failed",
                "failure_type": "mutation_load_error",
                "mutation_file": str(mutation_path),
                "details": f"{type(exc).__name__}: {exc}",
                "traceback": traceback.format_exc(),
            }
            failure["reason"] = describe_failure(failure)
            failure_breakdown[failure["failure_type"]] = failure_breakdown.get(failure["failure_type"], 0) + 1
            if first_failure is None:
                first_failure = failure
            failed_cases += 1
            if len(task_failure_examples) < 10:
                task_failure_examples.append(failure)
            mutation_reports.append(
                {
                    "mutation_file": str(mutation_path),
                    "status": "failed",
                    "failure_type": failure["failure_type"],
                    "passed_cases": 0,
                    "failed_cases": 1,
                    "total_cases": 1,
                    "different_output_cases": 1,
                    "same_output_cases": 0,
                    "accuracy": 0.0,
                    "first_failure": failure,
                    "failure_examples": [failure],
                }
            )
            continue

        mutation_func = getattr(mutation_module, task["entry_point"], None)
        if mutation_func is None:
            failure = {
                "status": "failed",
                "failure_type": "missing_mutation_entry_point",
                "mutation_file": str(mutation_path),
                "entry_point": task["entry_point"],
            }
            failure["reason"] = describe_failure(failure)
            failure_breakdown[failure["failure_type"]] = failure_breakdown.get(failure["failure_type"], 0) + 1
            if first_failure is None:
                first_failure = failure
            failed_cases += 1
            if len(task_failure_examples) < 10:
                task_failure_examples.append(failure)
            mutation_reports.append(
                {
                    "mutation_file": str(mutation_path),
                    "status": "failed",
                    "failure_type": failure["failure_type"],
                    "passed_cases": 0,
                    "failed_cases": 1,
                    "total_cases": 1,
                    "different_output_cases": 1,
                    "same_output_cases": 0,
                    "accuracy": 0.0,
                    "first_failure": failure,
                    "failure_examples": [failure],
                }
            )
            continue

        mutation_passed_cases = 0
        mutation_failed_cases = 0
        mutation_same_output_cases = 0
        mutation_failure_breakdown = {}
        mutation_first_failure = None
        mutation_failure_examples = []
        mutation_skipped = False
        mutation_skip_reason = None
        for case_index, inp in enumerate(inputs):
            args = normalize_args(inp)
            case_report = run_negative_case(
                module,
                original_func,
                mutation_func,
                args,
                case_index,
                mutation_path,
                impl_call_timeout,
                spec_call_timeout,
            )
            if case_report is None:
                same_output_cases += 1
                mutation_same_output_cases += 1
                continue
            if case_report["status"] == "skipped":
                mutation_skipped = True
                mutation_skip_reason = case_report
                break
            if case_report["status"] == "passed":
                passed_cases += 1
                mutation_passed_cases += 1
            else:
                case_report["reason"] = describe_failure(case_report)
                failed_cases += 1
                mutation_failed_cases += 1
                if first_failure is None:
                    first_failure = case_report
                if mutation_first_failure is None:
                    mutation_first_failure = case_report
                if len(mutation_failure_examples) < 3:
                    mutation_failure_examples.append(case_report)
                if len(task_failure_examples) < 10:
                    task_failure_examples.append(case_report)
            failure_type = case_report["failure_type"]
            failure_breakdown[failure_type] = failure_breakdown.get(failure_type, 0) + 1
            mutation_failure_breakdown[failure_type] = mutation_failure_breakdown.get(failure_type, 0) + 1

        if mutation_skipped:
            mutation_reports.append(
                {
                    "mutation_file": str(mutation_path),
                    "status": "skipped",
                    "failure_type": mutation_skip_reason["failure_type"],
                    "skip_reason": mutation_skip_reason,
                    "passed_cases": 0,
                    "failed_cases": 0,
                    "total_cases": 0,
                    "different_output_cases": 0,
                    "same_output_cases": mutation_same_output_cases,
                    "accuracy": None,
                }
            )
            continue

        mutation_total_cases = mutation_passed_cases + mutation_failed_cases
        mutation_report = {
            "mutation_file": str(mutation_path),
            "status": "passed" if mutation_failed_cases == 0 else "failed",
            "passed_cases": mutation_passed_cases,
            "failed_cases": mutation_failed_cases,
            "total_cases": mutation_total_cases,
            "different_output_cases": mutation_total_cases,
            "same_output_cases": mutation_same_output_cases,
            "accuracy": (
                mutation_passed_cases / mutation_total_cases
                if mutation_total_cases
                else None
            ),
            "failure_breakdown": mutation_failure_breakdown,
        }
        if mutation_first_failure is not None:
            mutation_report["failure_type"] = mutation_first_failure["failure_type"]
            mutation_report["first_failure"] = mutation_first_failure
        if mutation_failure_examples:
            mutation_report["failure_examples"] = mutation_failure_examples
        mutation_reports.append(mutation_report)

    total_cases = passed_cases + failed_cases
    report = {
        "task_id": task["task_id"],
        "task_name": task_name,
        "status": "passed" if failed_cases == 0 else "failed",
        "module_path": str(module_path),
        "mutation_dir": str(mutation_dir),
        "entry_point": task["entry_point"],
        "passed_cases": passed_cases,
        "failed_cases": failed_cases,
        "total_cases": total_cases,
        "different_output_cases": total_cases,
        "accuracy": (passed_cases / total_cases) if total_cases else 1.0,
        "same_output_cases": same_output_cases,
        "mutation_files": len(mutation_paths),
        "syntax_correct": True,
        "spec_correct": failed_cases == 0,
        "negative_cases_found": total_cases,
        "failure_breakdown": failure_breakdown,
        "mutations": mutation_reports,
        "skipped_mutations": sum(1 for item in mutation_reports if item.get("status") == "skipped"),
    }
    if first_failure is not None:
        report["failure_type"] = first_failure["failure_type"]
        report["first_failure"] = first_failure
    if task_failure_examples:
        report["failure_examples"] = task_failure_examples
    return report


def _run_task_worker(conn, task, output_dir_str, mutation_root_str, impl_call_timeout, spec_call_timeout):
    try:
        report = run_task(
            task,
            Path(output_dir_str),
            Path(mutation_root_str),
            impl_call_timeout,
            spec_call_timeout,
        )
    except Exception as exc:
        report = {
            "task_id": task["task_id"],
            "task_name": task["task_id"].replace("/", "_"),
            "status": "failed",
            "failure_type": "worker_error",
            "module_path": str(Path(output_dir_str) / f"{task['task_id'].replace('/', '_')}.py"),
            "mutation_dir": str(Path(mutation_root_str) / task["task_id"].replace("/", "_")),
            "passed_cases": 0,
            "failed_cases": 0,
            "total_cases": 0,
            "accuracy": 0.0,
            "same_output_cases": 0,
            "mutation_files": 0,
            "syntax_correct": False,
            "spec_correct": False,
            "details": f"{type(exc).__name__}: {exc}",
            "traceback": traceback.format_exc(),
        }
    try:
        conn.send(report)
    finally:
        conn.close()


def run_task_with_timeout(
    task: dict,
    output_dir: Path,
    mutation_root: Path,
    task_timeout: int,
    impl_call_timeout: int,
    spec_call_timeout: int,
):
    ctx = multiprocessing.get_context("fork")
    parent_conn, child_conn = ctx.Pipe(duplex=False)
    proc = ctx.Process(
        target=_run_task_worker,
        args=(
            child_conn,
            task,
            str(output_dir),
            str(mutation_root),
            impl_call_timeout,
            spec_call_timeout,
        ),
    )
    proc.start()
    child_conn.close()
    proc.join(None if task_timeout <= 0 else task_timeout)
    if task_timeout > 0 and proc.is_alive():
        proc.terminate()
        proc.join()
        parent_conn.close()
        return {
            "task_id": task["task_id"],
            "task_name": task["task_id"].replace("/", "_"),
            "status": "failed",
            "failure_type": "task_timeout",
            "module_path": str(output_dir / f"{task['task_id'].replace('/', '_')}.py"),
            "mutation_dir": str(mutation_root / task["task_id"].replace("/", "_")),
            "passed_cases": 0,
            "failed_cases": 0,
            "total_cases": 0,
            "accuracy": 0.0,
            "same_output_cases": 0,
            "mutation_files": 0,
            "syntax_correct": True,
            "spec_correct": False,
            "details": f"Task exceeded time limit of {task_timeout}s",
        }
    if parent_conn.poll():
        report = parent_conn.recv()
        parent_conn.close()
        return report
    parent_conn.close()
    return {
        "task_id": task["task_id"],
        "task_name": task["task_id"].replace("/", "_"),
        "status": "failed",
        "failure_type": "worker_no_result",
        "module_path": str(output_dir / f"{task['task_id'].replace('/', '_')}.py"),
        "mutation_dir": str(mutation_root / task["task_id"].replace("/", "_")),
        "passed_cases": 0,
        "failed_cases": 0,
        "total_cases": 0,
        "accuracy": 0.0,
        "same_output_cases": 0,
        "mutation_files": 0,
        "syntax_correct": False,
        "spec_correct": False,
        "details": "Worker exited without producing a report",
    }


def write_report(report_dir: Path, report: dict):
    report_path = report_dir / f"{report['task_name']}.json"
    report_path.write_text(
        json.dumps(report, ensure_ascii=False, indent=2, default=str) + "\n",
        encoding="utf-8",
    )


def report_filename_for_index(idx: int) -> str:
    return f"HumanEval_{idx}.json"


def aggregate_reports(report_dir: Path):
    report_paths = sorted(report_dir.glob("HumanEval_*.json"))
    passed = 0
    failed = 0
    failed_tasks = []
    total_cases = 0
    passed_cases = 0
    same_output_cases = 0
    syntax_correct_tasks = 0
    spec_correct_tasks = 0
    tasks_with_negative_cases = 0
    total_mutations = 0
    passed_mutations = 0
    failed_mutations = 0
    skipped_mutations = 0

    for report_path in report_paths:
        report = json.loads(report_path.read_text(encoding="utf-8"))
        total_cases += report.get("total_cases", 0)
        passed_cases += report.get("passed_cases", 0)
        same_output_cases += report.get("same_output_cases", 0)
        syntax_correct_tasks += int(report.get("syntax_correct", False))
        spec_correct_tasks += int(report.get("spec_correct", report.get("status") == "passed"))
        tasks_with_negative_cases += int(report.get("total_cases", 0) > 0)
        mutation_reports = report.get("mutations", [])
        report_passed_mutations = sum(1 for item in mutation_reports if item.get("status") == "passed")
        report_failed_mutations = sum(1 for item in mutation_reports if item.get("status") == "failed")
        report_skipped_mutations = sum(1 for item in mutation_reports if item.get("status") == "skipped")
        passed_mutations += report_passed_mutations
        failed_mutations += report_failed_mutations
        skipped_mutations += report_skipped_mutations
        total_mutations += report_passed_mutations + report_failed_mutations
        if report.get("status") == "passed":
            passed += 1
        else:
            failed += 1
            failed_tasks.append(
                {
                    "task_id": report["task_id"],
                    "task_name": report["task_name"],
                    "failure_type": report.get("failure_type", "unknown"),
                    "report_file": str(report_path),
                }
            )

    return {
        "passed": passed,
        "failed": failed,
        "total": passed + failed,
        "syntax_correct_tasks": syntax_correct_tasks,
        "spec_correct_tasks": spec_correct_tasks,
        "tasks_with_negative_cases": tasks_with_negative_cases,
        "case_accuracy": (passed_cases / total_cases) if total_cases else 0.0,
        "passed_cases": passed_cases,
        "total_cases": total_cases,
        "different_output_cases": total_cases,
        "same_output_cases": same_output_cases,
        "total_mutations": total_mutations,
        "passed_mutations": passed_mutations,
        "failed_mutations": failed_mutations,
        "skipped_mutations": skipped_mutations,
        "mutation_accuracy": (passed_mutations / total_mutations) if total_mutations else 0.0,
        "failed_tasks": failed_tasks,
    }


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--input-jsonl", default="HumanEvalPlus.jsonl")
    parser.add_argument("--output-dir")
    parser.add_argument("--output-root", default="output")
    parser.add_argument("--report-dir")
    parser.add_argument("--report-root", default="negative_report")
    parser.add_argument("--mutation-root", default="humaneval_mutations")
    parser.add_argument("--range")
    parser.add_argument("--idx", nargs="+", type=int)
    parser.add_argument("--task-timeout", type=int, default=0)
    parser.add_argument("--impl-call-timeout", type=int, default=1)
    parser.add_argument("--spec-call-timeout", type=int, default=3)
    parser.add_argument("--fail-fast", action="store_true")
    args = parser.parse_args()

    jsonl_path = Path(args.input_jsonl)
    output_dir = Path(args.output_dir) if args.output_dir else infer_latest_output_dir(Path(args.output_root))
    report_dir = Path(args.report_dir) if args.report_dir else infer_report_dir(Path(args.report_root), output_dir)
    mutation_root = Path(args.mutation_root)
    report_dir.mkdir(parents=True, exist_ok=True)

    with jsonl_path.open(encoding="utf-8") as fh:
        lines = fh.readlines()

    if args.idx or args.range:
        indices = select_indices(len(lines), args.range, args.idx)
    else:
        indices = available_generated_indices(output_dir)
    if len(indices) == len(lines):
        for old_report in report_dir.glob("HumanEval_*.json"):
            old_report.unlink()
    else:
        for idx in indices:
            report_path = report_dir / report_filename_for_index(idx)
            if report_path.exists():
                report_path.unlink()

    passed = 0
    failed = 0

    for idx in indices:
        task = json.loads(lines[idx])
        report = run_task_with_timeout(
            task,
            output_dir,
            mutation_root,
            args.task_timeout,
            args.impl_call_timeout,
            args.spec_call_timeout,
        )
        report.setdefault("syntax_correct", report.get("failure_type") != "syntax_error")
        report.setdefault("spec_correct", report["status"] == "passed")
        write_report(report_dir, report)

        if report["status"] == "passed":
            passed += 1
            print(f"PASS {report['task_id']}")
        else:
            failed += 1
            print(f"FAIL {report['task_id']}: {report.get('failure_type', 'unknown')}")
            if args.fail_fast:
                break

    summary = {
        "output_dir": str(output_dir),
        "mutation_root": str(mutation_root),
        "report_dir": str(report_dir),
        **aggregate_reports(report_dir),
    }
    (report_dir / "_summary.json").write_text(
        json.dumps(summary, ensure_ascii=False, indent=2) + "\n",
        encoding="utf-8",
    )

    print(f"Output dir: {output_dir}")
    print(f"Report dir: {report_dir}")
    print(f"Summary: passed={passed} failed={failed}")
    if failed:
        raise SystemExit(1)


if __name__ == "__main__":
    main()
