"""Original-parent and immutable-input checks for the automatic route."""
from copy import deepcopy
import json
from pathlib import Path
import tempfile
import unittest

from spectest.auto_route import _same_counterexample, run_auto
from spectest.core import run_job


def parent(arms):
    return "Definition result :=\n(\n" + "\n) \\/\n(\n".join(arms) + "\n).\n"


def arm(guard, pre="((p) # Int |-> x)", post="emp"):
    return f"forall (p: Z) (x: Z) {guard},\n {pre}\n|--\n {post}"


class OriginalParentTests(unittest.TestCase):
    def test_missing_private_parameter_cells_need_independent_evidence(self):
        import hashlib
        from spectest.auto_route import _checked_c_source, _missing_value_parameter_cells, _value_aggregate_parameters

        with tempfile.TemporaryDirectory() as tmp:
            p = Path(tmp) / "unit.c"
            p.write_text("void send(struct Packet parcel, Box copy, struct Packet *user) "
                         "/*@ Require emp Ensure emp */ {}")
            case = {"generated_source": str(p),
                    "generated_source_sha256": hashlib.sha256(p.read_bytes()).hexdigest(),
                    "target_layout": {"aliases": [{"name": "Box", "type": {"kind": "struct"}}]}}
            def missing(pre, post):
                params = _value_aggregate_parameters(_checked_c_source(case), case["target_layout"], "send")
                return _missing_value_parameter_cells(params, parent([arm("", pre, post)]), "proof_of_result")
            self.assertEqual(missing("emp", "(parcel + 4) # Int |-> 1"), ["parcel"])
            self.assertEqual(missing("emp", "(copy + 0) # Char |-> 1"), ["copy"])
            self.assertEqual(missing("emp", "(user + 4) # Int |-> 1"), [])
            self.assertEqual(missing("parcel # Int |-> 0", "(parcel + 0) # Int |-> 1"), [])
            self.assertEqual(missing("emp", "(other_parcel + 4) # Int |-> 1"), [])
            self.assertEqual(missing("emp", "(base + (parcel)) # Int |-> 1"), [])
            p.write_text(p.read_text() + " ")
            with self.assertRaisesRegex(ValueError, "generated_source_changed"):
                missing("emp", "parcel # Int |-> 1")

    def test_internal_result_diagnostic_requires_partial_exact_ownership_in_every_arm(self):
        from spectest.auto_route import _partial_return_temporary

        def branch(base, offsets):
            return {"spatial": [{"kind": "cell", "address": f"({base} + {offset})", "type": "i32"}
                                for offset in offsets]}
        for base, expected in [("record_return_821_free", ["record_return_821_free"]), ("caller_821_free", [])]:
            full, one = branch(base, [0, 4]), branch(base, [4])
            ir = {"mode": "exact", "pre": [full], "post": [one]}
            self.assertEqual(_partial_return_temporary(ir, "struct Box build(void)"), expected)
            for guarded in (dict(ir, mode="frame"), dict(ir, post=[one, full]),
                            dict(ir, post=[branch(base, [])]), dict(ir, pre=[full, full])):
                self.assertEqual(_partial_return_temporary(guarded, ""), [])
            self.assertEqual(_partial_return_temporary(ir, "int record_return;"), [])

    def test_negative_requires_equivalent_guards_in_every_alternative(self):
        prefix = "(PreH1 : (x >= 0))"
        restricting = "(PreH1 : (x > 0))"
        for guards in ((prefix, restricting), (restricting, prefix)):
            with self.subTest(guards=guards):
                self.assertFalse(_same_counterexample(parent([arm(g) for g in guards]),
                                                      "proof_of_result", True, 1000))
        positive = parent([arm("(PreH1 : (x = (INT_MIN)))"),
                           arm("(PreH1 : (x = INT_MIN)) (PreH2 : (x <= INT_MAX))")])
        self.assertTrue(_same_counterexample(positive, "proof_of_result", True, 1000))

    def test_nonempty_heap_only_refutes_alternatives_demanding_empty(self):
        guard = "(PreH1 : (x = 1))"
        for alt in [arm(guard, pre="emp"), arm(guard, post="TT")]:
            for arms in ([arm(guard), alt], [alt, arm(guard)]):
                self.assertFalse(_same_counterexample(parent(arms), "proof_of_result", True, 1000))
        text = parent([arm(guard), arm(guard, post="TT && emp")])
        self.assertFalse(_same_counterexample(text, "proof_of_result", False, 1000))
        self.assertTrue(_same_counterexample(text, "proof_of_result", True, 1000))


class AutoRunTests(unittest.TestCase):
    def test_artifact_and_native_verdict_isolation(self):
        repo = Path(__file__).resolve().parents[1]
        with tempfile.TemporaryDirectory() as tmp:
            folder = Path(tmp)
            source = folder / "single.c"
            source.write_text('#include "verification_stdlib.h"\n#include "int_array_def.h"\n'
                              'int sample(int *p) /*@ With xs Require IntArray::full(p,2,xs) '
                              'Ensure data_at(p,int,7) * data_at(p+1,int,9) */ { return 0; }\n')
            job = folder / "job.json"
            job.write_text(json.dumps({"source": str(source), "function":"sample",
                           "binds":[{"id":"cell", "args":{"p":4096}, "values":{"xs":[7,9]}}],
                           "qcp":{"binary":str(repo / "bin/tespec-symexec"),"qcip_root":str(repo / "runtime/qcip"),
                                  "include_dirs":[str(repo / "runtime/qcip/QCP_examples/QCP_demos_human")]}}))
            native = run_job(job, folder / "raw")
            original = deepcopy(native)
            case = native["results"][0]
            self.assertEqual(case["status"], "UNKNOWN")
            result = run_auto(native, folder / "valid")
            self.assertEqual(result["results"][0]["status"], "PASS")
            self.assertFalse(result["itp_vcs"])
            self.assertEqual(native, original)
            goal = Path(case["vc"]["files"]["goal"])
            goal.write_text(goal.read_text() + "(* changed *)\n")
            corrupt = run_auto(native, folder / "corrupt")
            self.assertEqual(corrupt["results"][0]["status"], "UNKNOWN")
            self.assertIn("original_coq_file_changed", corrupt["results"][0]["auto_route"]["error"])
            self.assertEqual(native, original)
