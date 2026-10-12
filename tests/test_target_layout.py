import copy
import json
import unittest

from spectest.core import JobError, _executor_target_layout
from spectest.layout import generate_layout_source


class TargetLayoutTests(unittest.TestCase):
    def layout_fixture(self):
        return {
            "schema": "sac-target-layout/v1",
            "architecture_bits": 64,
            "pointer_size": 8,
            "aliases": [],
            "aggregates": [
                {
                    "id": 1,
                    "kind": "struct",
                    "name": "Cell",
                    "defined": True,
                    "size": 8,
                    "alignment": 4,
                    "fields": [
                        {
                            "id": 2,
                            "name": "value",
                            "offset": 4,
                            "size": 4,
                            "alignment": 4,
                            "computational": True,
                            "type": {"kind": "basic", "name": "int"},
                        }
                    ],
                }
            ],
        }

    def test_inconsistent_admitted_layouts_are_rejected(self):
        for key, value in (
            ("offset", 8),
            ("offset", -1),
            ("offset", 2),
            ("size", 2),
            ("alignment", 3),
        ):
            layout = self.layout_fixture()
            layout["aggregates"][0]["fields"][0][key] = value
            with self.subTest(key=key, value=value), self.assertRaises(ValueError):
                generate_layout_source(layout)

    def test_dangling_type_reference_is_rejected(self):
        layout = self.layout_fixture()
        layout["aggregates"][0]["fields"][0]["type"] = {"kind": "struct", "id": 99}
        with self.assertRaisesRegex(ValueError, "dangling"):
            generate_layout_source(layout)

    def test_malformed_layout_records_fail_before_elaboration(self):
        cases = [None, [], "layout"]
        for inventory in ("aggregates", "aliases"):
            for record in (None, [], 1):
                layout = self.layout_fixture()
                layout[inventory] = [record]
                cases.append(layout)
        for record in (None, [], 1):
            layout = self.layout_fixture()
            layout["aggregates"][0]["fields"] = [record]
            cases.append(layout)
        layout = self.layout_fixture()
        layout["aggregates"][0]["fields"][0]["name"] = ["value"]
        cases.append(layout)
        for layout in cases:
            with self.subTest(layout=layout), self.assertRaises(ValueError):
                generate_layout_source(layout)

    def test_shadowed_names_do_not_select_an_arbitrary_type(self):
        layout = self.layout_fixture()
        other = copy.deepcopy(layout["aggregates"][0])
        other["id"] = 3
        other["fields"][0]["id"] = 4
        layout["aggregates"].append(other)
        source = generate_layout_source(layout)
        self.assertNotIn('String.eqb name "Cell"', source)
        self.assertIn("Nat.eqb id 1%nat", source)
        self.assertIn("Nat.eqb id 3%nat", source)

    def test_tag_alias_collision_is_not_silently_overridden(self):
        layout = self.layout_fixture()
        layout["aliases"] = [
            {"id": 3, "name": "Cell", "type": {"kind": "basic", "name": "int"}}
        ]
        source = generate_layout_source(layout)
        alias_body = source.split("Definition resolve_alias", 1)[1].split(
            "Definition resolve_type", 1
        )[0]
        self.assertNotIn('String.eqb name "Cell"', alias_body)

    def test_old_or_failed_executor_output_has_no_layout(self):
        for value in (None, "", "not JSON", "null", "{}", '{"spec_test": null}'):
            self.assertIsNone(_executor_target_layout(value))

    def test_target_width_must_match_executor_and_pointer_size(self):
        layout = {
            "schema": "sac-target-layout/v1",
            "architecture_bits": 64,
            "pointer_size": 8,
            "aggregates": [],
        }

        def output(value):
            return json.dumps(
                {"spec_test": {"architecture_bits": 64, "target_layout": value}}
            )

        self.assertEqual(_executor_target_layout(output(layout)), layout)
        for key, value in (
            ("schema", "unsupported"),
            ("architecture_bits", 32),
            ("architecture_bits", True),
            ("pointer_size", 4),
            ("aggregates", {}),
        ):
            mutated = copy.deepcopy(layout)
            mutated[key] = value
            with self.subTest(key=key, value=value), self.assertRaises(JobError):
                _executor_target_layout(output(mutated))


if __name__ == "__main__":
    unittest.main()
