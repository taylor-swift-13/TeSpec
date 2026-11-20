#!/usr/bin/env python3
"""Check Auto against the archived read or dll_remove results; use --route both for paired replay."""
import argparse
import hashlib
import json
from pathlib import Path
import subprocess
import sys

ROOT = Path(__file__).resolve().parents[2]
sys.path[:0] = [str(ROOT), str(Path(__file__).resolve().parent)]
from tools.benchmark.current_test_plan import load_current_plan
from tools.benchmark.evaluation_expectations import expected
from tools.benchmark.replay_dll_add import execute


def read(path):
    return json.loads(path.read_bytes())


def hash_file(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def cases(group):
    base = ROOT / "benchmark/programs" / group
    plan, _ = load_current_plan(base / "evaluation-plan.json")
    variants = {v["id"]: read(ROOT / v["manifest"]) for v in read(base / "manifest.json")["variants"]}
    tasks = {}
    for pair in plan["pairings"]:
        variant = pair["qcp_variant"]
        source = variants[variant]["files"]["qcp"]
        if hash_file(ROOT / source["path"]) != source["sha256"]:
            raise ValueError("QCP source changed for " + variant)
        for case in pair["cases"]:
            for strategy in ("inline", "modular"):
                key = (variant, case["id"], strategy)
                item = (pair["function"], source, dict(case["binds"], id=case["id"]),
                        expected(case, "tespec_on", strategy))
                if key in tasks and tasks[key] != item:
                    raise ValueError("Conflicting shared QCP input: " + repr(key))
                tasks[key] = item
    return tasks


def matrix_hash(tasks):
    rows = [(key, function, source["sha256"], binds, expectation)
            for key, (function, source, binds, expectation) in sorted(tasks.items())]
    encoded = json.dumps(rows, sort_keys=True, separators=(",", ":"), ensure_ascii=False)
    return hashlib.sha256(encoded.encode()).hexdigest()


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("group", choices=("dll_remove", "read"))
    parser.add_argument("--output", type=Path, required=True, help="fresh output directory")
    parser.add_argument("--case", help="one frozen case ID")
    parser.add_argument("--strategy", choices=("inline", "modular"))
    parser.add_argument("--variant", help="one frozen QCP variant ID")
    parser.add_argument("--route", choices=("auto", "itp", "both"), default="auto",
                        help="default: auto; use both for paired replay with checked proof sources")
    args = parser.parse_args()
    output = args.output.resolve()
    output.mkdir(parents=True, exist_ok=True)
    if any(output.iterdir()):
        parser.error("output must be empty")
    evidence = ROOT / "benchmark/results" / args.group / "residual-routes"
    comparison = read(evidence / "comparison.json")
    tasks = cases(args.group)
    if matrix_hash(tasks) != comparison["input_matrix_sha256"]:
        raise ValueError("Variant, source, case, bindings or expectation differ from the measured batch")
    records = comparison["executions"]
    previous = {(r["variant"], r["input"], r["strategy"]): r for r in records}
    itp_config = output / "itp-config.json"
    if args.route in {"both", "itp"}:
        itp_config.write_text(json.dumps({"check_timeout": 900}))
    selected = 0
    for key, (function, source, binds, _) in tasks.items():
        variant, case, strategy = key
        if any(a is not None and a != b for a, b in
               [(args.variant, variant), (args.case, case), (args.strategy, strategy)]):
            continue
        selected += 1
        folder = output / (variant.replace(":", "_") + "-" + case + "-" + strategy)
        native, _ = execute(folder, function, source, 32, binds, strategy, "off")
        cache = folder / "cache"
        proof = previous[key].get("itp_proof")
        if proof and args.route in {"both", "itp"}:
            cache.mkdir()
            candidate = read(evidence / "proofs.json")[proof["candidate_sha256"]].encode("utf-8")
            if hashlib.sha256(candidate).hexdigest() != proof["candidate_sha256"]:
                raise ValueError("Archived candidate changed")
            # The controller computes the key again from the new source, input,
            # VC and complete runtime context, then independently rechecks Coq.
            (cache / (proof["cache_key"] + ".v")).write_bytes(candidate)
        command = [sys.executable, "-B", "-m", "spectest", "routes", "--native-report", str(native),
                   "--output-dir", str(folder / "routes"), "--route", args.route]
        if args.route in {"both", "itp"}:
            command += ["--proof-cache", str(cache), "--itp-replay-only", "--itp-config", str(itp_config)]
        subprocess.run(command, cwd=ROOT, check=True)
        replay, = read(folder / "routes/routes.json")["cases"]
        reference = previous[key]
        active = ("auto", "itp") if args.route == "both" else (args.route,)
        fields = ["native_status", *(route + "_status" for route in active)]
        if any(replay[field] != reference[field] for field in fields):
            raise ValueError(f"Route result changed for {key}: {replay}")
    if not selected:
        parser.error("no frozen input matched")


if __name__ == "__main__":
    main()
