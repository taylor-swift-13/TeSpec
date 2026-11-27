"""Exercise target-layout binding on the nonempty IntList_cons benchmark."""
import json
import os
from pathlib import Path
import shutil
import subprocess
import sys
import tempfile
import unittest

from spectest.layout import target_layout_digest
from spectest.errors import FieldLayoutMismatch
from spectest.layout_job import _uses_field_addresses, validate_layout_context


ROOT = Path(__file__).resolve().parents[1]
SOURCE = ROOT / "benchmark/programs/list_all/variants/qcp_existing_ab15e46be3488118dfcd/qcp/list-all.c"
HEADERS = ROOT / "runtime/qcip/QCP_examples/QCP_demos_human"
PREDICATES = "SimpleC.EE.QCP_demos_human.sll_lib"


class AutoListLayoutTest(unittest.TestCase):
    def test_discovery_reads_declarations(self):
        self.assertTrue(_uses_field_addresses('Definition f p := &(p # "parcel" ->ₛ "slot").'))
        self.assertFalse(_uses_field_addresses('Import GeneratedLayout.AddressNotations. Definition f p := &(p ->ₛ field).'))
        self.assertFalse(_uses_field_addresses('(* Definition f p := &(p ->ₛ field). *)'))
        self.assertFalse(_uses_field_addresses('Definition label := "&(p ->ₛ field)".'))

    def test_incomplete_execution_without_a_goal_still_checks_layout_identity(self):
        deps = {"LayoutAddress": "a", "GeneratedLayout": "b", "BoundLib": "c"}
        manifest = {"coq_dependencies": [{"module": k, "sha256": v} for k, v in deps.items()],
                    "files": {}, "status": "not_generated", "residual_goals": [], "counterexample_goals": [],
                    "target_layout": {}}
        context = {"dependencies": deps, "modules": {"Lib": "BoundLib"}, "runtime_source_sha256": "r",
                   "target_layout_sha256": target_layout_digest({})}
        validate_layout_context(context, manifest, "r", incomplete_without_goal=True)
        with self.assertRaises(FieldLayoutMismatch):
            validate_layout_context(context, manifest, "r")
        for changed, vc in [(context | {"dependencies": deps | {"BoundLib": "x"}}, manifest),
                            (context, manifest | {"residual_goals": ["witness"]}),
                            (context | {"guard_projection": {}}, manifest)]:
            with self.subTest(context=changed, vc=vc), self.assertRaises(FieldLayoutMismatch):
                validate_layout_context(changed, vc, "r", incomplete_without_goal=True)

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
                    subprocess.run([sys.executable, "-B", "-m", "spectest", "routes", str(job),
                                    "--output-dir", str(prepared)], cwd=ROOT, check=True, capture_output=True,
                                   env={**os.environ, "COQC": compiler})
                    route = json.loads((prepared / "routes.json").read_text())
                    self.assertEqual(route["auto_layout"]["modules"], [PREDICATES])
                    case, = json.loads((prepared / "auto/report.json").read_text())["results"]
                    entry = case["auto_route"]["entry"]
                    self.assertEqual((case["status"], entry["status"]), ("PASS", "SAT"))
                    pre, = entry["normalized_vc"]["pre"]
                    self.assertCountEqual([c["type"] for c in pre["spatial"]], expected.keys())
                    for cell in pre["spatial"]:
                        self.assertRegex(cell["address"], rf"\+ {expected[cell['type']]}\)$")
                    self.assertEqual(sorted(entry["owned_addresses"]), list(range(8192, 8200)))
                    goal_hashes.add(case["vc"]["immutable_sha256"]["goal"])
            self.assertEqual(len(goal_hashes), 2)
