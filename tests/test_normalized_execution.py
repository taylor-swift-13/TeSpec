import json
from pathlib import Path
import tempfile
import unittest
import subprocess
from unittest.mock import patch

from spectest.core import JobError
from spectest.normalized_execution import (
    run_normalized_case,
    validate_execution_context,
)
from spectest.preflight import snapshot_frontend_inputs


class NormalizedExecutionGateTests(unittest.TestCase):
    def test_executor_error_without_goal_retains_diagnostic_and_automatic_report(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            output = root / "run"
            source = root / "input.c"
            source.write_text("int sample(void);")
            header = root / "header.v"
            header.write_text("(* fixture context *)\n")
            association = root / "association.json"
            association.write_text(
                json.dumps(
                    {
                        "association": {
                            "binding_scope": "all-referenced-symbols",
                            "semantic_binding_scope": "formula-notation-interpretations",
                            "definition_binding_scope": "qualified-selected-predicate",
                        }
                    }
                )
            )
            rules = root / "rules.strategies"
            rules.write_text("")
            layout = {
                "schema": "sac-target-layout/v1",
                "architecture_bits": 32,
                "pointer_size": 4,
                "aggregates": [],
                "aliases": [],
            }
            program = {
                "frontend_snapshot": {"roots": []},
                "input": {"path": str(source)},
                "binary": {"path": str(root / "binary")},
                "coq_header": {"path": str(header)},
                "target_layout": layout,
                "original_source": str(source),
                "provenance": {"binary_sha256": "fixture-binary-hash"},
                "qcip_root": str(root),
                "function": "sample",
                "case": "case",
                "bindings": {},
                "arguments": {},
                "type_bindings": {},
                "coq_dependencies": [],
                "command": [
                    str(root / "binary"),
                    "--input-file=" + str(source),
                    "--spec-test-preflight",
                ],
            }

            def preflight(*args, **kwargs):
                path = output / "preflight"
                path.mkdir()
                (path / "manifest.json").write_text(json.dumps(program))
                return program

            error = {"Main Error Message": "cannot read owned memory"}
            payload = {
                "spec_test": {
                    "schema": "sac-spec-test/v1",
                    "mode": "expand",
                    "scope": "execution",
                    "overall": "ERROR",
                    "completed": False,
                    "certificate": "NOT_CHECKED",
                    "architecture_bits": 32,
                    "target_layout": layout,
                    "phases": {
                        "precondition": "SAT",
                        "safety": "UNKNOWN",
                        "postcondition": "UNKNOWN",
                        "annotations": "NOT_RUN",
                    },
                },
                "errormessage": error,
            }
            vc = {
                "status": "not_generated",
                "residual_goals": [],
                "coq_dependencies": [],
            }
            with (
                patch(
                    "spectest.normalized_execution.seal_predicate_normalization",
                    return_value={
                        "status": "PASS",
                        "rules": str(rules),
                        "executor_args": [],
                        "manifest_sha256": "fixture",
                    },
                ),
                patch(
                    "spectest.normalized_execution.export_program_preflight",
                    side_effect=preflight,
                ),
                patch(
                    "spectest.normalized_execution.prepare_normalization_association",
                    return_value={
                        "manifest": str(association),
                        "manifest_sha256": "fixture",
                    },
                ),
                patch(
                    "spectest.normalized_execution.check_certificate",
                    return_value={"status": "PASS"},
                ),
                patch("spectest.normalized_execution.validate_execution_context"),
                patch(
                    "spectest.normalized_execution._run_measured",
                    return_value=(
                        subprocess.CompletedProcess(
                            [], 1, json.dumps(payload), "failure"
                        ),
                        123,
                        0.01,
                    ),
                ),
                patch(
                    "spectest.normalized_execution._write_vc_manifest", return_value=vc
                ),
            ):
                report = run_normalized_case("job", "normalization", "digest", output)
            self.assertEqual(report["status"], "ERROR")
            self.assertEqual(report["execution"], "INCOMPLETE")
            self.assertTrue(report["results"], report)
            self.assertEqual(report["results"][0]["executor_error"], error)
            automatic = json.loads(Path(report["automatic_report"]).read_text())
            self.assertEqual(automatic["results"][0]["executor_error"], error)
            self.assertEqual(automatic["summary"]["ERROR"], 1)
            self.assertEqual(automatic["provenance"], program["provenance"])
            self.assertEqual(report["provenance"], program["provenance"])

    def test_timeout_cannot_leave_started_or_pass_in_terminal_report(self):
        with tempfile.TemporaryDirectory() as directory:
            output = Path(directory) / "run"

            def timeout(*args, **kwargs):
                output.mkdir()
                (output / "report.json").write_text(
                    json.dumps(
                        {
                            "status": "UNKNOWN",
                            "execution": "STARTED",
                            "results": [],
                        }
                    )
                )
                raise subprocess.TimeoutExpired(["fixture"], 1)

            with patch(
                "spectest.normalized_execution._run_normalized_case",
                side_effect=timeout,
            ):
                report = run_normalized_case("job", "normalization", "digest", output)
            self.assertEqual(report["status"], "UNKNOWN")
            self.assertEqual(report["execution"], "INCOMPLETE")
            self.assertGreaterEqual(report["wall_seconds"], 0)

    def test_failed_equations_do_not_parse_or_execute(self):
        with tempfile.TemporaryDirectory() as directory:
            output = Path(directory) / "run"
            with (
                patch(
                    "spectest.normalized_execution.seal_predicate_normalization",
                    return_value={"status": "UNKNOWN"},
                ),
                patch(
                    "spectest.normalized_execution.export_program_preflight"
                ) as preflight,
                patch("spectest.normalized_execution._run_measured") as execution,
            ):
                report = run_normalized_case("job", "normalization", "digest", output)
            preflight.assert_not_called()
            execution.assert_not_called()
            self.assertEqual(report["status"], "UNKNOWN")
            self.assertEqual(report["execution"], "NOT_RUN")
            self.assertEqual(report["reason"], "normalization_equations_not_proved")
            self.assertEqual(json.loads((output / "report.json").read_text()), report)

    def test_failed_association_does_not_execute(self):
        with tempfile.TemporaryDirectory() as directory:
            output = Path(directory) / "run"

            def preflight(*args, **kwargs):
                path = output / "preflight"
                path.mkdir()
                (path / "manifest.json").write_text("{}")
                return {"frontend_snapshot": {"roots": []}, "provenance": {}}

            with (
                patch(
                    "spectest.normalized_execution.seal_predicate_normalization",
                    return_value={"status": "PASS"},
                ),
                patch(
                    "spectest.normalized_execution.export_program_preflight",
                    side_effect=preflight,
                ),
                patch(
                    "spectest.normalized_execution.prepare_normalization_association",
                    return_value={"manifest": "fixture", "manifest_sha256": "fixture"},
                ),
                patch(
                    "spectest.normalized_execution.check_certificate",
                    return_value={"status": "UNKNOWN"},
                ),
                patch("spectest.normalized_execution._run_measured") as execution,
            ):
                report = run_normalized_case("job", "normalization", "digest", output)
            execution.assert_not_called()
            self.assertEqual(report["reason"], "program_association_not_proved")
            self.assertEqual(report["execution"], "NOT_RUN")

    def test_original_inputs_changed_outside_search_trees_reject_execution(self):
        from spectest.certificates import digest

        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            stable = root / "stable"
            stable.write_text("unchanged")
            for name in ("job.json", "original.c", "contract.spec"):
                with self.subTest(input=name):
                    original = root / name
                    original.write_text("original")
                    record = {"path": str(stable), "sha256": digest(stable)}
                    program = {
                        "frontend_snapshot": snapshot_frontend_inputs([]),
                        **{
                            key: record
                            for key in (
                                "binary",
                                "input",
                                "coq_header",
                                "generated_layout",
                            )
                        },
                        "original_inputs": [
                            {"path": str(original), "sha256": digest(original)}
                        ],
                    }
                    original.write_text("changed")
                    with self.assertRaisesRegex(
                        JobError, "original job inputs changed"
                    ):
                        validate_execution_context(program, {})

    def test_changed_or_new_frontend_files_reject_stale_context(self):
        for change in ("modify", "add"):
            with (
                self.subTest(change=change),
                tempfile.TemporaryDirectory() as directory,
            ):
                root = Path(directory)
                header = root / "input.h"
                header.write_text("struct A { int x; };")
                program = {"frontend_snapshot": snapshot_frontend_inputs([root])}
                if change == "modify":
                    header.write_text("struct A { int x; int y; };")
                else:
                    (root / "new.strategies").write_text("provider changed")
                with self.assertRaisesRegex(JobError, "frontend inputs changed"):
                    validate_execution_context(program, {})

    def test_incomplete_identity_proof_cannot_authorize_execution(self):
        for identity, reason in (
            (
                {"binding_scope": "predicate-only"},
                "program_association_incomplete_symbol_coverage",
            ),
            (
                {"binding_scope": "all-referenced-symbols"},
                "program_association_incomplete_semantic_coverage",
            ),
            (
                {
                    "binding_scope": "all-referenced-symbols",
                    "semantic_binding_scope": "formula-notation-interpretations",
                },
                "program_association_missing_definition_identity",
            ),
        ):
            with (
                self.subTest(identity=identity),
                tempfile.TemporaryDirectory() as directory,
            ):
                root = Path(directory)
                output = root / "run"
                manifest = root / "association.json"
                manifest.write_text(json.dumps({"association": identity}))

                def preflight(*args, **kwargs):
                    path = output / "preflight"
                    path.mkdir()
                    (path / "manifest.json").write_text("{}")
                    return {"frontend_snapshot": {"roots": []}, "provenance": {}}

                with (
                    patch(
                        "spectest.normalized_execution.seal_predicate_normalization",
                        return_value={"status": "PASS"},
                    ),
                    patch(
                        "spectest.normalized_execution.export_program_preflight",
                        side_effect=preflight,
                    ),
                    patch(
                        "spectest.normalized_execution.prepare_normalization_association",
                        return_value={
                            "manifest": str(manifest),
                            "manifest_sha256": "fixture",
                        },
                    ),
                    patch(
                        "spectest.normalized_execution.check_certificate",
                        return_value={"status": "PASS"},
                    ),
                    patch("spectest.normalized_execution._run_measured") as execution,
                ):
                    report = run_normalized_case(
                        "job", "normalization", "digest", output
                    )
                execution.assert_not_called()
                self.assertEqual(report["reason"], reason)
                self.assertEqual(report["status"], "UNKNOWN")
                self.assertEqual(report["execution"], "NOT_RUN")

    def test_absolute_strategy_import_outside_search_root_is_pinned(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            source = root / "case"
            source.mkdir()
            strategy = root / "outside.strategies"
            strategy.write_text("a rule fixture")
            (source / "input.c").write_text(f'/*@ include strategies "{strategy}" */')
            before = snapshot_frontend_inputs([source])
            self.assertIn(str(strategy), [record["path"] for record in before["files"]])
            strategy.write_text("a changed rule fixture")
            self.assertNotEqual(before, snapshot_frontend_inputs([source]))


if __name__ == "__main__":
    unittest.main()
