from pathlib import Path
import tempfile
import unittest

from spectest.core import JobError, _stage_source_coq_dependencies, _runtime_coq_module


class RuntimeDependencyOwnershipTests(unittest.TestCase):
    def fixture(self, root):
        runtime = root / "qcp"
        module = runtime / "SeparationLogic/examples/Domain/Shapes.v"
        module.parent.mkdir(parents=True)
        module.write_text("Definition shape := True.\n")
        source = root / "case/input.c"
        source.parent.mkdir()
        source.write_text("/*@ Import Coq Require Import SimpleC.EE.Domain.Shapes */")
        return runtime, module, source

    def test_runtime_import_is_pinned_without_copying_into_task_namespace(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            runtime, module, source = self.fixture(root)
            compiled = module.with_suffix(".vo")
            compiled.write_bytes(b"compiled fixture; not proof evidence")
            imports = []
            tasks = _stage_source_coq_dependencies(
                source, source, runtime, root / "vc", runtime_dependencies=imports
            )
            self.assertEqual(tasks, [])
            self.assertFalse((root / "vc/dependencies").exists())
            self.assertEqual(imports[0]["module"], "SimpleC.EE.Domain.Shapes")
            self.assertEqual(imports[0]["source"], str(module))
            self.assertEqual(imports[0]["compiled"], str(compiled))
            self.assertEqual(imports[0]["origin"], "pinned-runtime")

    def test_missing_compiled_runtime_module_is_explicit(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            runtime, _, source = self.fixture(root)
            imports = []
            _stage_source_coq_dependencies(
                source, source, runtime, root / "vc", runtime_dependencies=imports
            )
            self.assertIsNone(imports[0]["compiled"])
            self.assertIsNone(imports[0]["compiled_sha256"])

    def test_changed_local_copy_cannot_impersonate_runtime_module(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            runtime, _, source = self.fixture(root)
            (source.parent / "Shapes.v").write_text("Definition shape := False.\n")
            with self.assertRaisesRegex(JobError, "shadows pinned runtime"):
                _stage_source_coq_dependencies(source, source, runtime, root / "vc")

    def test_task_library_recursively_importing_runtime_keeps_its_own_identity(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            runtime, _, source = self.fixture(root)
            source.write_text("/*@ Import Coq Require Import Task */")
            (source.parent / "Task.v").write_text(
                "Require Import SimpleC.EE.Domain.Shapes.\nDefinition task := shape."
            )
            imports = []
            tasks = _stage_source_coq_dependencies(
                source, source, runtime, root / "vc", runtime_dependencies=imports
            )
            self.assertEqual([item["module"] for item in tasks], ["Task"])
            self.assertEqual(
                [item["module"] for item in imports], ["SimpleC.EE.Domain.Shapes"]
            )

    def test_logical_load_path_resolves_multiple_runtime_roots(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            for folder, module in (
                ("auxlibs", "AUXLib.Tools"),
                ("stdlib", "SimpleC.StdLib.Tools"),
                ("examples/Domain", "SimpleC.EE.Domain.Tools"),
            ):
                source = root / "SeparationLogic" / folder / "Tools.v"
                source.parent.mkdir(parents=True, exist_ok=True)
                source.write_text("Definition tool := True.")
                self.assertEqual(_runtime_coq_module(module, root), source)


if __name__ == "__main__":
    unittest.main()
