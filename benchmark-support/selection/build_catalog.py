#!/usr/bin/env python3
"""Build or check the source-complete, evidence-linked benchmark selection."""

from __future__ import annotations

import argparse
from collections import Counter
import csv
import hashlib
import io
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
PAIRED = ROOT / "benchmark/paper-cn-qcp"
SNAPSHOT = HERE / "sources/fulminate-cn"


def read(path: Path):
    return json.loads(path.read_text())


def sha(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def reference(path: Path) -> dict:
    path = path.resolve()
    if not path.is_relative_to(ROOT) or not path.is_file():
        raise ValueError(f"Missing or external input: {path}")
    return {"path": path.relative_to(ROOT).as_posix(), "sha256": sha(path)}


def source_inventory(lock: dict) -> list[str]:
    actual = {p.relative_to(SNAPSHOT).as_posix() for p in SNAPSHOT.rglob("*") if p.is_file()}
    if actual != set(lock["files"]):
        raise ValueError(
            "Fulminate snapshot differs from the complete locked inventory"
        )
    for name, digest in lock["files"].items():
        path = SNAPSHOT / name
        if path.is_symlink() or sha(path) != digest:
            raise ValueError(f"Changed upstream source: {name}")
        if path.suffix not in {".c", ".h", ".txt", ".md", ".sh"}:
            raise ValueError(f"Unexpected upstream file type: {name}")
    names = sorted(
        n for n in actual if n.startswith("src/examples/") and n.endswith(".c")
    )
    core = [n for n in names if len(Path(n).parts) == 3 and "broken" not in n]
    if (
        len(names) != lock["all_c_input_count"]
        or len(core) != lock["core_program_count"]
    ):
        raise ValueError("Incomplete mandatory CN program inventory")
    return names


def cn_category(name: str) -> str:
    stem = Path(name).stem
    if "runtime-extras" in name:
        return "allocation_lifecycle"
    if "Dbl_Linked_List" in name:
        return "lists"
    if "queue" in stem:
        return "queues"
    if "stack" in stem:
        return "stacks"
    if stem in {"list_all", "mergesort"}:
        return "lists"
    if "array" in stem:
        return "arrays"
    if "struct" in stem or "transpose" in stem or stem == "init_point":
        return "structures"
    if "runway" in name:
        return "stateful_resource"
    if stem == "slf18_two_dice":
        return "nondeterminism"
    if (
        stem.startswith("slf")
        or "mem" in stem
        or stem
        in {
            "read",
            "read.broken",
            "read2",
            "add_read",
            "swap",
            "bcp_framerule",
        }
    ):
        return "pointer_ownership"
    return "arithmetic"


def cn_blockers(name: str) -> list[str]:
    stem = Path(name).stem
    result = [
        "Translate original CN contracts while preserving executable bodies and trusted interfaces."
    ]
    if (
        stem
        in {
            "slf10_basic_ref",
            "slf11_basic_ref_greater",
            "slf12_basic_ref_greater_abstract",
            "slf13_basic_ref_with_frame",
            "slf16_basic_succ_using_incr",
            "slf17_get_and_free",
            "slf_sized_stack",
            "list_all",
            "queue_all",
            "mergesort",
        }
        or "runtime-extras" in name
        or "Dbl_Linked_List" in name
    ):
        result.append(
            "Whole-program replay needs CN allocation/free runtime integration and lifecycle semantics; "
            "allocation-free target functions can be evaluated separately."
        )
    if stem == "slf18_two_dice":
        result.append(
            "Pin rand() state or a shared replayable random trace on both sides."
        )
    if "broken" in name:
        result.append(
            "Establish the violated obligation and original driver witness before assigning a negative label."
        )
    return result


def cn_records(lock: dict) -> list[dict]:
    records = []
    migration_dir = HERE / "qcp-migration"
    migrations = read(migration_dir / "manifest.json")
    migration_report_path = migration_dir / "evidence/20261014/report.json"
    migration_report = read(migration_report_path)
    if migration_report["manifest_sha256"] != sha(migration_dir / "manifest.json"):
        raise ValueError("QCP migration report does not match the migration manifest")
    translated = {row["upstream"]: row for row in migrations["cases"]}
    native = {row["case"]: row for row in migration_report["native"]}
    for name in source_inventory(lock):
        relative = Path(name).relative_to("src/examples")
        core = len(relative.parts) == 1 and "broken" not in name
        records.append(
            {
                "id": "fulminate-cn/" + relative.as_posix(),
                "family": "fulminate-cn",
                "track": "mandatory-cn-core"
                if core
                else "mandatory-cn-supplemental-input",
                "counting_unit": "upstream whole program"
                if core
                else "upstream supplemental C input",
                "category": cn_category(name),
                "questions": ["baseline"],
                "selection_reason": "完整上游清单：保留所有原始输入，与当前工具是否成功无关。",
                "source": reference(SNAPSHOT / name),
                "upstream_path": name,
                "upstream_revision": lock["revision"],
                "qcp_translation": "pending-for-this-source-revision",
                "paired_input_count": 0,
                "replay_status": "not-run-for-this-source-revision",
                "blockers": cn_blockers(name),
                "evidence": [],
            }
        )
        if relative.as_posix() in translated:
            migration = translated[relative.as_posix()]
            if migration["upstream_sha256"] != sha(SNAPSHOT / name):
                raise ValueError(f"Migration has a different upstream source: {name}")
            result = native[migration["id"]]
            record = records[-1]
            record.update(
                qcp_translation="function-subset-migrated",
                replay_status="native-qcp-and-tespec-run; CN-pairing-pending",
                qcp_bind_count=sum(len(t["binds"]) for t in migration["targets"]),
                migration_targets={
                    t["function"]: result["functions"]
                    .get(t["function"], {})
                    .get("status", "MISSING_TARGET")
                    if result["status"] == "COMPLETED"
                    else result["status"]
                    for t in migration["targets"]
                },
                migration_notes=migration["notes"],
                evidence=[
                    reference(migration_dir / "manifest.json"),
                    reference(migration_report_path),
                ],
                blockers=[
                    "Finish remaining functions and original CN/QCP pairing; this is function-subset coverage.",
                    "Native automatic obligations are not kernel-certified; inspect helper and target residuals separately.",
                    "teSpec execution gaps and proof obligations are recorded per input in the migration report.",
                ],
            )
    simple = migration_dir / "simple"
    simple_manifest = read(simple / "manifest.json")
    simple_results = read(simple / "verification-index.json")["results"]
    by_source = {row["original"]: row for row in simple_manifest["cases"]}
    by_hash = {row["source_sha256"]: row for row in simple_results}
    for record in records:
        migration = by_source.get(record["source"]["path"])
        if migration is None:
            continue
        if migration["original_sha256"] != record["source"]["sha256"]:
            raise ValueError("Simple migration source mismatch")
        source = ROOT / migration["qcp"]
        if sha(source) != migration["qcp_sha256"]:
            raise ValueError("Simple migration translation mismatch")
        result = by_hash[migration["qcp_sha256"]]
        record.update(
            qcp_translation="target-function-migrated;original-main-excluded",
            replay_status="native-qcp-run;tespec-and-CN-pairing-pending",
            migration_targets={fn: result["functions"].get(fn, {}).get("status", "MISSING_TARGET") if result["status"] == "COMPLETED" else result["status"] for fn in migration.get("functions", [migration["function"]])},
            unit_manual_obligations=result["unit_manual_obligations"],
            prepared_qcp_input_count=migration.get("input_preparation", {}).get("count", 0),
            input_preparation=migration.get("input_preparation", {}),
            ownership_profile=migration.get("ownership_profile", "typed cells"),
            evidence=[reference(simple / "manifest.json"), reference(source),
                      reference(simple / "verification-index.json")],
            blockers=["Original trusted main and matched CN/teSpec input replay pending.",
                      "Native automatic results have not been independently kernel-checked."]
            + ([migration["ownership_profile"]] if "correspondence pending" in migration.get("ownership_profile", "") else [])
            + (["Resolve remaining automatic obligations including helper functions."] if result["unit_manual_obligations"] else []),
        )
    simple = migration_dir / "simple"
    simple_manifest = read(simple / "manifest.json")
    simple_results = read(simple / "verification-index.json")["results"]
    by_source = {row["original"]: row for row in simple_manifest["cases"]}
    by_hash = {row["source_sha256"]: row for row in simple_results}
    for record in records:
        migration = by_source.get(record["source"]["path"])
        if migration is None:
            continue
        if migration["original_sha256"] != record["source"]["sha256"]:
            raise ValueError("Simple migration source mismatch")
        source = ROOT / migration["qcp"]
        if sha(source) != migration["qcp_sha256"]:
            raise ValueError("Simple migration translation mismatch")
        result = by_hash[migration["qcp_sha256"]]
        record.update(
            qcp_translation="target-function-migrated;original-main-excluded",
            replay_status="native-qcp-run;tespec-and-CN-pairing-pending",
            migration_targets={fn: result["functions"].get(fn, {}).get("status", "MISSING_TARGET") if result["status"] == "COMPLETED" else result["status"] for fn in migration.get("functions", [migration["function"]])},
            unit_manual_obligations=result["unit_manual_obligations"],
            prepared_qcp_input_count=migration.get("input_preparation", {}).get("count", 0),
            input_preparation=migration.get("input_preparation", {}),
            ownership_profile=migration.get("ownership_profile", "typed cells"),
            evidence=[reference(simple / "manifest.json"), reference(source),
                      reference(simple / "verification-index.json")],
            blockers=["Original trusted main and matched CN/teSpec input replay pending.",
                      "Native automatic results have not been independently kernel-checked."]
            + ([migration["ownership_profile"]] if "correspondence pending" in migration.get("ownership_profile", "") else [])
            + (["Resolve remaining automatic obligations including helper functions."] if result["unit_manual_obligations"] else []),
        )
    simple = migration_dir / "simple"
    simple_manifest = read(simple / "manifest.json")
    simple_results = read(simple / "verification-index.json")["results"]
    by_source = {row["original"]: row for row in simple_manifest["cases"]}
    by_hash = {row["source_sha256"]: row for row in simple_results}
    for record in records:
        migration = by_source.get(record["source"]["path"])
        if migration is None:
            continue
        if migration["original_sha256"] != record["source"]["sha256"]:
            raise ValueError("Simple migration source mismatch")
        source = ROOT / migration["qcp"]
        if sha(source) != migration["qcp_sha256"]:
            raise ValueError("Simple migration translation mismatch")
        result = by_hash[migration["qcp_sha256"]]
        record.update(
            qcp_translation="target-function-migrated;original-main-excluded",
            replay_status="native-qcp-run;tespec-and-CN-pairing-pending",
            migration_targets={fn: result["functions"].get(fn, {}).get("status", "MISSING_TARGET") if result["status"] == "COMPLETED" else result["status"] for fn in migration.get("functions", [migration["function"]])},
            unit_manual_obligations=result["unit_manual_obligations"],
            prepared_qcp_input_count=migration.get("input_preparation", {}).get("count", 0),
            input_preparation=migration.get("input_preparation", {}),
            ownership_profile=migration.get("ownership_profile", "typed cells"),
            evidence=[reference(simple / "manifest.json"), reference(source),
                      reference(simple / "verification-index.json")],
            blockers=["Original trusted main and matched CN/teSpec input replay pending.",
                      "Native automatic results have not been independently kernel-checked."]
            + ([migration["ownership_profile"]] if "correspondence pending" in migration.get("ownership_profile", "") else [])
            + (["Resolve remaining automatic obligations including helper functions."] if result["unit_manual_obligations"] else []),
        )
    kernel_report = simple / "proofs/report.json"
    if kernel_report.exists():
        checked = {row["id"]: row for row in read(kernel_report)["results"]}
        for record in records:
            migration = by_source.get(record["source"]["path"])
            receipt = checked.get(migration["id"]) if migration else None
            if receipt is None:
                continue
            if receipt["kernel_check_exit"] != 0 or receipt["qcp_source_sha256"] != migration["qcp_sha256"]:
                raise ValueError("Kernel receipt does not match current migration")
            record["kernel_verification"] = {
                "status": "complete-VC-module-checked",
                "vc_count": len(receipt["proved_original_vcs"]),
                "runtime_assumptions": "recorded separately; not axiom-free",
            }
            record["evidence"].append(reference(kernel_report))
            record["blockers"] = [item for item in record["blockers"] if not item.startswith("Native automatic") and not item.startswith("Resolve remaining")]
    finding_path = simple / "advanced/queue-guarded/finding.json"
    if finding_path.exists():
        finding = read(finding_path)
        for record in records:
            if record["source"]["path"] == finding["original"]:
                record["source_contract_finding"] = finding
                record["migration_targets"].update({"push_induction": "RESIDUAL;original-contract-counterexample", "IntQueue_push_induction": "RESIDUAL"})
                record["evidence"].append(reference(finding_path))
                record["blockers"].append("Original push_induction contract has a concrete counterexample; caller depends on it.")
                corrected_receipt = simple / "advanced/queue-corrected/verification-receipt.json"
                if corrected_receipt.exists():
                    certificate = read(corrected_receipt)
                    corrected_source = simple / "advanced/queue-corrected/queue_corrected.qcp.c"
                    if certificate["manual_kernel_exit"] != 0 or sha(corrected_source) != certificate["source_sha256"]:
                        raise ValueError("Corrected queue certificate mismatch")
                    record["original_migration_targets"] = dict(record["migration_targets"])
                    record["migration_targets"].update({"push_induction": "MANUAL_PROVED", "IntQueue_push_induction": "AUTOMATICALLY_DISCHARGED"})
                    record["qcp_translation"] = "corrected-QCP-spec;original-CN-contract-refuted"
                    record["qcp_verification"] = {"status": "automatic-plus-manual-verified", "variant": "corrected-QCP-spec", "auto_vcs": certificate["auto_vcs"], "manual_vcs": certificate["manual_vcs"], "spec_correspondence": "intentional standard-segment replacement; not original CN equivalence"}
                    record["evidence"] += [reference(corrected_source), reference(corrected_receipt), reference(simple / "advanced/queue-corrected/queue-spec-finding.md")]
                    record["blockers"] = [x for x in record["blockers"] if not x.startswith("Original push_induction") and not x.startswith("Resolve remaining")]
                    record["blockers"].append("Original CN contract remains refuted; verified QCP variant intentionally corrects its specification.")

    supplemental_registry = HERE / "qcp-migration/supplemental/registry.json"
    if supplemental_registry.exists():
        supplemental = {row["original"]: row for row in read(supplemental_registry)["records"]}
        for record in records:
            migration = supplemental.get(record["source"]["path"])
            if migration is None:
                continue
            qcp_source = ROOT / migration["qcp"]
            if sha(qcp_source) != migration["qcp_sha256"] or record["source"]["sha256"] != migration["original_sha256"]:
                raise ValueError("Supplemental source/hash mismatch")
            record.update(
                qcp_translation="supplemental-active-QCP-variant;normalizations-and-contract-changes-explicit",
                replay_status="native-qcp-run;CN-paired-execution-pending",
                migration_targets=migration["migration_targets"],
                unit_manual_obligations=migration["native_unit_manual_obligations"],
                qcp_verification={"status": migration["qcp_status"], "scope": migration["verified_scope"]},
                evidence=[reference(supplemental_registry), reference(qcp_source)] + [reference(ROOT / path) for path in migration["evidence"]],
                blockers=["Fixed original CN/teSpec matched-input replay is not complete."],
            )
            if "manual_verification" in migration:
                record["manual_verification"] = migration["manual_verification"]
            if "manual_refutation" in migration:
                record["manual_refutation"] = migration["manual_refutation"]
            for key in ["normalization", "spec_correspondence", "remaining_component_scope", "concrete_witness", "verified_component"]:
                if key in migration:
                    record[key] = migration[key]
            if migration["qcp_status"] != "VERIFIED_AUTOMATIC_PLUS_MANUAL":
                record["blockers"].append("Expected negative outcome is retained; this input is not marked verified.")
    return records


def legacy_record(choice: dict, legacy: dict) -> dict:
    ident, group = choice["id"], choice["group"]
    record = {
        k: v for k, v in choice.items() if k not in {"group", "bindings", "source"}
    }
    record.update(
        track="selected-supplement", counting_unit="target function", evidence=[]
    )
    if group == "expansion80":
        old = legacy[ident]
        folder = PAIRED / "expansion80"
        suite_path = folder / "suites" / ident / "suite.json"
        suite = read(suite_path)
        if "source_snapshot" in old:
            source = folder / old["source_snapshot"]
        else:
            metadata = read(PAIRED / old["case_path"] / "case.json")
            source = PAIRED / metadata["sources"][0]["path"]
        record.update(
            family="qcp" if old["family"].startswith("qcp") else "cav",
            function=suite["function"],
            source=reference(source),
            suite=reference(suite_path),
            qcp_translation="paired-sources-prepared",
            paired_input_count=suite["input_count"],
            replay_status="existing-frozen-replay",
            blockers=[
                "Review representation correspondence and held-out admission separately from verdicts."
            ],
        )
        # This newer report covers all 79 frozen suites, including the tree.
        record["evidence"].append(reference(PAIRED / "review-20261014/summary.json"))
        if old.get("suite_evidence_path"):
            record["evidence"].append(reference(folder / old["suite_evidence_path"]))
        if old.get("paired_translation_receipt"):
            record["evidence"].append(
                reference(folder / old["paired_translation_receipt"])
            )
    elif group in {"qcp-native-examples", "qcp-memory-v2"}:
        folder = PAIRED / group
        item = next(
            p for p in read(folder / "catalog.json")["programs"] if p["id"] == ident
        )
        metadata_path = folder / item["path"] / "case.json"
        metadata = read(metadata_path)
        record.update(
            family="qcp",
            function=metadata["function"],
            source=reference(ROOT / metadata["source"]),
            input_metadata=reference(metadata_path),
            qcp_translation="original-qcp;cn-translation-pending",
            paired_input_count=0,
            qcp_only_input_count=item["inputs"],
            replay_status="existing-qcp-only-replay",
            blockers=["CN translation, shared inputs and matched replay pending."],
        )
        if group == "qcp-memory-v2":
            record["evidence"].append(
                reference(PAIRED / "review-20261014/memory-expansion/summary.json")
            )
        else:
            record["evidence"].append(reference(folder / "replay-report.json"))
    elif group == "runtime-source":
        record.update(
            family="qcp",
            source=reference(ROOT / choice["source"]),
            qcp_translation="original-qcp;cn-translation-pending",
            paired_input_count=0,
            replay_status="not-run-for-selected-target",
            blockers=[
                "Prepare shared finite input models and corresponding CN contracts."
            ],
        )
        if choice.get("bindings"):
            record["qcp_bindings"] = reference(ROOT / choice["bindings"])
            record["replay_status"] = "existing-qcp-instantiation-study"
            record["evidence"].append(
                reference(PAIRED / "review-20261014/summary.json")
            )
    else:
        raise ValueError(f"Unknown selection group: {group}")
    return record


def build() -> dict:
    policy = read(HERE / "policy.json")
    lock = read(HERE / "fulminate-source-lock.json")
    old_catalog = read(PAIRED / "expansion80/catalog.json")
    legacy = {p["id"]: p for p in old_catalog["programs"]}
    records = cn_records(lock)
    records += [legacy_record(p, legacy) for p in policy["supplements"]]
    industrial = dict(policy["industrial"])
    candidate_path = PAIRED / "expansion80/industrial/pkvm-buddy/candidate.json"
    candidate = read(candidate_path)
    industrial.update(
        family="fulminate-pkvm",
        track="mandatory-industrial",
        counting_unit="complete allocator; operation traces are inputs",
        source=reference(
            PAIRED / "expansion80" / candidate["source_snapshot"] / "page_alloc.c"
        ),
        input_metadata=reference(candidate_path),
        qcp_translation="pending",
        paired_input_count=0,
        replay_status="native-and-component-evidence;matched-tool-replay-pending",
        blockers=[
            "Complete CN/QCP contract and ownership correspondence.",
            "Align pointer width, byte encoding, header/page resources and address arithmetic.",
            "Replay complete original allocation/release traces on both tools.",
        ],
        evidence=[
            reference(PAIRED / "expansion80" / candidate["qcp_abi_alignment_audit"])
        ],
    )
    records.append(industrial)
    ids = [r["id"] for r in records]
    if len(ids) != len(set(ids)):
        raise ValueError("Duplicate selected ID")
    for row in records:
        if (
            not row["questions"]
            or not set(row["questions"]) <= policy["questions"].keys()
        ):
            raise ValueError(f"Missing or unknown experiment question: {row['id']}")
    selected = set(ids)
    retired = [
        {
            "id": p["id"],
            "source_family": p["family"],
            "reason": (
                "Modern CN adaptation retained for migration; the mandatory original corpus is counted separately."
                if p["family"].startswith("cn")
                else "Mechanism control retained outside upstream program counts."
                if p["id"] in policy["preserved_controls"]
                else "Historical result retained; selected additions already represent this routine capability."
            ),
        }
        for p in old_catalog["programs"]
        if p["id"] not in selected
    ]
    return {
        "schema": "tespec-source-complete-selection/v1",
        "policy": reference(HERE / "policy.json"),
        "source_lock": reference(HERE / "fulminate-source-lock.json"),
        "counting": "Tracks have distinct units; C inputs, target functions and whole programs are not added as unique programs.",
        "selection_basis": "source membership and experiment questions; outcomes never remove a mandatory input",
        "summary": {
            "cn_core_programs": sum(r["track"] == "mandatory-cn-core" for r in records),
            "cn_supplemental_c_inputs": sum(
                r["track"] == "mandatory-cn-supplemental-input" for r in records
            ),
            "cn_total_c_inputs": lock["all_c_input_count"],
            "qcp_selected_targets": sum(r["family"] == "qcp" for r in records),
            "cav_selected_targets": sum(r["family"] == "cav" for r in records),
            "industrial_subjects": 1,
            "selected_supplement_categories": dict(
                sorted(
                    Counter(
                        r["category"]
                        for r in records
                        if r["track"] == "selected-supplement"
                    ).items()
                )
            ),
            "cn_supplemental_qcp_outcomes": dict(sorted(Counter(
                record.get("qcp_verification", {}).get("status", "not-recorded")
                for record in records if record["track"] == "mandatory-cn-supplemental-input"
            ).items())),
            "cn_original_revision_paired_replay_complete": False,
        },
        "programs": records,
        "retained_historical_entries": retired,
        "retained_controls": policy["preserved_controls"],
        "retained_modern_cn_adaptations": [
            reference(PAIRED / "upstream-memory/catalog.json"),
            reference(PAIRED / "fulminate-memory/catalog.json"),
        ],
    }


def render_csv(catalog: dict) -> str:
    out = io.StringIO(newline="")
    writer = csv.writer(out, lineterminator="\n")
    writer.writerow(
        [
            "id",
            "track",
            "category",
            "source",
            "questions",
            "translation",
            "replay",
            "target_auto_status",
            "kernel_status",
            "kernel_vc_count",
            "prepared_qcp_inputs",
            "selection_reason",
        ]
    )
    for row in catalog["programs"]:
        writer.writerow(
            [
                row["id"],
                row["track"],
                row["category"],
                row["source"]["path"],
                ";".join(row["questions"]),
                row["qcp_translation"],
                row["replay_status"],
                json.dumps(row.get("migration_targets", {}), ensure_ascii=False, sort_keys=True),
                row.get("kernel_verification", {}).get("status", "not-recorded"),
                row.get("kernel_verification", {}).get("vc_count", 0),
                row.get("prepared_qcp_input_count", 0),
                row["selection_reason"],
            ]
        )
    return out.getvalue()


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--write", action="store_true", help="Regenerate catalog.json and programs.csv"
    )
    args = parser.parse_args()
    catalog = build()
    outputs = {
        "catalog.json": json.dumps(catalog, ensure_ascii=False, indent=2) + "\n",
        "programs.csv": render_csv(catalog),
    }
    for name, text in outputs.items():
        path = HERE / name
        if args.write:
            path.write_text(text)
        elif not path.exists() or path.read_text() != text:
            raise SystemExit(
                f"Stale {name}; review inputs, then run this script with --write"
            )
    print(json.dumps(catalog["summary"], ensure_ascii=False, indent=2))


if __name__ == "__main__":
    main()
