#!/usr/bin/env python3
"""Recreate the dll_add teSpec execution matrix from the checked-in plan and ABI."""
import argparse
from itertools import product
import json
from pathlib import Path
import subprocess
import sys
import time

ROOT = Path(__file__).resolve().parents[2]
sys.path[:0] = [str(ROOT), str(Path(__file__).resolve().parent)]
from spectest.proof_reuse import dependency_ids
from spectest.run_certificates import check_run_certificates, prepare_run_certificates
from tools.benchmark.current_test_plan import load_current_plan
from tools.benchmark.evaluation_expectations import expected
from tools.benchmark.publish_replayed_certificate import source_candidate
from tools.finite_spatial_smt import regress_completed_groups as metrics

GROUP = ROOT / "benchmark/programs/dll_add"
RUNTIME = ROOT / "runtime/qcip"


def group_inputs():
    plan, _ = load_current_plan(GROUP / "evaluation-plan.json")
    unique = {}
    for pairing in plan["pairings"]:
        if pairing["qcp_variant"] != plan["primary_qcp_variant"] or pairing["function"] != plan["function"]:
            raise ValueError("dll_add no longer shares a single QCP variant and function across pairings")
        cases = {}
        for case in pairing["cases"]:
            oracle = {(strategy, mode): expected(case, "tespec_" + mode, strategy)
                      for strategy in ("inline", "modular") for mode in ("off", "on")}
            cases[case["id"]] = ({"id": case["id"], **case["binds"]}, oracle)
        if len(cases) != len(pairing["cases"]) or (unique and cases != unique):
            raise ValueError("dll_add case IDs and bindings must agree across the shared pairings")
        unique = cases
    variants = metrics.load(GROUP / "manifest.json")["variants"]
    [reference] = [v for v in variants if v["id"] == plan["primary_qcp_variant"]]
    variant_path = ROOT / reference["manifest"]
    variant = metrics.load(variant_path)["files"]["qcp"]
    if metrics.digest(ROOT / variant["path"]) != variant["sha256"]:
        raise ValueError("QCP source hash differs from the variant manifest")
    abi = variant_path.parent / "dependencies/coq"
    layout = metrics.load(abi / "target-layout.json")
    for name, checksum in metrics.load(abi / "layout-libraries.json")["files"].items():
        if metrics.digest(abi / name) != checksum:
            raise ValueError("ABI dependency hash mismatch: " + name)
    return plan["function"], variant, layout["architecture_bits"], unique


def execute(folder, function, source, bits, bind, strategy, spatial):
    folder.mkdir()
    output = folder / "auto"
    job = {
        "source": str(ROOT / source["path"]), "function": function, "binds": [bind],
        "output_dir": str(output),
        "qcp": {
            "binary": str(ROOT / "bin/tespec-symexec"), "qcip_root": str(RUNTIME),
            "architecture_bits": bits, "vc_scope": "all-boundaries",
            "execution": strategy, "spatial_smt": spatial == "on",
            "loop_unroll_limit": 64, "call_depth_limit": 64, "timeout_seconds": 30,
            "spatial_smt_timeout_ms": 2000,
            "include_dirs": [str(RUNTIME / "QCP_examples/QCP_demos_human"),
                             *(str(ROOT / d) for d in source["include_dirs"])],
        },
    }
    job_file = folder / "job.json"
    metrics.save(job_file, job)
    resource_file = folder / "cli-metrics.json"
    command = [
        "/usr/bin/time", "--quiet", "-f",
        '{"max_process_rss_kib":%M,"user_seconds":%U,"system_seconds":%S}',
        "-o", str(resource_file), sys.executable, "-B", str(Path(__file__).resolve()),
        "--worker", str(folder), "check", str(job_file), "--output-dir", str(output), "--compact",
    ]
    started = time.monotonic()
    with (folder / "stdout.log").open("wb") as out, (folder / "stderr.log").open("wb") as err:
        run = subprocess.run(command, cwd=ROOT, stdout=out, stderr=err, timeout=90)
    elapsed = time.monotonic() - started
    path = output / "report.json"
    if run.returncode not in (0, 1) or not path.is_file():
        raise RuntimeError(f"teSpec exited with {run.returncode}; see {folder}/stderr.log")
    cli = json.loads(resource_file.read_bytes())
    cli["wall_seconds"] = elapsed
    metrics.save(resource_file, cli)
    report = json.loads(path.read_bytes())
    case, = report["results"]
    return path, case["status"]


def archived_source(report, entry):
    case, = report["results"]
    origin = metrics.load(ROOT / "benchmark/results/dll_add/evidence/proofs" / f"modular-off-{case['id']}.json")
    native = {"args": case["arguments"], "values": case["bindings"]}
    bundle = json.loads(Path(entry["manifest"]).read_bytes())
    manifest = json.loads(Path(case["vc"]["manifest"]).read_bytes())
    context = metrics.load(ROOT / origin["logical_context"]["path"])
    if (origin["native_input"] != native or origin["input"] != [{"id": case["id"], **native}]
            or case["type_bindings"] or Path(report["source"]).resolve() != ROOT / origin["source"]["path"]
            or report["provenance"]["source_sha256"] != origin["source"]["sha256"]
            or origin["goal"]["sha256"] != bundle["original_goal_sha256"]
            or origin["targets"] != [target["proof"] for target in bundle["goals"]]
            or context["target_layout"] != bundle["target_layout"]
            or any(dependency_ids(context[k]) != dependency_ids(manifest[k])
                   for k in ("coq_dependencies", "runtime_dependencies"))):
        raise ValueError("Archived source does not match this input, goal and logical context")
    expected_deps = {d["sha256"] for d in bundle["dependencies"]}
    evidence = dict(origin, dependencies=[d for d in origin["dependencies"] if d["sha256"] in expected_deps])
    return source_candidate(ROOT, origin, evidence)


def replay_proof(report_path, folder):
    automatic = json.loads(report_path.read_bytes())
    prepared = prepare_run_certificates(report_path, folder, decision_only=True)
    manifest = Path(prepared["manifest"])
    entries = json.loads(manifest.read_bytes())["certificates"]
    if len(entries) != 1:
        raise ValueError("Expected one original decision task for this unresolved execution")
    entry, = entries
    Path(entry["editable"]).write_text(archived_source(automatic, entry))
    # The normal controller measures each candidate, recompiles and audits it,
    # and runs full coqchk. This replay command only supplies archival source.
    checked = check_run_certificates(manifest, prepared["manifest_sha256"], timeout=600,
                                     candidate_attempts=lambda _: (None,))
    return checked["results"][0]["status"]


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", type=Path, required=True, help="fresh output directory")
    parser.add_argument("--case", action="append", help="select an input ID (repeatable)")
    parser.add_argument("--strategy", choices=("inline", "modular"))
    parser.add_argument("--spatial", choices=("off", "on"))
    parser.add_argument("--with-proofs", action="store_true",
                        help="independently recheck archived proof source for every unresolved execution")
    args = parser.parse_args()
    fn, source, bits, binds = group_inputs()
    cases = list(dict.fromkeys(args.case or binds))
    if set(cases) - binds.keys():
        parser.error("unknown input; select from " + ", ".join(binds))
    root = args.output.resolve()
    root.mkdir(parents=True, exist_ok=True)
    if any(root.iterdir()):
        parser.error("the reproduction output directory must be empty")
    mismatches = 0
    for strategy, spatial, case in product([args.strategy] if args.strategy else ("inline", "modular"),
                                          [args.spatial] if args.spatial else ("off", "on"), cases):
        folder = root / f"{strategy}-{spatial}-{case}"
        bind, oracle = binds[case]
        report, native = execute(folder, fn, source, bits, bind, strategy, spatial)
        final = replay_proof(report, folder / "proof") if args.with_proofs and native == "UNKNOWN" else native
        expectation = oracle[(strategy, spatial)]
        mismatches += final != expectation
        print(f"{folder.name} native={native} final={final} expected={expectation}", flush=True)
    return 1 if args.with_proofs and mismatches else 0


if __name__ == "__main__":
    if sys.argv[1:2] == ["--worker"]:
        folder = Path(sys.argv[2])
        # The shared meter confines its output paths to its own run directory.
        metrics.ROOT = metrics.OUTPUT_ROOT = folder
        sys.exit(metrics.worker(str(folder / "phase-metrics.json"), sys.argv[3:]))
    sys.exit(main())
