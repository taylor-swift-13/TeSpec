"""Real native return VCs must stay bound to their original proof artifacts."""
from copy import deepcopy
import json
import os
from pathlib import Path
import tempfile
import unittest

from spectest.core import run_job
from spectest.spatial_smt import refine_case

ROOT = Path(__file__).resolve().parents[1]
BINARY = Path(os.environ.get("SAC_SYMEXEC", ROOT / "bin/tespec-symexec"))


@unittest.skipUnless(BINARY.is_file(), "requires the native executor")
class NativeReturnArtifactBindingTests(unittest.TestCase):
    def setUp(self):
        temporary = tempfile.TemporaryDirectory()
        self.addCleanup(temporary.cleanup)
        self.folder = Path(temporary.name)
        source = self.folder / "sample.c"
        source.write_text(
            '#include "verification_stdlib.h"\n#include "int_array_def.h"\n'
            'int sample(int *p) /*@ With xs Require IntArray::full(p,2,xs) '
            'Ensure data_at(p,int,7) * data_at(p+1,int,9) */ { return 0; }\n'
        )
        job = self.folder / "job.json"
        job.write_text(json.dumps({
            "source": str(source), "function": "sample",
            "binds": [{"id": "cell", "args": {"p": 4096}, "values": {"xs": [7, 9]}}],
            "qcp": {"binary": str(BINARY), "include_dirs": [
                str(ROOT / "runtime/qcip/QCP_examples/QCP_demos_human")],
                "spatial_smt": False},
        }))
        self.case = run_job(job, self.folder / "run")["results"][0]
        self.assertEqual(self.case["status"], "UNKNOWN")
        self.assertEqual([v["kind"] for v in self.case["vc_results"]
                          if v["status"] == "UNKNOWN"], ["return"])
        self.raw = self.folder / "run/artifacts/cell/executor.json"
        self.raw_bytes = self.raw.read_bytes()

    def refine(self, suffix):
        case = deepcopy(self.case)
        refine_case(case, self.raw, self.folder / suffix, timeout_ms=2000)
        self.assertEqual(self.raw.read_bytes(), self.raw_bytes)
        self.assertEqual(case["residual_vcs"], self.case["residual_vcs"])
        return case

    def test_complete_original_return_group_still_passes(self):
        files = self.case["vc"]["files"]
        before = {k: Path(p).read_bytes() for k, p in files.items()}
        case = self.refine("untouched")
        self.assertEqual(case["status"], "PASS")
        self.assertTrue(case["spatial_smt"]["return_residual_coverage"])
        self.assertFalse(case["spatial_smt"]["itp_required"])
        self.assertIn("return_artifact_binding", case["spatial_smt"])
        self.assertEqual({k: Path(p).read_bytes() for k, p in files.items()}, before)

    def test_missing_or_changed_original_files_never_clear_itp(self):
        manifest = self.case["vc"]
        paths = {**{k: Path(p) for k, p in manifest["files"].items()},
                 "manifest": Path(manifest["manifest"]),
                 "source": Path(self.case["generated_source"])}
        for name, path in paths.items():
            original = path.read_bytes()
            for action in ("missing", "changed"):
                with self.subTest(file=name, action=action):
                    try:
                        if action == "missing":
                            path.unlink()
                        elif name == "proof_manual":
                            path.write_bytes(original.replace(b"proof_of_sample_return_wit_1",
                                                              b"proof_of_unrelated_return_wit_1"))
                        elif name == "manifest":
                            saved = json.loads(original)
                            saved["case_id"] = "different-case"
                            path.write_text(json.dumps(saved))
                        else:
                            path.write_bytes(original + b"\n(* changed original bytes *)\n")
                        case = self.refine(name + "-" + action)
                        self.assertEqual(case["status"], "UNKNOWN")
                        self.assertFalse(case["spatial_smt"]["return_residual_coverage"])
                        self.assertTrue(case["spatial_smt"]["itp_required"])
                        self.assertTrue(all(v["status"] == "VALID" for v in case["vc_results"]))
                        self.assertIn("original_artifact_binding_failed:",
                                      case["spatial_smt"]["return_coverage_reason"])
                    finally:
                        path.write_bytes(original)

    def test_missing_manifest_does_not_use_unit_fixture_bypass(self):
        self.case.pop("vc")
        case = self.refine("no-manifest")
        self.assertEqual(case["status"], "UNKNOWN")
        self.assertTrue(case["spatial_smt"]["itp_required"])
        self.assertFalse(case["spatial_smt"]["return_residual_coverage"])


if __name__ == "__main__":
    unittest.main()
