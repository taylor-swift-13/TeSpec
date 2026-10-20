#!/usr/bin/env python3
"""Audit removal of modular sampling against the previous symbolic-only executions."""
from collections import Counter
import hashlib
import json
import re
from pathlib import Path
import subprocess
import tempfile

from audit_instance_reuse import compare, ROOT

OUT = ROOT / "benchmark/results/modular-symbolic-only-20261020"
BASE = ROOT / "benchmark/results/spatial-smt-regressions"


def save(path, data):
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(data, ensure_ascii=False, indent=2) + "\n")


def fixtures():
    before = json.loads((OUT / "fixtures-before.json").read_text())
    after = []
    for old in before:
        with tempfile.TemporaryDirectory() as temp:
            source = Path(temp) / "input.c"
            source.write_text(old["source"])
            command = [str(ROOT / "bin/tespec-symexec"), "--input-file=" + str(source),
                       "--spec-test", "--function=sample", "--full-auto", "--Json-output",
                       "--no-strategy-gen", "--arch=32", "--execution-strategy=modular",
                       "--annotation-policy=" + old["policy"]]
            result = subprocess.run(command, text=True, capture_output=True, timeout=20)
            raw = json.loads(result.stdout)
            new = raw["spec_test"]
            assert result.returncode == old["code"]
            for key in ("overall", "precondition_result", "completed", "phases", "vc_results"):
                assert new[key] == old["report"]["spec_test"][key], (old["case"], key)
            assert new["sampling_events"] == []
            assert new["modular_instantiation"] == "off"
            assert new["declaration_call_policy"] == "contract-symbolic/v1"
            assert not any(e["kind"] == "contract-sample" for e in new["abstraction_events"])
            after.append({"case": old["case"], "policy": old["policy"], "source": old["source"],
                          "code": result.returncode, "report": raw, "stderr": result.stderr})
    save(OUT / "fixtures-after.json", after)
    return len(after)


def main():
    audits = [compare("inline", "20261020-instance-reuse-inline",
                      "20261020-inline-after-no-modular-sampling", True),
              compare("modular", "20261020-instance-reuse-modular-off",
                      "20261020-modular-symbolic-only", True)]
    assert all(not x["regressions"] for x in audits)
    rows = json.loads((BASE / "20261020-modular-symbolic-only/results.json").read_text())["runs"]
    by_group = {}
    for row in rows:
        report = json.loads((ROOT / row["report"]["path"]).read_text())["results"][0]
        assert report["sampling_events"] == []
        assert report["execution_semantics"] == "modular-symbolic/v1"
        assert report["declaration_call_policy"] == "contract-symbolic/v1"
        assert report["modular_instantiation"] == "off"
        assert not any(e["kind"] == "contract-sample" for e in report["abstraction_events"])
        by_group.setdefault(row["group"], []).append(row)
    all_final = {"off": Counter(), "on": Counter()}
    for group, items in by_group.items():
        old_path = ROOT / "benchmark/results/instance-reuse-20261020/groups" / group / "result-cost.json"
        old_data = json.loads(old_path.read_text())
        entries = []
        for mode in ("off", "on"):
            selected = [x for x in items if x["mode"] == mode]
            previous = next(x for x in old_data["rows"] if x["strategy"] == "modular-off" and x["spatial_smt"] == mode)
            keys = {(x["variant"], x["case"]) for x in selected}
            assert keys == {(x["variant"], x["case"]) for x in previous["decisions"]}
            # compare() above proves source, inputs and complete original VC files
            # match the exact executions whose certificates these rows reference.
            decisions = previous["decisions"]
            final = dict(Counter(x["status"] for x in decisions))
            all_final[mode].update(final)
            entries.append({"spatial_smt": mode, "executions": len(selected),
                "native_statuses": dict(Counter(x["current"]["status"] for x in selected)),
                "final_statuses_with_exact_existing_certificates": final,
                "existing_decision_table": {"path": str(old_path.relative_to(ROOT)),
                    "sha256": hashlib.sha256(old_path.read_bytes()).hexdigest()},
                "decisions": decisions,
                "cli_mean_seconds": sum(x["measurement"]["wall_seconds"] for x in selected) / len(selected),
                "cli_mean_peak_rss_mib": sum(x["measurement"]["resources"]["max_process_rss_kib"] / 1024 for x in selected) / len(selected),
                "tokens": 0, "model_calls": 0,
                "stage_measurements": [{"case": x["case"], "variant": x["variant"],
                    "measurements": x["stage_measurements"]} for x in selected]})
        folder = OUT / "groups" / group
        save(folder / "result-cost.json", {"group": group, "rows": entries,
            "scope": "Fresh native regression; byte-identical original VCs reuse existing certificates and their historical costs."})
        lines = ["# " + group, "", "No modular boundary sampling. Entry inputs and original obligations unchanged.", "",
                 "| Spatial SMT | Runs | Native | Final using exact existing certificates | Mean CLI s | Mean per-run peak MiB |",
                 "|---|---:|---|---|---:|---:|"]
        lines += ["| %s | %d | %s | %s | %.6f | %.3f |" % (x["spatial_smt"], x["executions"],
            x["native_statuses"], x["final_statuses_with_exact_existing_certificates"], x["cli_mean_seconds"], x["cli_mean_peak_rss_mib"]) for x in entries]
        (folder / "result-cost.md").write_text("\n".join(lines) + "\n")
        import csv
        with (folder / "result-cost.csv").open("w", newline="") as f:
            cols = ["spatial_smt", "executions", "native_statuses", "final_statuses_with_exact_existing_certificates", "cli_mean_seconds", "cli_mean_peak_rss_mib", "tokens", "model_calls"]
            writer = csv.DictWriter(f, fieldnames=cols, extrasaction="ignore")
            writer.writeheader()
            writer.writerows(entries)
    count = fixtures()
    summary = {"schema": "tespec-no-modular-sampling-audit/v1", "passed": True,
               "native_executions": sum(x["executions"] for x in audits),
               "audits": audits, "fixture_comparisons": count,
               "modular_sampling_events": 0, "final_modular_by_spatial_smt": {k: dict(v) for k, v in all_final.items()},
               "new_model_calls": 0, "new_tokens": 0,
               "scope": "No new formal claims: exact original VC identity permits reference to prior certificates; UNKNOWN remains unresolved."}
    test_log = OUT / "python-tests-final.log"
    if test_log.exists():
        text = test_log.read_text()
        match = re.search(r"Ran (\d+) tests", text)
        if match and "OK (skipped=15)" in text:
            total = int(match[1])
            summary["python_tests"] = {"total": total, "passed": total - 15, "skipped": 15,
                "log": str(test_log.relative_to(ROOT)),
                "log_sha256": hashlib.sha256(test_log.read_bytes()).hexdigest()}
    save(OUT / "audit.json", summary)
    print(json.dumps({k: v for k, v in summary.items() if k != "audits"}))


if __name__ == "__main__":
    main()
