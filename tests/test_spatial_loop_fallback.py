"""Native loop traces feed residual VCs to the post-execution solver."""
from pathlib import Path
import json
import tempfile
import unittest

from spectest.core import run_job

ROOT = Path(__file__).resolve().parents[1]


@unittest.skipUnless((ROOT / "bin/tespec-symexec").is_file(), "requires native executor")
class SpatialLoopFallbackTests(unittest.TestCase):
    def run_loop(self, strategy, mode, missing_owner=False):
        temp = tempfile.TemporaryDirectory()
        self.addCleanup(temp.cleanup)
        folder = Path(temp.name)
        post = "emp" if missing_owner else "data_at(p,int,7)"
        source = folder / "loop.c"
        source.write_text(
            '#include "verification_stdlib.h"\n'
            'int sample(int *p) /*@ Require data_at(p,int,7) '
            f'Ensure {post} && __return == 3 */ '
            '{ int i=0; /*@ Inv 0<=i && i<=3 && data_at(p,int,7) */ '
            'while(i<3) { i++; } return i; }\n'
        )
        job = folder / "job.json"
        job.write_text(json.dumps({
            "source": str(source), "function": "sample",
            "binds": [{"id": "cell", "args": {"p": 4096}, "values": {}}],
            "qcp": {
                "execution_strategy": strategy, "execution_mode": mode,
                "include_dirs": [str(ROOT / "runtime/qcip/QCP_examples/QCP_demos_human")],
            },
        }))
        off = run_job(job, folder / "off", spatial_smt=False)["results"][0]
        on = run_job(job, folder / "on", spatial_smt=True)["results"][0]
        for kind in ("goal", "proof_auto", "proof_manual", "goal_check"):
            self.assertEqual(
                Path(off["vc"]["files"][kind]).read_bytes(),
                Path(on["vc"]["files"][kind]).read_bytes(),
            )
        self.assertEqual(off["residual_vcs"], on["residual_vcs"])
        self.assertTrue(on["execution_completed"])
        return off, on

    def test_loop_ownership_loss_reaches_spatial_solver(self):
        for strategy in ("inline", "modular"):
            for mode in ("entry-exit", "all-boundaries"):
                with self.subTest(strategy=strategy, mode=mode):
                    off, on = self.run_loop(strategy, mode, missing_owner=True)
                    self.assertEqual(off["status"], "UNKNOWN", off)
                    self.assertEqual(on["status"], "FAIL", on)
                    self.assertEqual(on["spatial_smt"]["attempted"], 1)
                    self.assertFalse(on["spatial_smt"]["itp_required"])
                    self.assertEqual(on["vc_results"][-1]["status"], "INVALID")

    def test_correct_loop_remains_pass(self):
        for strategy in ("inline", "modular"):
            for mode in ("entry-exit", "all-boundaries"):
                with self.subTest(strategy=strategy, mode=mode):
                    off, on = self.run_loop(strategy, mode)
                    self.assertEqual(off["status"], "PASS", off)
                    self.assertEqual(on["status"], "PASS", on)
                    self.assertEqual(on["spatial_smt"]["attempted"], 0)
