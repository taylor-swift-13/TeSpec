from __future__ import annotations

import hashlib
import json
import os
from pathlib import Path
import subprocess
import shutil
import tempfile
import unittest
from contextlib import redirect_stdout
from io import StringIO

from spectest.cli import main

ROOT = Path(__file__).resolve().parents[1]


class PrepareProofManifestTests(unittest.TestCase):
    def test_prepare_proof_pins_generated_files_and_residuals(self) -> None:
        with tempfile.TemporaryDirectory(prefix="qcp-prepare-proof-") as temp:
            vc_dir = Path(temp) / "vc"
            vc_dir.mkdir()
            generated_source = vc_dir / "case.c"
            original_source = Path(temp) / "original.c"
            generated_source.write_text("void f(void) {}\n", encoding="utf-8")
            original_source.write_text("void f(void) {}\n", encoding="utf-8")

            files = {
                "goal": "Definition f_precondition := True.\n",
                "proof_auto": "(* automatic proof *)\n",
                "proof_manual": "Lemma proof_of_f_precondition : True.\n",
                "goal_check": "(* check *)\n",
            }
            for suffix, contents in files.items():
                path = vc_dir / f"case_{suffix}.v"
                path.write_text(contents, encoding="utf-8")

            output = StringIO()
            with redirect_stdout(output):
                status = main(
                    [
                        "prepare-proof",
                        str(vc_dir),
                        str(generated_source),
                        str(original_source),
                        "--function",
                        "f",
                        "--case-id",
                        "f_require_sat",
                    ]
                )

            self.assertEqual(status, 0)
            report = json.loads(output.getvalue())
            self.assertEqual(report["status"], "residual")
            self.assertEqual(report["residual_goals"], ["proof_of_f_precondition"])
            expected_hash = hashlib.sha256(
                (vc_dir / "case_goal.v").read_bytes()
            ).hexdigest()
            self.assertEqual(report["immutable_sha256"]["goal"], expected_hash)
            saved = json.loads((vc_dir / "manifest.json").read_text(encoding="utf-8"))
            self.assertEqual(saved["case_id"], "f_require_sat")

    def test_empty_itp_inventory_skips_agent_process(self) -> None:
        script = ROOT / "skills/qcp-spec-test/scripts/run-agent.sh"
        with tempfile.TemporaryDirectory(prefix="qcp-no-itp-agent-") as temp:
            report = Path(temp) / "report.json"
            report.write_text(
                json.dumps(
                    {
                        "schema": "qcp-spectest-report/v1",
                        "function": "f",
                        "results": [
                            {
                                "id": "x",
                                "status": "PASS",
                                "evidence": {"certificate": "NOT_CHECKED"},
                            }
                        ],
                        "summary": {},
                        "itp_vcs": [],
                    }
                ),
                encoding="utf-8",
            )
            environment = os.environ.copy()
            environment["CODEX_BIN"] = str(Path(temp) / "codex-must-not-run")
            completed = subprocess.run(
                [str(script), str(report)],
                cwd=ROOT,
                env=environment,
                capture_output=True,
                text=True,
                check=False,
            )
            self.assertEqual(completed.returncode, 0, completed.stderr)
            result = json.loads(completed.stdout)
            final = json.loads(Path(result["report"]).read_text())
            self.assertEqual(final["proof_completion"]["agent"]["status"], "SKIPPED")
            self.assertEqual(
                final["results"][0]["evidence"]["certificate"], "NOT_CHECKED"
            )
            shutil.rmtree(Path(result["agent_report"]).parent)

    def test_forged_old_proof_report_cannot_establish_success(self) -> None:
        script = ROOT / "skills/qcp-spec-test/scripts/run-agent.sh"
        with tempfile.TemporaryDirectory(prefix="qcp-agent-report-") as temp:
            root = Path(temp)
            vc_dir = root / "vc"
            vc_dir.mkdir()
            manifest = vc_dir / "manifest.json"
            manifest.write_text("{}", encoding="utf-8")
            (vc_dir / "proof_report.json").write_text(
                json.dumps({"status": "PASS", "duration_seconds": 0.25}),
                encoding="utf-8",
            )
            automatic = root / "report.json"
            automatic.write_text(
                json.dumps({"itp_vcs": [{"manifest": str(manifest), "goals": ["g"]}]}),
                encoding="utf-8",
            )
            codex = root / "codex"
            codex.write_text(
                "#!/bin/sh\n"
                'case "$*" in *--help*) echo usage; exit 0;; esac\n'
                'echo \'{"type":"turn.completed","usage":{"input_tokens":12,"output_tokens":3}}\'\n',
                encoding="utf-8",
            )
            codex.chmod(0o755)
            environment = os.environ.copy()
            environment["CODEX_BIN"] = str(codex)
            completed = subprocess.run(
                [str(script), str(automatic)],
                cwd=ROOT,
                env=environment,
                capture_output=True,
                text=True,
                check=False,
            )
            self.assertNotEqual(completed.returncode, 0)
            self.assertIn("expected an automatic spec-test report", completed.stderr)


if __name__ == "__main__":
    unittest.main()
