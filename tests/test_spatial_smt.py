"""Opt-in adapter tests, separate from program benchmark measurements."""

from copy import deepcopy
import json
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
    def apply(self, case, raw):
        temp = tempfile.TemporaryDirectory()
        self.addCleanup(temp.cleanup)
        root = Path(temp.name)
        stdout = root / "executor.json"
        stdout.write_text(json.dumps(raw))
        saved = stdout.read_bytes()
        residuals = deepcopy(case["residual_vcs"])
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


if __name__ == "__main__":
    unittest.main()
