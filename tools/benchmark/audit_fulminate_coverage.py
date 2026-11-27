#!/usr/bin/env python3
"""Audit finite Fulminate executions against frozen CN targets and phase receipts."""

import argparse
from collections import Counter, defaultdict
from functools import lru_cache
import json
from pathlib import Path
import re

from cn_toolchain import ROOT, sha

RESULTS = ROOT / "benchmark/results"
GROUPS = ROOT / "benchmark/programs"
DLL = RESULTS / "dll_remove/fulminate"
DLL_COST = DLL / "replay-measurements.json"
AUDIT = RESULTS / "fulminate-coverage.json"
HEAD = re.compile(
    r"\b([a-zA-Z_]\w*)\s*\((?:(?!\*/)[^(){};])*\)\s*((?:(?:/\*[\s\S]*?\*/|//[^\n]*\n)\s*)*)\{"
)
ANNOTATION = re.compile(r"/\*@([\s\S]*?)\*/")


@lru_cache(maxsize=None)
def read(path):
    return json.loads(Path(path).read_bytes())


def save(path, data):
    path.write_text(json.dumps(data, ensure_ascii=False, indent=2) + "\n")


def require(condition, message):
    if not condition:
        raise ValueError(str(message))


def key(row):
    return row["variant"], row.get("case", row.get("case_id"))


def keyed(rows):
    table = {key(r): r for r in rows}
    require(len(table) == len(rows), "duplicate CN variant/case")
    return table


def import_dll_measurements(receipt):
    raw = read(receipt)
    historical = read(DLL / "results.json")
    expected = keyed(historical["runs"])
    replay = keyed(raw["rows"])
    require(replay.keys() == expected.keys(), "dll_remove replay inventory changed")
    require(
        raw["plan_sha256"] == sha(GROUPS / "dll_remove/evaluation-plan.json"), receipt
    )
    measurements = {m["id"]: m for m in raw["measurements"]}
    rows = []
    for ident, row in replay.items():
        old = expected[ident]
        for field in (
            "source_sha256",
            "harness_sha256",
            "expected",
            "status",
            "contract_checked",
            "driver_semantic_oracle",
        ):
            require(old[field] == row[field], (ident, field))
        for field in ("calls_dll_pre", "calls_dll_post", "checks_removed_payload"):
            require(
                old["instrumentation"][field] == row["instrumentation"][field],
                (ident, field),
            )
        record = {
            "variant": ident[0],
            "case": ident[1],
            "source_sha256": row["source_sha256"],
            "harness_sha256": row["harness_sha256"],
            "binary_sha256": row["binary_sha256"],
            "instrumented_unit_sha256": row["instrumentation"]["unit_sha256"],
            "actual": row["status"],
        }
        for field in ("pipeline", "test"):
            stage = measurements[row[field]]
            validate_stage(stage, (ident, field))
            record[field] = {
                k: stage[k]
                for k in (
                    "exit_code",
                    "wall_seconds",
                    "max_process_rss_kib",
                    "tokens",
                    "stdout_sha256",
                    "stderr_sha256",
                )
            }
        rows.append(record)
    require(len(measurements) == 2 * len(rows), "unaccounted replay stage")
    totals = {
        stage: {
            "attempts": len(rows),
            "wall_seconds": sum(r[stage]["wall_seconds"] for r in rows),
            "max_process_rss_kib": max(r[stage]["max_process_rss_kib"] for r in rows),
            "tokens": 0,
        }
        for stage in ("pipeline", "test")
    }
    save(
        DLL_COST,
        {
            "totals": totals,
            "scope": "Separate replay, retained because the historical published phase IDs resolved only to aggregated costs. The historical run and its costs remain in the group results/statistics. Source, driver, outcome and observed contract-check flags match for each input. Binary and generated unit digests belong to this replay.",
            "reproduce": historical["reproduce"],
            "toolchain": historical["toolchain_ref"],
            "plan_sha256": raw["plan_sha256"],
            "receipts_sha256": sha(receipt),
            "cases": rows,
        },
    )


def validate_stage(stage, ident):
    require(isinstance(stage, dict), (ident, "no stage"))
    rss = stage.get(
        "max_process_rss_kib", stage.get("resources", {}).get("max_process_rss_kib")
    )
    require(
        isinstance(stage.get("exit_code"), int)
        and stage.get("wall_seconds", 0) > 0
        and rss
        and rss > 0
        and stage.get("tokens") == 0,
        (ident, stage),
    )


def measurements(group, result, statistics, rows):
    if group == "dll_add":
        ref = statistics["cost_ledger"]
        require(sha(ROOT / ref["path"]) == ref["sha256"], ref)
        ledger = {m["id"]: m for m in read(ROOT / ref["path"])["measurements"]}
        return {
            k: (ledger[r["pipeline"]], ledger[r["test"]], r) for k, r in rows.items()
        }
    if group == "dll_remove":
        return {
            k: (r["pipeline"], r["test"], r)
            for k, r in keyed(read(DLL_COST)["cases"]).items()
        }
    if group == "read":
        archived = keyed(read(ROOT / next(iter(rows.values()))["raw_report"])["runs"])
        return {
            k: (
                r["instrument_compile_initial_execution"],
                r["runtime_test"],
                archived[k],
            )
            for k, r in rows.items()
        }
    if result.get("evidence"):
        archived = keyed(read(ROOT / result["evidence"])["runs"])
        return {
            k: (
                r.get("fulminate_pipeline", r.get("pipeline")),
                r.get("fulminate_test", r.get("test")),
                r,
            )
            for k, r in archived.items()
        }
    return {k: (r["build"], r["test"], r) for k, r in rows.items()}


@lru_cache(maxsize=None)
def declaration(path, name):
    # C identifiers with this spelling can also appear inside block and line comments.
    text = path.read_text()
    matches = [m for m in HEAD.finditer(text) if m[1] == name]
    if len(matches) != 1:
        return None
    annotations = " ".join(ANNOTATION.findall(matches[0][2]))
    return bool(re.search(r"\b(?:requires|ensures)\b", annotations)), bool(
        re.search(r"\btrusted\s*;", annotations)
    )


def source_target(group, name, src, driver, result):
    if group == "array_load" and name in ("read", "verify_main"):
        name = {"read": "array_load_read", "verify_main": "main"}[name]
        require("array_load_read(" in driver.replace(" ", ""), (group, name))
    flags = declaration(src, name)
    if flags is None and group == "runway__funcs2":
        # The actual build inlines these exact archived headers and checks the hashes.
        for filename, digest in result["compatibility"]["headers"].items():
            header = ROOT / "arxiv/fulminate-cn/src/examples/runway" / filename
            require(sha(header) == digest, header)
            flags = declaration(header, name)
            if flags is not None:
                break
    require(flags is not None, (src, name))
    return name, *flags


def audit_group(group, folder):
    planpath = GROUPS / group / "evaluation-plan.json"
    resultpath, statpath = folder / "results.json", folder / "statistics.json"
    plan = read(planpath)
    result = read(resultpath)
    rows = keyed(result.get("cases", result.get("runs")))
    costs = measurements(group, result, read(statpath), rows)
    require(rows.keys() == costs.keys(), (group, "measurements mismatch"))
    sources = {}
    for variant in read(planpath.parent / "manifest.json")["variants"]:
        file = read(ROOT / variant["manifest"])["files"].get("cn")
        if file:
            path = ROOT / file["path"]
            require(sha(path) == file["sha256"], file)
            sources[variant["id"]] = (path, file["sha256"])
    seen = set()
    stats, statuses, exceptions = Counter(), Counter(), defaultdict(list)
    for pair in plan["pairings"]:
        variant = pair["cn_variant"]
        src, digest = sources[variant]
        for case in pair["cases"]:
            ident = (variant, case["id"])
            require(ident not in seen, ident)
            seen.add(ident)
            row = rows[ident]
            pipeline, test, archived = costs[ident]
            validate_stage(pipeline, (ident, "build"))
            validate_stage(test, (ident, "test"))
            source_hash = archived.get(
                "source_sha256", archived.get("cn_source_sha256")
            )
            if source_hash:
                require(source_hash == digest, (ident, "source hash"))
            else:
                # The singleton receipt binds the exact driver file, which embeds the original function.
                harness = ROOT / archived["harness"]
                require(
                    sha(harness) == archived["harness_sha256"]
                    and src.read_bytes().strip() in harness.read_bytes(),
                    ident,
                )
            status = row.get(
                "raw_actual", row.get("actual", row.get("status", test.get("status")))
            )
            require(
                isinstance(status, str)
                and (status == "PASS") == (test["exit_code"] == 0),
                (ident, status),
            )
            statuses[status] += 1
            stats["executed_inputs"] += 1
            match = row.get(
                "matches_expected", row.get("correct", status == row["expected"])
            )
            stats["matched_published_expectation"] += int(match)
            if not match:
                exceptions[
                    (
                        "observed_expectation_mismatch",
                        variant,
                        pair.get("function", plan["function"]),
                        row["expected"] + " / " + status,
                    )
                ].append(case["id"])
            name, explicit, trusted = source_target(
                group,
                pair.get("function", plan["function"]),
                src,
                case["cn_body"],
                result,
            )
            if row.get("expected") is not None:
                require(
                    match
                    == (
                        status == row["expected"]
                        or (
                            group == "read"
                            and status == "RUNTIME_FAILURE"
                            and row["expected"] in {"FAIL", "ERROR"}
                        )
                    ),
                    (
                        ident,
                        "published verdict and expectation disagree",
                        row["expected"],
                        status,
                        match,
                    ),
                )
            if "contract_checked" in row:
                require(row["contract_checked"] == explicit, (ident, name, explicit))
            different_pair = (
                pair.get("contract_comparison", {}).get("same_contract_comparison")
                is False
            )
            if different_pair:
                stats["explicitly_different_paired_contracts"] += 1
            if explicit:
                stats["explicit_target_contract"] += 1
                stats[
                    "matched_published_expectation_with_explicit_target_contract"
                ] += int(match)
                if different_pair:
                    stats["explicit_target_contract_with_recorded_pair_difference"] += 1
            else:
                stats["target_contract_na"] += 1
                mode = (
                    "trusted target, no requires/ensures"
                    if trusted
                    else "no requires/ensures"
                )
                checks = []
                if re.search(r"/\*@\s*assert\b", case["cn_body"]):
                    checks.append("plan driver contains CN assertion")
                if row.get("driver_semantic_oracle") is True:
                    checks.append("driver validates target result")
                if row.get("driver_semantic_oracle") is False:
                    checks.append("driver has no semantic result oracle")
                exceptions[
                    ("target_contract_na", variant, name, ", ".join([mode] + checks))
                ].append(case["id"])
            if result.get("locked_original_outcomes"):
                require(row["locked_original"]["status"] == "NOT_BUILT", ident)
                stats["legacy_syntax_adapted_original_build_rejected"] += 1
    require(seen == rows.keys(), (group, "plan inventory mismatch"))
    return {
        "counts": dict(stats),
        "native_status_counts": dict(statuses),
        "phase_cost_evidence": str(
            (DLL_COST if group == "dll_remove" else resultpath).relative_to(ROOT)
        ),
        "scope_exceptions": [
            {"kind": k, "variant": v, "cn_function": n, "detail": d, "cases": ids}
            for (k, v, n, d), ids in sorted(exceptions.items())
        ],
    }


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--import-dll-remove-receipts", type=Path)
    args = parser.parse_args()
    if args.import_dll_remove_receipts:
        import_dll_measurements(args.import_dll_remove_receipts)
    groups = {}
    total, statuses = Counter(), Counter()
    for program in sorted(GROUPS.glob("*/evaluation-plan.json")):
        name = program.parent.name
        item = audit_group(name, RESULTS / name / "fulminate")
        groups[name] = item
        total.update(item["counts"])
        statuses.update(item["native_status_counts"])
    audit = {
        "schema": "fulminate-finite-coverage/v1",
        "groups_evaluated": len(groups),
        "scope": "Distinct (CN variant, input ID) in each frozen plan. Each recorded standalone invocation and preceding instrument/compile/initial-run phase has an exit code, positive wall time and peak process RSS, and zero tokens. The plan and original source are checked against phase evidence. Source declarations are audited separately from observed executable status. An instrumented body can exercise assertions, calls and memory operations even without declared target pre/postconditions. Explicit target contract denotes a source declaration, not an independent check of every emitted C assertion or parity with a paired QCP specification. Legacy-header/source compatibility scopes and tool versions are recorded in each evaluation.",
        "counts": dict(total),
        "native_status_counts": dict(statuses),
        "groups": groups,
    }
    save(AUDIT, audit)
    print(len(groups), dict(total), dict(statuses))


if __name__ == "__main__":
    main()
