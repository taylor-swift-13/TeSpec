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
    return {"path": str(path.relative_to(ROOT)), "sha256": sha(path)}


def source_inventory(lock: dict) -> list[str]:
    actual = {str(p.relative_to(SNAPSHOT)) for p in SNAPSHOT.rglob("*") if p.is_file()}
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
