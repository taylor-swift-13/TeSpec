"""Decision tasks must neither lose original proof goals nor confuse alternatives."""

from copy import deepcopy
import unittest

from spectest.itp_schedule import decision_itp_task
from tests import test_spatial_smt as fixtures


class DecisionScheduleTests(unittest.TestCase):
    apply = fixtures.SpatialAdapterTests.apply

    def case(self, other_kind="entailment", other_goal=fixtures.PRE, native_fail=False):
        case, raw = fixtures.annotation_sample()
        first, returned = case["vc_results"]
        first.update(path=fixtures.PRE, goal=fixtures.PRE, proof_roots=["inspect_entail_wit_1"])
        family = {"entailment": "entail", "safety": "safety"}[other_kind]
        number = 2 if other_kind == "entailment" else 1
        second_name = f"inspect_{family}_wit_{number}"
        second = dict(first, kind=other_kind, goal=other_goal, proof_roots=[second_name])
        returned["proof_roots"] = ["inspect_return_wit_1"]
        case["vc_results"].insert(1, second)
        case["residual_vcs"].append("proof_of_" + second_name)
        if native_fail:
            first["status"] = "INVALID"
            case.update(status="FAIL", overall="FAIL", test_result="FAIL", reason="invalid_path_vc")
            case["phases"]["annotations"] = "FAIL"
        raw["spec_test"]["vc_results"] = deepcopy(case["vc_results"])
        return case, raw

    def test_same_line_distinct_roots_and_multiple_roots_per_vc(self):
        case, raw = self.case()
        case["vc_results"][0]["proof_roots"].append("inspect_entail_wit_3")
        case["residual_vcs"].append("proof_of_inspect_entail_wit_3")
        raw["spec_test"]["vc_results"] = deepcopy(case["vc_results"])
        result, _ = self.apply(case, raw)
        self.assertEqual(result["status"], "PASS")
        self.assertIsNone(decision_itp_task(result, "inspect"))
        self.assertEqual(result["vc"]["residual_goals"], case["residual_vcs"])
        self.assertEqual(len(result["spatial_smt"]["proof_root_vc_indices"]), 3)

    def test_only_unresolved_parent_remains(self):
        case, raw = self.case(other_goal="PROP[]\nLOCAL[]\nSEP[unknown(4096)]\n")
        result, _ = self.apply(case, raw)
        self.assertEqual(result["status"], "UNKNOWN")
        task = decision_itp_task(result, "inspect")
        self.assertEqual(task["goals"], ["proof_of_inspect_entail_wit_2"])
        self.assertEqual(result["vc"]["residual_goals"], case["residual_vcs"])

    def test_ambiguous_or_foreign_root_keeps_original_task(self):
        for incorrect in (["inspect_entail_wit_1"], ["unknown_entail_wit_2"], {}):
            with self.subTest(incorrect=incorrect):
                case, raw = self.case()
                case["vc_results"][1]["proof_roots"] = incorrect
                raw["spec_test"]["vc_results"] = deepcopy(case["vc_results"])
                result, _ = self.apply(case, raw)
                self.assertEqual(result["status"], "UNKNOWN")
                self.assertEqual(decision_itp_task(result, "inspect")["goals"], case["residual_vcs"])

    def test_native_fail_keeps_only_unresolved_safety_when_fully_mapped(self):
        case, raw = self.case(other_kind="safety", other_goal="PROP[opaque(1)]\nLOCAL[]\nSEP[]\n",
                              native_fail=True)
        case["phases"]["safety"] = "UNKNOWN"
        result, _ = self.apply(case, raw)
        self.assertEqual(result["status"], "FAIL")
        self.assertEqual(decision_itp_task(result, "inspect")["goals"], ["proof_of_inspect_safety_wit_1"])

    def test_native_fail_with_no_unresolved_safety_needs_no_decision_itp(self):
        case, raw = self.case(other_goal="PROP[]\nLOCAL[]\nSEP[unknown(4096)]\n", native_fail=True)
        result, _ = self.apply(case, raw)
        self.assertEqual(result["status"], "FAIL")
        self.assertIsNone(decision_itp_task(result, "inspect"))

    def test_raw_spatial_refutation_does_not_suppress_sibling_obligation(self):
        case, raw = self.case(other_goal="PROP[]\nLOCAL[]\nSEP[unknown(4096)]\n")
        case["vc_results"][0]["goal"] = fixtures.EMPTY
        raw["spec_test"]["vc_results"] = deepcopy(case["vc_results"])
        result, _ = self.apply(case, raw)
        self.assertEqual(result["status"], "FAIL")
        self.assertEqual(decision_itp_task(result, "inspect")["goals"], case["residual_vcs"])

    def test_unmapped_entry_remains_in_full_unknown_case(self):
        case, raw = self.case()
        case["residual_vcs"].append("proof_of_inspect_precondition_wit_1")
        case["precondition_result"] = "UNKNOWN"
        result, _ = self.apply(case, raw)
        self.assertEqual(result["status"], "UNKNOWN")
        self.assertEqual(decision_itp_task(result, "inspect")["goals"], case["residual_vcs"])
