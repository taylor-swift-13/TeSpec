#!/usr/bin/env python3
"""Publish compact current Auto results and references to archived ITP evidence."""

import argparse
from contextlib import nullcontext
from collections import Counter
from concurrent.futures import ThreadPoolExecutor
import hashlib
import json
from pathlib import Path
import re
import subprocess
import sys
from tempfile import TemporaryDirectory

ROOT = Path(__file__).resolve().parents[2]
sys.path[:0] = [str(ROOT), str(Path(__file__).resolve().parent)]
from spectest.routes import fingerprint, read  # noqa: E402
from tools.benchmark.current_test_plan import (  # noqa: E402
    executed_source, load_current_plan, matches_crash, select_qcp_input,
)
from tools.benchmark.evaluation_expectations import expected  # noqa: E402
from tools.benchmark.replay_complementary_routes import matrix_hash  # noqa: E402

RESULTS = ROOT / "benchmark/results"
BINARY = ROOT / "bin/tespec-symexec"
RUNTIME = ROOT / "runtime/qcip"
SEMANTICS_BASE = "781508ce5e"


def digest(data):
    return hashlib.sha256(
        json.dumps(data, sort_keys=True, separators=(",", ":")).encode()
    ).hexdigest()


def reference(path):
    return {"path": str(path.relative_to(ROOT)), "sha256": fingerprint(path)}


def save(path, value):
    path.parent.mkdir(parents=True, exist_ok=True)
    temp = path.with_suffix(".tmp")
    temp.write_text(
        json.dumps(value, separators=(",", ":"), ensure_ascii=False) + "\n",
        encoding="utf-8",
    )
    temp.replace(path)


def inputs(group):
    base = ROOT / "benchmark/programs" / group
    plan, oracle = load_current_plan(base / "evaluation-plan.json")
    variants = {
        v["id"]: ROOT / v["manifest"] for v in read(base / "manifest.json")["variants"]
    }
    tasks, pairings = {}, {}
    for pair in plan["pairings"]:
        variant = pair["qcp_variant"]
        manifest = variants[variant]
        source = read(manifest)["files"]["qcp"]
        if fingerprint(ROOT / source["path"]) != source["sha256"]:
            raise ValueError(f"source changed: {group} {variant}")
        layout = manifest.parent / "dependencies/coq/target-layout.json"
        bits = read(layout)["architecture_bits"] if layout.is_file() else 32
        function = pair.get("function", plan.get("function"))
        for case in pair["cases"]:
            selected = select_qcp_input(ROOT, source, case, function)
            bind = dict(case["binds"], id=case["id"])
            for strategy in ("inline", "modular"):
                key = (variant, case["id"], strategy)
                row = (function, selected, bind, expected(case, "tespec_on", strategy))
                detail = (row, bits, case.get("expected_crash_fault_code"))
                if tasks.setdefault(key, detail) != detail:
                    raise ValueError(f"conflicting execution identity: {group} {key}")
                pairings.setdefault(key, set()).add(pair["cn_variant"])
    return tasks, pairings, oracle


def archived_routes(group, tasks):
    path = RESULTS / group / "residual-routes/comparison.json"
    if not path.is_file():
        return None, {}
    data = read(path)
    if data["native_binary_sha256"] != fingerprint(BINARY):
        return None, {}
    if data["input_matrix_sha256"] != matrix_hash({k: v[0] for k, v in tasks.items()}):
        return None, {}
    # The CLI migration changed only parameter parsing and reporting.
    for name, checksum in data["auto_implementation_sha256"].items():
        if name in ("spectest/core.py", "spectest/routes.py"):
            original = subprocess.check_output(
                ["git", "show", f"{SEMANTICS_BASE}:{name}"], cwd=ROOT
            )
            if hashlib.sha256(original).hexdigest() != checksum:
                return None, {}
        elif fingerprint(ROOT / name) != checksum:
            return None, {}
    rows = {
        (r["variant"], r["input"], r["strategy"]): i
        for i, r in enumerate(data["executions"])
    }
    if rows.keys() != tasks.keys():
        return None, {}
    # Older paired archives did not record which specialized C file the
    # executor opened. Preserve their other rows, but remeasure fixture rows.
    for key, ((_, src, _, _), _, _) in tasks.items():
        if "original_source_sha256" not in src:
            continue
        old = data["executions"][rows[key]]
        if (old.get("qcp_input_fixture_path") != src["path"]
                or old.get("original_source_sha256") != src["original_source_sha256"]
                or old.get("source_sha256") != src["sha256"]
                or not re.fullmatch(r"[0-9a-f]{64}", old.get("executed_source_sha256") or "")):
            del rows[key]
    return path, rows


def plan_reference(group, archive, oracle):
    plan = ROOT / "benchmark/programs" / group / "evaluation-plan.json"
    if archive:
        return {
            "path": str(plan.relative_to(ROOT)),
            "tespec_input_matrix_sha256": archive["input_matrix_sha256"],
            "fault_oracle_sha256": oracle,
        }
    return reference(plan)


def reusable_row(row, detail):
    (_, source, bind, expectation), _, fault = detail
    if (row.get("source_sha256") != source["sha256"] or row.get("input_sha256") != digest(bind)
            or row.get("expected") != expectation or row.get("expected_fault_code") != fault):
        return False
    return "original_source_sha256" not in source or (
        row.get("original_source_sha256") == source["original_source_sha256"]
        and row.get("qcp_input_fixture_path") == source["path"]
        and bool(re.fullmatch(r"[0-9a-f]{64}", row.get("executed_source_sha256") or ""))
    )


def branch_counts(native):
    raw = native.get("stdout")
    if not raw or not Path(raw).is_file():
        return None
    try:
        report = read(raw)
    except (UnicodeError, ValueError):
        return None
    counts = report.get("spec_test", {}).get("branch_evaluation")
    if not isinstance(counts, dict) or counts.get("schema") != "instance-first-branch-query/v1":
        return None
    names = ("pure_queries", "evaluated_true", "evaluated_false", "smt_fallback")
    if any(type(counts.get(k)) is not int or counts[k] < 0 for k in names):
        raise ValueError("Invalid native branch counters")
    return {k: counts[k] for k in names}


def make_test_job(task, folder):
    key, detail = task
    (function, source, bind, expectation), bits, fault = detail
    runtime_id = (
        bind["id"]
        if re.fullmatch(r"[A-Za-z_][A-Za-z_0-9]*", bind["id"])
        else "case_" + digest(bind)[:16]
    )
    job = folder / "job.json"
    source_path = ROOT / source["path"]
    if fingerprint(source_path) != source["sha256"]:
        raise ValueError(f"Selected QCP input changed before execution: {source_path}")
    relocated_strategy = None
    if source_path.name == "init_array_rev.qcp.c":
        legacy = (
            ROOT
            / "benchmark/selection/qcp-migration/simple/init_array_rev.strategies"
        )
        dependency = (
            source_path.parent.parent / "dependencies/init_array_rev.strategies"
        )
        original = source_path.read_bytes()
        if str(legacy).encode() in original and not legacy.is_file():
            relocated_strategy = reference(dependency)
            source_path = folder / source_path.name
            source_path.write_bytes(
                original.replace(str(legacy).encode(), str(dependency).encode())
            )
    save(
        job,
        {
            "source": str(source_path),
            "function": function,
            "binds": [dict(bind, id=runtime_id)],
            "qcp": {
                "binary": str(BINARY),
                "qcip_root": str(RUNTIME),
                "architecture_bits": bits,
                "execution": key[2],
                "vc_scope": "all-boundaries",
                "loop_unroll_limit": 64,
                "call_depth_limit": 64,
                "timeout_seconds": 30,
                "include_dirs": [
                    str(RUNTIME / "QCP_examples/QCP_demos_human"),
                    *(
                        [str((ROOT / source["path"]).parent)]
                        if relocated_strategy
                        else []
                    ),
                    *(str(ROOT / p) for p in source["include_dirs"]),
                ],
            },
        },
    )
    return job, relocated_strategy, source_path, runtime_id


def run_one(task, *, workspace=None):
    key, detail = task
    (function, source, bind, expectation), bits, fault = detail
    with (TemporaryDirectory(prefix="tespec-auto-") if workspace is None
          else nullcontext(workspace)) as temp:
        folder = Path(temp)
        job, relocated_strategy, source_path, runtime_id = make_test_job(task, folder)
        out = folder / "out"
        command = [
            sys.executable,
            "-B",
            "-m",
            "spectest",
            "routes",
            str(job),
            "--output-dir",
            str(out),
        ]
        proc = subprocess.run(command, cwd=ROOT, capture_output=True, text=True)
        report = out / "routes.json"
        native_path = out / "native/report.json"
        native_report = read(native_path) if native_path.is_file() else None
        ran_sha = None
        if native_report is not None:
            job_sha = fingerprint(source_path) if relocated_strategy else source["sha256"]
            layout = read(report).get("auto_layout", {}) if report.is_file() else {}
            if layout.get("status") == "bound":
                if layout["original_source_sha256"] != job_sha or layout["original_job_sha256"] != fingerprint(job):
                    raise ValueError("Auto layout was bound to a different benchmark source or job")
                job_sha = fingerprint(Path(read(Path(layout["job"]))["source"]))
            ran_sha = executed_source(native_report, job_sha)
        if not report.is_file():
            log = out / "measurements/native/stderr.log"
            diagnostic = (
                log.read_text(errors="replace").strip() if log.is_file() else ""
            )
            diagnostic = (
                diagnostic or proc.stderr.strip() or proc.stdout.strip()
            ).replace(str(folder), "<work>")
            rss = out / "measurements/native/rss.txt"
            return {
                "native_status": "ERROR",
                "auto_status": "NOT_RUN",
                "effective_status": "ERROR",
                "expected_match": False,
                "failure": diagnostic,
                "executed_source_sha256": ran_sha,
                "native": {
                    "wall_seconds": None,
                    "max_process_rss_kib": int(rss.read_text())
                    if rss.is_file()
                    else None,
                    "tokens": 0,
                },
                "auto": None,
            }
        routes = read(report)
        if native_report is None or routes["native_report_sha256"] != fingerprint(native_path):
            raise ValueError("Missing or mismatched native report for route result")
        (row,) = routes["cases"]
        (native,) = native_report["results"]
        auto = routes["routes"].get("auto")
        auto_path = out / "auto/report.json"
        final = read(auto_path)["results"][0] if auto_path.is_file() else native
        status = row["auto_status"] if row["eligible"] else row["native_status"]
        goal = native.get("vc", {}).get("files", {}).get("goal")
        return {
            "auto_layout": {k: v for k, v in routes.get("auto_layout", {}).items() if k != "job"},
            "executor_case_id": runtime_id,
            "branch_evaluation": branch_counts(native),
            "executed_source_sha256": ran_sha,
            "relocated_strategy": relocated_strategy,
            "native_status": row["native_status"],
            "auto_status": row["auto_status"],
            "effective_status": status,
            "expected_match": status == expectation
            and (status != "CRASH" or matches_crash(final, fault)),
            "reason": final.get("reason"),
            "execution_completed": native.get("execution_completed"),
            "precondition_result": native.get("precondition_result"),
            "fault_code": (final.get("executor_error") or {}).get("fault_code"),
            "failure": final.get("executor_error") if status == "ERROR" else None,
            "goal_sha256": fingerprint(goal) if goal and Path(goal).is_file() else None,
            "native_report_sha256": routes["native_report_sha256"],
            "native": {
                k: routes["native_cost"].get(k)
                for k in ("wall_seconds", "max_process_rss_kib", "tokens")
            },
            "auto": (
                {
                    k: auto.get(k)
                    for k in (
                        "wall_seconds",
                        "max_process_rss_kib",
                        "tokens",
                        "model_calls",
                        "status",
                    )
                }
                | {
                    "report_sha256": fingerprint(auto_path)
                    if auto_path.is_file()
                    else None
                }
            )
            if auto
            else None,
        }


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--group", action="append")
    parser.add_argument("--retry-launch-errors", action="store_true")
    parser.add_argument("--retry-execution-errors", action="store_true")
    parser.add_argument("--workers", type=int, default=4)
    args = parser.parse_args()
    groups = args.group or sorted(
        p.name for p in (ROOT / "benchmark/programs").iterdir() if p.is_dir()
    )
    with ThreadPoolExecutor(max_workers=args.workers) as pool:
        for group in groups:
            tasks, pairings, oracle = inputs(group)
            path, archived = archived_routes(group, tasks)
            published = read(path) if path else None
            previous = {}
            output = RESULTS / group / "tespec/routes.json"
            if args.retry_launch_errors or args.retry_execution_errors:
                old = read(output)
                assert old["plan"] == plan_reference(group, published, oracle)
                assert (
                    old["binary"] == reference(BINARY)
                    and old["fault_oracle_sha256"] == oracle
                )
                for row in old["executions"]:
                    key = row["variant"], row["case"], row["strategy"]
                    if key not in tasks or not reusable_row(row, tasks[key]):
                        continue
                    if row.get("native_report_sha256") and not (
                        args.retry_execution_errors and row["native_status"] == "ERROR"
                    ):
                        previous[key] = row
            jobs = (
                (key, value)
                for key, value in tasks.items()
                if key not in archived and key not in previous
            )
            results = iter(pool.map(run_one, jobs))
            rows = []
            for key, ((_, source, bind, expectation), _, fault) in tasks.items():
                row = {
                    "variant": key[0],
                    "case": key[1],
                    "strategy": key[2],
                    "cn_pairings": sorted(pairings[key]),
                    "input_sha256": digest(bind),
                    "source_sha256": source["sha256"],
                    "expected": expectation,
                    "expected_fault_code": fault,
                }
                if "original_source_sha256" in source:
                    row["original_source_sha256"] = source["original_source_sha256"]
                    row["qcp_input_fixture_path"] = source["path"]
                if key in archived:
                    original = published["executions"][archived[key]]
                    if "executed_source_sha256" in original:
                        row["executed_source_sha256"] = original["executed_source_sha256"]
                    status = (
                        original["native_status"]
                        if original["auto_status"] == "NOT_RUN"
                        else original["auto_status"]
                    )
                    row.update(
                        archive_row=archived[key],
                        native_status=original["native_status"],
                        auto_status=original["auto_status"],
                        effective_status=status,
                        expected_match=status == expectation,
                        itp_status=original["itp_status"],
                    )
                elif key in previous:
                    row = previous[key]
                else:
                    refreshed = next(results)
                    if refreshed.get("failure") and isinstance(
                        refreshed["failure"], dict
                    ):
                        refreshed["failure"].pop("fileName", None)
                    row.update(refreshed)
                    row["itp_status"] = (
                        "UNMEASURED" if row["auto_status"] != "NOT_RUN" else "NOT_RUN"
                    )
                rows.append(row)
            data = {
                "schema": "tespec-experiment-routes/v1",
                "group": group,
                "binary": reference(BINARY),
                "plan": plan_reference(group, published, oracle),
                "fault_oracle_sha256": oracle,
                "vc_scope": "all-boundaries",
                "archive": reference(path) if path else None,
                "executions": rows,
                "summary": {
                    "auto_effective": dict(
                        Counter(row["effective_status"] for row in rows)
                    ),
                    "auto_expected_matches": sum(row["expected_match"] for row in rows),
                    "itp": dict(Counter(row["itp_status"] for row in rows)),
                    "reused_executions": len(archived),
                },
            }
            save(RESULTS / group / "tespec/routes.json", data)
            print(group, len(rows), data["summary"], flush=True)


if __name__ == "__main__":
    main()
