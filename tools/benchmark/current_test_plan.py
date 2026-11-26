"""Load current, source-bound teSpec fault expectations for fresh runs.

The original plan is kept byte-for-byte for historical evidence audits.
"""

import hashlib
import json
import re
from pathlib import Path


FAULT_CODES = {
    "missing_read_permission", "missing_write_permission",
    "uninitialized_read", "missing_call_permission", "invalid_safety_vc",
}


def sha256(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def select_qcp_input(root, source, case, function):
    """Bind an optional per-case input to the checked variant source."""
    if "qcp_input_fixture" not in case:
        return source
    fixture = case["qcp_input_fixture"]
    original = root / source["path"]
    path = (root / fixture["path"]).resolve()
    if not path.is_relative_to(root.resolve()) or not path.is_file():
        raise ValueError(f"Missing or external QCP input fixture: {path}")
    if fixture["original_source_sha256"] != source["sha256"] or sha256(original) != source["sha256"]:
        raise ValueError(f"QCP fixture original source hash mismatch: {original}")
    if sha256(path) != fixture["sha256"]:
        raise ValueError(f"QCP input fixture hash mismatch: {path}")
    if fixture.get("scope") == "CONCRETE_AGGREGATE_FIELD_ENTRY_BINDING" or "inserted_require_prefix" in fixture:
        _check_aggregate_fixture(original, path, function, fixture)
    return {
        **source,
        "path": fixture["path"],
        "sha256": fixture["sha256"],
        "original_source_sha256": source["sha256"],
        "include_dirs": list(dict.fromkeys([str(Path(source["path"]).parent), *source.get("include_dirs", [])])),
    }


def _check_aggregate_fixture(original, path, function, fixture):
    fields = fixture["field_bindings"]
    param = fixture["parameter"]
    typename = fixture["struct_type"]
    ident = r"[A-Za-z_]\w*"
    if (fixture["scope"] != "CONCRETE_AGGREGATE_FIELD_ENTRY_BINDING" or not fields
            or not all(re.fullmatch(ident, v) for v in (param, typename, *fields))
            or any(type(value) is not int for value in fields.values())):
        raise ValueError(f"Invalid aggregate field binding: {path}")
    prefix = "Require " + " && ".join(f"{param}.{k} == {v}" for k, v in fields.items()) + " && "
    contents = original.read_bytes().decode("utf-8")
    offset = fixture["original_require_offset"]
    signature = re.compile(r"\b" + re.escape(function) + r"\s*\(\s*struct\s+" +
                           re.escape(typename) + r"\s+" + re.escape(param) + r"\s*\)\s*/\*@")
    if (type(offset) is not int or offset < 0 or not contents.startswith("Require ", offset)
            or not any("*/" not in contents[m.end():offset] for m in signature.finditer(contents, 0, offset))
            or prefix != fixture["inserted_require_prefix"]
            or path.read_bytes() != (contents[:offset] + prefix + contents[offset + len("Require "):]).encode("utf-8")):
        raise ValueError(f"Fixture does not specialize the selected Require: {path}")


def executed_source(report, job_source_sha256):
    if report["provenance"]["source_sha256"] != job_source_sha256:
        raise ValueError("Native report used a different job source")
    (native,) = report["results"]
    command = native.get("command")
    if not command:
        return None
    generated = Path(native["generated_source"])
    if [arg for arg in command if arg.startswith("--input-file=")] != [f"--input-file={generated}"]:
        raise ValueError("Native command and generated source disagree")
    actual = sha256(generated)
    if native.get("generated_source_sha256", actual) != actual:
        raise ValueError("Executed source hash mismatch")
    return actual


def matches_crash(result, code):
    """Score the diagnostic from the same raw execution, never a generic ERROR."""
    phases = result.get("phases")
    vcs = result.get("vc_results")
    if (code not in FAULT_CODES or result.get("status") != "CRASH"
            or result.get("reason") != code or result.get("scope") != "execution"
            or result.get("precondition_result") != "SAT" or result.get("limit_reason")
            or not isinstance(phases, dict) or phases.get("precondition") != "SAT"
            or not isinstance(vcs, list) or any(not isinstance(vc, dict)
                or vc.get("status") not in {"VALID", "INVALID", "UNKNOWN"} for vc in vcs)):
        return False
    if type(result.get("returncode")) is not int:
        return False
    if code == "invalid_safety_vc":
        return (result.get("returncode") == 0 and result.get("execution_completed") is True
                and "executor_error" in result and not result["executor_error"]
                and result.get("test_result") == "FAIL" and phases.get("safety") == "FAIL"
                and any(vc.get("kind") == "safety" and vc["status"] == "INVALID" for vc in vcs))
    diagnostic = result.get("executor_error")
    return (isinstance(diagnostic, dict) and diagnostic.get("fault_code") == code
            and result.get("returncode") == 1 and result.get("execution_completed") is False
            and result.get("test_result") == ("FAIL" if any(vc["status"] == "INVALID" for vc in vcs) else "UNKNOWN"))


def check_current_expectations(plan):
    for pairing in plan["pairings"]:
        for case in pairing["cases"]:
            for mode in ("off", "on"):
                by_mode = case.get("expected_by_tool", {}).get("tespec_" + mode, case["expected"])
                for strategy in ("inline", "modular"):
                    value = case.get("expected_by_execution_strategy", {}).get(strategy, by_mode)
                    if value not in {"PASS", "FAIL", "CRASH"}:
                        raise ValueError("A current teSpec expectation must be PASS, FAIL or CRASH")
                    if value == "CRASH" and case.get("expected_crash_fault_code") not in FAULT_CODES:
                        raise ValueError("A CRASH expectation requires a reviewed fault code")


def load_current_plan(plan_path):
    """Apply a reviewed, optional overlay; return plan and overlay content hash."""
    plan_path = Path(plan_path)
    plan = json.loads(plan_path.read_bytes())
    overlay_path = plan_path.with_name("tespec-fault-oracle.json")
    if not overlay_path.is_file():
        check_current_expectations(plan)
        return plan, None
    raw = overlay_path.read_bytes()
    overlay = json.loads(raw)
    if (overlay.get("schema") != "tespec-execution-fault-oracle/v1"
            or overlay.get("group") != plan["program_group"]
            or overlay.get("plan_sha256") != sha256(plan_path)):
        raise ValueError("Fault oracle does not match the frozen group plan")

    variants = {}
    for path in (plan_path.parent / "variants").glob("*/manifest.json"):
        variant = json.loads(path.read_bytes())
        if "qcp" in variant["files"]:
            variants[variant["id"]] = variant["files"]["qcp"]
    cases = {(p["cn_variant"], p["qcp_variant"], c["id"]): c
             for p in plan["pairings"] for c in p["cases"]}
    root = plan_path.resolve().parents[3]
    seen = set()
    for target in overlay["targets"]:
        code = target["fault_code"]
        if target["expected"] != "CRASH" or code not in FAULT_CODES:
            raise ValueError("Unsupported fault oracle")
        source = variants[target["qcp_variant"]]
        path = (root / source["path"]).resolve()
        if (not path.is_relative_to(root) or target["qcp_source_sha256"] != source["sha256"]
                or sha256(path) != source["sha256"]):
            raise ValueError("Fault oracle source has changed")
        for cid in target["cases"]:
            key = (target["cn_variant"], target["qcp_variant"], cid)
            if key not in cases or key in seen:
                raise ValueError("Missing or duplicate fault-oracle case: " + repr(key))
            seen.add(key)
            case = cases[key]
            if case.get("precondition_valid") is not True:
                raise ValueError("CRASH requires a semantically valid entry")
            # A generic comparison uses the original default for other tools.
            by_tool = case.setdefault("expected_by_tool", {})
            by_tool.setdefault("fulminate_test", case["expected"])
            if "fulminate_expectation" in target:
                if target["fulminate_expectation"] not in {"PASS", "FAIL"}:
                    raise ValueError("Invalid Fulminate expectation for a fresh test")
                by_tool["fulminate_test"] = target["fulminate_expectation"]
            case["expected"] = "CRASH"
            for mode in ("off", "on"):
                by_tool["tespec_" + mode] = "CRASH"
            case["expected_by_execution_strategy"] = {"inline": "CRASH", "modular": "CRASH"}
            case["expected_crash_fault_code"] = code
    check_current_expectations(plan)
    return plan, hashlib.sha256(raw).hexdigest()
