"""Refutation must cover the frozen parent, its guards, and observable resources."""
import hashlib
import json
import tempfile
import unittest
from pathlib import Path

try:
    import z3
except ImportError:
    z3 = None


PRELUDE = """From SimpleC.Verification Require Import VCPrelude.
Import naive_C_Rules.
Local Open Scope sac.
Local Open Scope Z_scope.
"""
ROOT = "proof_of_example_return_wit_1"
SOURCE = "int example(int *p) /*@ Require emp Ensure emp */ { return 0; }"
RETURN_PARAMETER = (
    "int **example(int *p) /*@ Require emp Ensure data_at(__return,int*,p) */ { return &p; }"
)
LAYOUT = {"architecture_bits": 32, "byte_order": "big", "memory_rules": "naive_C_Rules",
          "field_address_semantics": "base-plus-byte-offset/v1"}


def arm(pre, post, guards=()):
    names = "(p: Z) (v: Z)"
    for i, guard in enumerate(guards):
        names += f" (PreH{i} : ({guard}))"
    return f"forall {names},\n  {pre}\n|--\n  {post}"


def sha(data):
    return hashlib.sha256(data).hexdigest()


@unittest.skipUnless(z3, "optional z3 backend")
class ParentFootprintTests(unittest.TestCase):
    def setUp(self):
        from spectest.auto_parent_evidence import refute_parent_by_footprint

        self.refute = refute_parent_by_footprint
        temp = tempfile.TemporaryDirectory()
        self.addCleanup(temp.cleanup)
        self.directory = Path(temp.name)

    def prepare(self, arms, *, source=SOURCE, prefix=PRELUDE):
        goal = prefix + "Definition example_return_wit_1 :=\n(\n" + "\n) \\/\n(\n".join(arms)
        goal += "\n).\nModule Type VC_Correct.\nAxiom " + ROOT + " : example_return_wit_1.\nEnd VC_Correct.\n"
        goal_file = self.directory / "Goal.v"
        goal_file.write_text(goal)
        c_file = self.directory / "test.c"
        c_file.write_text(source)
        manifest = self.directory / "manifest.json"
        vc = {
            "coq_dependencies": [], "runtime_dependencies": [], "target_layout": LAYOUT,
            "manifest": str(manifest), "files": {"goal": str(goal_file)},
            "qcip_root": str(Path(__file__).resolve().parents[1] / "runtime/qcip"),
            "immutable_sha256": {"goal": sha(goal_file.read_bytes())},
        }
        manifest.write_text(json.dumps(vc))
        return {"vc": vc, "generated_source": str(c_file),
                "generated_source_sha256": sha(c_file.read_bytes())}, goal

    def check(self, *arms, kind="return", **kw):
        case, goal = self.prepare(arms, **kw)
        return self.refute(case, "example", goal, ROOT, kind, 2000)

    def test_distinct_heaps_and_common_bindings(self):
        a = arm("p # Int |-> v", "TT && emp", ("p = 4096", "v = -1"))
        b = arm("TT && emp", "EX (n: Z), p # Int |-> n", ("p = 4096",))
        w = self.check(a, b)
        self.assertEqual(w["bindings"], {"p": 4096, "v": -1})
        self.assertEqual(w["arms"][0]["heap"], [[i, 255, True] for i in range(4096, 4100)])
        self.assertEqual(w["arms"][1], {"pre_bytes": 0, "required_post_bytes": [4], "heap": []})

    def test_unsigned_last_nbits_is_mod_and_native_percent_is_rem(self):
        a = arm("p # UInt |-> (unsigned_last_nbits v 8)", "TT && emp",
                ("p = 4096", "v = -1", "(v % 256) = -1"))
        self.assertEqual(self.check(a, a)["arms"][0]["heap"][-1][1], 255)

    def test_undefined_owned_bytes_form_a_real_antecedent(self):
        a = arm("p # Int |->_", "emp", ("p = 4096",))
        b = arm("EX (n: Z), p # Int |-> n", "emp", ("p = 4096",))
        w = self.check(a, b)
        heap = w["arms"][0]["heap"]
        self.assertEqual([byte[0] for byte in heap], list(range(4096, 4100)))
        # ConAssertion.mstore_noninit accepts either constructor at each byte.
        self.assertTrue(all(isinstance(init, bool) and 0 <= value < 256
                            for _, value, init in heap))
        self.assertTrue(w["arms"][1]["local_witnesses"])

    def test_all_guards_and_actual_scalar_ranges_are_retained(self):
        def rejected(pre, guards):
            a = arm(pre, "TT && emp", guards)
            self.assertIsNone(self.check(a, a), (pre, guards))
        rejected("p # UInt |-> v", ("v = -1",))
        rejected("p # Int |-> v", ("v = 2147483648",))
        rejected("p # Int |-> v", ("p = 4097",))
        rejected("p # Int |-> v", ("v = 1", "v = 2"))
        rejected("“ (v = 1) ” && (p # Int |-> v)", ("v = 2",))
        rejected("(p # Int |-> v) ** (p # UInt |-> v)", ())
        rejected("“ (opaque_helper v) ” && (p # Int |-> v)", ())

    def test_every_original_disjunct_and_rhs_alternative(self):
        mismatch = arm("p # Int |-> v", "TT && emp")
        enough = arm("p # Int |-> v", "p # Int |-> v")
        self.assertIsNone(self.check(mismatch, enough))
        alt = arm("p # Int |-> v", "(p # Int |-> v) || emp")
        self.assertIsNone(self.check(alt, mismatch))
        self.assertIsNone(self.check(mismatch))
        self.assertIsNone(self.check(mismatch, arm("TT && emp", "p # Int |->_", ("False",))))

    def test_shadowed_contexts_and_changed_artifacts(self):
        a = arm("p # Int |-> v", "TT && emp")
        self.assertIsNone(self.check(a, a, prefix=PRELUDE + "Definition unsigned_last_nbits := 0.\n"))
        self.assertIsNone(self.check(a, a, prefix=PRELUDE + 'Notation "TT" := emp.\n'))
        case, goal = self.prepare([a, a])
        self.assertIsNone(self.refute(case, "example", goal + " ", ROOT, "return", 500))
        Path(case["generated_source"]).write_text("int example(){return 1;}")
        self.assertIsNone(self.refute(case, "example", goal, ROOT, "return", 500))

    def test_expired_parameter_requires_direct_return_and_mandatory_ownership(self):
        local = '(&( "p_spec_87" )) # Ptr |-> p'
        a = arm("TT && emp", local)
        self.assertIsNotNone(self.check(a, a, source=RETURN_PARAMETER))
        for source in (RETURN_PARAMETER.replace("return &p", "return 0"),
                       RETURN_PARAMETER.replace("Ensure data_at", "Ensure emp || data_at"),
                       RETURN_PARAMETER.replace("Ensure data_at(__return,int*,p)", "Ensure emp")):
            self.assertIsNone(self.check(a, a, source=source))
        self.assertIsNone(self.check(a, a, source=RETURN_PARAMETER, kind="entailment"))
        b = arm("TT && emp", local.replace("p_spec", "other_spec"))
        self.assertIsNone(self.check(a, b, source=RETURN_PARAMETER))
        self.assertIsNone(self.check(arm(local, "emp"), a, source=RETURN_PARAMETER))

    def test_abstract_paths_and_private_aggregates_cannot_be_run_witnesses(self):
        a = arm("p # Int |-> v", "emp")
        for src in (SOURCE.replace("return 0", "if (0) return 2; return 0"),
                    SOURCE.replace("return 0", "while (0) { return 1; } return 0"),
                    SOURCE.replace("int *p", "struct S p"),
                    SOURCE.replace("return 0", "return example(p)"),
                    "#define TEST(x) if (x)\n" + SOURCE):
            self.assertIsNone(self.check(a, a, source=src))
