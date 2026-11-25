import hashlib
import tempfile
import unittest
from pathlib import Path
from types import SimpleNamespace
from unittest.mock import patch

try:
    import z3
except ImportError:
    z3 = None


@unittest.skipUnless(z3, "optional Z3 backend")
class CommonFrameTests(unittest.TestCase):
    ROOT = "generated_goal"
    FRAME = '(fragment ( &( "node_spec_17" ) ) )'
    CELL = '(2048 # Int |-> 3)'

    def setUp(self):
        self.dir = tempfile.TemporaryDirectory()
        self.addCleanup(self.dir.cleanup)
        self.file = Path(self.dir.name) / "input_goal.v"
        self.source = (f"Definition {self.ROOT} :=\n(\nforall (n: Z),\n  {self.CELL}\n"
                       f"  ** {self.FRAME}\n|--\n  {self.CELL}\n  ** {self.FRAME}\n).\n")
        native = "PROP[]LOCAL[Temp node node_17_addr]SEP[store(2048,3,signed int);fragment(node_17_addr)]"
        self.record = {"layout": {}, "check_mode": "exact", "local_semantics": "same-program-environment/v1",
                       "vc": {"kind": "return", "path": native, "goal": native, "proof_roots": [self.ROOT]}}
        self.case = {"vc": {"files": {"goal": str(self.file)}, "immutable_sha256": {}}}
        self.freeze(self.source)
        self.predicate = SimpleNamespace(args=(("ptr", "Z"),), result="Assertion")
        self.solved = []

    def freeze(self, source):
        data = source.encode()
        self.file.write_bytes(data)
        self.case["vc"]["immutable_sha256"]["goal"] = hashlib.sha256(data).hexdigest()

    def solve(self, record, status="VALID"):
        from spectest.auto_common_frame import prove_with_common_frame

        def residual(reduced):
            self.solved.append(reduced["vc"])
            return {"status": status, "antecedent_satisfiability": "sat", "vacuous": False}

        with patch("spectest.auto_common_frame.definitions_for", return_value=({"fragment": self.predicate}, {}, {})):
            return prove_with_common_frame(record, self.case, "fragment", residual)

    def test_arbitrary_shared_predicate_preserves_cells_and_locals(self):
        result = self.solve(self.record)
        self.assertEqual(result["status"], "VALID")
        self.assertNotIn("antecedent_satisfiability", result)
        self.assertNotIn("vacuous", result)
        for key in ("path", "goal"):
            self.assertIn("store(2048,3,signed int)", self.solved[0][key])
            self.assertIn("Temp node node_17_addr", self.solved[0][key])
            self.assertNotIn("fragment", self.solved[0][key])
        for status in ("UNKNOWN", "INVALID"):
            self.assertIsNone(self.solve(self.record, status))

    def test_local_scope_identity_and_multiplicity(self):
        vc = self.record["vc"]
        for goal in (
            vc["goal"].replace("Temp node node_17_addr", "Temp node node_17_addr; Temp node other"),
            vc["goal"].replace("Temp node node_17_addr", "Temp node other"),
            vc["goal"].replace("fragment(node_17_addr)", "fragment(other)"),
            "EX fragment\n" + vc["goal"],
            "EX node_17_addr\n" + vc["goal"],
        ):
            self.assertIsNone(self.solve(self.record | {"vc": vc | {"goal": goal}}))
        for source in (
            self.source.replace('** '+self.FRAME, '&& '+self.FRAME),
            self.source.replace(self.FRAME, '(other '+self.FRAME+')'),
            self.source.replace('forall (n: Z)', 'forall (fragment: Z -> Assertion)'),
            self.source.replace('node_spec_17', 'node_spec_18', 1),
            self.source.replace('  ** '+self.FRAME, '  ** (some_operator\n  ** '+self.FRAME+'\n  )'),
            self.source.replace(self.ROOT, "other_goal"),
        ):
            self.freeze(source)
            self.assertIsNone(self.solve(self.record))
        self.freeze(self.source)
        dup = vc["path"].replace("fragment(node_17_addr)", "fragment(node_17_addr);fragment(node_17_addr)")
        self.assertIsNone(self.solve(self.record | {"vc": vc | {"path": dup, "goal": dup}}))
        self.assertFalse(self.solved)

    def test_tokens_distinguish_symbols_and_numeral_arguments(self):
        self.predicate.args = (("a", "Z"), ("b", "Z"))
        vc = self.record["vc"]
        native = vc["path"].replace("fragment(node_17_addr)", "fragment(1, 23)")
        for atom in ("(fragment 12 3)", "(fragment123)", "(fragment1 23)"):
            self.freeze(self.source.replace(self.FRAME, atom))
            self.assertIsNone(self.solve(self.record | {"vc": vc | {"path": native, "goal": native}}))
        self.assertFalse(self.solved)
        self.freeze(self.source.replace(self.FRAME, "(fragment 1 23)"))
        self.assertIsNotNone(self.solve(self.record | {"vc": vc | {"path": native, "goal": native}}))

    def test_removing_last_atom_preserves_empty_ownership_and_pure_guards(self):
        vc = self.record["vc"]
        native = vc["path"].replace("store(2048,3,signed int);", "")
        path = native.replace("PROP[]", "PROP[x == 0]")
        goal = native.replace("PROP[]", "PROP[x != 0]")
        self.freeze(self.source.replace(self.CELL + "\\n  ** ", ""))
        self.assertIsNone(self.solve(self.record | {"vc": vc | {"path": path, "goal": goal}}, "INVALID"))
        self.assertIn("PROP[x == 0]", self.solved[0]["path"])
        self.assertIn("PROP[x != 0]", self.solved[0]["goal"])
        for side in ("path", "goal"):
            self.assertIn("SEP[]", self.solved[0][side])

    def test_frozen_goal_and_predicate_binding_required(self):
        self.file.write_bytes(self.file.read_bytes() + b" ")
        self.assertIsNone(self.solve(self.record))
        self.freeze(self.source)
        self.predicate.result = "opaque"
        self.assertIsNone(self.solve(self.record))
        self.assertFalse(self.solved)
