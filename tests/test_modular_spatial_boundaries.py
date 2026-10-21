"""Completed modular contract/annotation states use the same finite VC solver."""
from copy import deepcopy
import unittest
from tests import test_spatial_smt as spatial_tests


def symbolic_sample(value=7):
    case, raw = spatial_tests.annotation_sample(value)
    events = [{"kind": "modular-assertion", "function": "inspect", "count": 1},
              {"kind": "contract-use", "function": "helper", "count": 1},
              {"kind": "contract_state_symbolic", "function": "contract", "count": 1}]
    for state in (case, raw["spec_test"]):
        state.update(execution_strategy="modular", execution_semantics="modular-symbolic/v1",
            result_scope="contract-and-invariant-symbolic", declaration_call_policy="contract-symbolic/v1",
            sampling_events=[], abstraction_events=deepcopy(events))
    return case, raw


class ModularSpatialBoundaryTests(unittest.TestCase):
    apply = spatial_tests.SpatialAdapterTests.apply

    def test_positive_array_split_keeps_pass(self):
        result, _ = self.apply(*symbolic_sample())
        self.assertEqual(result["status"], "PASS")
        self.assertTrue(result["spatial_smt"]["annotation_residual_coverage"])

    def test_wrong_array_contents_fails(self):
        result, _ = self.apply(*symbolic_sample(99))
        self.assertEqual(result["status"], "FAIL")

    def test_incomplete_or_unmatched_contract_events_stay_unknown(self):
        for change in ["count", "loop", "sample", "caller"]:
            with self.subTest(change=change):
                case, raw = symbolic_sample()
                if change == "count":
                    raw["spec_test"]["abstraction_events"][1]["count"] = 2
                elif change == "loop":
                    raw["spec_test"]["abstraction_events"].append({"kind": "modular-loop", "function": "inspect", "count": 1})
                elif change == "sample":
                    raw["spec_test"]["sampling_events"] = [{"status": "SAMPLED"}]
                else:
                    raw["spec_test"]["abstraction_events"][0]["function"] = "wrong"
                case["abstraction_events"] = deepcopy(raw["spec_test"]["abstraction_events"])
                case["sampling_events"] = deepcopy(raw["spec_test"]["sampling_events"])
                result, _ = self.apply(case, raw)
                self.assertEqual(result["status"], "UNKNOWN")
