"""Per-VC fallback is independent of whole-execution verdict eligibility."""

from copy import deepcopy
import unittest
from unittest.mock import patch

from tests import test_spatial_smt as spatial_tests


def modular_loop_sample(goal):
    case, raw = spatial_tests.sample(goal)
    events = [{"kind": "modular-loop-invariant", "function": "read", "count": 1}]
    for state in (case, raw["spec_test"]):
        state.update(
            execution_strategy="modular",
            execution_semantics="modular-symbolic/v1",
            result_scope="contract-and-invariant-symbolic",
            declaration_call_policy="contract-symbolic/v1",
            annotation_policy="ignore",
            sampling_events=[],
            abstraction_events=deepcopy(events),
        )
    raw["spec_test"].update(completed=True, scope="execution", mode="expand")
    return case, raw


class SpatialVcDispatchTests(unittest.TestCase):
    apply = spatial_tests.SpatialAdapterTests.apply

    def test_all_unknown_kinds_reach_fallback_in_original_order(self):
        case, raw = spatial_tests.sample()
        kinds = ["return", "entailment", "safety", "assert", "future-vc-kind"]
        obligations = [dict(case["vc_results"][0], kind=kind) for kind in kinds]
        case["vc_results"] = obligations
        raw["spec_test"]["vc_results"] = deepcopy(obligations)
        with patch(
            "spectest.spatial_smt._solve_record",
            return_value={"status": "UNKNOWN", "reason": "unsupported_test_fragment"},
        ) as solve:
            result, _ = self.apply(case, raw)
        self.assertEqual(
            [call.args[0]["vc"]["kind"] for call in solve.call_args_list], kinds
        )
        self.assertEqual(result["spatial_smt"]["attempted"], len(kinds))
        self.assertEqual(result["status"], "UNKNOWN")
        self.assertTrue(result["spatial_smt"]["itp_required"])

    def test_existing_invalid_is_preserved_while_other_unknowns_are_dispatched(self):
        case, raw = spatial_tests.sample()
        base = case["vc_results"][0]
        obligations = [
            dict(base, status="INVALID"),
            dict(base, status="VALID"),
            dict(base, kind="assert"),
            dict(base, kind="future-vc-kind"),
        ]
        case.update(status="FAIL", overall="FAIL", test_result="FAIL", satisfied=False)
        case["vc_results"] = obligations
        raw["spec_test"]["vc_results"] = deepcopy(obligations)
        phases = deepcopy(case["phases"])
        with patch(
            "spectest.spatial_smt._solve_record",
            return_value={"status": "UNKNOWN", "reason": "unsupported_test_fragment"},
        ) as solve:
            result, _ = self.apply(case, raw)
        self.assertEqual(solve.call_count, 2)
        self.assertEqual(
            [v["status"] for v in result["vc_results"]],
            ["INVALID", "VALID", "UNKNOWN", "UNKNOWN"],
        )
        self.assertEqual(result["status"], "FAIL")
        self.assertEqual(result["phases"], phases)

    def test_incomplete_or_ineligible_execution_can_solve_vc_without_promotion(self):
        for condition in ("error", "incomplete", "entry_unknown", "entry_unsat", "limit"):
            for goal in (spatial_tests.PRE, spatial_tests.EMPTY):
                with self.subTest(condition=condition, goal=goal):
                    case, raw = spatial_tests.sample(goal)
                    if condition == "error":
                        case.update(status="ERROR", overall="ERROR", test_result="ERROR",
                                    executor_error="unreadable memory", returncode=1)
                        case["phases"]["execution"] = "ERROR"
                    elif condition == "incomplete":
                        case["execution_completed"] = False
                        case["phases"]["execution"] = "UNKNOWN"
                        raw["spec_test"]["completed"] = False
                    elif condition == "entry_unknown":
                        case["precondition_result"] = "UNKNOWN"
                    elif condition == "entry_unsat":
                        case.update(status="INVALID", overall="INVALID", test_result="INVALID",
                                    precondition_result="UNSAT")
                    else:
                        raw["spec_test"]["limit_reason"] = "loop_unroll_limit"
                    before = {
                        key: deepcopy(case[key])
                        for key in ("status", "overall", "test_result", "reason", "phases")
                    }
                    result, _ = self.apply(case, raw)
                    self.assertEqual(result["spatial_smt"]["attempted"], 1)
                    self.assertEqual(
                        result["vc_results"][0]["status"],
                        "VALID" if goal == spatial_tests.PRE else "INVALID",
                    )
                    self.assertEqual({key: result[key] for key in before}, before)

    def test_modular_loop_return_reaches_solver_and_can_decide(self):
        for goal, expected in ((spatial_tests.PRE, "PASS"), (spatial_tests.EMPTY, "FAIL")):
            with self.subTest(expected=expected):
                result, _ = self.apply(*modular_loop_sample(goal))
                self.assertEqual(result["spatial_smt"]["attempted"], 1)
                self.assertEqual(result["status"], expected)
                self.assertTrue(result["spatial_smt"]["return_residual_coverage"])

    def test_untrusted_event_does_not_block_vc_or_promote_execution(self):
        for goal in (spatial_tests.PRE, spatial_tests.EMPTY):
            with self.subTest(goal=goal):
                case, raw = spatial_tests.sample(goal)
                events = [{"kind": "future-event", "function": "read", "count": 1}]
                case["abstraction_events"] = deepcopy(events)
                raw["spec_test"]["abstraction_events"] = deepcopy(events)
                phases = deepcopy(case["phases"])
                result, _ = self.apply(case, raw)
                self.assertEqual(result["spatial_smt"]["attempted"], 1)
                self.assertEqual(result["status"], "UNKNOWN")
                self.assertEqual(result["phases"], phases)
                self.assertIn(result["vc_results"][0]["status"], ("VALID", "INVALID"))
                self.assertTrue(result["spatial_smt"]["itp_required"])

    def test_unsupported_predicate_does_not_block_later_supported_vc(self):
        case, raw = spatial_tests.sample()
        supported = deepcopy(case["vc_results"][0])
        unsupported = dict(supported, goal="PROP[]\nLOCAL[]\nSEP[Dll(4096)]\n")
        case["vc_results"] = [unsupported, supported]
        raw["spec_test"]["vc_results"] = deepcopy(case["vc_results"])
        result, _ = self.apply(case, raw)
        self.assertEqual(result["spatial_smt"]["attempted"], 2)
        self.assertEqual([v["status"] for v in result["vc_results"]], ["UNKNOWN", "INVALID"])
        self.assertEqual(result["status"], "FAIL")
        self.assertTrue(result["spatial_smt"]["itp_required"])


if __name__ == "__main__":
    unittest.main()
