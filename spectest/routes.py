"""Compare independent decision backends on an unchanged native test report."""

import argparse
from collections import Counter
from concurrent.futures import ThreadPoolExecutor
import hashlib
import json
from pathlib import Path
import subprocess
import sys
import time

from .errors import JobError
from .itp_schedule import route_case_ids
from .verdict import CASE_STATUSES


def read(path):
    return json.loads(Path(path).read_bytes())


def write(path, data):
    path.write_text(
        json.dumps(data, indent=2, ensure_ascii=False) + "\n", encoding="utf-8"
    )


def fingerprint(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def native_cases(report):
    if (
        report.get("schema") != "qcp-spectest-report/v1"
        or "proof_completion" in report
        or report.get("vc_policy", {}).get("spatial_smt", {}).get("enabled")
        or any(
            "spatial_smt" in case or "auto_route" in case or "automatic_status" in case
            for case in report.get("results", [])
        )
    ):
        raise JobError("routes requires a native report before spatial SMT or ITP")
    cases = {case["id"]: case for case in report["results"]}
    if not cases or len(cases) != len(report["results"]):
        raise JobError("empty or duplicate native case IDs")
    return cases


def measure(command, output):
    """Charge a whole branch, including descendants, once. GNU time reports KiB."""
    output.mkdir(parents=True, exist_ok=True)
    resources = output / "rss.txt"
    start = time.monotonic()
    with (
        (output / "stdout.log").open("wb") as out,
        (output / "stderr.log").open("wb") as err,
    ):
        proc = subprocess.run(
            ["/usr/bin/time", "-q", "-f", "%M", "-o", str(resources), *command],
            stdout=out,
            stderr=err,
        )
    return {
        "wall_seconds": time.monotonic() - start,
        "exit_code": proc.returncode,
        "max_process_rss_kib": int(resources.read_text().strip()),
        "rss_scope": "maximum single-process RSS, including descendants",
    }


def itp_command(args, native, work, selected):
    cmd = [
        sys.executable,
        "-m",
        "spectest.proof_controller",
        str(native),
        "--output",
        str(work),
        "--agent-timeout",
        str(args.agent_timeout),
        "--check-timeout",
        str(args.check_timeout),
        "--switch",
        args.switch,
    ]
    if args.replay_only:
        cmd.append("--replay-only")
    if args.proof_cache:
        cmd.extend(["--proof-cache", str(args.proof_cache.resolve())])
    for case_id in sorted(selected):
        cmd.extend(["--only-case", case_id])
    return cmd


def proof_costs(agent):
    """Separate local checking from CLI time, including unsuccessful attempts."""
    by_stage = {}
    for attempt in agent["attempts"]:
        for step in attempt["check"]["stages"]:
            label = "kernel" if step["stage"] == "kernel_replay" else "coq"
            by_stage.setdefault(label, []).append(step)
    totals = {}
    for label, steps in by_stage.items():
        peaks = [(s.get("resources") or {}).get("max_process_rss_kib") for s in steps]
        totals[label] = {
            "wall_seconds": sum(s["wall_seconds"] for s in steps),
            "max_process_rss_kib": max(peaks)
            if all(isinstance(m, int) for m in peaks)
            else None,
            "steps": len(steps),
        }
    return totals


def run_backend(route, args, native, output, selected, cases, raw_hash):
    work = output / route
    meter = output / "measurements" / route
    cmd = (
        [
            sys.executable,
            "-m",
            "spectest.routes",
            str(native),
            str(work),
            str(args.spatial_smt_timeout_ms),
        ]
        if route == "auto"
        else itp_command(args, native, work, selected)
    )
    stats = measure(cmd, meter)
    stats["tokens"] = 0 if route == "auto" or args.replay_only else None
    if route == "auto":
        stats["model_calls"] = 0
    else:
        stats["candidate_policy"] = (
            "replay_only" if args.replay_only else "replay_then_generate"
        )
    if route == "auto":
        path = work / "report.json"
    else:
        negative = work / "negative-proof/report.json"
        path = negative if negative.is_file() else work / "proof/report.json"
    # Worker failures are branch-local. Never treat an early controller report
    # or a missing worker result as a proof, even if the other backend succeeded.
    good = stats["exit_code"] == 0 if route == "auto" else stats["exit_code"] in (0, 1)
    branch = read(path) if good and path.is_file() else {}
    if route == "itp" and branch:
        completion = branch.get("proof_completion", {})
        agent = completion.get("agent")
        if agent is None:
            branch = {}
        else:
            stats.update(
                tokens=agent["tokens"],
                model_calls=agent["agent_invocations"],
                model_wall_seconds=agent["wall_seconds"],
                model_peak_rss_kib=(agent.get("resources") or {}).get(
                    "max_process_rss_kib"
                ),
                checker_stages=proof_costs(agent),
                missing_candidates=completion.get("missing_candidates", []),
            )
    outputs = {c["id"]: c for c in branch.get("results", [])}
    if branch and (
        outputs.keys() != cases.keys() or len(outputs) != len(branch["results"])
    ):
        raise JobError(f"{route} returned a different execution inventory")
    verdicts = {}
    for key in selected:
        item = outputs[key] if branch else {"status": "ERROR"}
        status = item["status"]
        # A provisional functional rejection can still become a safety CRASH.
        if (
            status == "FAIL"
            and item.get("phases", {}).get("safety") == "UNKNOWN"
            and cases[key]["status"] == "FAIL"
        ):
            status = "UNKNOWN"
        verdicts[key] = status
    if not set(verdicts.values()) <= set(CASE_STATUSES):
        raise JobError(f"invalid {route} verdict")
    stats.update(
        status="COMPLETED" if branch else "BACKEND_ERROR",
        report=str(path) if branch else None,
        native_report_sha256=raw_hash,
    )
    statuses = Counter(verdicts.values())
    stats.update(
        eligible_executions=len(selected),
        verdict_counts=dict(statuses),
        decided_executions=sum(statuses[s] for s in ("PASS", "FAIL", "CRASH")),
    )
    return route, stats, verdicts


def compare(args):
    output = args.output_dir.resolve()
    if output.exists() and (not output.is_dir() or any(output.iterdir())):
        raise JobError("routes output directory must be empty")
    output.mkdir(parents=True, exist_ok=True)
    source = args.input.resolve()
    if args.from_native:
        native = source
        native_cost = {"source": "existing native report", "measured_this_run": False}
    else:
        native_dir = output / "native"
        native_cost = measure(
            [
                sys.executable,
                "-m",
                "spectest",
                "check",
                str(source),
                "--no-spatial-smt",
                "--output-dir",
                str(native_dir),
                "--compact",
            ],
            output / "measurements/native",
        )
        native = native_dir / "report.json"
        if native_cost["exit_code"] not in (0, 1) or not native.is_file():
            raise JobError(
                f"native run failed; see {output / 'measurements/native/stderr.log'}"
            )
        native_cost.update(measured_this_run=True, tokens=0)
    original = native.read_bytes()
    report = json.loads(original)
    cases = native_cases(report)
    selected = route_case_ids(report)
    raw_hash = hashlib.sha256(original).hexdigest()
    artifacts = {}
    for case_id in selected:
        case = cases[case_id]
        paths = [case["stdout"], case["vc"]["manifest"], *case["vc"]["files"].values()]
        for name in paths:
            if name:
                artifacts[name] = fingerprint(name)
    rows = {
        key: {
            "case_id": key,
            "native_status": case["status"],
            "eligible": key in selected,
            "auto_status": "NOT_RUN",
            "itp_status": "NOT_RUN",
        }
        for key, case in cases.items()
    }
    requested = [r for r in ("auto", "itp") if selected and args.route in (r, "both")]

    def run(route):
        data = run_backend(route, args, native, output, selected, cases, raw_hash)
        if native.read_bytes() != original or any(
            fingerprint(p) != h for p, h in artifacts.items()
        ):
            raise JobError(
                f"original report or proof obligations changed during {route}"
            )
        return data

    concurrent = args.parallel and len(requested) == 2
    if concurrent:
        with ThreadPoolExecutor(max_workers=2) as pool:
            outcomes = list(pool.map(run, requested))
    else:
        outcomes = [run(route) for route in requested]
    routes = {}
    for route, stats, verdicts in outcomes:
        routes[route] = stats
        for key, status in verdicts.items():
            rows[key][route + "_status"] = status
    conflicts = [
        k
        for k, r in rows.items()
        if r["auto_status"] in {"PASS", "FAIL", "CRASH"}
        and r["itp_status"] in {"PASS", "FAIL", "CRASH"}
        and r["auto_status"] != r["itp_status"]
    ]
    result = {
        "schema": "tespec-independent-routes/v1",
        "native_report": str(native),
        "native_report_sha256": raw_hash,
        "native_cost": native_cost,
        "parallel_execution": concurrent,
        "routes": routes,
        "native_executions": len(rows),
        "eligible_executions": len(selected),
        "cases": list(rows.values()),
        "conflicts": conflicts,
        "paired_outcomes": dict(
            Counter(
                row["auto_status"] + "/" + row["itp_status"]
                for row in rows.values()
                if row["eligible"]
            )
        ),
    }
    write(output / "routes.json", result)
    return result


def routes_cli(argv):
    parser = argparse.ArgumentParser(
        prog="qcp-spectest routes",
        description="Run Auto and ITP separately on the same unsolved native executions.",
    )
    parser.add_argument(
        "input", type=Path, help="job, or original report with --from-native"
    )
    parser.add_argument("--output-dir", type=Path, required=True)
    parser.add_argument("--route", choices=("auto", "itp", "both"), default="both")
    parser.add_argument("--from-native", action="store_true")
    parser.add_argument(
        "--parallel",
        action="store_true",
        help="launch both backends concurrently; resource contention may affect timings",
    )
    parser.add_argument(
        "--replay-only", action="store_true", help="use existing ITP proof sources only"
    )
    parser.add_argument("--proof-cache", type=Path)
    parser.add_argument("--switch", default="qcp-8.20")
    parser.add_argument("--agent-timeout", type=float, default=900)
    parser.add_argument("--check-timeout", type=float, default=600)
    parser.add_argument("--spatial-smt-timeout-ms", type=int, default=2000)
    args = parser.parse_args(argv)
    if (
        not 1 <= args.spatial_smt_timeout_ms <= 60000
        or min(args.agent_timeout, args.check_timeout) <= 0
    ):
        parser.error("invalid timeout")
    try:
        result = compare(args)
    except (JobError, OSError, ValueError, KeyError, TypeError) as exc:
        print(str(exc), file=sys.stderr)
        return 2
    print(
        json.dumps(
            {
                "report": str(args.output_dir.resolve() / "routes.json"),
                "eligible": result["eligible_executions"],
                "conflicts": result["conflicts"],
            }
        )
    )
    # This command runs a comparison; individual test verdicts live in routes.json.
    return (
        2
        if any(r["status"] == "BACKEND_ERROR" for r in result["routes"].values())
        else int(bool(result["conflicts"]))
    )


if __name__ == "__main__":
    from .auto_route import run_auto

    frozen, work, timeout = sys.argv[1:]
    original = read(frozen)
    run_auto(
        original,
        Path(work),
        timeout_ms=int(timeout),
        only_case_ids=route_case_ids(original),
    )
