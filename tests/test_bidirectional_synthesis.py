from __future__ import annotations

import hashlib
import json
from pathlib import Path
import re
import runpy
import tempfile
import unittest


ROOT = Path(__file__).resolve().parents[1]
EXPERIMENT = ROOT / "benchmark/experiments/spec-synthesis-tester-ablation-20260731"


class BidirectionalSynthesisTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls) -> None:
        cls.runner = runpy.run_path(str(EXPERIMENT / "run.py"))
        cls.checker = runpy.run_path(str(EXPERIMENT / "syntax_checker.py"))

    def test_dataset_manifest_locks_public_and_hidden_artifacts(self) -> None:
        manifest = json.loads(
            (EXPERIMENT / "dataset-manifest.json").read_text(encoding="utf-8")
        )
        self.assertEqual(manifest["judge"]["training_cases"], 0)
        self.assertEqual(manifest["judge"]["hidden_state_count"], 30)
        self.assertEqual(manifest["judge"]["hidden_mutant_count"], 12)
        self.assertFalse(manifest["public_interface"]["semantic_feedback"])
        self.assertEqual(
            manifest["public_interface"]["conditions"],
            ["no-tool", "qcp-tool", "tespec-tool"],
        )
        for relative, expected in manifest["sha256"].items():
            path = (
                ROOT / relative
                if relative.startswith("e2e/")
                else EXPERIMENT / relative
            )
            self.assertEqual(
                hashlib.sha256(path.read_bytes()).hexdigest(),
                expected,
                msg=relative,
            )

    def test_hidden_suite_is_six_groups_of_five_without_prompt_leakage(self) -> None:
        split, states = self.runner["load_protocol"]()
        self.assertEqual(len(split["groups"]), 6)
        self.assertTrue(all(len(group["cases"]) == 5 for group in split["groups"]))
        self.assertEqual(len(states), 30)

        prompts = [
            self.runner["task_prompt"](direction, condition)
            for direction in ("code-to-spec", "spec-to-code")
            for condition in ("no-tool", "qcp-tool", "tespec-tool")
        ]
        mutant_names = {
            path.name
            for directory in self.runner["MUTANT_DIRS"]
            for path in directory.glob("*.c")
        }
        for prompt in prompts:
            self.assertTrue(all(item["id"] not in prompt for item in states))
            self.assertTrue(all(name not in prompt for name in mutant_names))

    def test_default_results_directory_is_outside_the_repository(self) -> None:
        results_root = self.runner["DEFAULT_RESULTS_ROOT"].resolve()
        self.assertNotEqual(results_root, ROOT)
        self.assertNotIn(ROOT, results_root.parents)

    def test_hidden_cases_record_c_states_not_gold_binders(self) -> None:
        _, states = self.runner["load_protocol"]()
        forbidden = {
            "star_time",
            "next_mode",
            "old_mode",
            "orbit_t0",
            "orbit_inject_delay",
            "switch_delay",
        }
        for state in states:
            self.assertEqual(set(state), {"id", "args", "objects"})
            self.assertEqual(len(state["objects"]), 1)
            obj = state["objects"][0]
            self.assertEqual(obj["root"], "p")
            self.assertEqual(obj["type"], "ModeConvert_AMM")
            self.assertEqual(obj["address"], state["args"]["p"])
            self.assertTrue(forbidden.isdisjoint(obj["fields"]))
            self.assertIn("m_starTime", obj["fields"])
            self.assertIn("fun", obj["fields"])

    def test_state_binding_is_invariant_under_binder_renaming(self) -> None:
        _, states = self.runner["load_protocol"]()
        original = (EXPERIMENT / "input/spec.qcp").read_text(encoding="utf-8")
        renames = {
            "star_time": "observed_time",
            "tm3": "phase_origin",
            "next_mode": "requested_mode",
            "old_mode": "mode_before",
            "orbit_t0": "injection_origin",
            "orbit_inject_delay": "injection_wait",
            "switch_delay": "switch_wait",
        }
        renamed = original
        for old, new in renames.items():
            renamed = re.sub(rf"\b{old}\b", new, renamed)
        renamed = renamed.replace("->phase_origin", "->tm3")

        original_binds = self.runner["bind_states_for_spec"](original, states)
        renamed_binds = self.runner["bind_states_for_spec"](renamed, states)
        self.assertEqual(len(original_binds), len(renamed_binds))
        for original_case, renamed_case in zip(original_binds, renamed_binds):
            self.assertEqual(original_case["id"], renamed_case["id"])
            for old, new in renames.items():
                self.assertEqual(
                    original_case["values"][old],
                    renamed_case["values"][new],
                )
        split, _ = self.runner["load_protocol"]()
        with tempfile.TemporaryDirectory(prefix="tespec-alpha-state-test-") as temp:
            score = self.runner["score_spec"](
                self.runner["evaluate_spec"](
                    renamed,
                    Path(temp) / "evaluation",
                    states,
                ),
                split,
            )
        self.assertTrue(score["correct"])
        self.assertEqual(score["reference_counts"]["PASS"], 30)
        self.assertEqual(score["mutation_summary"]["killed"], 12)

    def test_state_binding_rejects_computed_or_unmapped_inputs(self) -> None:
        _, states = self.runner["load_protocol"]()
        invalid = (
            "With (value: Z)\n"
            "Require store(&(((ModeConvert_AMM *)p)->m_starTime), value + 1)\n"
            "Ensure emp\n"
        )
        with self.assertRaises(self.runner["StateBindingError"]):
            self.runner["bind_states_for_spec"](invalid, states)

    def test_state_binding_supports_an_additional_struct_field(self) -> None:
        _, states = self.runner["load_protocol"]()
        gold = (EXPERIMENT / "input/spec.qcp").read_text(encoding="utf-8")
        candidate = gold.replace("With ", "With (fun_value: Z) ", 1)
        candidate = candidate.replace(
            "  p != 0 &&\n",
            "  p != 0 &&\n  store(&(((ModeConvert_AMM *)p)->fun), fun_value) *\n",
            1,
        )
        candidate = candidate.replace(
            "  exists (new_mode: Z),\n",
            "  exists (new_mode: Z),\n"
            "    store(&(((ModeConvert_AMM *)p@pre)->fun), fun_value) *\n",
            1,
        )
        binds = self.runner["bind_states_for_spec"](candidate, states)
        self.assertEqual(len(binds), 30)
        self.assertTrue(all("fun_value" in item["values"] for item in binds))

    def test_state_binding_allows_additional_constant_constraints(self) -> None:
        _, states = self.runner["load_protocol"]()
        gold = (EXPERIMENT / "input/spec.qcp").read_text(encoding="utf-8")
        candidate = gold.replace(
            "  p != 0 &&\n",
            "  p != 0 &&\n  store(&(((ModeConvert_AMM *)p)->fun), 0) *\n",
            1,
        )
        binds = self.runner["bind_states_for_spec"](candidate, states)
        self.assertEqual(len(binds), 30)
        self.assertTrue(
            all(
                set(item["values"])
                == {
                    "star_time",
                    "tm3",
                    "next_mode",
                    "old_mode",
                    "orbit_t0",
                    "orbit_inject_delay",
                    "switch_delay",
                }
                for item in binds
            )
        )

    def test_examples_include_raw_and_annotated_qcp_forms(self) -> None:
        for name, implementation, specification, annotated in self.runner["DEMOS"]:
            self.assertTrue(implementation.is_file(), name)
            self.assertTrue(specification.is_file(), name)
            self.assertTrue(annotated.is_file(), name)
            text = annotated.read_text(encoding="utf-8")
            self.assertIn("/*@", text)
            self.assertIn(
                " ".join(specification.read_text(encoding="utf-8").split()),
                " ".join(text.split()),
            )

    def test_public_syntax_checkers_accept_both_gold_artifacts(self) -> None:
        spec_report = self.checker["check_spec"](
            EXPERIMENT / "input/impl.c",
            EXPERIMENT / "input/spec.qcp",
            "ModeConvert_AMMFun",
        )
        self.assertTrue(spec_report["syntax_valid"])

        with tempfile.TemporaryDirectory(prefix="tespec-code-syntax-test-") as temp:
            code = Path(temp) / "candidate.c"
            code.write_text(self.runner["gold_function"](), encoding="utf-8")
            code_report = self.checker["check_code"](
                EXPERIMENT / "input/interface.h",
                code,
                "ModeConvert_AMMFun",
            )
        self.assertTrue(code_report["syntax_valid"])
        self.assertNotIn("bind", json.dumps(spec_report).lower())

    def test_original_qcp_tool_accepts_both_gold_artifacts(self) -> None:
        with tempfile.TemporaryDirectory(prefix="tespec-original-qcp-test-") as temp:
            root = Path(temp)
            for direction, candidate in (
                ("code-to-spec", (EXPERIMENT / "input/spec.qcp").read_text()),
                ("spec-to-code", self.runner["gold_function"]()),
            ):
                output = root / direction
                output.mkdir()
                report = self.runner["check_with_original_qcp"](
                    direction,
                    candidate,
                    output,
                )
                self.assertTrue(report["accepted"], direction)
                self.assertEqual(report["returncode"], 0)

    def test_public_spec_checker_rejects_malformed_qcp(self) -> None:
        with tempfile.TemporaryDirectory(prefix="tespec-spec-syntax-test-") as temp:
            candidate = Path(temp) / "candidate.qcp"
            candidate.write_text(
                "With (x: Z)\nRequire (\nEnsure true\n",
                encoding="utf-8",
            )
            report = self.checker["check_spec"](
                EXPERIMENT / "input/impl.c",
                candidate,
                "ModeConvert_AMMFun",
            )
        self.assertFalse(report["syntax_valid"])

    def test_public_spec_checker_rejects_unmapped_state_binder(self) -> None:
        gold = (EXPERIMENT / "input/spec.qcp").read_text(encoding="utf-8")
        candidate_spec = gold.replace("With ", "With (ghost: Z) ", 1)
        with tempfile.TemporaryDirectory(prefix="tespec-state-interface-test-") as temp:
            candidate = Path(temp) / "candidate.qcp"
            candidate.write_text(candidate_spec, encoding="utf-8")
            report = self.checker["check_spec"](
                EXPERIMENT / "input/impl.c",
                candidate,
                "ModeConvert_AMMFun",
            )
        self.assertFalse(report["syntax_valid"])
        self.assertEqual(report["stage"], "state-interface")
        self.assertIn("ghost", report["diagnostic"])

    def test_public_spec_checker_does_not_return_a_semantic_verdict(self) -> None:
        with tempfile.TemporaryDirectory(prefix="tespec-spec-syntax-only-") as temp:
            candidate = Path(temp) / "candidate.qcp"
            candidate.write_text(
                "With (v: Z)\n"
                "Require x == v && v < 2147483647\n"
                "Ensure __return == v + 999\n",
                encoding="utf-8",
            )
            report = self.checker["check_spec"](
                EXPERIMENT / "demo/add_one.c",
                candidate,
                "add_one",
            )
        self.assertTrue(report["syntax_valid"])
        self.assertEqual(
            set(report),
            {"schema", "syntax_valid", "stage", "diagnostic"},
        )

    def test_gold_artifacts_pass_both_hidden_directions(self) -> None:
        split, states = self.runner["load_protocol"]()
        with tempfile.TemporaryDirectory(prefix="tespec-bidirectional-oracle-") as temp:
            report = self.runner["oracle_audit"](Path(temp), split, states)
        self.assertTrue(report["code_to_spec"]["correct"])
        self.assertTrue(report["spec_to_code"]["correct"])
        self.assertEqual(
            [item["score"] for item in report["code_to_spec"]["groups"]],
            [1.0] * 6,
        )
        self.assertEqual(
            [item["score"] for item in report["spec_to_code"]["groups"]],
            [1.0] * 6,
        )


if __name__ == "__main__":
    unittest.main()
