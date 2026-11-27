"""Exercise target-layout binding on the nonempty IntList_cons benchmark."""
import json
import os
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest

from spectest.auto_route import run_auto
from spectest.core import run_job
from spectest.layout_job import prepare_layout_job


ROOT = Path(__file__).resolve().parents[1]
SOURCE = ROOT / "benchmark/programs/list_all/variants/qcp_existing_ab15e46be3488118dfcd/qcp/list-all.c"
HEADERS = ROOT / "runtime/qcip/QCP_examples/QCP_demos_human"
PREDICATES = "SimpleC.EE.QCP_demos_human.sll_lib"


class AutoListLayoutTest(unittest.TestCase):
    def test_nonempty_list_uses_the_selected_declaration_layout(self):
        compiler = shutil.which(os.environ.get("COQC", "coqc"))
        if not compiler or "version 8.20" not in subprocess.check_output([compiler, "-v"], text=True):
            self.skipTest("complete QCP predicate libraries require Coq 8.20")
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            source = root / SOURCE.name
            shutil.copyfile(SOURCE, source)
            job = root / "input.json"
            job.write_text(json.dumps({
                "source": str(source), "function": "IntList_cons",
                "binds": [{"args": {"h": -2147483648, "t": 8192}, "values": {"h0": -2147483648, "l": [1]}}],
                "qcp": {"architecture_bits": 32, "execution": "inline", "vc_scope": "all-boundaries",
                        "include_dirs": [str(root), str(HEADERS)]},
            }))
            header = (HEADERS / "sll_def.h").read_text()
            original_fields = "int data;\n   struct list *next;"
            reversed_fields = "struct list *next;\n   int data;"
            self.assertEqual(header.count(original_fields), 1)
            goal_hashes = set()
            for label, fields, expected in [
                ("original", original_fields, {"i32": 0, "ptr": 4}),
                ("reversed", reversed_fields, {"i32": 4, "ptr": 0}),
            ]:
                with self.subTest(layout=label):
                    (root / "sll_def.h").write_text(header.replace(original_fields, fields))
                    prepared = root / label
                    prepare_layout_job(job, [PREDICATES], prepared, coqc_command=[compiler])
                    native = run_job(prepared / "job.json", prepared / "native")
                    case, = run_auto(native, prepared / "auto")["results"]
                    entry = case["auto_route"]["entry"]
                    self.assertEqual((case["status"], entry["status"]), ("PASS", "SAT"))
                    pre, = entry["normalized_vc"]["pre"]
                    self.assertCountEqual([c["type"] for c in pre["spatial"]], expected.keys())
                    for cell in pre["spatial"]:
                        self.assertRegex(cell["address"], rf"\+ {expected[cell['type']]}\)$")
                    self.assertEqual(sorted(entry["owned_addresses"]), list(range(8192, 8200)))
                    goal_hashes.add(case["vc"]["immutable_sha256"]["goal"])
            self.assertEqual(len(goal_hashes), 2)
