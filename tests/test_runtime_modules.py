from pathlib import Path
import subprocess
import tempfile
import unittest
from unittest.mock import patch

from spectest.certificates import tree_digest
from spectest.core import JobError
from spectest.runtime_modules import prepare_runtime_modules


class PrivateRuntimePreparationTests(unittest.TestCase):
    def test_precompiled_root_still_prepares_missing_dependency(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            source, folder = self.fixture(root)
            (folder / "Outer.vo").write_bytes(b"precompiled unit fixture")
            calls = []

            def compile_fixture(command, **kwargs):
                path = Path(command[-1])
                calls.append(path.name)
                path.with_suffix(".vo").write_bytes(b"unit fixture")
                return subprocess.CompletedProcess(command, 0, "", ""), 1, 0.0

            with patch(
                "spectest.runtime_modules._run_measured", side_effect=compile_fixture
            ):
                report = prepare_runtime_modules(
                    source, ["SimpleC.EE.Domain.Outer"], root / "prepared"
                )
            self.assertEqual(report["status"], "COMPILED")
            self.assertEqual(calls, ["Base.v", "Outer.v"])

    def test_requested_precompiled_module_is_checked_against_current_dependencies(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            source, folder = self.fixture(root)
            for name in ("Base", "Outer"):
                (folder / (name + ".vo")).write_bytes(b"old imported assumptions")
            before = tree_digest(source / "SeparationLogic")
            calls = []

            def compile_fixture(command, **kwargs):
                path = Path(command[-1])
                calls.append(path.name)
                path.with_suffix(".vo").write_bytes(b"checked current assumptions")
                return subprocess.CompletedProcess(command, 0, "", ""), 1, 0.0

            with patch(
                "spectest.runtime_modules._run_measured", side_effect=compile_fixture
            ):
                report = prepare_runtime_modules(
                    source, ["SimpleC.EE.Domain.Outer"], root / "prepared"
                )
            self.assertEqual(calls, ["Outer.v"])
            self.assertEqual(report["status"], "COMPILED")
            self.assertEqual(tree_digest(source / "SeparationLogic"), before)

    def test_rebuilt_dependency_invalidates_precompiled_transitive_dependents(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            source, folder = self.fixture(root)
            (folder / "Middle.v").write_text(
                "Require Import SimpleC.EE.Domain.Base. Definition middle := base."
            )
            (folder / "Outer.v").write_text(
                "Require Import SimpleC.EE.Domain.Middle. Definition outer := middle."
            )
            for name in ("Middle", "Outer"):
                (folder / (name + ".vo")).write_bytes(b"stale dependency fixture")
            calls = []

            def compile_fixture(command, **kwargs):
                path = Path(command[-1])
                calls.append(path.name)
                path.with_suffix(".vo").write_bytes(b"rebuilt dependency fixture")
                return subprocess.CompletedProcess(command, 0, "", ""), 1, 0.0

            with patch(
                "spectest.runtime_modules._run_measured", side_effect=compile_fixture
            ):
                report = prepare_runtime_modules(
                    source, ["SimpleC.EE.Domain.Outer"], root / "prepared"
                )
            self.assertEqual(calls, ["Base.v", "Middle.v", "Outer.v"])
            self.assertEqual(report["status"], "COMPILED")

    def fixture(self, root):
        source = root / "source"
        folder = source / "SeparationLogic/examples/Domain"
        folder.mkdir(parents=True)
        (source / "SeparationLogic/_CoqProject").write_text("-R examples SimpleC.EE\n")
        (folder / "Base.v").write_text("Definition base := True.")
        (folder / "Outer.v").write_text(
            "Require Import SimpleC.EE.Domain.Base.\nDefinition outer := base."
        )
        return source, folder

    def test_private_compilation_preserves_names_orders_dependencies_and_original_bytes(
        self,
    ):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            source, folder = self.fixture(root)
            before = tree_digest(source / "SeparationLogic")
            calls = []

            def compile_fixture(command, **kwargs):
                path = Path(command[-1])
                calls.append(path.name)
                path.with_suffix(".vo").write_bytes(
                    b"unit compile fixture, not proof evidence"
                )
                return subprocess.CompletedProcess(command, 0, "", ""), 1, 0.0

            with patch(
                "spectest.runtime_modules._run_measured", side_effect=compile_fixture
            ):
                report = prepare_runtime_modules(
                    source, ["SimpleC.EE.Domain.Outer"], root / "prepared"
                )
            self.assertEqual(calls, ["Base.v", "Outer.v"])
            self.assertEqual(report["status"], "COMPILED")
            self.assertEqual(report["scope"], "compilation-only")
            self.assertEqual(tree_digest(source / "SeparationLogic"), before)
            self.assertFalse((folder / "Base.vo").exists())
            for stage in report["stages"]:
                self.assertTrue(stage["module"].startswith("SimpleC.EE.Domain."))

    def test_cyclic_imports_fail_without_invoking_compiler(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            source, folder = self.fixture(root)
            (folder / "Base.v").write_text("Require Import SimpleC.EE.Domain.Outer.")
            with patch("spectest.runtime_modules._run_measured") as compile_fixture:
                report = prepare_runtime_modules(
                    source, ["SimpleC.EE.Domain.Outer"], root / "prepared"
                )
            compile_fixture.assert_not_called()
            self.assertEqual(report["status"], "ERROR")
            self.assertIn("cyclic", report["error"])

    def test_output_inside_runtime_rejected_before_copy(self):
        with tempfile.TemporaryDirectory() as directory:
            source, _ = self.fixture(Path(directory))
            with self.assertRaisesRegex(JobError, "outside the original runtime"):
                prepare_runtime_modules(
                    source,
                    ["SimpleC.EE.Domain.Outer"],
                    source / "SeparationLogic/prepared",
                )


if __name__ == "__main__":
    unittest.main()
