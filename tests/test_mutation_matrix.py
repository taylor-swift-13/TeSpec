from __future__ import annotations

import json
from pathlib import Path
import re
import subprocess
import sys
import tempfile
import unittest


ROOT = Path(__file__).resolve().parents[1]
MATRIX_RUNNER = ROOT / "skills/tespec-e2e/scripts/run_mutation_matrix.py"


class MutationMatrixTests(unittest.TestCase):
    def test_separate_candidate_spec_is_applied_to_reference_and_mutants(
        self,
    ) -> None:
        annotated = (ROOT / "cases/add_one/add_one.c").read_text(encoding="utf-8")
        match = re.search(r"/\*@(?P<body>.*?)\*/", annotated, re.DOTALL)
        assert match is not None
        implementation = annotated[: match.start()] + annotated[match.end() :]

        with tempfile.TemporaryDirectory(prefix="tespec-matrix-spec-file-") as temp:
            artifact_root = Path(temp)
            reference = artifact_root / "reference.c"
            spec = artifact_root / "candidate.qcp"
            binds = artifact_root / "binds.json"
            mutants = artifact_root / "mutants"
            output = artifact_root / "output"
            mutants.mkdir()
            reference.write_text(implementation, encoding="utf-8")
            spec.write_text(match.group("body").strip() + "\n", encoding="utf-8")
            binds.write_text(
                json.dumps(
                    {
                        "binds": [
                            {
                                "id": "small",
                                "args": {"x": 1},
                                "values": {"v": 1},
                            }
                        ]
                    }
                ),
                encoding="utf-8",
            )
            (mutants / "wrong_increment.c").write_text(
                implementation.replace("return x + 1;", "return x + 2;"),
                encoding="utf-8",
            )

            completed = subprocess.run(
                [
                    sys.executable,
                    str(MATRIX_RUNNER),
                    "--reference",
                    str(reference),
                    "--function",
                    "add_one",
                    "--spec-file",
                    str(spec),
                    "--binds",
                    str(binds),
                    "--mutants",
                    str(mutants),
                    "--output-dir",
                    str(output),
                    "--artifact-root",
                    str(artifact_root),
                    "--spec-version",
                    "candidate",
                    "--expected-binds",
                    "1",
                    "--minimum-mutants",
                    "1",
                ],
                cwd=ROOT,
                capture_output=True,
                text=True,
                check=False,
            )
            self.assertEqual(
                completed.returncode,
                0,
                msg=f"{completed.stdout}\n{completed.stderr}",
            )
            matrix = json.loads((output / "matrix.json").read_text(encoding="utf-8"))
            self.assertEqual(matrix["reference"]["counts"]["PASS"], 1)
            self.assertEqual(matrix["mutation_summary"]["killed"], 1)
            self.assertEqual(matrix["spec_file"], "candidate.qcp")


if __name__ == "__main__":
    unittest.main()
