"""Execution strategy selects state transitions independently of VC generation."""

from __future__ import annotations

from copy import deepcopy
import io
import json
import os
from pathlib import Path
import tempfile
from types import SimpleNamespace
import unittest
from unittest.mock import patch

from spectest.cli import _run_parser, _run_source
from spectest.core import JobError, _parse_qcp_config, _qcp_command, run_job
from spectest.modes import EXECUTION_SEMANTICS
from spectest.verdict import _executor_result

ROOT = Path(__file__).resolve().parents[1]
VC = {"status": "generated", "residual_goals": [], "manifest": "manifest.json"}


def native_result(strategy="inline", mode="entry-exit"):
    return {
        "spec_test": {
            "schema": "sac-spec-test/v1",
            "mode": mode,
            "execution_strategy": strategy,
            "execution_semantics": EXECUTION_SEMANTICS[strategy],
            "declaration_call_policy": "contract-sample/v1",
            "result_scope": "contract-and-invariant-model",
            "sampling_events": [{
                "kind": "contract-sample", "function": "external",
                "instance": {"return": 6}, "constraints": "5 <= return <= 7",
            }],
            "abstraction_events": [{"kind": "contract-sample", "function": "external"}],
            "scope": "execution",
            "completed": True,
            "overall": "PASS",
            "certificate": "NOT_CHECKED",
            "vc_semantics": "path-vc/v1",
            "result_semantics": "three-valued-conjunction/v1",
            "precondition_result": "SAT",
            "test_result": "PASS",
            "annotation_policy": "ignore" if mode == "entry-exit" else "qcp",
            "phases": {
                "precondition": "SAT", "safety": "PASS", "postcondition": "PASS",
                "annotations": "NOT_RUN" if mode == "entry-exit" else "PASS",
            },
            "vc_results": [],
        },
    }


class ExecutionStrategyTests(unittest.TestCase):
    def test_all_four_cli_config_and_command_combinations(self):
        for strategy in ("inline", "modular"):
            for mode, flag in (
                ("entry-exit", "--concrete-bindings"),
                ("all-boundaries", "--spec-test-no-expand"),
            ):
                with self.subTest(strategy=strategy, mode=mode):
                    args = _run_parser().parse_args([
                        "input.c", "--function", "sample", "--binds", "binds.json",
                        "--execution-mode", mode, "--execution-strategy", strategy,
                    ])
                    self.assertEqual((args.execution_mode, args.execution_strategy),
                                     (mode, strategy))
                    config = _parse_qcp_config({"qcp": {
                        "execution_mode": mode, "execution_strategy": strategy,
                    }}, ROOT, ROOT)
                    command = _qcp_command(config, ROOT / "input.c", "sample", None, ROOT / "vc")
                    self.assertIn(flag, command)
                    self.assertEqual(config.execution_strategy, strategy)
                    if strategy == "inline":
                        self.assertNotIn("--execution-strategy", command)
                    else:
                        self.assertEqual(command[command.index("--execution-strategy") + 1],
                                         "modular")

    def test_default_inline_preserves_legacy_command_and_invalid_values_fail(self):
        default = _parse_qcp_config({}, ROOT, ROOT)
        explicit = _parse_qcp_config({"qcp": {"execution_strategy": "inline"}}, ROOT, ROOT)
        self.assertEqual(default.execution_strategy, "inline")
        self.assertEqual(
            _qcp_command(default, ROOT / "i.c", "sample", None, ROOT / "vc"),
            _qcp_command(explicit, ROOT / "i.c", "sample", None, ROOT / "vc"),
        )
        for value in (None, [], "all-boundaries", "unknown", False):
            with self.subTest(value=value), self.assertRaises(JobError):
                _parse_qcp_config({"qcp": {"execution_strategy": value}}, ROOT, ROOT)

    def test_cli_persists_both_independent_parameters(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            source, binds = root / "input.c", root / "binds.json"
            source.write_text("int sample(void) { return 0; }")
            binds.write_text('[{"id":"one","values":{}}]')
            for strategy in ("inline", "modular"):
                for mode in ("entry-exit", "all-boundaries"):
                    output = root / (strategy + "-" + mode)
                    def check_job(path, override):
                        job = json.loads(path.read_text())
                        self.assertEqual(job["qcp"]["execution_strategy"], strategy)
                        self.assertEqual(job["qcp"]["execution_mode"], mode)
                        self.assertEqual(override, output)
                        return {"summary": {"PASS": 1, "total": 1}}
                    with self.subTest(strategy=strategy, mode=mode),                          patch("spectest.cli.run_job", side_effect=check_job),                          patch("sys.stdout", new_callable=io.StringIO):
                        code = _run_source([
                            str(source), "--function", "sample", "--binds", str(binds),
                            "--output-dir", str(output), "--execution-mode", mode,
                            "--execution-strategy", strategy,
                        ])
                        self.assertEqual(code, 0)

    def test_sampled_native_metadata_is_preserved_in_both_strategies(self):
        for strategy in ("inline", "modular"):
            for mode in ("entry-exit", "all-boundaries"):
                payload = native_result(strategy, mode)
                result = _executor_result(json.dumps(payload), 0, VC,
                                          expected_strategy=strategy)
                with self.subTest(strategy=strategy, mode=mode):
                    self.assertEqual(result["status"], "PASS")
                    self.assertEqual(result["execution_strategy"], strategy)
                    self.assertEqual(result["execution_semantics"], EXECUTION_SEMANTICS[strategy])
                    self.assertEqual(result["declaration_call_policy"], "contract-sample/v1")
                    self.assertEqual(result["result_scope"], "contract-and-invariant-model")
                    self.assertEqual(result["sampling_events"],
                                     payload["spec_test"]["sampling_events"])
                    self.assertEqual(result["abstraction_events"],
                                     payload["spec_test"]["abstraction_events"])

    def test_strategy_mismatch_cannot_be_accepted_as_success(self):
        payloads = [
            (native_result("inline"), "modular"),
            (native_result("modular"), "inline"),
        ]
        invalid = native_result("modular")
        invalid["spec_test"]["execution_semantics"] = "inline-preserve/v1"
        payloads.append((invalid, "modular"))
        for payload, expected in payloads:
            result = _executor_result(json.dumps(payload), 0, VC, expected_strategy=expected)
            self.assertEqual(result["status"], "ERROR")
            self.assertEqual(result["reason"], "executor_execution_strategy_mismatch")

    def test_symbolic_request_requires_matching_executor_semantics(self):
        payload = native_result("modular")
        self.assertEqual(_executor_result(json.dumps(payload), 0, VC,
            expected_strategy="modular", expected_modular_instantiation="off")["status"], "ERROR")
        payload["spec_test"].update(modular_instantiation="off",
            execution_semantics="modular-symbolic/v1", declaration_call_policy="contract-symbolic/v1",
            sampling_events=[], result_scope="contract-and-invariant-symbolic")
        result = _executor_result(json.dumps(payload), 0, VC,
            expected_strategy="modular", expected_modular_instantiation="off")
        self.assertEqual(result["status"], "PASS")
        self.assertEqual(result["modular_instantiation"], "off")

    def test_legacy_inline_response_is_usable_but_not_for_modular(self):
        payload = native_result("inline")
        for field in ("execution_strategy", "declaration_call_policy", "sampling_events", "result_scope"):
            payload["spec_test"].pop(field)
        self.assertEqual(
            _executor_result(json.dumps(payload), 0, VC, expected_strategy="inline")["status"],
            "PASS",
        )
        self.assertEqual(
            _executor_result(json.dumps(payload), 0, VC, expected_strategy="modular")["status"],
            "ERROR",
        )

    def test_sampled_invalid_vc_keeps_failure_and_its_origin(self):
        payload = native_result("modular")
        payload["spec_test"].update({
            "overall": "FAIL", "test_result": "FAIL",
            "vc_results": [{"kind": "assertion", "status": "INVALID"}],
        })
        result = _executor_result(json.dumps(payload), 0, VC, expected_strategy="modular")
        self.assertEqual(result["status"], "FAIL")
        self.assertEqual(result["sampling_events"], payload["spec_test"]["sampling_events"])
        self.assertEqual(result["execution_semantics"], EXECUTION_SEMANTICS["modular"])

    def test_report_does_not_describe_modular_or_external_calls_as_inline(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            source = root / "input.c"
            source.write_text("int sample(void) /*@ Require emp Ensure __return==0 && emp */ { return 0; }")
            for strategy in ("inline", "modular"):
                for mode in ("entry-exit", "all-boundaries"):
                    payload = native_result(strategy, mode)
                    job = root / "job.json"
                    job.write_text(json.dumps({
                        "source": str(source), "function": "sample",
                        "binds": [{"id": "one", "values": {}}],
                        "qcp": {"execution_strategy": strategy, "execution_mode": mode},
                    }))
                    completed = SimpleNamespace(stdout=json.dumps(payload), stderr="", returncode=0)
                    with patch("spectest.core._run_measured", return_value=(completed, 123, 0.01)),                          patch("spectest.core._write_vc_manifest", return_value=deepcopy(VC)):
                        report = run_job(job, root / (strategy + "-" + mode))
                    with self.subTest(strategy=strategy, mode=mode):
                        self.assertEqual(report["summary"]["PASS"], 1)
                        policy = report["vc_policy"]
                        self.assertEqual(policy["mode"], mode)
                        self.assertEqual(policy["execution_strategy"], strategy)
                        self.assertEqual(policy["execution_semantics"], EXECUTION_SEMANTICS[strategy])
                        self.assertEqual(policy["declaration_calls"], "sample_contract_postconditions")
                        self.assertEqual(policy["defined_function_calls"],
                                         "execute_bodies" if strategy == "inline" else "sample_or_retain_symbolic_contract_postconditions")
                        self.assertEqual(report["results"][0]["sampling_events"],
                                         payload["spec_test"]["sampling_events"])


CANDIDATE = os.environ.get("SAC_SYMEXEC")


@unittest.skipUnless(CANDIDATE, "set SAC_SYMEXEC to exercise strategy-aware native execution")
class NativeExecutionStrategyTests(unittest.TestCase):
    """Semantic checks use a selected candidate, never the legacy bundled binary."""

    def run_source(self, source, strategy, mode, **options):
        arguments = options.pop("arguments", {})
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            path = root / "input.c"
            path.write_text(source)
            job = root / "job.json"
            job.write_text(json.dumps({
                "source": str(path), "function": "sample",
                "binds": [{"id": "one", "values": {}, "args": arguments}],
                "qcp": {
                    "binary": str(Path(CANDIDATE).resolve()),
                    "execution_strategy": strategy,
                    "execution_mode": mode, "instance_trace": True,
                    **options,
                },
            }))
            report = run_job(job, root / "out")
            case = report["results"][0]
            self.assertIn("stdout", case, case)
            raw = json.loads(Path(case["stdout"]).read_text())
            self.assertEqual(case["execution_strategy"], strategy, case)
            self.assertEqual(case["mode"], mode, case)
            return case, raw

    def assert_sampled(self, case, kind):
        self.assertEqual(case["result_scope"], "contract-and-invariant-hybrid" if case["execution_strategy"] == "modular" else "contract-and-invariant-model", case)
        self.assertTrue(any(event.get("kind") == kind
                            for event in case["abstraction_events"]), case)
        self.assertTrue(case["sampling_events"], case)
        self.assertTrue(any(
            event.get("status") == "SAMPLED"
            and isinstance(event.get("constraint_state"), str)
            and isinstance(event.get("selected_state"), str)
            for event in case["sampling_events"]
        ), case)

    def test_symbolic_modular_keeps_range_and_all_original_obligations(self):
        source = (
            "int external(void) /*@ Require emp Ensure "
            "0 <= __return && __return <= 1 && emp */;\n"
            "int sample(void) /*@ Require emp Ensure __return == 0 && emp */ "
            "{ return external(); }"
        )
        for mode in ("entry-exit", "all-boundaries"):
            with self.subTest(mode=mode):
                case, raw = self.run_source(source, "modular", mode,
                                            modular_instantiation="off")
                self.assertTrue(case["execution_completed"], case)
                self.assertEqual(case["execution_semantics"], "modular-symbolic/v1")
                self.assertEqual(case["declaration_call_policy"], "contract-symbolic/v1")
                self.assertEqual(case["sampling_events"], [])
                # A range permitting 1 cannot silently become the passing sample 0.
                self.assertNotEqual(case["status"], "PASS", case)
                self.assertTrue(case["vc_results"], case)
                self.assertTrue(any(e["kind"] == "contract_state_symbolic"
                                    for e in case["abstraction_events"]), raw)

    def test_opaque_contract_sampling_cannot_block_execution_or_erase_vcs(self):
        prefix = (
            "/*@ Extern Coq (opaque : Z -> Assertion) */\n"
            "void external(void) /*@ Require emp Ensure opaque(7) */;\n"
        )
        for mode in ("entry-exit", "all-boundaries"):
            for sampling in ("on", "off"):
                with self.subTest(mode=mode, sampling=sampling):
                    source = prefix + (
                        "int sample(void) /*@ Require emp Ensure __return == 0 && opaque(7) */ "
                        "{ external(); return 0; }"
                    )
                    case, raw = self.run_source(source, "modular", mode,
                                                modular_instantiation=sampling)
                    self.assertEqual(case["status"], "PASS", case)
                    self.assertTrue(case["execution_completed"], case)
                    self.assertTrue(case["vc_results"], case)
                    if sampling == "on":
                        fallback = [e for e in case["sampling_events"] if e["status"] == "SYMBOLIC_FALLBACK"]
                        self.assertTrue(fallback, raw)
                        self.assertTrue(all(e["constraint_state"] == e["selected_state"] for e in fallback))
                    else:
                        self.assertEqual(case["sampling_events"], [])
        # The same unsupported predicate in an unproved assertion remains an
        # original obligation; falling back must not manufacture a PASS.
        source = "/*@ Extern Coq (opaque : Z -> Assertion) */\n" + (
            "int sample(void) /*@ Require emp Ensure __return == 0 && opaque(7) */ "
            "{ /*@ Assert opaque(7) */ return 0; }"
        )
        case, _ = self.run_source(source, "modular", "all-boundaries")
        self.assertNotEqual(case["status"], "PASS", case)
        self.assertTrue(any(v["kind"] == "entailment" and v["status"] != "VALID"
                            for v in case["vc_results"]), case)

    def test_inconsistent_modular_contract_is_not_a_successful_fallback(self):
        source = (
            "int external(void) /*@ Require emp Ensure __return < 0 && __return >= 0 && emp */;\n"
            "int sample(void) /*@ Require emp Ensure __return == 0 && emp */ { external(); return 0; }"
        )
        for sampling in ("on", "off"):
            with self.subTest(sampling=sampling):
                case, raw = self.run_source(source, "modular", "all-boundaries",
                                            modular_instantiation=sampling)
                self.assertEqual(case["status"], "UNKNOWN", case)
                self.assertNotEqual(case["reason"], "qcp_full_auto_passed", raw)

    def test_defined_weak_contract_uses_body_only_in_inline(self):
        source = (
            "int helper(void) /*@ Require emp Ensure "
            "0 <= __return && __return <= 1 && emp */ { return 1; }\n"
            "int sample(void) /*@ Require emp Ensure "
            "0 <= __return && __return <= 1 && emp */ { return helper(); }"
        )
        for mode in ("entry-exit", "all-boundaries"):
            for strategy in ("inline", "modular"):
                with self.subTest(mode=mode, strategy=strategy):
                    case, _ = self.run_source(source, strategy, mode)
                    self.assertEqual(case["status"], "PASS", case)
                    if strategy == "modular":
                        self.assert_sampled(case, "contract-sample")
                    else:
                        self.assertEqual(case["result_scope"], "concrete-execution", case)
                        self.assertFalse(any(event.get("kind") == "contract-sample"
                                             for event in case["abstraction_events"]), case)

    def test_bodyless_range_contract_is_sampled_in_all_four_combinations(self):
        source = (
            "int external(int x) /*@ Require x == 5 && emp Ensure "
            "x <= __return && __return <= x + 2 && emp */;\n"
            "int sample(void) /*@ Require emp Ensure "
            "5 <= __return && __return <= 7 && emp */ "
            "{ int r = external(5); return r; }"
        )
        for mode in ("entry-exit", "all-boundaries"):
            for strategy in ("inline", "modular"):
                with self.subTest(mode=mode, strategy=strategy):
                    case, _ = self.run_source(source, strategy, mode)
                    self.assertEqual(case["status"], "PASS", case)
                    self.assertEqual(case["declaration_call_policy"], "contract-sample-or-symbolic/v2" if strategy == "modular" else "contract-sample/v1")
                    self.assert_sampled(case, "contract-sample")

    def test_assertion_vc_policy_stays_independent_of_state_strategy(self):
        source = (
            "int sample(void) /*@ Require emp Ensure __return == 0 && emp */ "
            "{ int x = 5; /*@ Assert x == 9 && emp */ return 0; }"
        )
        for strategy in ("inline", "modular"):
            for mode in ("entry-exit", "all-boundaries"):
                with self.subTest(mode=mode, strategy=strategy):
                    case, _ = self.run_source(source, strategy, mode)
                    self.assertEqual(case["status"],
                                     "PASS" if mode == "entry-exit" else "FAIL", case)
                    if mode == "all-boundaries":
                        self.assertTrue(any(vc["status"] == "INVALID"
                                            for vc in case["vc_results"]), case)

    def test_modular_loop_summary_does_not_consume_inline_iteration_budget(self):
        source = (
            "int sample(void) /*@ Require emp Ensure __return == 3 && emp */ "
            "{ int n = 3; int i = 0; /*@ Inv 0 <= i && i <= n && n == 3 && emp */ "
            "while (i < n) { i++; } return i; }"
        )
        for mode in ("entry-exit", "all-boundaries"):
            with self.subTest(mode=mode):
                inline, _ = self.run_source(source, "inline", mode, loop_unroll_limit=1)
                self.assertEqual(inline["status"], "UNKNOWN", inline)
                self.assertFalse(inline["execution_completed"], inline)
                modular, _ = self.run_source(source, "modular", mode, loop_unroll_limit=1)
                self.assertEqual(modular["status"], "PASS", modular)
                self.assertTrue(modular["execution_completed"], modular)
                self.assert_sampled(modular, "modular-loop-invariant")
                kinds = {event["kind"] for event in modular["sampling_events"]}
                self.assertIn("loop-preservation-input", kinds)
                self.assertIn("loop-exit-input", kinds)

    def test_modular_assertion_poststate_controls_continuation_only(self):
        source = (
            "int sample(void) /*@ Require emp Ensure __return == 9 && emp */ "
            "{ int x = 5; /*@ Assert x == 9 && emp */ return x; }"
        )
        inline, _ = self.run_source(source, "inline", "entry-exit")
        modular, _ = self.run_source(source, "modular", "entry-exit")
        self.assertEqual(inline["status"], "FAIL", inline)
        self.assertEqual(modular["status"], "PASS", modular)
        self.assertTrue(any(event.get("kind") == "assertion-poststate"
                            and event.get("status") == "SAMPLED"
                            for event in modular["sampling_events"]), modular)

    def test_modular_loop_keeps_entry_binding_and_unmodified_frame(self):
        source = (
            "int sample(int n) /*@ Require n == 3 && emp "
            "Ensure __return == 45 && emp */ "
            "{ int y = 42; int i = 0; /*@ Inv 0 <= i && i <= n && emp */ "
            "while (i < n) { i++; } return y + i; }"
        )
        for mode in ("entry-exit", "all-boundaries"):
            with self.subTest(mode=mode):
                case, _ = self.run_source(source, "modular", mode, loop_unroll_limit=1,
                                          arguments={"n": 3})
                self.assertEqual(case["status"], "PASS", case)
                self.assert_sampled(case, "modular-loop-invariant")

    def test_pure_modular_assertion_preserves_unmentioned_heap(self):
        source = (
            "int sample(int *p) /*@ Require data_at(p,int,7) "
            "Ensure __return == 7 && data_at(p@pre,int,7) */ "
            "{ int x = 0; /*@ Assert x >= 0 */ return *p; }"
        )
        for mode in ("entry-exit", "all-boundaries"):
            with self.subTest(mode=mode):
                case, _ = self.run_source(source, "modular", mode)
                self.assertEqual(case["status"], "PASS", case)
                self.assert_sampled(case, "modular-assertion")

    def test_modular_loop_initialization_failure_survives_sampling(self):
        source = (
            "int sample(void) /*@ Require emp Ensure __return == 3 && emp */ "
            "{ int i = 0; /*@ Inv 1 <= i && i <= 3 && emp */ "
            "while (i < 3) { i++; } return i; }"
        )
        case, _ = self.run_source(source, "modular", "all-boundaries")
        self.assertEqual(case["status"], "FAIL", case)
        self.assertTrue(any(vc["status"] == "INVALID" for vc in case["vc_results"]), case)

    def test_modular_loop_preservation_failure_survives_sampled_exit(self):
        source = (
            "int sample(void) /*@ Require emp Ensure __return == 3 && emp */ "
            "{ int i = 0; /*@ Inv 0 <= i && i <= 3 && emp */ "
            "while (i < 3) { i = 4; } return i; }"
        )
        case, _ = self.run_source(source, "modular", "all-boundaries")
        self.assertEqual(case["status"], "FAIL", case)
        self.assertTrue(any(vc["status"] == "INVALID" for vc in case["vc_results"]), case)

    def test_loop_modified_parameter_is_not_frozen_to_entry_value(self):
        for body in ("n--;", "*p = 0;"):
            source = (
                "int sample(int n) /*@ Require n == 3 && emp "
                "Ensure __return == 0 && emp */ "
                "{ int *p = &n; /*@ Inv 0 <= n && n <= 3 && emp */ "
                "while (n > 0) { " + body + " } return n; }"
            )
            for mode in ("entry-exit", "all-boundaries"):
                with self.subTest(body=body, mode=mode):
                    case, _ = self.run_source(source, "modular", mode,
                                              arguments={"n": 3}, loop_unroll_limit=1)
                    self.assertEqual(case["status"], "PASS", case)
                    self.assert_sampled(case, "modular-loop-invariant")
