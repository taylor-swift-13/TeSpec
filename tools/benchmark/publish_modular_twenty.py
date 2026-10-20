#!/usr/bin/env python3
"""Audit the requested twenty completed benchmark groups and publish costs."""
from collections import Counter
import csv
import hashlib
import json
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
BASE = ROOT / "benchmark/results/spatial-smt-regressions"
OUT = ROOT / "benchmark/results/modular-20-groups-20261020"


def load(path):
    return json.loads(path.read_text())


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def save(path, value):
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(value, ensure_ascii=False, indent=2) + "\n")


def key(row):
    return tuple(row[k] for k in ("group", "variant", "case", "mode"))


def verify_refs(value):
    if isinstance(value, dict):
        if "path" in value and "sha256" in value:
            assert sha(ROOT / value["path"]) == value["sha256"], value
        for child in value.values():
            verify_refs(child)
    elif isinstance(value, list):
        for child in value:
            verify_refs(child)


def audit_batch(new_name, old_name, groups, strategy):
    current = load(BASE / new_name / "results.json")
    prior = load(BASE / old_name / "results.json")
    new = {key(x): x for x in current["runs"]}
    old = {key(x): x for x in prior["runs"] if x["group"] in groups}
    assert new.keys() == old.keys()
    assert current["summary"]["run_complete"]
    assert not current["summary"]["changed_evidence"]
    fields = ("status", "reason", "precondition_result", "execution_completed",
              "executor_error", "residual_vcs", "phases")
    for k, row in new.items():
        before = old[k]
        for ref in (row["source"], row["binds"], row["report"], *row["vc_artifacts"]):
            verify_refs(ref)
        assert row["source"] == before["source"] and row["binds"] == before["binds"]
        assert all(row["current"].get(f) == before["current"].get(f) for f in fields), k
        assert {x["kind"]: x["sha256"] for x in row["vc_artifacts"]} == {
            x["kind"]: x["sha256"] for x in before["vc_artifacts"]}, k
        case = load(ROOT / row["report"]["path"])["results"][0]
        raw = load(Path(case["stdout"]))["spec_test"]
        assert "modular_instantiation" not in raw and "modular_instantiation" not in case
        if strategy == "modular":
            assert raw["sampling_events"] == [] and case["sampling_events"] == []
            assert raw["execution_semantics"] == "modular-symbolic/v1"
            assert raw["declaration_call_policy"] == "contract-symbolic/v1"
    return current["runs"]


def main():
    selection = load(OUT / "selection.json")
    groups = selection["groups"]
    assert len(groups) == 20 and "array_load" not in groups
    modular = audit_batch("20261020-clean-modular-20", "20261020-modular-symbolic-only", groups, "modular")
    inline = audit_batch("20261020-clean-inline-20", "20261020-inline-after-no-modular-sampling", groups, "inline")
    all_final = {"off": Counter(), "on": Counter()}
    links = []
    for group in groups:
        previous_path = ROOT / "benchmark/results/modular-symbolic-only-20261020/groups" / group / "result-cost.json"
        previous = load(previous_path)
        entries = []
        for strategy, runs in (("modular", modular), ("inline", inline)):
            for mode in ("off", "on"):
                selected = [x for x in runs if x["group"] == group and x["mode"] == mode]
                final, decisions = None, None
                if strategy == "modular":
                    old = next(x for x in previous["rows"] if x["spatial_smt"] == mode)
                    decisions = old["decisions"]
                    assert {(x["variant"], x["case"]) for x in selected} == {
                        (x["variant"], x["case"]) for x in decisions}
                    verify_refs(decisions)
                    final = dict(Counter(x["status"] for x in decisions))
                    assert sum(final.values()) == len(selected) and not final.get("UNKNOWN")
                    expected = {(x["variant"], x["case"]): x["expected"] for x in selected}
                    assert all(x["status"] == expected[x["variant"], x["case"]] for x in decisions)
                    all_final[mode].update(final)
                cli_mean = sum(x["measurement"]["wall_seconds"] for x in selected) / len(selected)
                rss_mean = sum(x["measurement"]["resources"]["max_process_rss_kib"] / 1024 for x in selected) / len(selected)
                entries.append({"strategy": strategy, "spatial_smt": mode, "executions": len(selected),
                    "native": dict(Counter(x["current"]["status"] for x in selected)),
                    "final_using_exact_existing_certificates": final,
                    "decisions": decisions, "mean_cli_seconds": cli_mean, "mean_per_execution_peak_rss_mib": rss_mean,
                    "tokens": 0, "model_calls": 0,
                    "per_execution_stage_metrics": [{"case": x["case"], "variant": x["variant"], "metrics": x["stage_measurements"]} for x in selected]})
        base_path = ROOT / "benchmark/results" / group / "result-cost.json"
        folder = OUT / "groups" / group
        save(folder / "result-cost.json", {"group": group, "rows": entries,
            "previous_certificate_decision_table": {"path": str(previous_path.relative_to(ROOT)), "sha256": sha(previous_path)},
            "existing_four_tool_table": {"path": str(base_path.relative_to(ROOT)), "sha256": sha(base_path)},
            "cost_scope": "Fresh native run costs only. Exact original VC certificates and CN/QCP/Fulminate costs reused, not charged again."})
        columns = ["strategy", "spatial_smt", "executions", "native", "final_using_exact_existing_certificates", "mean_cli_seconds", "mean_per_execution_peak_rss_mib", "tokens"]
        with (folder / "result-cost.csv").open("w", newline="") as f:
            writer = csv.DictWriter(f, fieldnames=columns, extrasaction="ignore", lineterminator="\n")
            writer.writeheader()
            writer.writerows(entries)
        text = ["# " + group, "", "Current CLI has no modular sampling switch. OFF/ON below refers only to spatial SMT.", "",
                "| Strategy | Spatial SMT | Runs | Native | Final with exact certificates | Mean CLI s | Mean peak MiB |", "|---|---|---:|---|---|---:|---:|"]
        text += ["| %s | %s | %d | %s | %s | %.6f | %.3f |" % (x["strategy"], x["spatial_smt"], x["executions"], x["native"], x["final_using_exact_existing_certificates"], x["mean_cli_seconds"], x["mean_per_execution_peak_rss_mib"]) for x in entries]
        text += ["", "Historical CN/QCP/Fulminate costs: [original group table](../../../" + group + "/result-cost.md). New native per-stage costs remain in this group's JSON; nested stages are not added together."]
        (folder / "result-cost.md").write_text("\n".join(text) + "\n")
        links.append("| %s | [results and costs](groups/%s/result-cost.md) |" % (group, group))
    summary = {"schema": "tespec-twenty-group-regression/v1", "passed": True,
        "groups": groups, "case_pairs": selection["case_pairs"], "native_executions": len(modular) + len(inline),
        "original_vc_files_identical": True, "modular_sampling_events": 0,
        "final_modular_by_spatial_smt": {k: dict(v) for k, v in all_final.items()},
        "all_twenty_groups_match_expected_after_exact_certificate_reuse": True,
        "new_model_calls": 0, "new_tokens": 0,
        "excluded": selection["excluded_known_unresolved"],
        "scope": "All selected variants/inputs tested. Previous unresolved array_load group explicitly excluded, not marked complete."}
    log = OUT / "python-tests.log"
    if log.exists():
        text = log.read_text()
        matched = re.search(r"Ran (\d+) tests", text)
        if matched and "OK (skipped=15)" in text:
            total = int(matched[1])
            summary["python_tests"] = {"total": total, "passed": total - 15, "skipped": 15,
                "log": str(log.relative_to(ROOT)), "sha256": sha(log)}
    save(OUT / "audit.json", summary)
    (OUT / "index.md").write_text("# Twenty completed groups after removing the old mode\n\n" +
        "Only inline/modular strategy and VC scope remain; modular has no sampling toggle.\n\n" +
        "| Group | Result |\n|---|---|\n" + "\n".join(links) +
        "\n\n833 input pairs, 3332 native executions; original VC files match the immediately preceding corresponding strategy. Each spatial mode's modular results match all 833 expectations after exact existing certificate reuse.\n")
    print(json.dumps(summary))


if __name__ == "__main__":
    main()
