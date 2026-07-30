import json
from pathlib import Path
import subprocess
import sys
import tempfile
import unittest


ROOT = Path(__file__).resolve().parents[1]
SCRIPT = (
    ROOT / "skills" / "tespec-classify-ieee754-clamp" / "scripts" / "find_witnesses.py"
)
QUESTION = ROOT / "benchmark" / "nano-probe" / "ieee754-clamp-expert"


class Ieee754ClampSkillTests(unittest.TestCase):
    def test_finds_both_directional_witnesses(self) -> None:
        with tempfile.TemporaryDirectory(prefix="tespec-ieee754-skill-test-") as temp:
            output = Path(temp) / "witnesses.json"
            completed = subprocess.run(
                [
                    sys.executable,
                    str(SCRIPT),
                    "--impl",
                    str(QUESTION / "input" / "impl.c"),
                    "--spec",
                    str(QUESTION / "input" / "spec.qcp"),
                    "--semantics",
                    str(QUESTION / "dependencies" / "SEMANTICS.md"),
                    "--definitions",
                    str(QUESTION / "dependencies" / "definitions.v"),
                    "--output",
                    str(output),
                ],
                cwd=ROOT,
                check=True,
                capture_output=True,
                text=True,
            )
            payload = json.loads(completed.stdout)
            self.assertEqual(payload, json.loads(output.read_text(encoding="utf-8")))
            self.assertTrue(payload["all_witnesses_found"])
            self.assertTrue(payload["complete_counterexample"]["witness_found"])
            self.assertEqual(
                payload["complete_counterexample"]["witness_direction"],
                "implementation_satisfies_and_spec_rejects",
            )
            self.assertTrue(payload["sound_counterexample"]["witness_found"])
            self.assertEqual(
                payload["sound_counterexample"]["witness_direction"],
                "spec_satisfies_and_implementation_rejects",
            )
            self.assertEqual(
                payload["sound_counterexample"]["spec_admitted_post_state"][
                    "output_bits"
                ],
                "0x0000000000000000",
            )
            self.assertEqual(
                payload["sound_counterexample"]["implementation_observation"][
                    "output_bits"
                ],
                "0x8000000000000000",
            )

    def test_rejects_a_different_question(self) -> None:
        other = ROOT / "benchmark" / "pilot" / "p116-sort-hard"
        completed = subprocess.run(
            [
                sys.executable,
                str(SCRIPT),
                "--impl",
                str(other / "mutant.c"),
                "--spec",
                str(other / "candidate.qcp"),
                "--semantics",
                str(other / "SEMANTICS.md"),
                "--definitions",
                str(other / "definitions.v"),
            ],
            cwd=ROOT,
            check=False,
            capture_output=True,
            text=True,
        )
        self.assertEqual(completed.returncode, 2)
        payload = json.loads(completed.stdout)
        self.assertFalse(payload["all_witnesses_found"])
        self.assertIn("does not match this task", payload["error"])


if __name__ == "__main__":
    unittest.main()
