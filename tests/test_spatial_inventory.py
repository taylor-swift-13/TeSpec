"""Native inventory normalization must preserve every residual obligation."""

from copy import deepcopy
import unittest

from spectest.spatial_smt import _witness_inventory
from tests import test_spatial_smt as spatial_tests


FAMILIES = {
    "entailment": "entailment_checker_wit",
    "safety": "safety_checker_wit",
    "return_entailment": "return_checker_wit",
    "partial_solve": "partial_solve_wit",
    "which_implies": "which_implies_wit",
    "spec_entailment": "spec_entailment_wit",
}


def structured_inventory():
    conditions = {}
    for index, kind in enumerate(FAMILIES, 1):
        conditions[kind] = {
            "total": 2,
            "auto_solved": 1,
            "manual_obligations": [{
                "kind": kind,
                "location": {"file": "sample.c", "line": index + 10, "column": index},
                "goal": "original obligation " + kind,
            }],
        }
    return {
        "schema_version": 1,
        "verification_conditions": [{"function": "inspect", "conditions": conditions}],
    }


def structured_annotation(value=7):
    case, raw = spatial_tests.annotation_sample(value)
    old = raw.pop("WitnessList")[0]["Witness"]
    conditions = {}
    for kind, family in FAMILIES.items():
        counts = old.get(family, {"total": 0, "auto_solved": 0})
        conditions[kind] = {
            "total": counts["total"],
            "auto_solved": counts["auto_solved"],
            "manual_obligations": [
                {
                    "kind": kind,
                    "location": {"file": item["fileName"], "line": item["line"],
                                 "column": item["column"]},
                    "goal": item["goal"],
                }
                for item in counts.get("manual_witness") or []
            ],
        }
    raw.update(schema_version=1, verification_conditions=[{
        "function": "inspect", "conditions": conditions,
    }])
    return case, raw


class WitnessInventoryTests(unittest.TestCase):
    def test_all_families_counts_and_locations_are_preserved(self):
        raw = structured_inventory()
        original = deepcopy(raw)
        result = _witness_inventory(raw)
        self.assertEqual(raw, original)
        self.assertEqual(len(result), 1)
        self.assertEqual(result[0]["functionName"], "inspect")
        witness = result[0]["Witness"]
        self.assertEqual(set(witness), {*FAMILIES.values(), "total_witness_count"})
        self.assertEqual(witness["total_witness_count"], {
            "total": 12, "auto_solved": 6, "manual": 6,
        })
        for index, (kind, family) in enumerate(FAMILIES.items(), 1):
            self.assertEqual(witness[family], {
                "total": 2, "auto_solved": 1, "manual": 1,
                "manual_witness": [{"fileName": "sample.c", "line": index + 10,
                                    "column": index, "goal": "original obligation " + kind}],
            })
        witness["safety_checker_wit"]["manual_witness"][0]["line"] = 999
        self.assertEqual(raw, original)

    def test_schema_version_must_be_integer_one(self):
        for version in (None, 0, 2, "1", True, False):
            with self.subTest(version=version):
                raw = structured_inventory()
                raw["schema_version"] = version
                self.assertEqual(_witness_inventory(raw), [])

    def test_bad_inventory_structure_is_rejected(self):
        for value in (None, {}, "conditions", [None], [{"function": 5}],
                      [{"function": "inspect", "conditions": []}]):
            with self.subTest(value=value):
                raw = structured_inventory()
                raw["verification_conditions"] = value
                self.assertEqual(_witness_inventory(raw), [])

    def test_missing_or_unknown_family_is_rejected(self):
        for change in ("missing", "unknown"):
            with self.subTest(change=change):
                raw = structured_inventory()
                conditions = raw["verification_conditions"][0]["conditions"]
                if change == "missing":
                    conditions.pop("safety")
                else:
                    conditions["new_family"] = {"total": 0, "auto_solved": 0,
                                                "manual_obligations": []}
                self.assertEqual(_witness_inventory(raw), [])

    def test_counts_must_account_for_every_obligation(self):
        for total, solved in ((3, 1), (0, 1), (-1, 0), (2, -1),
                              ("2", 1), (2, "1"), (True, 0), (2, True)):
            with self.subTest(total=total, solved=solved):
                raw = structured_inventory()
                counts = raw["verification_conditions"][0]["conditions"]["safety"]
                counts.update(total=total, auto_solved=solved)
                self.assertEqual(_witness_inventory(raw), [])

    def test_malformed_category_and_manual_list_are_rejected(self):
        for value in (None, [], {}, {"total": 1, "auto_solved": 0,
                                   "manual_obligations": None}):
            with self.subTest(value=value):
                raw = structured_inventory()
                raw["verification_conditions"][0]["conditions"]["safety"] = value
                self.assertEqual(_witness_inventory(raw), [])

    def test_manual_kind_must_match_its_family(self):
        for value in (None, "return_entailment", 3):
            with self.subTest(value=value):
                raw = structured_inventory()
                obligation = raw["verification_conditions"][0]["conditions"]["safety"]["manual_obligations"][0]
                obligation["kind"] = value
                self.assertEqual(_witness_inventory(raw), [])

    def test_bad_manual_location_or_goal_is_rejected(self):
        changes = [("location", None), ("goal", None), ("goal", 9),
                   ("file", None), ("line", "11"), ("line", True),
                   ("column", None), ("column", False)]
        for field, value in changes:
            with self.subTest(field=field, value=value):
                raw = structured_inventory()
                obligation = raw["verification_conditions"][0]["conditions"]["safety"]["manual_obligations"][0]
                if field in ("location", "goal"):
                    obligation[field] = value
                else:
                    obligation["location"][field] = value
                self.assertEqual(_witness_inventory(raw), [])

    def test_legacy_inventory_is_authoritative_even_when_malformed(self):
        for legacy in (None, [], "broken", [{"functionName": "different"}]):
            with self.subTest(legacy=legacy):
                raw = structured_inventory()
                raw["WitnessList"] = legacy
                self.assertIs(_witness_inventory(raw), legacy)


class StructuredInventoryIntegrationTests(unittest.TestCase):
    apply = spatial_tests.SpatialAdapterTests.apply

    def test_complete_annotation_inventory_allows_pass(self):
        case, _ = self.apply(*structured_annotation())
        self.assertEqual(case["status"], "PASS")
        self.assertTrue(case["spatial_smt"]["annotation_residual_coverage"])
        self.assertFalse(case["spatial_smt"]["itp_required"])

    def test_wrong_array_value_is_still_fail(self):
        case, _ = self.apply(*structured_annotation(99))
        self.assertEqual(case["status"], "FAIL")
        self.assertTrue(case["spatial_smt"]["annotation_residual_coverage"])

    def test_unrepresented_manual_safety_obligation_prevents_pass(self):
        case, raw = structured_annotation()
        manual = {
            "kind": "safety_checker_wit", "functionName": "inspect",
            "fileName": "sample.c", "line": 15, "column": 2, "goal": "extra safety",
        }
        raw["manual_obligations"].append(manual)
        raw["manual_obligation_count"] += 1
        raw["verification_conditions"][0]["conditions"]["safety"] = {
            "total": 1, "auto_solved": 0,
            "manual_obligations": [{"kind": "safety",
                                    "location": {"file": "sample.c", "line": 15, "column": 2},
                                    "goal": "extra safety"}],
        }
        case["residual_vcs"].append("proof_of_inspect_safety_wit_1")
        case, _ = self.apply(case, raw)
        self.assertEqual(case["vc_results"][0]["status"], "VALID")
        self.assertEqual(case["status"], "UNKNOWN")
        self.assertFalse(case["spatial_smt"]["annotation_residual_coverage"])
        self.assertTrue(case["spatial_smt"]["itp_required"])

    def test_invalid_legacy_inventory_cannot_fall_back_to_good_structured_data(self):
        case, raw = structured_annotation()
        raw["WitnessList"] = []
        case, _ = self.apply(case, raw)
        self.assertEqual(case["vc_results"][0]["status"], "VALID")
        self.assertEqual(case["status"], "UNKNOWN")
        self.assertTrue(case["spatial_smt"]["itp_required"])


if __name__ == "__main__":
    unittest.main()
