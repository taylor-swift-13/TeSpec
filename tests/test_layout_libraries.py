import json
from pathlib import Path
import tempfile
import unittest

from spectest.core import JobError
from spectest.layout_libraries import elaborate_library, prepare_layout_libraries


class LayoutLibraryTests(unittest.TestCase):
    def test_noncode_scopes_are_ignored_and_source_is_preserved(self):
        source = """(* Local Open Scope sac. (* nested *) *)
Definition s := "Local Open Scope sac.".
Local Open (* notation *) Scope sac.
Definition original := 42.
Lemma retained : original = 42. Proof. reflexivity. Qed.
"""
        result = elaborate_library(source)
        inserted = "\nRequire Import GeneratedLayout.\nImport GeneratedLayout.AddressNotations."
        self.assertEqual(result.replace(inserted, "", 1), source)
        self.assertIn("Scope sac." + inserted, result)

    def test_ambiguous_or_preinterpreted_sources_are_rejected(self):
        for source in [
            "(* Local Open Scope sac. *)",
            "Local Open Scope sac. Local Open Scope sac.",
            "Require Import GeneratedLayout. Local Open Scope sac.",
            "Local Open Scope sac. (* unterminated",
        ]:
            with self.subTest(source=source), self.assertRaises(JobError):
                elaborate_library(source)

    def test_staging_validates_before_writing_and_never_overwrites(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            layout = root / "layout.json"
            layout.write_text(
                json.dumps(
                    {
                        "schema": "sac-target-layout/v1",
                        "architecture_bits": 32,
                        "pointer_size": 4,
                        "aggregates": [],
                        "aliases": [],
                    }
                )
            )
            source = root / "Example.v"
            source.write_text("Local Open Scope sac.\nDefinition x := 1.\n")
            output = root / "output"
            with self.assertRaises(JobError):
                prepare_layout_libraries(layout, [source, source], output)
            self.assertFalse(output.exists())
            manifest = prepare_layout_libraries(layout, [source], output)
            self.assertEqual(manifest["status"], "PREPARED_UNCHECKED")
            self.assertEqual(
                (output / "original/Example.v").read_bytes(), source.read_bytes()
            )
            with self.assertRaises(JobError):
                prepare_layout_libraries(layout, [source], output)


if __name__ == "__main__":
    unittest.main()
