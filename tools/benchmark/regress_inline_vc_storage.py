#!/usr/bin/env python3
"""Differential native VC storage regression; never rewrites benchmark evidence.

Run explicit old/new binaries serially on loop fixtures, or compare two full
regress_execution_strategies.py results. Exact original Coq artifacts and raw
legacy native fields are compared, not just aggregate PASS/FAIL. New top-level
spec_test storage metrics may be ignored only by an explicit CLI key allowlist.
No Coq proof or ITP certificate is implied by this native regression.
"""
from __future__ import annotations
import argparse
import hashlib
import json
import os
from pathlib import Path
import sys

ROOT = Path(__file__).resolve().parents[2]
OUTPUT_ROOT = ROOT / "benchmark/results/vc-storage-regressions"
COQ_KINDS = ("goal", "proof_auto", "goal_check")
sys.path.insert(0, str(ROOT))
from tools.finite_spatial_smt.regress_completed_groups import measure, now, save


def sha(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def canonical(value):
    return json.dumps(value, sort_keys=True, ensure_ascii=False, separators=(",", ":"))


def resolve(value):
    p = Path(value)
    return (p if p.is_absolute() else ROOT / p).resolve()


def checked_report(path):
    p = resolve(path)
    report = json.loads(p.read_text())
    if len(report.get("results", [])) != 1:
        raise ValueError("Expected exactly one native case: " + str(p))
    return report["results"][0], p


def replace_strings(value, replacements):
    if isinstance(value, str):
        for old, new in replacements:
            value = value.replace(old, new)
        return value
    if isinstance(value, list):
        return [replace_strings(x, replacements) for x in value]
    if isinstance(value, dict):
        return {k: replace_strings(v, replacements) for k, v in value.items()}
    return value


def capture(path, ignored_metrics=(), runtime_metrics=()):
    case, report_path = checked_report(path)
    raw_path = resolve(case["stdout"])
    raw = json.loads(raw_path.read_text())
    # Generated input location differs across paired output folders. Only the
    # exact case output directory prefix is normalized, never formula content.
    case_dir = str(raw_path.parent)
    normalized = replace_strings(raw, [(case_dir, "<case-output>")])
    metrics = {}
    spec = normalized.get("spec_test", {})
    for key in ignored_metrics:
        if key in spec:
            metrics[key] = spec.pop(key)
    runtime = {}
    for key in runtime_metrics:
        if key != "branch_evaluation":
            raise ValueError("Not an allowed execution diagnostic: " + key)
        if key not in spec:
            continue
        value = spec.pop(key)
        fields = ("pure_queries", "evaluated_true", "evaluated_false", "smt_fallback")
        if set(value) != {"schema", *fields} or value["schema"] != "instance-first-branch-query/v1":
            raise ValueError("Unexpected branch diagnostic schema")
        if any(type(value[f]) is not int or value[f] < 0 for f in fields):
            raise ValueError("Invalid branch diagnostic counts")
        if value["pure_queries"] != sum(value[f] for f in fields[1:]):
            raise ValueError("Inconsistent branch diagnostic counts")
        runtime[key] = value
    coq = {}
    for kind in COQ_KINDS:
        value = (case.get("vc") or {}).get("files", {}).get(kind)
        if value:
            p = resolve(value)
            coq[kind] = {"path": str(p), "exists": p.is_file(),
                         "sha256": sha(p) if p.is_file() else None,
                         "bytes": p.stat().st_size if p.is_file() else None}
    decisions = {k: case.get(k) for k in (
        "status", "overall", "precondition_result", "execution_completed",
        "executor_error", "executor_reported_status", "residual_vcs", "vc_results",
        "phases", "result_scope", "sampling_events", "abstraction_events")}
    # Report errors can refer to the invocation's generated source.
    decisions = replace_strings(decisions, [(case_dir, "<case-output>")])
    return {
        "report": str(report_path), "report_sha256": sha(report_path),
        "raw": str(raw_path), "raw_sha256": sha(raw_path),
        "legacy_raw_sha256": hashlib.sha256(canonical(normalized).encode()).hexdigest(),
        "legacy_raw": normalized, "decisions": decisions, "coq": coq,
        "storage_metrics": metrics, "runtime_metrics": runtime, "executor_resources": case.get("resources"),
        "vc_count": len(raw.get("spec_test", {}).get("vc_results", [])),
        "witness_counts": raw.get("WitnessList"),
        "generated_source_sha256": case.get("generated_source_sha256"),
    }


def differences(old, new, prefix=""):
    if type(old) is not type(new):
        return [prefix or "<root>"]
    if isinstance(old, dict):
        result = []
        for key in sorted(set(old) | set(new)):
            path = prefix + "." + key if prefix else key
            if key not in old or key not in new:
                result.append(path)
            else:
                result.extend(differences(old[key], new[key], path))
        return result
    if isinstance(old, list):
        if len(old) != len(new):
            return [prefix + ".length"]
        result = []
        for i, (a, b) in enumerate(zip(old, new)):
            result.extend(differences(a, b, "%s[%d]" % (prefix, i)))
        return result
    return [] if old == new else [prefix]


def compare(old, new):
    raw_diff = differences(old["legacy_raw"], new["legacy_raw"])
    decision_diff = differences(old["decisions"], new["decisions"])
    # Missing artifacts must match too; no fuzzy whitespace/alpha-renaming.
    coq_diff = [kind for kind in set(old["coq"]) | set(new["coq"])
                if (old["coq"].get(kind) or {}).get("sha256")
                != (new["coq"].get(kind) or {}).get("sha256")
                or (old["coq"].get(kind) or {}).get("exists")
                != (new["coq"].get(kind) or {}).get("exists")]
    source_equal = old["generated_source_sha256"] == new["generated_source_sha256"]
    additive_only = not old["storage_metrics"]
    runtime_keys_match = old.get("runtime_metrics", {}).keys() == new.get("runtime_metrics", {}).keys()
    return {
        "passed": not raw_diff and not decision_diff and not coq_diff and source_equal and additive_only and runtime_keys_match,
        "ignored_metrics_are_new_only": additive_only,
        "runtime_metric_keys_match": runtime_keys_match,
        "raw_differences": raw_diff, "decision_differences": decision_diff,
        "coq_byte_differences": sorted(coq_diff), "source_bytes_equal": source_equal,
        "baseline_vc_count": old["vc_count"], "candidate_vc_count": new["vc_count"],
        "original_coq_files_byte_equal": not coq_diff,
        "legacy_raw_equal": not raw_diff,
    }


def compact(snapshot):
    return {k: v for k, v in snapshot.items() if k != "legacy_raw"}


def fixtures(iterations):
    pre = "int sample(int n) /*@ Require 0 <= n && n <= 4096 && emp Ensure __return == n && emp */ "
    for n in iterations:
        yield {"id": "counter-%d" % n, "n": n, "strategy": "inline",
               "mode": "all-boundaries", "expected": "PASS",
               "source": pre + "{ int i=0; int k=7; while(i<n) { k=k+0; i++; } return i; }\n"}
        yield {"id": "last-assertion-%d" % n, "n": n, "strategy": "inline",
               "mode": "all-boundaries", "expected": "FAIL",
               "source": pre + "{ int i=0; while(i<n) { if(i==n-1) { /*@ Assert i==n && emp */ } i++; } return i; }\n"}
        yield {"id": "break-continue-%d" % n, "n": n, "strategy": "inline",
               "mode": "all-boundaries", "expected": "PASS",
               "source": "int sample(int n) /*@ Require 5 <= n && n <= 4096 && emp Ensure __return == 3 && emp */ "
                         "{ int i=0; int c=0; while(i<n) { i++; if(i==2) continue; if(i==5) break; c++; } return c; }\n"}
    for strategy in ("inline", "modular"):
        for mode in ("entry-exit", "all-boundaries"):
            yield {"id": "invariant-%s-%s" % (strategy, mode), "n": 4,
                   "strategy": strategy, "mode": mode, "expected": "PASS",
                   "source": pre + "{ int i=0; /*@ Inv 0 <= i && i <= n && emp */ while(i<n) { i++; } return i; }\n"}
    yield {"id": "ignored-last-assertion", "n": 4, "strategy": "inline",
           "mode": "entry-exit", "expected": "PASS",
           "source": pre + "{ int i=0; while(i<n) { if(i==n-1) { /*@ Assert i==n && emp */ } i++; } return i; }\n"}


def write_summary(out, rows, provenance):
    complete = (len(rows) == provenance["expected_cases"]
                and all(row.get("comparison") is not None for row in rows))
    passed = complete and all(row["comparison"]["passed"] for row in rows)
    summary = {"complete": complete, "passed": passed, "cases": len(rows),
               "failures": [r["id"] for r in rows if not (r.get("comparison") or {}).get("passed")],
               "finished_utc": now(), "tokens": 0, "model_calls": 0,
               "scope": "Native differential regression; no ITP or new universal proof."}
    save(out / "results.json", {"summary": summary, "provenance": provenance, "runs": rows})
    save(out / "summary.json", summary)
    lines = ["# Inline VC storage differential regression", "",
             "Original Coq goal/auto/check bytes, raw native decisions, witness counts and enabled instance traces are compared.",
             "Only generated output directory prefixes, explicitly named additive metrics, and validated branch query counters are normalized.",
             "Runs execute serially. Times/RSS are observations; a single pair does not establish a general speedup.",
             "No ITP or Coq certificate is inferred. Native model tokens: 0.", "",
             "| Case | Exact gate | Old/new VC count | Old/new executor seconds | Old/new peak KiB |",
             "| --- | --- | --- | --- | --- |"]
    for row in rows:
        c = row.get("comparison") or {}
        a = row.get("baseline", {}).get("executor_resources") or {}
        b = row.get("candidate", {}).get("executor_resources") or {}
        lines.append("| %s | %s | %s / %s | %s / %s | %s / %s |" % (
            row["id"], "PASS" if c.get("passed") else "FAIL",
            c.get("baseline_vc_count"), c.get("candidate_vc_count"),
            a.get("wall_seconds"), b.get("wall_seconds"),
            a.get("peak_rss_kib"), b.get("peak_rss_kib")))
    (out / "summary.md").write_text("\n".join(lines) + "\n")
    return summary


def run_pairs(args, out):
    binaries = {"baseline": resolve(args.baseline_binary),
                "candidate": resolve(args.candidate_binary)}
    for value in binaries.values():
        if not value.is_file():
            raise ValueError("Missing binary: " + str(value))
    provenance = {
        "started_utc": now(), "binaries": {k: {"path": str(v), "sha256": sha(v)}
                                           for k, v in binaries.items()},
        "driver_sha256": sha(__file__), "ignored_additive_storage_metrics": args.ignore_storage_metric,
        "validated_runtime_metrics": args.ignore_runtime_metric,
        "execution_order": "baseline then candidate, serial, for each case",
        "trace_max_iterations": args.trace_max_iterations, "iterations": args.iterations,
        "expected_cases": len(list(fixtures(args.iterations))),
    }
    save(out / "provenance.json", provenance)
    rows = []
    for fixture in fixtures(args.iterations):
        folder = out / fixture["id"]
        folder.mkdir()
        source, binds = folder / "input.c", folder / "binds.json"
        source.write_text(fixture["source"])
        save(binds, [{"id": "one", "values": {}, "args": {"n": fixture["n"]}}])
        row = {"id": fixture["id"], "fixture": fixture, "source_sha256": sha(source),
               "binds_sha256": sha(binds), "trace_enabled": fixture["n"] <= args.trace_max_iterations}
        snapshots = {}
        for label, binary in binaries.items():
            run = folder / label
            cli = [sys.executable, "-B", "-m", "spectest", "run", str(source),
                   "--function", "sample", "--binds", str(binds),
                   "--qcp-binary", str(binary), "--execution-strategy", fixture["strategy"],
                   "--execution-mode", fixture["mode"],
                   "--loop-unroll-limit", str(max(16, fixture["n"] + 4)),
                   "--output-dir", str(run / "artifacts"),
                   "--timeout", str(args.timeout), "--no-spatial-smt"]
            if row["trace_enabled"]:
                cli.append("--instance-trace")
            measurement = measure(cli, run, args.timeout + 15)
            report = run / "artifacts/report.json"
            try:
                snap = capture(report, args.ignore_storage_metric, args.ignore_runtime_metric)
                snapshots[label] = snap
                row[label] = {**compact(snap), "measurement": measurement,
                              "matches_expected": snap["decisions"]["status"] == fixture["expected"]}
            except (OSError, ValueError, KeyError) as exc:
                row[label] = {"measurement": measurement, "capture_error": str(exc)}
        if len(snapshots) == 2:
            c = compare(snapshots["baseline"], snapshots["candidate"])
            c["both_match_expected"] = all(row[k]["matches_expected"] for k in binaries)
            c["transport_ok"] = all(row[k]["measurement"]["exit_code"] in (0, 1) for k in binaries)
            c["passed"] &= c["both_match_expected"] and c["transport_ok"]
            row["comparison"] = c
        else:
            row["comparison"] = {"passed": False, "reason": "capture_failed"}
        save(folder / "comparison.json", row)
        rows.append(row)
        print(fixture["id"], "PASS" if row["comparison"]["passed"] else "FAIL", flush=True)
        write_summary(out, rows, provenance)
    provenance["binaries_unchanged"] = all(sha(v) == provenance["binaries"][k]["sha256"]
                                             for k, v in binaries.items())
    summary = write_summary(out, rows, provenance)
    return 0 if summary["passed"] and provenance["binaries_unchanged"] else 1


def compare_suites(args, out):
    before_path, after_path = resolve(args.compare_before), resolve(args.compare_after)
    before, after = json.loads(before_path.read_text()), json.loads(after_path.read_text())
    key = lambda r: (r["group"], r["variant"], r["case"], r["mode"])
    old, new = {key(r): r for r in before["runs"]}, {key(r): r for r in after["runs"]}
    if len(old) != len(before["runs"]) or len(new) != len(after["runs"]):
        raise ValueError("Duplicate suite case keys")
    if set(old) != set(new):
        raise ValueError("Suite coverage differs")
    provenance = {"started_utc": now(), "before": {"path": str(before_path), "sha256": sha(before_path)},
                  "after": {"path": str(after_path), "sha256": sha(after_path)},
                  "driver_sha256": sha(__file__), "ignored_additive_storage_metrics": args.ignore_storage_metric,
        "validated_runtime_metrics": args.ignore_runtime_metric,
                  "expected_cases": len(old)}
    rows = []
    for identity in sorted(old):
        a, b = old[identity], new[identity]
        row = {"id": "/".join(identity)}
        try:
            x = capture(a["report"]["path"], args.ignore_storage_metric, args.ignore_runtime_metric)
            y = capture(b["report"]["path"], args.ignore_storage_metric, args.ignore_runtime_metric)
            row.update(baseline=compact(x), candidate=compact(y), comparison=compare(x, y))
            row["comparison"]["source_input_identity_equal"] = (a["source"] == b["source"] and a["binds"] == b["binds"])
            row["comparison"]["passed"] &= row["comparison"]["source_input_identity_equal"]
        except (OSError, ValueError, KeyError) as exc:
            row["comparison"] = {"passed": False, "reason": str(exc)}
        rows.append(row)
    return 0 if write_summary(out, rows, provenance)["passed"] else 1


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument("--baseline-binary")
    p.add_argument("--candidate-binary", default=os.environ.get("SAC_SYMEXEC"))
    p.add_argument("--compare-before", help="Prior full-suite results.json")
    p.add_argument("--compare-after", help="New full-suite results.json")
    p.add_argument("--output", required=True)
    p.add_argument("--iterations", nargs="+", type=int, default=[16, 64, 256])
    p.add_argument("--timeout", type=int, default=60)
    p.add_argument("--trace-max-iterations", type=int, default=64)
    p.add_argument("--ignore-storage-metric", action="append", default=[],
                   help="Explicit new additive spec_test key excluded from legacy equality; retained in receipts")
    p.add_argument("--ignore-runtime-metric", action="append", default=[],
                   choices=("branch_evaluation",),
                   help="Validate and preserve execution counters separately; never excludes proof or verdict fields")
    args = p.parse_args()
    if not 1 <= args.timeout <= 600 or any(n < 5 or n > 4096 for n in args.iterations):
        p.error("timeout must be 1..600, iterations must be 5..4096")
    comparison = bool(args.compare_before or args.compare_after)
    if comparison and not (args.compare_before and args.compare_after):
        p.error("both --compare-before and --compare-after are required")
    if not comparison and not (args.baseline_binary and args.candidate_binary):
        p.error("paired mode needs --baseline-binary and --candidate-binary (or SAC_SYMEXEC)")
    out = resolve(args.output)
    if out == OUTPUT_ROOT or not out.is_relative_to(OUTPUT_ROOT.resolve()) or out.exists():
        p.error("output must be a fresh child of " + str(OUTPUT_ROOT))
    out.mkdir(parents=True)
    return compare_suites(args, out) if comparison else run_pairs(args, out)


if __name__ == "__main__":
    raise SystemExit(main())
