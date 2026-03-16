#!/usr/bin/env python3
import argparse
import ast
import importlib.util
import json
import multiprocessing
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


def list_timestamped_runs(root: Path):
    if not root.exists():
        return []
    dirs = [path for path in root.iterdir() if path.is_dir()]
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
    assertion = test_globals.get("assertion")
    if assertion is None:
        raise RuntimeError(f"Unsupported test structure for {task['task_id']}")
    mod = ast.parse(task["test"])
    check_func = next(
        (node for node in mod.body if isinstance(node, ast.FunctionDef) and node.name == "check"),
        None,
    )
    if check_func is None:
        raise RuntimeError(f"Missing check(candidate) for {task['task_id']}")
    inputs = None
    results = None
    use_ref_func = "ref_func" in task["test"]
    for node in check_func.body:
        if not isinstance(node, ast.Assign) or len(node.targets) != 1:
            continue
        target = node.targets[0]
        if not isinstance(target, ast.Name):
            continue
        if target.id == "inputs":
            inputs = ast.literal_eval(node.value)
        elif target.id == "results":
            results = ast.literal_eval(node.value)
    if inputs is None:
        raise RuntimeError(f"Missing inputs in check(candidate) for {task['task_id']}")
    if results is None and not use_ref_func:
        raise RuntimeError(f"Missing results/ref_func in check(candidate) for {task['task_id']}")
    if results is not None and len(inputs) != len(results):
        raise RuntimeError(f"Mismatched inputs/results for {task['task_id']}")
    ref_func = test_globals.get("ref_func") if use_ref_func else None
    if use_ref_func and ref_func is None:
        raise RuntimeError(f"Missing ref_func for {task['task_id']}")
    return inputs, results, assertion, ref_func


def normalize_args(inp):
    if isinstance(inp, list):
        return tuple(inp)
    if isinstance(inp, tuple):
        return inp
    return (inp,)


def determine_assertion_failure(module, args):
    if not hasattr(module, "precondition") or not hasattr(module, "postcondition"):
        return "wrapper_assertion_failed", None
    input_tuple = tuple(args)
    try:
        if not module.precondition(input_tuple):
            return "precondition_failed", None
        if not hasattr(module, "_impl"):
            return "missing_impl", None
        output = module._impl(*args)
        if not module.postcondition(input_tuple, output):
            return "postcondition_failed", output
        return "wrapper_assertion_failed", output
    except Exception as exc:
        return "spec_evaluation_error", f"{type(exc).__name__}: {exc}"


def describe_failure(case_report: dict):
    failure_type = case_report.get("failure_type", "unknown")
    if failure_type == "precondition_failed":
        return "precondition returned false before running the wrapped implementation"
    if failure_type == "postcondition_failed":
        return "precondition passed, but postcondition rejected the implementation output"
    if failure_type == "wrapper_assertion_failed":
        return "the wrapper raised AssertionError but the exact pre/postcondition branch could not be determined"
    if failure_type == "spec_evaluation_error":
        return "precondition or postcondition raised an exception during evaluation"
    if failure_type == "runtime_error":
        return "the wrapped candidate raised an exception during execution"
    if failure_type == "test_assertion_failed":
        return "the wrapped candidate returned, but the official test assertion failed"
    if failure_type == "missing_impl":
        return "generated file is missing _impl"
    if failure_type == "impl_runtime_error":
        return "calling _impl directly raised an exception"
    if failure_type == "impl_test_assertion_failed":
        return "ignoring precondition, _impl output still failed the official test"
    if failure_type == "missing_entry_point":
        return "generated file is missing the expected entry point"
    if failure_type == "syntax_error":
        return "generated file has a syntax error"
    if failure_type == "module_load_error":
        return "generated file failed to load"
    if failure_type == "unsupported_test_structure":
        return "dataset test structure could not be parsed by the runner"
    if failure_type == "task_timeout":
        return "task exceeded the configured timeout"
    return failure_type


def run_unrestricted_case(module, assertion, args, expected, case_index):
    if not hasattr(module, "_impl"):
        return {
            "status": "failed",
            "failure_type": "missing_impl",
            "case_index": case_index,
            "input": list(args),
            "expected": expected,
            "details": None,
        }
    try:
        actual = module._impl(*args)
    except Exception as exc:
        return {
            "status": "failed",
            "failure_type": "impl_runtime_error",
            "case_index": case_index,
            "input": list(args),
            "expected": expected,
            "details": f"{type(exc).__name__}: {exc}",
        }
    try:
        assertion(actual, expected, 0)
    except Exception as exc:
        return {
            "status": "failed",
            "failure_type": "impl_test_assertion_failed",
            "case_index": case_index,
            "input": list(args),
            "expected": expected,
            "actual": actual,
            "details": f"{type(exc).__name__}: {exc}",
        }
    return {
        "status": "passed",
        "case_index": case_index,
    }


def run_single_case(module, candidate, assertion, args, expected, case_index):
    try:
        actual = candidate(*args)
    except AssertionError:
        failure_type, extra = determine_assertion_failure(module, args)
        return {
            "status": "failed",
            "failure_type": failure_type,
            "case_index": case_index,
            "input": list(args),
            "expected": expected,
            "details": extra,
        }
    except Exception as exc:
        return {
            "status": "failed",
            "failure_type": "runtime_error",
            "case_index": case_index,
            "input": list(args),
            "expected": expected,
            "details": f"{type(exc).__name__}: {exc}",
            "traceback": traceback.format_exc(),
        }

    try:
        assertion(actual, expected, 0)
    except Exception as exc:
        return {
            "status": "failed",
            "failure_type": "test_assertion_failed",
            "case_index": case_index,
            "input": list(args),
            "expected": expected,
            "actual": actual,
            "details": f"{type(exc).__name__}: {exc}",
            "traceback": traceback.format_exc(),
        }

    return {
        "status": "passed",
        "case_index": case_index,
    }


def run_task(task: dict, output_dir: Path):
    task_name = task["task_id"].replace("/", "_")
    module_path = output_dir / f"{task_name}.py"
    if not module_path.exists():
        return {
            "task_id": task["task_id"],
            "task_name": task_name,
            "status": "failed",
            "failure_type": "missing_generated_file",
            "module_path": str(module_path),
            "passed_cases": 0,
            "failed_cases": 0,
            "total_cases": 0,
            "accuracy": 0.0,
            "unrestricted_passed_cases": 0,
            "unrestricted_failed_cases": 0,
            "unrestricted_accuracy": 0.0,
        }

    try:
        module = load_module(module_path, f"generated_{task_name}")
    except SyntaxError as exc:
        return {
            "task_id": task["task_id"],
            "task_name": task_name,
            "status": "failed",
            "failure_type": "syntax_error",
            "module_path": str(module_path),
            "details": f"{type(exc).__name__}: {exc}",
            "traceback": traceback.format_exc(),
            "passed_cases": 0,
            "failed_cases": 0,
            "total_cases": 0,
            "accuracy": 0.0,
            "unrestricted_passed_cases": 0,
            "unrestricted_failed_cases": 0,
            "unrestricted_accuracy": 0.0,
        }
    except Exception as exc:
        return {
            "task_id": task["task_id"],
            "task_name": task_name,
            "status": "failed",
            "failure_type": "module_load_error",
            "module_path": str(module_path),
            "details": f"{type(exc).__name__}: {exc}",
            "traceback": traceback.format_exc(),
            "passed_cases": 0,
            "failed_cases": 0,
            "total_cases": 0,
            "accuracy": 0.0,
            "unrestricted_passed_cases": 0,
            "unrestricted_failed_cases": 0,
            "unrestricted_accuracy": 0.0,
        }

    candidate = getattr(module, task["entry_point"], None)
    if candidate is None:
        return {
            "task_id": task["task_id"],
            "task_name": task_name,
            "status": "failed",
            "failure_type": "missing_entry_point",
            "module_path": str(module_path),
            "entry_point": task["entry_point"],
            "passed_cases": 0,
            "failed_cases": 0,
            "total_cases": 0,
            "accuracy": 0.0,
            "unrestricted_passed_cases": 0,
            "unrestricted_failed_cases": 0,
            "unrestricted_accuracy": 0.0,
        }

    try:
        inputs, results, assertion, ref_func = load_cases(task)
    except Exception as exc:
        return {
            "task_id": task["task_id"],
            "task_name": task_name,
            "status": "failed",
            "failure_type": "unsupported_test_structure",
            "module_path": str(module_path),
            "details": f"{type(exc).__name__}: {exc}",
            "traceback": traceback.format_exc(),
            "passed_cases": 0,
            "failed_cases": 0,
            "total_cases": 0,
            "accuracy": 0.0,
            "unrestricted_passed_cases": 0,
            "unrestricted_failed_cases": 0,
            "unrestricted_accuracy": 0.0,
        }

    first_failure = None
    passed_cases = 0
    failed_cases = 0
    unrestricted_passed_cases = 0
    unrestricted_failed_cases = 0
    first_unrestricted_failure = None
    failure_examples = []
    unrestricted_failure_examples = []
    for case_index, inp in enumerate(inputs):
        args = normalize_args(inp)
        expected = results[case_index] if results is not None else ref_func(*args)
        case_report = run_single_case(module, candidate, assertion, args, expected, case_index)
        if case_report["status"] == "passed":
            passed_cases += 1
        else:
            case_report["reason"] = describe_failure(case_report)
            failed_cases += 1
            if first_failure is None:
                first_failure = case_report
            if len(failure_examples) < 10:
                failure_examples.append(case_report)

        unrestricted_case_report = run_unrestricted_case(module, assertion, args, expected, case_index)
        if unrestricted_case_report["status"] == "passed":
            unrestricted_passed_cases += 1
        else:
            unrestricted_case_report["reason"] = describe_failure(unrestricted_case_report)
            unrestricted_failed_cases += 1
            if first_unrestricted_failure is None:
                first_unrestricted_failure = unrestricted_case_report
            if len(unrestricted_failure_examples) < 10:
                unrestricted_failure_examples.append(unrestricted_case_report)

    report = {
        "task_id": task["task_id"],
        "task_name": task_name,
        "status": "passed" if failed_cases == 0 else "failed",
        "module_path": str(module_path),
        "entry_point": task["entry_point"],
        "passed_cases": passed_cases,
        "failed_cases": failed_cases,
        "total_cases": len(inputs),
        "accuracy": passed_cases / len(inputs),
        "unrestricted_passed_cases": unrestricted_passed_cases,
        "unrestricted_failed_cases": unrestricted_failed_cases,
        "unrestricted_accuracy": unrestricted_passed_cases / len(inputs),
        "syntax_correct": True,
        "spec_correct": failed_cases == 0,
        "postcondition_correct_without_precondition": unrestricted_failed_cases == 0,
    }
    if first_failure is not None:
        report["failure_type"] = first_failure["failure_type"]
        report["first_failure"] = first_failure
        report["failure_examples"] = failure_examples
    if first_unrestricted_failure is not None:
        report["first_unrestricted_failure"] = first_unrestricted_failure
        report["unrestricted_failure_examples"] = unrestricted_failure_examples
    return report


def _run_task_worker(conn, task, output_dir_str):
    try:
        report = run_task(task, Path(output_dir_str))
    except Exception as exc:
        report = {
            "task_id": task["task_id"],
            "task_name": task["task_id"].replace("/", "_"),
            "status": "failed",
            "failure_type": "worker_error",
            "module_path": str(Path(output_dir_str) / f"{task['task_id'].replace('/', '_')}.py"),
            "passed_cases": 0,
            "failed_cases": 0,
            "total_cases": 0,
            "accuracy": 0.0,
            "unrestricted_passed_cases": 0,
            "unrestricted_failed_cases": 0,
            "unrestricted_accuracy": 0.0,
            "syntax_correct": False,
            "spec_correct": False,
            "postcondition_correct_without_precondition": False,
            "details": f"{type(exc).__name__}: {exc}",
            "traceback": traceback.format_exc(),
        }
    try:
        conn.send(report)
    finally:
        conn.close()


def run_task_with_timeout(task: dict, output_dir: Path, task_timeout: int):
    ctx = multiprocessing.get_context("fork")
    parent_conn, child_conn = ctx.Pipe(duplex=False)
    proc = ctx.Process(target=_run_task_worker, args=(child_conn, task, str(output_dir)))
    proc.start()
    child_conn.close()
    proc.join(task_timeout)
    if proc.is_alive():
        proc.terminate()
        proc.join()
        parent_conn.close()
        return {
            "task_id": task["task_id"],
            "task_name": task["task_id"].replace("/", "_"),
            "status": "failed",
            "failure_type": "task_timeout",
            "module_path": str(output_dir / f"{task['task_id'].replace('/', '_')}.py"),
            "passed_cases": 0,
            "failed_cases": 0,
            "total_cases": 0,
            "accuracy": 0.0,
            "unrestricted_passed_cases": 0,
            "unrestricted_failed_cases": 0,
            "unrestricted_accuracy": 0.0,
            "syntax_correct": True,
            "spec_correct": False,
            "postcondition_correct_without_precondition": False,
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
        "passed_cases": 0,
        "failed_cases": 0,
        "total_cases": 0,
        "accuracy": 0.0,
        "unrestricted_passed_cases": 0,
        "unrestricted_failed_cases": 0,
        "unrestricted_accuracy": 0.0,
        "syntax_correct": False,
        "spec_correct": False,
        "postcondition_correct_without_precondition": False,
        "details": "Worker exited without producing a report",
    }


def write_report(report_dir: Path, report: dict):
    report_path = report_dir / f"{report['task_name']}.json"
    report_path.write_text(
        json.dumps(report, ensure_ascii=False, indent=2, default=str) + "\n",
        encoding="utf-8",
    )


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--input-jsonl", default="HumanEvalPlus.jsonl")
    parser.add_argument("--output-dir")
    parser.add_argument("--output-root", default="output")
    parser.add_argument("--report-dir")
    parser.add_argument("--report-root", default="test_reports")
    parser.add_argument("--range")
    parser.add_argument("--idx", nargs="+", type=int)
    parser.add_argument("--task-timeout", type=int, default=30)
    parser.add_argument("--fail-fast", action="store_true")
    args = parser.parse_args()

    jsonl_path = Path(args.input_jsonl)
    output_dir = Path(args.output_dir) if args.output_dir else infer_latest_output_dir(Path(args.output_root))
    report_dir = Path(args.report_dir) if args.report_dir else infer_report_dir(Path(args.report_root), output_dir)
    report_dir.mkdir(parents=True, exist_ok=True)
    for old_report in report_dir.glob("HumanEval_*.json"):
        old_report.unlink()
    summary_path = report_dir / "_summary.json"
    if summary_path.exists():
        summary_path.unlink()

    with jsonl_path.open(encoding="utf-8") as fh:
        lines = fh.readlines()

    indices = select_indices(len(lines), args.range, args.idx)

    passed = 0
    failed = 0
    failed_tasks = []
    total_cases = 0
    passed_cases = 0
    unrestricted_passed_cases = 0
    syntax_correct_tasks = 0
    spec_correct_tasks = 0
    postcondition_correct_without_precondition_tasks = 0

    for idx in indices:
        task = json.loads(lines[idx])
        report = run_task_with_timeout(task, output_dir, args.task_timeout)
        report.setdefault("syntax_correct", report.get("failure_type") != "syntax_error")
        report.setdefault("spec_correct", report["status"] == "passed")
        report.setdefault("postcondition_correct_without_precondition", False)
        write_report(report_dir, report)
        if "total_cases" in report:
            total_cases += report["total_cases"]
            passed_cases += report.get("passed_cases", 0)
            unrestricted_passed_cases += report.get("unrestricted_passed_cases", 0)
        syntax_correct_tasks += int(report.get("syntax_correct", False))
        spec_correct_tasks += int(report.get("spec_correct", False))
        postcondition_correct_without_precondition_tasks += int(
            report.get("postcondition_correct_without_precondition", False)
        )
        if report["status"] == "passed":
            passed += 1
            print(f"PASS {report['task_id']}")
        else:
            failed += 1
            failed_tasks.append(
                {
                    "task_id": report["task_id"],
                    "task_name": report["task_name"],
                    "failure_type": report.get("failure_type", "unknown"),
                    "report_file": str(report_dir / f"{report['task_name']}.json"),
                }
            )
            print(f"FAIL {report['task_id']}: {report.get('failure_type', 'unknown')}")
            if args.fail_fast:
                break

    summary = {
        "output_dir": str(output_dir),
        "report_dir": str(report_dir),
        "passed": passed,
        "failed": failed,
        "total": passed + failed,
        "syntax_correct_tasks": syntax_correct_tasks,
        "spec_correct_tasks": spec_correct_tasks,
        "postcondition_correct_without_precondition_tasks": (
            postcondition_correct_without_precondition_tasks
        ),
        "case_accuracy": (passed_cases / total_cases) if total_cases else 0.0,
        "unrestricted_case_accuracy": (
            unrestricted_passed_cases / total_cases
        ) if total_cases else 0.0,
        "passed_cases": passed_cases,
        "total_cases": total_cases,
        "unrestricted_passed_cases": unrestricted_passed_cases,
        "failed_tasks": failed_tasks,
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
