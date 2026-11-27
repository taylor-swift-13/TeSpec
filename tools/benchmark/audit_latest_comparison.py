"""Check the published four-tool comparison and its input receipts without running tools."""

import argparse
import csv
import fcntl
import hashlib
import math
import sys
from collections import Counter, defaultdict
from contextlib import nullcontext
from functools import lru_cache
from pathlib import Path

from organize_tespec_routes import RESULTS, ROOT, read
from publish_current_tables import BRANCHES, COLUMNS, latest_route_stages, tool_results
from publish_paired_comparison import markdown, paired_route_costs

STRATEGIES = ("inline", "modular")
DEFAULT_LOCK = Path("/var/tmp/tespec-latest-itp-489/latest-publish.lock")


def equal(actual, expected, where):
    if isinstance(expected, float) and isinstance(actual, (float, int)):
        same = math.isclose(actual, expected, rel_tol=1e-11, abs_tol=1e-8)
    else:
        same = actual == expected
    if not same:
        if isinstance(actual, str) and isinstance(expected, str) and "\n" in expected:
            for i, (got, want) in enumerate(zip(actual.splitlines(), expected.splitlines()), start=1):
                if got != want:
                    raise ValueError(f"{where}, line {i}: actual {got[:160]!r}, expected {want[:160]!r}")
            raise ValueError(f"{where}: line count or trailing newline differs")
        raise ValueError(f"{where}: actual {str(actual)[:200]}, expected {str(expected)[:200]}")


def unique(values, where):
    values = list(values)
    equal(len(set(values)), len(values), where)
    return set(values)


@lru_cache(maxsize=None)
def file_digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def check_refs(value, owner):
    if isinstance(value, dict):
        if "path" in value and "sha256" in value:
            path = (ROOT / value["path"]).resolve()
            if not path.is_relative_to(ROOT):
                raise ValueError(f"{owner}: evidence outside repository: {path}")
            equal(file_digest(path), value["sha256"], f"{owner}: {path.relative_to(ROOT)}")
        else:
            for item in value.values():
                check_refs(item, owner)
    elif isinstance(value, list):
        for item in value:
            check_refs(item, owner)


def check_native_parts(parts, total, where):
    for field in (
        "executions",
        "native_batches",
        "native_invocations",
        "guard_fallback_batches",
        "wall_seconds",
        "tokens",
        "model_calls",
        "expected_matches",
        "branch_records",
        "branch_missing",
        *BRANCHES,
    ):
        equal(sum(p[field] for p in parts), total[field], f"{where}: {field}")
    equal(
        max(p["max_process_rss_kib"] for p in parts),
        total["max_process_rss_kib"],
        f"{where}: RSS",
    )
    for key in ("native_outcomes", "final_auto_outcomes"):
        equal(
            sum((Counter(p[key]) for p in parts), Counter()),
            Counter(total[key]),
            f"{where}: {key}",
        )
    equal(
        total["branch_records"] + total["branch_missing"],
        total["executions"],
        f"{where}: branch scope",
    )
    missing = [tuple(sorted(c.items())) for p in parts for c in p["missing_branch_cases"]]
    equal(
        Counter(missing),
        Counter(tuple(sorted(c.items())) for c in total["missing_branch_cases"]),
        f"{where}: branch-gap provenance",
    )
    equal(len(missing), total["branch_missing"], f"{where}: branch-gap count")
    for name in ("layout_prepare", "batch_auto"):
        phase = total[name]
        for key in (
            "invoked_batches",
            "measured_batches",
            "not_invoked_batches",
            "unmeasured_invocations",
            "wall_seconds",
            "model_calls",
            "tokens",
        ):
            equal(
                sum(p[name][key] for p in parts if p[name][key] is not None),
                phase[key],
                f"{where}: {name}.{key}",
            )
        peaks = [p[name]["max_process_rss_kib"] for p in parts if p[name]["max_process_rss_kib"] is not None]
        equal(
            max(peaks, default=None),
            phase["max_process_rss_kib"],
            f"{where}: {name}.rss",
        )


@lru_cache(maxsize=4)
def old_receipts(relative_path):
    return read(ROOT / relative_path)["executions"]


def check_shared(receipt, direct_ids, shared_ids, where):
    for row in receipt.get("checks", []):
        if row.get("certificate_sha256"):
            direct_ids.add(row["certificate_sha256"])
    shared = receipt.get("shared_check")
    if not shared:
        return
    certificate = shared["id"]
    old = shared["old_receipt"]
    equal(certificate, old["certificate_sha256"], f"{where}: shared certificate ID")
    if certificate in shared_ids:
        raise ValueError(f"{where}: duplicate cold charge for shared certificate {certificate}")
    shared_ids.add(certificate)
    record = old_receipts(old["group_itp_path"])[old["execution_key"]]
    matched = [r for r in record["attempts"] if r.get("report_sha256") == old["routes_sha256"]]
    equal(len(matched), 1, f"{where}: old route")
    match = matched[0]
    checks = [c for c in record["checks"] if c.get("certificate_sha256") == certificate]
    equal(len(checks), 1, f"{where}: old certificate")
    check = checks[0]
    equal(
        check["candidate_sha256"],
        old["candidate_sha256"],
        f"{where}: original candidate",
    )
    equal(check["proof_status"], "VALID", f"{where}: shared proof")
    equal(check["unexpected_assumptions"], [], f"{where}: shared assumptions")
    for key in ("wall_seconds", "max_process_rss_kib"):
        equal(shared[key], match[key], f"{where}: shared cold {key}")
    for phase, costs in shared["checker_stages"].items():
        steps = [s for s in check["stages"] if (s["stage"] == "kernel_replay") == (phase == "kernel")]
        equal(len(steps), costs["steps"], f"{where}: shared {phase} steps")
        equal(
            sum(s["wall_seconds"] for s in steps),
            costs["wall_seconds"],
            f"{where}: {phase} time",
        )
        equal(
            max(s["max_process_rss_kib"] for s in steps),
            costs["max_process_rss_kib"],
            f"{where}: {phase} peak",
        )


def check_input(h, auto, receipt, direct_ids, shared_ids):
    equal(auto["native_report_sha256"], h, f"{h}: original report")
    for k in (
        "case",
        "variant",
        "strategy",
        "expected",
        "expected_fault_code",
        "input_sha256",
        "source_sha256",
        "executed_source_sha256",
        "goal_sha256",
        "batch_native_report_sha256",
        "native_status",
    ):
        equal(auto[k], receipt[k], f"{h}: route identity {k}")
    equal(auto["auto"]["tokens"], 0, f"{h}: Auto tokens")
    equal(auto["auto"]["model_calls"], 0, f"{h}: Auto model calls")
    if auto["effective_status"] != "CRASH":
        equal(
            auto["expected_match"],
            auto["effective_status"] in {"PASS", "FAIL"} and auto["effective_status"] == auto["expected"],
            f"{h}: primary Auto verdict",
        )
    if receipt["needs_model"]:
        equal(receipt["final_status"], "PENDING", f"{h}: pending ITP")
        return
    equal(
        receipt["expected_match"],
        (receipt["final_status"] in {"PASS", "FAIL"} and receipt["final_status"] == receipt["expected"])
        or receipt.get("expected_crash_match", False),
        f"{h}: primary ITP verdict",
    )
    for attempt in receipt.get("model_attempts", []):
        equal(
            (attempt["requested_model"], attempt["requested_reasoning_effort"]),
            ("gpt-6.1-sol", "medium"),
            f"{h}: measured model",
        )
    attempts = receipt.get("model_attempts", [])
    measurement = receipt.get("itp_model")
    if measurement and attempts:
        for field, reducer in (("wall_seconds", sum), ("max_process_rss_kib", max)):
            values = [row.get(field) for row in attempts]
            if all(v is not None for v in values):
                equal(measurement[field], reducer(values), f"{h}: CLI {field}")
        events = [event for attempt in attempts for event in attempt["usage_events"]]
        # A missing usage event must remain visible as missing telemetry. Do not impute zero.
        if all(a["usage_events"] for a in attempts):
            for key in ("input_tokens", "output_tokens"):
                equal(measurement[key], sum(e[key] for e in events), f"{h}: CLI {key}")
            equal(
                measurement["tokens"],
                measurement["input_tokens"] + measurement["output_tokens"],
                f"{h}: actual CLI tokens",
            )
    for phase in ("itp_coq", "itp_kernel", "itp_binding"):
        if receipt.get(phase):
            equal(receipt[phase]["tokens"], 0, f"{h}: local {phase} tokens")
    check_shared(receipt, direct_ids, shared_ids, h)


def check_native_rows(stages, native, where):
    rows = {r["stage"]: r for r in stages if r["basis"] == "latest_native_matrix"}
    equal(set(rows), {"native", "layout_prepare", "batch_auto"}, f"{where}: native stages")
    for stage, row in rows.items():
        source = native if stage == "native" else native[stage]
        for k in ("wall_seconds", "max_process_rss_kib", "tokens"):
            equal(row[k], source[k], f"{where}: {stage}.{k}")
        equal(
            (source["tokens"], source["model_calls"]),
            (0, 0),
            f"{where}: non-ITP model costs",
        )
        if stage == "native":
            equal(
                row["required"],
                source["executions"],
                f"{where}: primary execution scope",
            )
            for k in ("branch_records", *BRANCHES):
                equal(row[k], source[k], f"{where}: branch {k}")
        else:
            equal(
                row["required"],
                source["invoked_batches"],
                f"{where}: {stage} denominator",
            )


def check_table(base, table, entry, paired, native):
    current = table["current_evaluation"]
    stages = current["stages"]
    equal(
        current["paired_comparison"],
        {"path": "benchmark/results/paired-tool-comparison.json", "group": base.name},
        f"{base.name}: comparison reference",
    )
    equal(
        sum(row["executions"] for row in native.values()),
        entry["current_evaluation"]["executions"],
        f"{base.name}: index",
    )
    equal(
        table["latest_results"],
        tool_results(base, current["strategies"], paired),
        f"{base.name}: results",
    )
    with (base / "result-cost.csv").open(newline="") as stream:
        reader = csv.DictReader(stream)
        equal(list(reader.fieldnames), list(COLUMNS), f"{base.name}: CSV header")
        equal(
            list(reader),
            [{k: "" if row[k] is None else str(row[k]) for k in COLUMNS} for row in stages],
            f"{base.name}: CSV stages",
        )
    md = (base / "result-cost.md").read_text().splitlines()
    all_measured = all(
        r["result"] in {"MEASURED", "NOT_REQUIRED"}
        for r in stages
        if r["basis"] == "latest_same_input_and_vc"
    )
    all_attempted = True
    for strategy in STRATEGIES:
        stats = paired["latest_" + strategy]
        rows = [r for r in stages if r["strategy"] == strategy]
        check_native_rows(rows, native[strategy], f"{base.name}/{strategy}")
        expected = latest_route_stages(base, strategy, stats["residual"])
        bases = {r["basis"] for r in expected}
        equal(
            [r for r in rows if r["basis"] in bases],
            expected,
            f"{base.name}/{strategy}: route stage costs",
        )
        summary = (
            "| "
            + " | ".join(
                map(
                    str,
                    (
                        strategy,
                        stats["native_only_executions"],
                        stats["residual"],
                        stats["attempted"],
                        stats["awaiting"],
                        stats["total_itp_matches"],
                    ),
                )
            )
            + " |"
        )
        equal(summary in md, True, f"{base.name}/{strategy}: Markdown latest ITP row")
        all_attempted &= stats["attempted"] == stats["residual"]
    equal(
        table["latest_complete"],
        all_measured and all_attempted,
        f"{base.name}: completeness",
    )
    return all_measured and all_attempted


def comparison_key(row):
    return (row["group"], row["cn_variant"], row["qcp_variant"], row["case"])


def check_aggregate(metrics, summary, count_field, label):
    equal(summary[count_field], len(metrics), label + " count")
    for field, combine in (("wall_seconds", sum), ("max_process_rss_kib", max), ("tokens", sum)):
        values = [m[field] for m in metrics]
        expected = combine(values) if values else (None if field == "max_process_rss_kib" else 0)
        equal(summary[field], expected, label + " " + field)


def check_dependencies(report, name):
    check_refs(report, name)
    for path, digest in report["dependencies"].items():
        check_refs({"path": path, "sha256": digest}, name)


def check_client_boundaries(boundary, parent, published):
    from measure_fulminate_client_boundaries import translated_array, translated_runtime

    check_dependencies(boundary, "client boundaries")
    eligible = {
        comparison_key(r): r
        for r in parent["rows"]
        if r["profile"] in {"array_client_entry_exit", "lifted_array_client", "runtime_client_entry_exit"}
    }
    rows = boundary["rows"]
    equal(unique(map(comparison_key, rows), "boundary row identities"), set(eligible), "entire client cohort")
    equal(
        boundary["source_comparison"]["path"],
        "benchmark/results/fulminate-contract-companions.json",
        "parent supplement",
    )
    for row in rows:
        key = comparison_key(row)
        g, cn, qcp, case = key
        old = eligible[key]
        files = parent["groups"][g]["sources"]
        equal(row["qcp_sha256"], files[qcp]["qcp"]["sha256"], f"{key}: QCP")
        equal(row["developer_source_cn_sha256"], files[cn]["cn"]["sha256"], f"{key}: original CN")
        qcp_text = (ROOT / files[qcp]["qcp"]["path"]).read_text()
        generated, contracts, assertions = (
            translated_array(old, qcp_text) if g == "array_load" else translated_runtime(g, qcp_text)
        )
        measured = row["fulminate"]
        equal(
            hashlib.sha256(generated.encode()).hexdigest(),
            measured["source_sha256"],
            f"{key}: generated source",
        )
        equal((contracts, assertions), (row["contracts"], row["assertions"]), f"{key}: original annotations")
        equal(
            measured["status"],
            "PASS" if measured["test"]["exit_code"] == 0 else "FAIL",
            f"{key}: test return",
        )
        for mode in STRATEGIES:
            current = row["strategies"][mode]
            equal(
                (current["vc_scope"], current["strategy"]),
                ("all-boundaries", mode),
                f"{key}/{mode}: VC policy",
            )
            for field in ("expected", "auto", "native_report_sha256"):
                equal(current[field], old["strategies"][mode][field], f"{key}/{mode}: {field}")
    # Two distinct case-specific build invocations can share input bytes. Check what was
    # compiled and what was actually timed independently using their own immutable receipts.
    data = {(r["group"], r["case"]): r["fulminate"] for r in rows}
    unique(
        (
            (
                m["generated_sha256"],
                m["pipeline"]["stdout_sha256"],
                m["pipeline"]["stderr_sha256"],
                m["pipeline"]["wall_seconds"],
            )
            for m in data.values()
        ),
        "cold pipelines charged more than once",
    )
    if any("pipeline_binding" in m or "standalone_binding" in m for m in data.values()):
        for field in ("pipeline_binding", "standalone_binding"):
            unique((m[field]["receipt_sha256"] for m in data.values()), field + " original receipt IDs")
        for key, m in data.items():
            build = m["pipeline_binding"]
            test = m["standalone_binding"]
            equal((build["group"], build["case"]), key, f"{key}: built input")
            for side in (build, test):
                equal(side["subject_sha256"], m["source_sha256"], f"{key}: phase input bytes")
            equal(
                (build["generated_sha256"], build["elf_sha256"]),
                (m["generated_sha256"], m["elf_sha256"]),
                f"{key}: cold build product",
            )
            origin_key = test["built_group"], test["built_case"]
            origin = data[origin_key]
            expected_binding = origin["pipeline_binding"]
            for field in ("subject_sha256", "elf_sha256", "generated_sha256"):
                equal(test[field], expected_binding[field], f"{key}: standalone {field}")
            previous = m.get("previous_source_only_pipeline_attribution")
            equal(previous is not None, origin_key != key, f"{key}: distinct ELF attribution")
            if previous:
                equal(
                    (previous["source_group"], previous["source_case"]),
                    origin_key,
                    f"{key}: former attribution",
                )
                equal(previous["previous_metric"], origin["pipeline"], f"{key}: former cold charge")
                equal(
                    previous["previous_receipt_sha256"],
                    expected_binding["receipt_sha256"],
                    f"{key}: former receipt",
                )
    totals = {
        "scopes": dict(Counter(r["comparison_scope"] for r in rows)),
        "fulminate": dict(Counter(r["fulminate"]["status"] for r in rows)),
    }
    equal(boundary["counts"], totals, "boundary status totals")
    equal(published["counts"], totals, "paired summary of client boundaries")
    equal(published["costs"], boundary["costs"], "published client costs")
    for stage in ("pipeline", "test"):
        check_aggregate(
            [r["fulminate"][stage] for r in rows], boundary["costs"][stage], "measurements", stage
        )
    for field, stage in (("superseded_builds", "pipeline"), ("development_cost_rechecks", "recheck")):
        check_aggregate([r[stage] for r in boundary[field]], boundary["costs"][field], "measurements", field)

    def original_stage(r):
        return tuple(
            r[k] for k in ("group", "case", "source_sha256", "stage", "stdout_sha256", "stderr_sha256")
        )

    rechecks = boundary["development_cost_rechecks"]
    equal(
        Counter(original_stage(r["original"]) for r in rechecks),
        Counter(
            original_stage(r) for r in parent["earlier_attempts"]["measurements"] if r["wall_seconds"] is None
        ),
        "same missing development stages with matched remeasurement",
    )
    for rec in rechecks:
        equal(rec["original_wall_seconds"], None, "original missing clock")
        equal(rec["recheck"]["exit_code"], 0, "comparable development recheck")


def check_companions(companions, comparison, reviewed, finite_coverage):
    from measure_fulminate_companions import make_subject, cause, phase

    check_dependencies(companions, "contract companions")
    lock = companions["cn_toolchain"]
    check_refs({"path": lock["lock"], "sha256": lock["lock_sha256"]}, "locked toolchain")
    equal(lock["cn_sha256"], read(ROOT / lock["lock"])["fingerprint"]["cn_sha256"], "CN binary identity")
    keys = unique(map(comparison_key, companions["rows"]), "companion identities")
    equal({r[0] for r in keys}, set(companions["groups"]), "companion group evidence")
    row_counts = Counter()
    diagnoses = Counter()
    used = set()
    old_bins = {s: Counter(comparison["paired"][s]) for s in STRATEGIES}
    inferred = {s: Counter() for s in STRATEGIES}
    profiles = Counter(r["profile"] for r in companions["rows"])
    by_group = defaultdict(list)
    for r in companions["rows"]:
        by_group[r["group"]].append(r)
    seen_new = set()
    for group, metadata in companions["groups"].items():
        files = metadata["sources"]
        plan = read(ROOT / metadata["plan"]["path"])
        cases = {
            (p["cn_variant"], p["qcp_variant"], c["id"]): (p, c) for p in plan["pairings"] for c in p["cases"]
        }
        native_data = read(ROOT / metadata["teSpec_native"]["path"])["executions"]
        native = {(r["variant"], r["case"], r["strategy"]): r for r in native_data}
        refreshed = {}
        if "teSpec_overlay" in metadata:
            refreshed = {
                (r["variant"], r["case"], r["strategy"]): r
                for r in read(ROOT / metadata["teSpec_overlay"]["path"])["executions"]
            }
        source_raw = read(ROOT / metadata["fulminate_evidence"]["path"])
        raw = {
            (r["variant"], r.get("case", r.get("case_id"))): r
            for r in source_raw.get("runs", source_raw.get("cases", []))
        }
        finite = read(RESULTS / group / "fulminate/results.json")
        baseline = {
            (r["variant"], r.get("case", r.get("case_id"))): r
            for r in finite.get("cases", finite.get("runs", []))
        }
        missing = {
            (s["variant"], c)
            for s in finite_coverage["groups"][group]["scope_exceptions"]
            if s["kind"] == "target_contract_na"
            for c in s["cases"]
        }
        for r in by_group[group]:
            ident = comparison_key(r)
            _, cn, qcp, case = ident
            member = (cn, qcp, case)
            pair, c = cases[member]
            raw_pair = (cn, case)
            orig = baseline[raw_pair]
            difference = any(native[qcp, case, s]["expected"] != orig["expected"] for s in STRATEGIES)
            if raw_pair in missing:
                category = "body_only"
            elif pair.get("contract_comparison", {}).get("same_contract_comparison") is False:
                category = "different_contract"
            elif difference:
                category = "different_expected"
            else:
                category = "previously_included_dll_contract"
            equal(r["frozen_class"], category, f"{ident}: original comparison class")
            equal(r["original_fulminate_expected"], orig["expected"], f"{ident}: frozen Fulminate oracle")
            row_counts[category] += 1
            for s in STRATEGIES:
                source = native[qcp, case, s]
                linked = r["strategies"][s]
                final = refreshed.get((qcp, case, s), source)
                equal(linked["auto"], final["effective_status"], f"{ident}/{s}: observed Auto")
                equal(linked["matches_expected"], final["expected_match"], f"{ident}/{s}: expectation match")
                for field in ("native_report_sha256", "expected"):
                    equal(linked[field], source[field], f"{ident}/{s} {field}")
            if category == "different_expected":
                old = raw[raw_pair]
                test = old.get("fulminate_test", old.get("runtime_test"))
                for s in STRATEGIES:
                    equal(cause(test, native[qcp, case, s]), r["diagnostic_class"], f"{ident}/{s} fault")
                for stream in ("stdout", "stderr"):
                    equal(
                        r[stream + "_sha256"],
                        test.get(stream + "_sha256", test.get(stream + "_omitted", {}).get("sha256")),
                        f"{ident}: original {stream}",
                    )
                equal(
                    r["fulminate_status"],
                    "PASS" if test["exit_code"] == 0 else "FAIL",
                    f"{ident}: finite exit",
                )
                diagnoses[r["diagnostic_class"]] += 1
                continue
            receipt_id = r["fulminate_receipt"]
            used.add(receipt_id)
            measurement = companions["measurements"][receipt_id]
            equal(measurement["status"], r["fulminate_status"], f"{ident}: receipt")
            if measurement.get("kind") == "archived_array_load2":
                donor, donor_q, donor_case = measurement["archive_key"]
                archive = raw[donor, donor_case]
                _, prior = cases[donor, donor_q, donor_case]
                for field in ("cn_body", "binds", "expected", "value"):
                    equal(c[field], prior[field], f"{ident}: archived array input {field}")
                equal(
                    measurement["source"]["sha256"],
                    archive["cn_source_sha256"],
                    f"{ident}: archived CN source",
                )
                equal(measurement["source_sha256"], archive["harness_sha256"], f"{ident}: archived input")
                equal(
                    measurement["binary_sha256"],
                    archive["instrumented_binary_sha256"],
                    f"{ident}: archived ELF",
                )
                for st in ("pipeline", "test"):
                    equal(measurement[st], phase(archive["fulminate_" + st]), f"{ident}: archive {st}")
                equal(
                    receipt_id, group + "/archive/" + archive["harness_sha256"], f"{ident}: archived cost ID"
                )
            else:
                original_pair = pair
                if r["profile"] in ("dll_add_strengthened", "dll_remove_strengthened"):
                    original_pair = next(p for p in plan["pairings"] if "orig.broken" in p["cn_variant"])
                if group == "array_load":
                    # The helper donor is owned by the existing strong-array measurement.
                    donor = next(
                        m
                        for m in companions["measurements"].values()
                        if m.get("kind") == "archived_array_load2"
                    )
                    files = {**files, "cn_original:array_load2": {"cn": donor["source"]}}
                generated, _ = make_subject(group, original_pair, c, files, plan)
                digest = hashlib.sha256(generated.encode()).hexdigest()
                equal(receipt_id, group + "/" + digest, f"{ident}: generated cost ID")
                equal(measurement["source_sha256"], digest, f"{ident}: generated source")
                check_refs(
                    {"path": measurement["compiler"], "sha256": measurement["compiler_sha256"]},
                    "actual compiler",
                )
            if category == "previously_included_dll_contract":
                equal(
                    r["profile"] in ("dll_add_strengthened", "dll_remove_strengthened"),
                    True,
                    f"{ident}: reviewed difference",
                )
                seen_new.add(ident)
                finite_match = orig.get("matches_expected", orig.get("correct"))
                if finite_match is None:
                    finite_match = orig.get("actual", orig.get("status")) == orig["expected"]
                for s in STRATEGIES:
                    t = r["strategies"][s]["matches_expected"]
                    old_class = {
                        (True, True): "both_match",
                        (True, False): "tespec_only",
                        (False, True): "fulminate_only",
                        (False, False): "neither_match",
                    }[t, finite_match]
                    inferred[s][old_class] += 1
        augmented_qcp = {
            r["qcp_variant"]
            for r in by_group[group]
            if r["profile"] in {"dll_add_strengthened", "dll_remove_strengthened"}
        }
        expected_new = {
            (group, cn, qcp, case)
            for (cn, qcp, case), (pair, c) in cases.items()
            if qcp in augmented_qcp
            and (cn, case) not in missing
            and pair.get("contract_comparison", {}).get("same_contract_comparison") is not False
            and all(
                native[qcp, case, mode]["expected"] == baseline[cn, case]["expected"] for mode in STRATEGIES
            )
        }
        equal(
            {k for k in seen_new if k[0] == group},
            expected_new,
            f"{group}: all formerly eligible DLL pairings",
        )
    equal(used, set(companions["measurements"]), "uniquely referenced companion cost IDs")
    # Coverage of all three frozen exclusion classes; successful or failed new outcomes never select this sample.
    for s in STRATEGIES:
        for k in ("body_only", "different_contract", "different_expected"):
            equal(row_counts[k], old_bins[s][k], f"{s}: complete {k} cohort")
        corrected = old_bins[s].copy()
        corrected.subtract(inferred[s])
        corrected["different_contract"] += len(seen_new)
        equal(Counter(reviewed["paired"][s]), corrected, f"{s}: corrected comparison")
        fair = ("both_match", "tespec_only", "fulminate_only", "neither_match")
        equal(
            sum(corrected[k] for k in fair),
            comparison["input_pairs"] - sum(row_counts.values()),
            f"{s}: corrected strict denominator",
        )
    equal({k: dict(v) for k, v in old_bins.items()}, reviewed["original_plan_paired"], "original comparison")
    equal(len(seen_new), reviewed["newly_excluded_pairs"], "new contract differences")
    equal(dict(row_counts), companions["counts"], "companion coverage")
    equal(dict(diagnoses), companions["diagnostic_classes"], "replayed historical diagnostic classes")
    equal(dict(diagnoses), reviewed["safety_observations"], "global diagnostic classes")
    equal(dict(profiles), reviewed["supplemental_profiles"], "global supplementary profiles")
    equal(companions["costs"], reviewed["supplemental_unique_costs"], "global supplementary costs")
    for kind, stats in companions["costs"].items():
        metrics = [
            m for m in companions["measurements"].values() if m.get("kind", "measured_companion") == kind
        ]
        equal(len(metrics), stats["unique_executions"], kind + " unique measured inputs")
        equal(Counter(m["status"] for m in metrics), Counter(stats["statuses"]), kind + " outcomes")
        for st in ("pipeline", "test", "fault_probe"):
            values = [m[st]["cost"] if st == "fault_probe" else m[st] for m in metrics if st in m]
            check_aggregate(values, stats[st], "invocations", kind + " " + st)


def mutually_matched_costs(auto, receipt):
    if receipt["needs_model"] or not (auto["expected_match"] and receipt["expected_match"]):
        return {}
    phases = [receipt.get(s) for s in ("itp_model", "itp_coq", "itp_kernel")]
    if receipt.get("itp_binding") is not None:
        phases.append(receipt["itp_binding"])
    if receipt.get("cumulative_costs_complete") is False or any(
        p is None
        or p.get("tokens") is None
        or p.get("wall_seconds") is None
        or (p.get("invoked") and p.get("max_process_rss_kib") is None)
        for p in phases
    ):
        return {}
    a = auto.get("auto")
    if not a or any(a.get(k) is None for k in ("tokens", "wall_seconds", "max_process_rss_kib")):
        return {}
    return {
        "count": 1,
        "auto_seconds": a["wall_seconds"],
        "itp_seconds": sum(p["wall_seconds"] for p in phases),
        "itp_tokens": sum(p["tokens"] for p in phases),
    }


def audit(require_complete):
    comparison = read(RESULTS / "paired-tool-comparison.json")
    index = read(RESULTS / "group-result-cost-index.json")
    latest = comparison["latest_routes"]
    coverage = index["four_tool_measurement"]
    check_refs(coverage["comparison"], "index")
    check_refs(comparison, "paired comparison")
    equal(
        (RESULTS / "paired-tool-comparison.md").read_text(),
        markdown(comparison),
        "comparison Markdown",
    )
    inventory = read(ROOT / latest["inventory"]["path"])
    native = read(ROOT / comparison["native_costs"]["evidence"]["path"])
    for k, v in comparison["native_costs"]["totals"].items():
        equal(v, native["totals"][k], f"paired native costs: {k}")
    fulminate = read(ROOT / comparison["contract_scope_evidence"]["path"])
    supplemental_file = RESULTS / "fulminate-contract-companions.json"
    boundary_file = RESULTS / "fulminate-client-boundaries.json"
    equal(supplemental_file.is_file(), "audited_contract_comparison" in comparison, "companion publication")
    equal(boundary_file.is_file(), "client_boundaries" in comparison, "boundary publication")
    if supplemental_file.is_file():
        data = read(supplemental_file)
        check_companions(data, comparison, comparison["audited_contract_comparison"], fulminate)
        if boundary_file.is_file():
            check_client_boundaries(read(boundary_file), data, comparison["client_boundaries"])
    equal(
        fulminate["counts"]["executed_inputs"],
        comparison["input_pairs"],
        "Fulminate input count",
    )
    names = unique((e["program_group"] for e in index["groups"]), "index group names")
    for name, source in (
        ("comparison", comparison),
        ("inventory", inventory),
        ("native costs", native),
        ("Fulminate", fulminate),
    ):
        equal(set(source["groups"]), names, f"{name} names")
    equal(len(names), index["groups_total"], "index group count")
    equal(len(names), 45, "frozen family scope")
    equal(native["totals"]["executions"], 3056, "frozen primary matrix")
    equal(inventory["residuals"], 489, "frozen residual cohort")
    for strategy in STRATEGIES:
        check_native_parts(
            [g[strategy] for g in native["groups"].values()],
            native["by_strategy"][strategy],
            strategy,
        )
    check_native_parts(list(native["by_strategy"].values()), native["totals"], "all native")
    stage_counts, outcomes, primary, supplemental = (
        Counter(),
        Counter(),
        Counter(),
        Counter(),
    )
    anomalies = read(ROOT / latest["unexpected_evidence"]["path"])["groups"]
    group_primary = defaultdict(Counter)
    both_checked = Counter()
    costs = defaultdict(list)
    directs, shared, all_reports, queue_shas, deltas = set(), set(), set(), set(), set()
    complete_groups = 0
    for entry in index["groups"]:
        group = entry["program_group"]
        base = RESULTS / group
        paired = comparison["groups"][group]
        group_native = native["groups"][group]
        spec = inventory["groups"][group]
        check_refs(spec.get("auto"), f"{group}: latest Auto")
        auto = read(ROOT / spec["auto"]["path"])["executions"] if spec.get("auto") else {}
        itp = read(base / "tespec/latest-itp.json")
        receipts = itp["executions"]
        equal(itp["group"], group, f"{group}: ITP receipt owner")
        queue_shas.add(itp["queue_sha256"])
        equal(
            itp["total_matrix_executions"],
            native["totals"]["executions"],
            f"{group}: ITP denominator",
        )
        equal(set(auto), set(receipts), f"{group}: frozen eligible report keys")
        equal(len(auto), itp["required"], f"{group}: ITP required")
        equal(
            sum(not r["needs_model"] for r in receipts.values()),
            itp["observed"],
            f"{group}: ITP observed",
        )
        equal(
            Counter(r["final_status"] for r in receipts.values()),
            Counter(itp["statuses"]),
            f"{group}: ITP statuses",
        )
        unique(
            ((r["case"], r["variant"], r["strategy"]) for r in auto.values()),
            f"{group}: duplicate execution",
        )
        equal(
            all_reports.isdisjoint(auto),
            True,
            f"{group}: duplicate report across groups",
        )
        all_reports.update(auto)
        flagged = set(anomalies.get(group, {}).get("single_native_reports", []))
        equal(
            flagged,
            {h for h, r in receipts.items() if not r["needs_model"] and not r["expected_match"]},
            f"{group}: ITP discrepancies",
        )
        for h, a in auto.items():
            check_input(h, a, receipts[h], directs, shared)
            both_checked.update(mutually_matched_costs(a, receipts[h]))
            if a["batch_auto_status"] != a["effective_status"]:
                deltas.add((h, a["batch_auto_status"], a["effective_status"]))
            diagnostic = a.get("additional_budget_diagnostic")
            if diagnostic:
                supplemental["budget_diagnostic_runs"] += 1
                supplemental["budget_diagnostic_" + diagnostic["effective_status"]] += 1
                if a["effective_status"] == "UNKNOWN":
                    supplemental["primary_unknown_retried"] += 1
                    supplemental["primary_unknown_retried_" + diagnostic["effective_status"]] += 1
            for result in a.get("additional_profile_runs", {}).values():
                supplemental["additional_profile_runs"] += 1
                supplemental["additional_profile_" + result["status"]] += 1
        table = read(base / "result-cost.json")
        complete_groups += check_table(base, table, entry, paired, group_native)
        for r in table["latest_results"]:
            if r["tool"] in ("cn", "qcp"):
                group_primary[r["tool"]][r["result"]] += 1
        for strategy in STRATEGIES:
            scope = f"{group}/{strategy}"
            rows = [r for r in auto.values() if r["strategy"] == strategy]
            equal(len(rows), spec["residuals"].get(strategy, 0), scope + " inventory")
            counts, stage_costs, statuses = paired_route_costs(rows, auto, receipts)
            n = group_native[strategy]
            equal(
                paired["auto_" + strategy],
                {"executions": n["executions"], "matches": n["expected_matches"]},
                scope + " matrix",
            )
            counts["native_only_executions"] = n["executions"] - len(rows)
            batch_matches = sum(
                r["batch_auto_status"] == r["expected"] and r["expected"] in ("PASS", "FAIL") for r in rows
            )
            counts["native_matches"] = n["expected_matches"] - batch_matches
            counts["total_itp_matches"] = counts["native_matches"] + counts["both_match"] + counts["itp_only"]
            counts.update({"itp_" + k: v for k, v in statuses.items()})
            equal(Counter(paired["latest_" + strategy]), counts, scope + " route outcomes")
            stage_counts.update(counts)
            outcomes.update(statuses)
            primary.update(n["final_auto_outcomes"])
            for k, v in stage_costs.items():
                costs[k].extend(v)
    equal(len(queue_shas), 1, "single frozen queue across groups")
    equal(len(all_reports), inventory["residuals"], "unique eligible executions")
    equal(
        shared & directs,
        set(),
        "same cold certificate charged in shared and current checker stages",
    )
    equal(len(shared), stage_counts["checked_by_reuse"], "shared cold charge count")
    equal(stage_counts + supplemental, Counter(latest["counts"]), "global latest counters")
    equal(outcomes, Counter(latest["itp_residual_outcomes"]), "global ITP statuses")
    equal(
        deltas,
        {(d["native_report_sha256"], d["batch"], d["one_input"]) for d in latest["auto_batch_vs_single"]},
        "published primary batch/single differences",
    )
    if "both_checked_costs" in latest:
        equal(set(both_checked), set(latest["both_checked_costs"]), "mutually matched cost fields")
        for field, value in both_checked.items():
            equal(latest["both_checked_costs"][field], value, "mutually matched " + field)
    reported_costs = latest["paired_postprocessing_costs"]
    equal(
        set(reported_costs),
        {k for k, v in costs.items() if v and not k.startswith("both_checked_")},
        "paired phase cost fields",
    )
    for key, value in reported_costs.items():
        equal(
            value,
            max(costs[key]) if key.endswith("rss") else sum(costs[key]),
            f"paired {key}",
        )
    equal(primary, Counter(comparison["outcomes"]), "primary full matrix outcomes")
    equal(
        comparison["unique_auto"],
        {
            "executions": sum(primary.values()),
            "matches": native["totals"]["expected_matches"],
        },
        "primary full matrix coverage",
    )
    equal(group_primary, comparison["primary_verdicts"], "CN and QCP group verdicts")
    for key, value in {
        "groups": len(names),
        "cn_main_observed": sum(group_primary["cn"].values()),
        "qcp_main_observed": sum(group_primary["qcp"].values()),
        "fulminate_executed_pairs": comparison["input_pairs"],
        "auto_executions": sum(primary.values()),
        "auto_matches": comparison["unique_auto"]["matches"],
        "itp_residuals": len(all_reports),
        "itp_attempted": stage_counts["attempted"],
        "itp_awaiting": stage_counts["awaiting"],
        "itp_pairs_with_observed_phase_costs": stage_counts["paired_cost_records"],
        "groups_all_residuals_attempted": sum(
            all(not g["latest_" + s]["awaiting"] for s in STRATEGIES) for g in comparison["groups"].values()
        ),
    }.items():
        equal(coverage[key], value, "index " + key)
    print(
        f"{len(names)} groups, {sum(primary.values())} primary executions, {len(all_reports)} residuals; "
        f"ITP {stage_counts['attempted']} attempted, {stage_counts['awaiting']} pending, "
        f"{stage_counts['paired_cost_records']} paired costs; {len(shared)} unique shared cold checks; "
        f"{native['totals']['branch_missing']} executions without branch counters."
    )
    if "audited_contract_comparison" in comparison:
        corrected = comparison["audited_contract_comparison"]["paired"]
        fair = ("both_match", "tespec_only", "fulminate_only", "neither_match")
        denominators = ", ".join(f"{s} {sum(corrected[s].get(k, 0) for k in fair)}" for s in STRATEGIES)
        boundary_count = sum(
            comparison.get("client_boundaries", {}).get("counts", {}).get("fulminate", {}).values()
        )
        print(
            f"Companions: {len(data['rows'])} mappings, {len(data['measurements'])} distinct cost receipts; "
            f"{boundary_count} client executions; corrected pairs: {denominators}; "
            f"both routes matched with complete costs: {both_checked['count']}."
        )
    if require_complete:
        equal(
            stage_counts["paired_cost_records"],
            len(all_reports),
            "complete measured residuals required",
        )
        equal(complete_groups, len(names), "complete measured groups required")


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--require-complete",
        action="store_true",
        help="require measured terminal ITP receipts on every residual",
    )
    parser.add_argument("--lock", type=Path, default=DEFAULT_LOCK, help="publisher lock, if present")
    args = parser.parse_args()
    with args.lock.open("rb") if args.lock.is_file() else nullcontext(None) as lock:
        if lock:
            fcntl.flock(lock, fcntl.LOCK_SH)
        try:
            audit(args.require_complete)
        except (KeyError, ValueError, OSError) as exc:
            print(f"Audit failed: {exc}", file=sys.stderr)
            return 1
    return 0


if __name__ == "__main__":
    sys.exit(main())
