"""Opt-in adapter tests, separate from program benchmark measurements."""

from copy import deepcopy
import json
import hashlib
from pathlib import Path
import subprocess
import sys
import tempfile
import unittest
from unittest.mock import patch

from spectest.cli import _check_parser, _run_parser
from spectest.core import _parse_qcp_config
from spectest.errors import JobError
from spectest.spatial_smt import refine_case

LAYOUT = {
    "schema": "sac-target-layout/v1",
    "architecture_bits": 32,
    "byte_order": "big",
    "pointer_size": 4,
    "memory_rules": "naive_C_Rules",
    "field_address_semantics": "base-plus-byte-offset/v1",
    "aggregates": [],
    "aliases": [],
}
PRE = "PROP[]\nLOCAL[]\nSEP[store(4096, 7, signed int)]\n"
EMPTY = "PROP[]\nLOCAL[]\nSEP[]\n"


def sample(goal=EMPTY):
    vc = {
        "kind": "return",
        "name": None,
        "line": 8,
        "status": "UNKNOWN",
        "path": PRE,
        "goal": goal,
    }
    case = {
        "status": "UNKNOWN",
        "overall": "UNKNOWN",
        "test_result": "UNKNOWN",
        "satisfied": None,
        "reason": "residual_vc_requires_proof",
        "scope": "execution",
        "execution_completed": True,
        "precondition_result": "SAT",
        "executor_error": None,
        "returncode": 0,
        "abstraction_events": [],
        "target_layout": LAYOUT,
        "mode": "entry-exit",
        "annotation_policy": "ignore",
        "residual_vcs": [
            "proof_of_read_return_wit_1_split_goal_spatial",
            "proof_of_read_return_wit_1",
        ],
        "phases": {
            "execution": "PASS",
            "safety": "PASS",
            "postcondition": "UNKNOWN",
            "annotations": "NOT_RUN",
        },
        "vc_results": [vc],
    }
    raw = {
        "spec_test": {
            "schema": "sac-spec-test/v1",
            "vc_semantics": "path-vc/v1",
            "query_semantics": "copy-only/v1",
            "execution_semantics": "inline-preserve/v1",
            "result_semantics": "three-valued-conjunction/v1",
            "vc_results": [vc],
        },
        "functionName": "read",
        "manual_obligation_count": 1,
        "manual_obligations": [
            {"kind": "return_checker_wit", "functionName": "read", "line": 8}
        ],
        "WitnessList": [
            {
                "functionName": "read",
                "Witness": {"return_checker_wit": {"total": 1, "manual": 1}},
            }
        ],
    }
    return deepcopy(case), deepcopy(raw)


class SpatialAdapterTests(unittest.TestCase):
    def apply(self, case, raw, mutate=None):
        temp = tempfile.TemporaryDirectory()
        self.addCleanup(temp.cleanup)
        root = Path(temp.name)
        stdout = root / "executor.json"
        stdout.write_text(json.dumps(raw))
        saved = stdout.read_bytes()
        residuals = deepcopy(case["residual_vcs"])
        if case.pop("_synthetic_coq_fixture", False):
            annotation_artifacts(case, raw, root)
            stdout.write_text(json.dumps(raw))
            saved = stdout.read_bytes()
        if mutate is not None:
            mutate(case, raw)
            stdout.write_text(json.dumps(raw))
            saved = stdout.read_bytes()
        refine_case(case, stdout, root / "spatial-smt", timeout_ms=2000)
        self.assertEqual(stdout.read_bytes(), saved)
        self.assertEqual(case["residual_vcs"], residuals)
        return case, root

    def test_missing_ownership_becomes_fail(self):
        case, root = self.apply(*sample())
        self.assertEqual(case["status"], "FAIL")
        self.assertEqual(case["test_result"], "FAIL")
        self.assertEqual(case["phases"]["postcondition"], "FAIL")
        self.assertFalse(case["spatial_smt"]["itp_required"])
        self.assertEqual(case["evidence"]["certificate"], "NOT_CHECKED")
        evidence = json.loads((root / "spatial-smt/vc-0000.json").read_text())
        self.assertEqual(len(evidence["countermodel"]["heap"]), 4)
        self.assertTrue((root / "spatial-smt/vc-0000.smt2").is_file())

    def test_valid_return_can_pass_with_complete_coverage(self):
        case, _ = self.apply(*sample(PRE))
        self.assertEqual(case["status"], "PASS")
        self.assertTrue(case["satisfied"])
        self.assertFalse(case["spatial_smt"]["itp_required"])

    def test_unsupported_predicate_keeps_itp(self):
        case, _ = self.apply(*sample("PROP[]\nLOCAL[]\nSEP[listrep(4096)]\n"))
        self.assertEqual(case["status"], "UNKNOWN")
        self.assertTrue(case["spatial_smt"]["itp_required"])

    def test_nonreturn_vc_keeps_itp(self):
        case, raw = sample()
        case["vc_results"][0]["kind"] = raw["spec_test"]["vc_results"][0]["kind"] = (
            "assert"
        )
        case, _ = self.apply(case, raw)
        self.assertEqual(case["status"], "UNKNOWN")

    def test_other_unknown_does_not_hide_counterexample_or_drop_itp(self):
        case, raw = sample()
        other = dict(case["vc_results"][0], kind="assert")
        case["vc_results"].append(other)
        raw["spec_test"]["vc_results"].append(deepcopy(other))
        case, _ = self.apply(case, raw)
        self.assertEqual(case["status"], "FAIL")
        self.assertTrue(case["spatial_smt"]["itp_required"])

    def test_backend_error_keeps_itp(self):
        for error in (ModuleNotFoundError("z3"), RuntimeError("solver failed")):
            with (
                self.subTest(error=error),
                patch("spectest.spatial_smt._solve_record", side_effect=error),
            ):
                case, _ = self.apply(*sample())
                self.assertEqual(case["status"], "UNKNOWN")
                self.assertTrue(case["spatial_smt"]["itp_required"])

    def test_solver_unknown_keeps_itp(self):
        with patch(
            "spectest.spatial_smt._solve_record",
            return_value={"status": "UNKNOWN", "reason": "solver_unknown:timeout"},
        ):
            case, _ = self.apply(*sample())
            self.assertEqual(case["status"], "UNKNOWN")
            self.assertTrue(case["spatial_smt"]["itp_required"])

    def test_disabled_import_does_not_require_z3(self):
        command = [
            sys.executable,
            "-c",
            'import sys; import spectest.core; import spectest.cli; assert "z3" not in sys.modules; assert "spectest.spatial_smt" not in sys.modules',
        ]
        subprocess.run(command, check=True, capture_output=True)


def ineligible(field, value):
    def test(self):
        case, raw = sample()
        case[field] = value
        baseline = deepcopy(case)
        with patch(
            "spectest.spatial_smt._solve_record",
            side_effect=AssertionError("must not run"),
        ) as solve:
            case, _ = self.apply(case, raw)
            solve.assert_not_called()
        info = case.pop("spatial_smt")
        self.assertEqual(case, baseline)
        self.assertEqual(info["attempted"], 0)

    return test


for n, (field, value) in enumerate(
    [
        ("status", "ERROR"),
        ("status", "FAIL"),
        ("status", "PASS"),
        ("status", "INVALID"),
        ("scope", "specification-only"),
        ("execution_completed", False),
        ("precondition_result", "UNKNOWN"),
        ("precondition_result", "UNSAT"),
        ("returncode", 1),
        ("executor_error", "unreadable memory"),
        ("abstraction_events", ["unknown call"]),
    ]
):
    setattr(
        SpatialAdapterTests, f"test_ineligible_{n}_{field}", ineligible(field, value)
    )


def incomplete(which):
    def test(self):
        case, raw = sample(PRE)
        if which == "safety":
            case["phases"]["safety"] = "UNKNOWN"
        elif which == "annotations":
            case["phases"]["annotations"] = "UNKNOWN"
        elif which == "unmapped_goal":
            case["residual_vcs"].append("proof_of_read_safety_wit_1")
        elif which == "missing_inventory":
            raw.pop("manual_obligations")
        elif which == "wrong_count":
            raw["manual_obligation_count"] = 2
        elif which == "wrong_line":
            raw["manual_obligations"][0]["line"] = 9
        elif which == "wrong_witness":
            raw["WitnessList"][0]["Witness"]["return_checker_wit"]["total"] = 2
        elif which == "foreign_function":
            raw["manual_obligations"][0]["functionName"] = "other"
        elif which == "no_residual":
            case["residual_vcs"] = []
        elif which == "missing_protocol":
            raw["spec_test"].pop("vc_semantics")
        elif which == "limit":
            raw["spec_test"]["limit_reason"] = "loop_unroll_limit"
        elif which == "mismatched_output":
            raw["spec_test"]["vc_results"][0]["goal"] = EMPTY
        case, _ = self.apply(case, raw)
        self.assertEqual(case["status"], "UNKNOWN")

    return test


for which in (
    "safety",
    "annotations",
    "unmapped_goal",
    "missing_inventory",
    "wrong_count",
    "wrong_line",
    "wrong_witness",
    "foreign_function",
    "no_residual",
    "missing_protocol",
    "limit",
    "mismatched_output",
):
    setattr(SpatialAdapterTests, "test_no_pass_" + which, incomplete(which))



def annotation_sample(value=7):
    local = "LOCAL[Temp buffer buffer_addr; Temp slot slot_addr]"
    pre = "PROP[]\n" + local + "\nSEP[IntArray.full(buffer_addr, 4, cons(Z_1, -2, cons(Z_1, 7, cons(Z_1, 9, cons(Z_1, 11, nil(Z_1))))))]\n"
    post = "PROP[]\nLOCAL[Temp buffer buffer_addr]\nSEP[store(pointer_offset(buffer_addr, 1, 4, signed int), " + str(value) + ", signed int); IntArray.missing_i(buffer_addr, 1, 0, 4, cons(Z_1, -2, cons(Z_1, 7, cons(Z_1, 9, cons(Z_1, 11, nil(Z_1))))))]\n"
    vc = dict(kind="entailment", name=None, line=11, status="UNKNOWN", path=pre, goal=post)
    returned = dict(kind="return", name=None, line=12, status="VALID", path=EMPTY, goal=EMPTY)
    case, raw = sample()
    case.update(mode="all-boundaries", annotation_policy="check-preserve", _synthetic_coq_fixture=True)
    case["phases"].update(postcondition="PASS", annotations="UNKNOWN")
    case["vc_results"] = [vc, returned]
    case["abstraction_events"] = [{"kind":"annotation-check", "function":"inspect", "count":1}]
    case["residual_vcs"] = ["proof_of_inspect_entail_wit_1", "proof_of_inspect_entail_wit_1_split_goal_spatial"]
    manual = dict(kind="entailment_checker_wit", functionName="inspect", fileName="sample.c", line=11, column=3, goal="array split")
    raw.update(functionName="inspect", manual_obligations=[manual], manual_obligation_count=1)
    raw["spec_test"].update(vc_results=deepcopy(case["vc_results"]), mode="no-expand", scope="execution", completed=True,
        annotation_policy="check-preserve", abstraction_events=deepcopy(case["abstraction_events"]))
    raw["WitnessList"] = [{"functionName":"inspect", "Witness": {
        "entailment_checker_wit":{"total":1,"manual":1,"auto_solved":0,
            "manual_witness":[{k:manual[k] for k in ("line","column","fileName","goal")}]},
        "return_checker_wit":{"total":1,"manual":0,"auto_solved":1,"manual_witness":None},
        "safety_checker_wit":{"total":0,"manual":0,"auto_solved":0,"manual_witness":None},
        "total_witness_count":{"manual":1,"auto_solved":1}}}]
    return case, raw



def annotation_artifacts(case, raw, root):
    folder = root / "vc"
    folder.mkdir()
    source = root / "input.c"
    source.write_text("void inspect(void) {}\n")
    case.update(id="array_case", generated_source=str(source),
                generated_source_sha256=hashlib.sha256(source.read_bytes()).hexdigest())
    raw["fileName"] = str(source)
    raw["spec_test"]["target_layout"] = deepcopy(LAYOUT)
    names = list(case["residual_vcs"])
    auto = []
    if not any("_return_wit_" in name for name in names):
        auto = ["proof_of_inspect_return_wit_1"]
    targets = [name.removeprefix("proof_of_") for name in names + auto]
    roots = [name for name in names + auto if "_split_goal_" not in name]
    texts = {
        "goal": "\n".join("Definition " + target + " := True." for target in targets)
            + "\nModule Type VC_Correct.\n"
            + "\n".join("Axiom " + name + " : " + name.removeprefix("proof_of_") + "." for name in roots)
            + "\nEnd VC_Correct.\n",
        "proof_manual": "\n".join("Lemma " + name + " : " + name.removeprefix("proof_of_") + ".\nProof. Abort." for name in names),
        "proof_auto": "\n".join("Lemma " + name + " : " + name.removeprefix("proof_of_") + ".\nProof. exact I. Qed." for name in auto),
        "goal_check": "Require Import input_goal input_proof_auto input_proof_manual.\nModule VC_Correctness : VC_Correct.\nInclude input_proof_auto.\nInclude input_proof_manual.\nEnd VC_Correctness.\n",
    }
    files = {}
    for kind, text in texts.items():
        p = folder / ("input_" + kind + ".v")
        p.write_text(text)
        files[kind] = str(p)
    manifest = {"schema":"qcp-spectest-vc-manifest/v1", "function":"inspect", "status":"residual", "case_id":"array_case", "source":str(source),
        "residual_goals":names, "missing_files":[], "files":files, "target_layout":LAYOUT,
        "immutable_sha256":{kind:hashlib.sha256(Path(files[kind]).read_bytes()).hexdigest()
                            for kind in ("goal","proof_auto","goal_check")}}
    path = folder / "manifest.json"
    path.write_text(json.dumps(manifest))
    case["vc"] = dict(manifest, manifest=str(path))

class AnnotationAdapterTests(unittest.TestCase):
    apply = SpatialAdapterTests.apply

    def test_array_split_annotation_passes(self):
        case, root = self.apply(*annotation_sample())
        self.assertEqual(case["status"], "PASS")
        self.assertEqual(case["phases"]["annotations"], "PASS")
        self.assertTrue(case["spatial_smt"]["annotation_residual_coverage"])
        self.assertFalse(case["spatial_smt"]["return_residual_coverage"])
        self.assertFalse(case["spatial_smt"]["itp_required"])
        evidence = json.loads((root / "spatial-smt/vc-0000.json").read_text())
        self.assertEqual(evidence["input"]["check_mode"], "exact")
        self.assertEqual(evidence["certificate"], "NOT_CHECKED")

    def test_wrong_array_value_is_rejected(self):
        case, _ = self.apply(*annotation_sample(value=8))
        self.assertEqual(case["status"], "FAIL")
        self.assertEqual(case["phases"]["annotations"], "FAIL")
        self.assertFalse(case["spatial_smt"]["itp_required"])

    def test_complete_inline_calls_are_allowed(self):
        case, raw = annotation_sample()
        events = [{"kind":"inline-call","function":"helper","count":2},
                  {"kind":"contract-check","function":"helper","count":2}]
        case["abstraction_events"].extend(events)
        raw["spec_test"]["abstraction_events"] = deepcopy(case["abstraction_events"])
        case, _ = self.apply(case, raw)
        self.assertEqual(case["status"], "PASS")

    def test_unknown_event_and_unpaired_contract_stay_unknown(self):
        for event in [{"kind":"havoc","function":"helper","count":1},
                      {"kind":"contract-check","function":"helper","count":1},
                      {"kind":"annotation-check","function":"callee","count":1}]:
            with self.subTest(event=event):
                case, raw = annotation_sample()
                case["abstraction_events"].append(event)
                raw["spec_test"]["abstraction_events"] = deepcopy(case["abstraction_events"])
                with patch("spectest.spatial_smt._solve_record", side_effect=AssertionError("must not solve")) as solve:
                    case, _ = self.apply(case, raw)
                    solve.assert_not_called()
                self.assertEqual(case["status"], "UNKNOWN")

    def test_ambiguous_annotation_inventory_keeps_itp(self):
        for change in ["branch_root", "extra_root", "missing_wrapper", "wrong_manual_line",
                       "foreign_witness", "other_manual", "missing_manual_goal", "duplicate_vc",
                       "wrong_witness_count", "wrong_annotation_policy", "wrong_completed"]:
            with self.subTest(change=change):
                case, raw = annotation_sample()
                witness = raw["WitnessList"][0]["Witness"]
                if change == "branch_root":
                    case["residual_vcs"][0] += "_1"
                elif change == "extra_root":
                    case["residual_vcs"].append("proof_of_inspect_entail_wit_2")
                elif change == "missing_wrapper":
                    case["residual_vcs"] = case["residual_vcs"][1:]
                elif change == "wrong_manual_line":
                    raw["manual_obligations"][0]["line"] = 13
                elif change == "foreign_witness":
                    raw["WitnessList"][0]["functionName"] = "another"
                elif change == "other_manual":
                    witness["safety_checker_wit"]["manual"] = 1
                elif change == "missing_manual_goal":
                    witness["entailment_checker_wit"]["manual_witness"][0].pop("goal")
                elif change == "duplicate_vc":
                    case["vc_results"].insert(0, deepcopy(case["vc_results"][0]))
                    raw["spec_test"]["vc_results"] = deepcopy(case["vc_results"])
                elif change == "wrong_witness_count":
                    witness["entailment_checker_wit"]["total"] = 2
                elif change == "wrong_annotation_policy":
                    raw["spec_test"]["annotation_policy"] = "assume"
                elif change == "wrong_completed":
                    raw["spec_test"]["completed"] = False
                case, _ = self.apply(case, raw)
                self.assertEqual(case["status"], "UNKNOWN")
                self.assertTrue(case["spatial_smt"]["itp_required"])

    def test_artifact_and_source_mismatches_keep_itp(self):
        def corrupt(kind):
            def change(case, raw):
                vc = case["vc"]
                if kind == "source":
                    Path(case["generated_source"]).write_text("changed")
                elif kind == "layout":
                    raw["spec_test"]["target_layout"]["architecture_bits"] = 64
                elif kind == "case_id":
                    vc["case_id"] = "other"
                elif kind == "goal_hash":
                    goal = Path(vc["files"]["goal"])
                    goal.write_text(goal.read_text() + "\n(* changed *)\n")
                elif kind == "manual_target":
                    p = Path(vc["files"]["proof_manual"])
                    p.write_text(p.read_text().replace(": inspect_entail_wit_1.", ": inspect_return_wit_1."))
                elif kind == "uncovered_root":
                    p = Path(vc["files"]["goal"])
                    text = p.read_text().replace("Module Type VC_Correct.", "Definition extra_goal := True.\nModule Type VC_Correct.\nAxiom proof_of_extra_goal : extra_goal.")
                    p.write_text(text)
                    vc["immutable_sha256"]["goal"] = hashlib.sha256(p.read_bytes()).hexdigest()
                    Path(vc["manifest"]).write_text(json.dumps({k:v for k,v in vc.items() if k != "manifest"}))
            return change
        for kind in ("source", "layout", "case_id", "goal_hash", "manual_target", "uncovered_root"):
            with self.subTest(kind=kind):
                case, raw = annotation_sample()
                case, _ = self.apply(case, raw, mutate=corrupt(kind))
                self.assertEqual(case["status"], "UNKNOWN")
                self.assertTrue(case["spatial_smt"]["itp_required"])
                self.assertFalse(case["spatial_smt"]["annotation_residual_coverage"])

    def test_mixed_return_and_annotation_group(self):
        case, raw = annotation_sample()
        returned = case["vc_results"][1]
        returned.update(status="UNKNOWN", path=PRE, goal=PRE)
        case["phases"]["postcondition"] = "UNKNOWN"
        case["residual_vcs"].append("proof_of_inspect_return_wit_1")
        manual = dict(kind="return_checker_wit", functionName="inspect", fileName="sample.c", line=12, column=1, goal="return cell")
        raw["manual_obligations"].append(manual)
        raw["manual_obligation_count"] = 2
        raw["spec_test"]["vc_results"] = deepcopy(case["vc_results"])
        witness = raw["WitnessList"][0]["Witness"]
        witness["return_checker_wit"].update(manual=1, auto_solved=0, manual_witness=[{k:manual[k] for k in ("line","column","fileName","goal")}])
        witness["total_witness_count"].update(manual=2, auto_solved=0)
        pending_case, pending_raw = deepcopy(case), deepcopy(raw)
        case, _ = self.apply(case, raw)
        self.assertEqual(case["status"], "PASS")
        self.assertFalse(case["spatial_smt"]["itp_required"])
        pending_case["vc_results"][1]["goal"] = "PROP[]\nLOCAL[]\nSEP[opaque(4096)]\n"
        pending_raw["spec_test"]["vc_results"] = deepcopy(pending_case["vc_results"])
        pending_case, _ = self.apply(pending_case, pending_raw)
        self.assertEqual(pending_case["status"], "UNKNOWN")
        self.assertEqual(pending_case["phases"]["annotations"], "PASS")
        self.assertEqual(pending_case["phases"]["postcondition"], "UNKNOWN")
        self.assertTrue(pending_case["spatial_smt"]["itp_required"])

class SpatialFlagTests(unittest.TestCase):
    def test_check_flags(self):
        parser = _check_parser()
        self.assertIsNone(parser.parse_args(["job.json"]).spatial_smt)
        self.assertTrue(parser.parse_args(["job.json", "--spatial-smt"]).spatial_smt)
        self.assertFalse(
            parser.parse_args(["job.json", "--no-spatial-smt"]).spatial_smt
        )

    def test_run_flags(self):
        args = _run_parser().parse_args(
            [
                "sample.c",
                "--function",
                "read",
                "--binds",
                "binds.json",
                "--spatial-smt",
                "--spatial-smt-timeout-ms",
                "17",
            ]
        )
        self.assertTrue(args.spatial_smt)
        self.assertEqual(args.spatial_smt_timeout_ms, 17)

    def test_config_default_and_validation(self):
        with tempfile.TemporaryDirectory() as tmp:
            p = Path(tmp)
            (p / "executor").touch()
            config = {"binary": str(p / "executor")}
            parsed = _parse_qcp_config({"qcp": config}, p, p)
            self.assertFalse(parsed.spatial_smt)
            self.assertEqual(parsed.spatial_smt_timeout_ms, 2000)
            for value in ("true", 1, None):
                with self.subTest(value=value), self.assertRaises(JobError):
                    _parse_qcp_config({"qcp": dict(config, spatial_smt=value)}, p, p)
            for value in (0, -1, True, 60001, "100", 1.5):
                with self.subTest(value=value), self.assertRaises(JobError):
                    _parse_qcp_config(
                        {"qcp": dict(config, spatial_smt_timeout_ms=value)}, p, p
                    )


@unittest.skipUnless(
    (Path(__file__).resolve().parents[1] / "bin/tespec-symexec").is_file(),
    "requires the bundled native executor",
)
class NativeSpatialIntegrationTests(unittest.TestCase):
    def run_modes(self, spec, values, declaration=""):
        from spectest.core import run_job

        root = Path(__file__).resolve().parents[1]
        temp = tempfile.TemporaryDirectory()
        self.addCleanup(temp.cleanup)
        folder = Path(temp.name)
        source = folder / "sample.c"
        source.write_text(
            '#include "verification_stdlib.h"\n'
            + declaration
            + "int read(int *p) /*@ "
            + spec
            + " */ { return *p; }\n"
        )
        job = folder / "job.json"
        job.write_text(
            json.dumps(
                {
                    "source": str(source),
                    "function": "read",
                    "binds": [{"id": "cell", "args": {"p": 4096}, "values": values}],
                    "qcp": {
                        "include_dirs": [
                            str(root / "runtime/qcip/QCP_examples/QCP_demos_human")
                        ]
                    },
                }
            )
        )
        off = run_job(job, folder / "off")
        on = run_job(job, folder / "on", spatial_smt=True)
        self.assertNotIn("spatial_smt", off["results"][0])
        return off, on, job, folder

    def test_missing_post_and_explicit_disable(self):
        from spectest.core import run_job

        off, on, job, folder = self.run_modes(
            "With v Require data_at(p,int,v) Ensure emp", {"v": 7}
        )
        self.assertEqual(off["results"][0]["status"], "UNKNOWN")
        self.assertEqual(on["results"][0]["status"], "FAIL")
        self.assertEqual(len(off["itp_vcs"]), 1)
        self.assertEqual(on["itp_vcs"], [])
        payload = json.loads(job.read_text())
        payload["qcp"]["spatial_smt"] = True
        job.write_text(json.dumps(payload))
        saved = job.read_bytes()
        disabled = run_job(job, folder / "disabled", spatial_smt=False)
        self.assertEqual(job.read_bytes(), saved)
        self.assertEqual(disabled["results"][0]["status"], "UNKNOWN")
        self.assertNotIn("spatial_smt", disabled["results"][0])
        for key in ("goal", "proof_auto", "proof_manual", "goal_check"):
            expected = Path(off["results"][0]["vc"]["files"][key]).read_bytes()
            for result in (on, disabled):
                self.assertEqual(
                    Path(result["results"][0]["vc"]["files"][key]).read_bytes(),
                    expected,
                )

    def test_correct_case_unchanged(self):
        off, on, _, _ = self.run_modes(
            "With v Require data_at(p,int,v) Ensure data_at(p,int,v) && __return == v",
            {"v": 7},
        )
        self.assertEqual(
            [r["results"][0]["status"] for r in (off, on)], ["PASS", "PASS"]
        )

    def test_unreadable_memory_unchanged(self):
        off, on, _, _ = self.run_modes("Require emp Ensure emp", {})
        self.assertEqual(
            [r["results"][0]["status"] for r in (off, on)], ["ERROR", "ERROR"]
        )

    def test_opaque_goal_preserves_itp(self):
        off, on, _, _ = self.run_modes(
            "With v Require data_at(p,int,v) Ensure mystery(__return) && data_at(p,int,v)",
            {"v": 7},
            "/*@ Extern Coq (mystery : Z -> Prop) */\n",
        )
        self.assertEqual(
            [r["results"][0]["status"] for r in (off, on)], ["UNKNOWN", "UNKNOWN"]
        )
        self.assertEqual(len(on["itp_vcs"]), 1)
        from spectest.run_certificates import prepare_run_certificates

        prepared = prepare_run_certificates(
            Path(on["report"]), Path(on["report"]).parent / "certificate-tasks"
        )
        self.assertTrue(prepared)


@unittest.skipUnless(
    (Path(__file__).resolve().parents[1] / "bin/tespec-symexec").is_file(),
    "requires the bundled native executor",
)
class NativeAnnotationIntegrationTests(unittest.TestCase):
    def run_array(self, values, index, defect=None):
        from spectest.core import run_job
        root = Path(__file__).resolve().parents[1]
        temp = tempfile.TemporaryDirectory()
        self.addCleanup(temp.cleanup)
        folder = Path(temp.name)
        sequence = "nil"
        for value in reversed(values):
            sequence = f"cons({value},{sequence})"
        n = len(values)
        stored = values[index] + (1 if defect == "wrong_value" else 0)
        cell = f"data_at(slot,int,{stored})"
        rest = f"IntArray::missing_i(buffer,{index},0,{n},{sequence})"
        if defect == "duplicate_ownership":
            rest = f"IntArray::full(buffer,{n},{sequence})"
        assertion = rest if defect == "missing_cell" else cell if defect == "missing_rest" else cell + " * " + rest
        source = folder / "finite_client.c"
        source.write_text(
            '#include "verification_stdlib.h"\n#include "int_array_def.h"\n'
            'int inspect_array(void) /*@ Require emp Ensure __return == 0 && emp */ {\n'
            + f'int buffer[{n}] = {{' + ','.join(map(str, values)) + '};\n'
            + f'int *slot = buffer + {index};\n'
            + '/*@ Assert ' + assertion + ' */\nreturn 0;\n}\n'
        )
        job = folder / "job.json"
        job.write_text(json.dumps({"source":str(source),"function":"inspect_array",
            "binds":[{"id":"finite","args":{},"values":{}}],
            "qcp":{"execution_mode":"all-boundaries","include_dirs":[str(root / "runtime/qcip/QCP_examples/QCP_demos_human")]}}))
        off = run_job(job, folder / "off")
        on = run_job(job, folder / "on", spatial_smt=True)
        for key in ("goal","proof_auto","proof_manual","goal_check"):
            self.assertEqual(Path(off["results"][0]["vc"]["files"][key]).read_bytes(),
                             Path(on["results"][0]["vc"]["files"][key]).read_bytes())
        return off, on

    def test_different_arrays_and_indices_pass(self):
        for values, index in [([5, -4],0), ([5,-4],1), ([8,-3,17,6,2],2), ([8,-3,17,6,2],4)]:
            with self.subTest(values=values,index=index):
                off, on = self.run_array(values,index)
                self.assertEqual(off["results"][0]["status"], "UNKNOWN")
                self.assertEqual(on["results"][0]["status"], "PASS")
                self.assertEqual(on["results"][0]["spatial_smt"]["attempted"], 1)
                self.assertEqual(on["itp_vcs"], [])

    def test_wrong_values_and_ownership_are_rejected(self):
        for defect in ("wrong_value","duplicate_ownership","missing_cell","missing_rest"):
            with self.subTest(defect=defect):
                off, on = self.run_array([13,-9,4,26],1,defect)
                self.assertIn(off["results"][0]["status"], ["UNKNOWN","FAIL"])
                self.assertEqual(on["results"][0]["status"], "FAIL")
                self.assertNotEqual(on["results"][0]["status"], "PASS")


if __name__ == "__main__":
    unittest.main()
