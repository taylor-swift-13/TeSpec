#!/usr/bin/env python3
"""Materialize one immutable native execution per eligible case in the latest full matrix."""
import argparse
from collections import Counter
from pathlib import Path
import hashlib
import json

from organize_tespec_routes import RESULTS, digest, fingerprint, inputs, read, save
from regress_auto_guards import batches
from replay_guarded_auto import inventory as guarded_inventory


def jobs(guard, final, remainder):
    for directory, group, _, items in batches(guard):
        yield (group, "original_roots", final / group / directory.name / "routes.json",
               [(key, row) for (key, _), row, _ in items])
    for out in sorted(RESULTS.glob("*/tespec/auto-remaining.json")):
        group = out.parents[1].name
        for row in read(out)["executions"]:
            key = tuple(row[k] for k in ("variant", "case", "strategy"))
            path = remainder / group / digest(key)[:20] / "out/routes.json"
            yield group, "remainder", path, [(key, row)]


def single_report(original, case, batch_path, batch_sha):
    if len(original["results"]) == 1:
        return batch_path.read_bytes()
    statuses = {k: int(case["status"] == k) for k in ("PASS", "FAIL", "UNKNOWN", "CRASH", "ERROR", "INVALID")}
    summary = {"total": 1, **statuses, "specification_only": int(case.get("scope") == "specification-only"),
               "duration_seconds": None, "executor_cpu_seconds": case.get("cpu_seconds"),
               "peak_rss_kb": case.get("peak_rss_kb")}
    tasks = [v for v in original["itp_vcs"] if v["case_id"] == case["id"]]
    projected = original | {"results": [case], "itp_vcs": tasks, "summary": summary,
                            "projection": {"native_report_sha256": batch_sha, "case_id": case["id"]}}
    return (json.dumps(projected, ensure_ascii=False, separators=(",", ":")) + "\n").encode()


def original_signature(vc):
    deps = {k: sorted([(r.get("module"), r.get("sha256"), r.get("compiled_sha256"))
                       for r in vc.get(k, [])], key=str) for k in
            ("coq_dependencies", "generated_coq_dependencies", "runtime_dependencies")}
    return digest({k:vc.get(k) for k in ("immutable_sha256", "residual_goals", "counterexample_goals")}
                  | {"dep":digest(deps)})


def prepare(args):
    rows, scopes, seen, groups = [], Counter(), set(), {}
    pinned = read(RESULTS / "group-result-cost-index.json")["auto_original_roots_measurement"]
    guarded = {(group, batch): raw for group, batch, _, _, raw, _ in guarded_inventory(args.guard)}
    marker = read(args.final/"implementation.json")
    refresh = args.final/"certificate-refresh"
    metadata = read(refresh/"implementation.json") if (refresh/"implementation.json").is_file() else marker
    if metadata["sha256"] != pinned["implementation_sha256"] or metadata.get("initial", marker["sha256"]) != marker["sha256"]:
        raise ValueError("Auto binary profile does not identify the frozen measurements")
    for group, batch in metadata.get("batches", []):
        before = read(args.final/group/batch/"routes.json")
        after = read(refresh/group/batch/"routes.json")
        if any(before[k] != after[k] for k in ("native_report_sha256","spatial_smt_timeout_ms","cases")):
            raise ValueError("certificate refresh changed the original input or its Auto outcome")
    for group, scope, route_path, items in jobs(args.guard, args.final, args.remainder):
        if group not in groups:
            groups[group] = inputs(group)[0]
        rt = read(route_path)
        batch = Path(rt["native_report"])
        batch_sha = fingerprint(batch)
        recorded = guarded[group,route_path.parent.name] if scope == "original_roots" else items[0][1]["native_report_sha256"]
        if batch_sha != rt["native_report_sha256"] or batch_sha != recorded:
            raise ValueError(f"changed native evidence in {route_path}")
        report = read(batch)
        job = Path(report["job"])
        if fingerprint(job) != report["provenance"]["job_sha256"]:
            raise ValueError(f"changed original job in {batch}")
        native = {c["id"]: c for c in report["results"]}
        cases = {r["case_id"]: r for r in rt["cases"]}
        if cases.keys() != native.keys() or len(cases) != len(items):
            raise ValueError(f"changed case inventory in {route_path}")
        for key, archived in items:
            identity = (group, *key)
            if identity in seen:
                raise ValueError(f"duplicate matrix coordinate {identity}")
            seen.add(identity)
            (func, source, bind, expected), _, fault = groups[group][key]
            case_id = archived["executor_case_id"]
            c, r = native[case_id], cases[case_id]
            if not r["eligible"]:
                continue
            if (c["arguments"], c["bindings"], c["execution_strategy"], report["function"]) != (
                    bind.get("args", {}), bind.get("values", {}), key[2], func):
                raise ValueError(f"different input in {route_path}: {case_id}")
            vc = c["vc"]
            for name, sha in vc["immutable_sha256"].items():
                if fingerprint(Path(vc["files"][name])) != sha:
                    raise ValueError(f"changed {name}: {batch} {case_id}")
            actual = fingerprint(Path(c["generated_source"]))
            if actual != c["generated_source_sha256"] or source["sha256"] != archived["source_sha256"] or digest(bind) != archived["input_sha256"]:
                raise ValueError(f"changed source or bindings: {identity}")
            if expected != archived["expected"] or fault != archived["expected_fault_code"]:
                raise ValueError(f"changed oracle: {identity}")
            data = single_report(report, c, batch, batch_sha)
            native_sha = hashlib.sha256(data).hexdigest()
            directory = args.scratch / native_sha
            path = directory / "out/native/report.json"
            path.parent.mkdir(parents=True, exist_ok=True)
            if path.exists() and fingerprint(path) != native_sha:
                raise ValueError(f"conflicting projection in {directory}")
            if not path.exists():
                path.write_bytes(data)
            original_job = directory / "job.json"
            if not original_job.exists():
                original_job.symlink_to(job.resolve())
            if fingerprint(original_job) != report["provenance"]["job_sha256"]:
                raise ValueError(f"wrong parent job for {directory}")
            scopes[scope] += 1
            rows.append(dict(group=group, variant=key[0], case=key[1], strategy=key[2], source_sha256=source["sha256"],
                             executed_source_sha256=actual, input_sha256=digest(bind), goal_sha256=vc["immutable_sha256"]["goal"],
                             original_goal_identity=original_signature(vc), batch_native_report_sha256=batch_sha,
                             native_report_sha256=native_sha, batch_native_path=str(batch), executor_case_id=case_id,
                             expected=expected, expected_fault_code=fault, native_status=c["status"],
                             auto_status=r["auto_status"], scope=scope, route_path=str(route_path),
                             spatial_smt_timeout_ms=rt["spatial_smt_timeout_ms"]))
    index = read(RESULTS/"paired-tool-comparison.json")
    if len(seen) != index["unique_auto"]["executions"] or len({r["native_report_sha256"] for r in rows}) != len(rows):
        raise ValueError("incomplete matrix or duplicated projected report")
    value = {"schema":"tespec-latest-itp-queue/v1","implementation_sha256":pinned["implementation_sha256"],
             "total_matrix_executions":len(seen),"eligibility":dict(scopes),"executions":rows}
    target=args.scratch/"queue.json"
    if target.exists() and read(target) != value:
        raise ValueError("occupied scratch belongs to a different queue")
    save(target, value)
    print("Prepared", len(rows), dict(scopes), flush=True)


if __name__ == "__main__":
    p=argparse.ArgumentParser(description=__doc__)
    for name in ("guard", "final", "remainder", "scratch"):
        p.add_argument("--"+name,type=Path,required=True)
    prepare(p.parse_args())
