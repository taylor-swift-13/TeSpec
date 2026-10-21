#!/usr/bin/env python3
"""Compact a published group to durable evidence; discard reproducible run trees."""
from pathlib import Path
import argparse, hashlib, json, shutil

ROOT = Path(__file__).resolve().parents[2]


def load(path):
    return json.loads(path.read_text())


def save(path, value):
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(value, ensure_ascii=False, indent=2) + "\n")


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def rel(path):
    return path.relative_to(ROOT).as_posix()


def compact_measurement(value):
    keep = {key: value.get(key) for key in (
        "command", "exit_code", "wall_seconds", "resources", "tokens", "model_calls",
        "status", "final_status", "statuses",
    ) if key in value}
    for field in ("stdout", "stderr", "report"):
        path = ROOT / value[field] if value.get(field) else None
        if path and path.is_file():
            keep[field + "_sha256"] = sha(path)
    return keep


def compact_strategy(path):
    data = load(path)
    rows = []
    for row in data.get("runs", []):
        rows.append({
            "variant": row["variant"], "case": row["case"], "mode": row["mode"],
            "expected": row["expected"], "status": row["current"]["status"],
            "comparison": row["comparison"]["kind"],
            "wall_seconds": row["measurement"]["wall_seconds"],
            "max_process_rss_kib": row["measurement"]["resources"]["max_process_rss_kib"],
            "source": row["source"], "binds": row["binds"],
        })
    compact = {
        "schema": "tespec-compact-strategy-evidence/v1",
        "summary": data["summary"],
        "runs": rows,
        "retention": "Summary, decisions, costs and immutable source/input hashes only; reproducible executor artifacts omitted.",
    }
    save(path, compact)
    for child in list(path.parent.iterdir()):
        if child != path:
            shutil.rmtree(child) if child.is_dir() else child.unlink()
    return compact


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--group", required=True)
    args = parser.parse_args()
    group = ROOT / "benchmark/programs" / args.group
    base = ROOT / "benchmark/results" / args.group
    manifest_path = group / "manifest.json"
    manifest = load(manifest_path)
    index_path = base / "index.json"
    index = load(index_path)
    evaluation_path = ROOT / index["evaluation"]
    native_path = ROOT / index["native_receipt"]
    proof_path = ROOT / index["qcp_receipt"]
    evaluation = load(evaluation_path)
    native = load(native_path)
    proof = load(proof_path)

    variants = {}
    for item in manifest["variants"]:
        value = load(ROOT / item["manifest"])
        variants[value["id"]] = value

    rows = []
    for row in evaluation["runs"]:
        rows.append({
            "variant": row["variant"], "paired_qcp_variant": row["paired_qcp_variant"],
            "case": row["case"], "initial": row.get("initial"),
            "expected": row["expected"], "precondition_valid": row["precondition_valid"],
            "cn_source_sha256": row["cn_source_sha256"],
            "qcp_source_sha256": row["qcp_source_sha256"],
            "harness_sha256": row["harness_sha256"], "binds_sha256": row["binds_sha256"],
            "fulminate_pipeline": compact_measurement(row["fulminate_pipeline"]),
            "fulminate_test": compact_measurement(row["fulminate_test"]),
            "tespec_off": compact_measurement(row["tespec_off"]),
            "tespec_on": compact_measurement(row["tespec_on"]),
        })

    compact_eval = {
        "schema": "tespec-compact-group-evidence/v1",
        "program_group": args.group,
        "evaluation_plan": rel(group / "evaluation-plan.json"),
        "summary": evaluation["summary"],
        "runs": rows,
        "toolchain": {
            key: evaluation["toolchain"].get(key)
            for key in ("cn_sha256", "executor_sha256", "driver_sha256", "compiler_wrapper_sha256", "build")
            if key in evaluation["toolchain"]
        },
        "retention": "Final decisions, costs, commands and hashes only. Raw run trees are reproducible and intentionally omitted.",
    }
    save(evaluation_path, compact_eval)
    for child in list(evaluation_path.parent.iterdir()):
        if child not in {evaluation_path, evaluation_path.parent / "statistics.json", evaluation_path.parent / "comparison.md"}:
            shutil.rmtree(child) if child.is_dir() else child.unlink()

    compact_native = {
        "schema": "tespec-compact-primary-native/v1",
        "program_group": args.group,
        "cn_build": native["cn_build"],
        "cn_source": native["cn_source"], "cn_source_sha256": native["cn_source_sha256"],
        "qcp_source": native["qcp_source"], "qcp_source_sha256": native["qcp_source_sha256"],
        "goal_sha256": native["goal_sha256"],
        "goal_reused_from": proof["original_goal"],
        "cn": compact_measurement(native["cn"]),
        "qcp": compact_measurement(native["qcp"]),
        "qcp_proof_receipt": rel(proof_path),
        "retention": "Measured native stages plus exact proof binding; duplicate generated Goal and logs omitted after hashing.",
    }
    save(native_path, compact_native)
    for child in list(native_path.parent.iterdir()):
        if child != native_path:
            shutil.rmtree(child) if child.is_dir() else child.unlink()

    strategy = manifest.get("execution_strategy_evidence", {})
    for name in ("inline", "modular"):
        if strategy.get(name):
            compact_strategy(ROOT / strategy[name])

    tests = group / "variants" / manifest["primary_variant"].replace(":", "_") / "tests"
    # Variant directory names are not derived from ids uniformly; remove only the active run fixture found by name.
    for fixture in group.glob("variants/*/tests/" + index["run_id"]):
        shutil.rmtree(fixture)

    index["native_receipt_sha256"] = sha(native_path)
    save(index_path, index)
    cn_result_path = base / "cn/results.json"
    cn_result = load(cn_result_path)
    cn_result["evidence_sha256"] = sha(native_path)
    save(cn_result_path, cn_result)
    stats_path = evaluation_path.parent / "statistics.json"
    if stats_path.is_file():
        stats = load(stats_path)
        save(stats_path, {
            "schema": "tespec-compact-spatial-smt-comparison/v1",
            "program_group": stats["program_group"],
            "case_pairs": stats["case_pairs"],
            "results_sha256": sha(evaluation_path),
            "modes": stats["modes"],
            "certificate": stats["certificate"],
            "ordering": stats["ordering"],
        })
    print(json.dumps({"group": args.group, "files_retained": sum(1 for p in base.rglob("*") if p.is_file())}))


if __name__ == "__main__":
    main()
