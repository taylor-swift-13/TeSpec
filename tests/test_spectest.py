from __future__ import annotations

import json
import os
import subprocess
import tempfile
import unittest
from pathlib import Path
from unittest.mock import patch

from spectest.core import (
    _FORBIDDEN_MANUAL_PROOF,
    JobError,
    _closed_generated_goal_value,
    _coq_required_modules,
    _default_coqc_command,
    _parse_qcp_config,
    _resolve_source_coq_module,
    _source_coq_imports,
    analyze_catalog,
    analyze_source,
    bundled_qcip_root,
    bundled_qcp_binary,
    read_source_text,
    run_job,
    source_with_local_includes,
    specialize_source,
)


ROOT = Path(__file__).resolve().parents[1]
QCIP = ROOT / "runtime/qcip"
EXTERNAL_QCIP = Path(os.environ.get("QCIP_SOURCE_DIR", str(ROOT.parent / "QCIP")))
QCP_SOURCE = Path(os.environ.get("QCP_SOURCE_DIR", str(ROOT.parent / "sac_c_parser")))
LOCAL_QCP = ROOT / "bin/qcp-symexec"


class SpecializationTests(unittest.TestCase):
    def setUp(self) -> None:
        self.source = (ROOT / "cases/sll_first_value/sll_first_value.c").read_text(
            encoding="utf-8"
        )

    def test_injects_all_bindings_into_require(self) -> None:
        specialized = specialize_source(
            self.source,
            "sll_first_value",
            {"x": "1", "xs": "cons(2, cons(3, nil))"},
            argument_bindings={"p": 4096},
        )
        self.assertIn("(p == (4096))", specialized)
        self.assertIn("(x == (1))", specialized)
        self.assertIn("(xs == (cons(2, cons(3, nil))))", specialized)
        self.assertIn("&& p != 0 && sll", specialized)

    def test_default_runtime_is_bundled_and_relocatable(self) -> None:
        config = _parse_qcp_config({}, ROOT, ROOT)
        self.assertEqual(config.qcip_root, bundled_qcip_root().resolve())
        self.assertEqual(config.binary, bundled_qcp_binary().resolve())
        self.assertEqual(config.include_dirs, (ROOT.resolve(),))
        self.assertFalse(any(path.name == "providers" for path in config.include_dirs))
        self.assertTrue(config.binary.is_file())
        self.assertTrue((config.qcip_root / "SeparationLogic/_CoqProject").is_file())

    def test_reads_utf8_and_gb18030_c_sources_strictly(self) -> None:
        with tempfile.TemporaryDirectory(prefix="qcp-source-encoding-") as temp:
            root = Path(temp)
            utf8_source = root / "utf8.c"
            gb_source = root / "gb18030.c"
            invalid_source = root / "invalid.c"
            utf8_source.write_bytes("/* 星 */\nvoid f(void) {}\n".encode("utf-8"))
            gb_source.write_bytes("/* 模式转换 */\nvoid g(void) {}\n".encode("gb18030"))
            invalid_source.write_bytes(b"\x81")

            self.assertIn("星", read_source_text(utf8_source))
            self.assertIn("模式转换", read_source_text(gb_source))
            with self.assertRaisesRegex(JobError, "cannot decode source"):
                read_source_text(invalid_source)

    def test_closed_generated_goal_detects_only_concrete_falsehoods(self) -> None:
        goals = """
Definition closed_false :=
forall (H : (4096 <> 0)), (0 = 1).
Definition vacuous_true :=
forall (H : (0 <> 0)), (0 = 1).
Definition closed_true :=
forall (H : (3 < 4)), ((2 + 3 = 5) /\\ (7 <> 8)).
Definition symbolic :=
forall (x : Z), (x = x).
Definition heap_goal := emp |-- emp.
"""
        self.assertIs(_closed_generated_goal_value(goals, "closed_false"), False)
        self.assertIs(_closed_generated_goal_value(goals, "vacuous_true"), True)
        self.assertIs(_closed_generated_goal_value(goals, "closed_true"), True)
        self.assertIsNone(_closed_generated_goal_value(goals, "symbolic"))
        self.assertIsNone(_closed_generated_goal_value(goals, "heap_goal"))

    def test_proof_checker_prefers_the_active_coqc_over_an_opam_switch_name(
        self,
    ) -> None:
        with patch(
            "spectest.core.shutil.which",
            side_effect=lambda name: {
                "coqc": "/opt/coq/bin/coqc",
                "opam": "/usr/local/bin/opam",
            }.get(name),
        ):
            self.assertEqual(
                _default_coqc_command(),
                ["/opt/coq/bin/coqc"],
            )

    def test_concrete_automation_has_no_regression_case_names(self) -> None:
        sources = (
            ROOT / "spectest/core.py",
            QCP_SOURCE / "SymExec/SymExec/ConcreteNormalize.c",
            QCP_SOURCE / "SymExec/CoqPrint/CoqSacEntailmentPrinter.c",
        )
        text = "\n".join(
            source.read_text(encoding="utf-8") for source in sources if source.is_file()
        )
        for forbidden in (
            "array_increment",
            "array_sum",
            "array_remove_value_to_output",
            "bubble_sort",
            "merge_sorted_arrays",
            "string_remove_char_to_output",
            "two_sum_sorted",
        ):
            with self.subTest(name=forbidden):
                self.assertNotIn(forbidden, text)

    def test_core_has_no_secondary_coq_auto(self) -> None:
        sources = (
            ROOT / "spectest/core.py",
            ROOT / "scripts/run-cav-memory-suite.py",
        )
        text = "\n".join(source.read_text(encoding="utf-8") for source in sources)
        for forbidden in (
            "coq_auto",
            "proof_coq_auto",
            "bounded_coq",
        ):
            with self.subTest(name=forbidden):
                self.assertNotIn(forbidden, text)

    def test_case_local_coq_imports_support_direct_and_from_syntax(self) -> None:
        source = """
/*@ Import Coq Require Import Domain.Direct */
/*@ Import Coq From Domain.Nested Require Import First Second */
"""
        self.assertEqual(
            _source_coq_imports(source),
            [
                "Domain.Direct",
                "Domain.Nested.First",
                "Domain.Nested.Second",
            ],
        )
        self.assertEqual(
            _coq_required_modules(
                """
Require Import Coq.ZArith.ZArith.
From Domain.Nested Require Import First Second.
"""
            ),
            [
                "Coq.ZArith.ZArith",
                "Domain.Nested.First",
                "Domain.Nested.Second",
            ],
        )

    def test_case_local_coq_module_wins_over_shared_module(self) -> None:
        with tempfile.TemporaryDirectory(prefix="qcp-case-dependency-") as temp:
            case = Path(temp) / "case"
            source = case / "source" / "subject.c"
            module = case / "dependencies/coq/SimpleC/EE/QCP_demos_LLM/swap_lib.v"
            source.parent.mkdir(parents=True)
            module.parent.mkdir(parents=True)
            source.write_text("void subject(void) {}", encoding="utf-8")
            module.write_text("Definition local := 1.", encoding="utf-8")
            resolved = _resolve_source_coq_module(
                "SimpleC.EE.QCP_demos_LLM.swap_lib",
                source,
                bundled_qcip_root(),
            )
            self.assertEqual(resolved, module.resolve())

    def test_rejects_missing_binding(self) -> None:
        with self.assertRaisesRegex(JobError, "missing With bindings"):
            specialize_source(self.source, "sll_first_value", {"x": "1"})

    def test_rejects_comment_injection(self) -> None:
        with self.assertRaisesRegex(JobError, "forbidden syntax"):
            specialize_source(
                self.source,
                "sll_first_value",
                {"x": "1 */ Ensure emp /*", "xs": "nil"},
            )

    def test_accepts_friendly_integer_and_list_values(self) -> None:
        specialized = specialize_source(
            self.source,
            "sll_first_value",
            {"x": 1, "xs": [2, 3]},
        )
        self.assertIn("(x == (1))", specialized)
        self.assertIn("(xs == (cons(2, cons(3, nil))))", specialized)

    def test_builds_large_repeat_bindings_without_quadratic_concatenation(
        self,
    ) -> None:
        source = """
void scan(void)
/*@ With (xs: list Z)
    Require emp
    Ensure emp
*/
{
}
"""
        specialized = specialize_source(
            source,
            "scan",
            {"xs": {"repeat": 7, "count": 5000}},
        )
        self.assertEqual(specialized.count("cons(7, "), 5000)
        self.assertIn("cons(7, nil)", specialized)

    def test_rejects_prefixed_axioms_and_variable_proof_escapes(self) -> None:
        for source in (
            "Local Axiom unsound : False.",
            "Global Conjecture unsound : False.",
            "Variable unsound : False.",
            "Context (unsound : False).",
        ):
            with self.subTest(source=source):
                self.assertIsNotNone(_FORBIDDEN_MANUAL_PROOF.search(source))

    def test_rejects_duplicate_bind_case_ids_before_writing_output(self) -> None:
        with tempfile.TemporaryDirectory(prefix="qcp-duplicate-id-") as temp:
            root = Path(temp)
            output = root / "output"
            job = root / "job.json"
            job.write_text(
                json.dumps(
                    {
                        "source": str(ROOT / "cases/add_one/add_one.c"),
                        "function": "add_one",
                        "binds": [
                            {
                                "id": "same",
                                "args": {"x": 1},
                                "values": {"v": 1},
                            },
                            {
                                "id": "same",
                                "args": {"x": 2},
                                "values": {"v": 2},
                            },
                        ],
                    }
                ),
                encoding="utf-8",
            )
            with self.assertRaisesRegex(JobError, "duplicate bind case id"):
                run_job(job, output)
            self.assertFalse(output.exists())

    def test_rerun_does_not_reuse_stale_vc_files(self) -> None:
        with tempfile.TemporaryDirectory(prefix="qcp-stale-vc-") as temp:
            root = Path(temp)
            output = root / "output"
            case_dir = output / "small"
            stale_vc = case_dir / "vc"
            stale_vc.mkdir(parents=True)
            stale_marker = stale_vc / "old-proof.v"
            stale_marker.write_text("stale", encoding="utf-8")

            job = root / "job.json"
            job.write_text(
                json.dumps(
                    {
                        "source": str(ROOT / "cases/add_one/add_one.c"),
                        "function": "add_one",
                        "binds": [
                            {
                                "id": "small",
                                "args": {"x": 1},
                                "values": {"v": 1},
                            }
                        ],
                    }
                ),
                encoding="utf-8",
            )
            completed = subprocess.CompletedProcess([], 0, "", "")
            with patch("spectest.core.subprocess.run", return_value=completed):
                report = run_job(job, output)

            self.assertEqual(report["results"][0]["reason"], "qcp_vc_generation_error")
            self.assertFalse(stale_marker.exists())

    def test_materializes_closed_derived_list_length(self) -> None:
        source = """
void scan(char *text)
/*@ With (contents: list Z) (n: Z)
    Require Zlength(contents) == n && emp
    Ensure emp
*/
{
}
"""
        specialized = specialize_source(
            source,
            "scan",
            {"contents": [65, 66, 67]},
            argument_bindings={"text": 4096},
        )
        self.assertIn("(contents == (cons(65, cons(66, cons(67, nil)))))", specialized)
        self.assertIn("(n == (3))", specialized)

    def test_analyzes_required_bindings(self) -> None:
        analysis = analyze_source(self.source, "sll_first_value")
        self.assertTrue(analysis["supported"])
        self.assertEqual(
            [
                (item["name"], item["declaration"], item["required"])
                for item in analysis["argument_bindings"]
            ],
            [("p", "struct list *p", True)],
        )
        self.assertEqual(
            [(item["name"], item["type"]) for item in analysis["value_bindings"]],
            [("x", "Z"), ("xs", "list Z")],
        )
        self.assertEqual(
            analysis["binds_template"][0]["values"],
            {"x": 0, "xs": [1, 2, 3]},
        )
        self.assertEqual(analysis["binds_template"][0]["args"], {"p": 4096})

    def test_declared_signature_wins_over_nested_list_heuristic(self) -> None:
        source = """
/*@ Extern Coq
      (point :: *)
      (mk_point : Z -> Z -> point)
      (UsesPoints : list point -> Prop)
 */
void sort_like(int n)
/*@ With (pts: list point) gx gy
    Require UsesPoints(cons(mk_point(gx, gy), pts)) && n == 0 && emp
    Ensure emp
 */
{
}
"""
        analysis = analyze_source(source, "sort_like")
        self.assertEqual(
            [(item["name"], item["type"]) for item in analysis["value_bindings"]],
            [("pts", "list point"), ("gx", "Z"), ("gy", "Z")],
        )

    def test_requires_every_top_level_c_argument_when_args_are_enabled(self) -> None:
        with self.assertRaisesRegex(JobError, "missing C argument bindings: p"):
            specialize_source(
                self.source,
                "sll_first_value",
                {"x": 1, "xs": [2, 3]},
                argument_bindings={},
            )
        with self.assertRaisesRegex(
            JobError, "bindings not declared as C parameters: extra"
        ):
            specialize_source(
                self.source,
                "sll_first_value",
                {"x": 1, "xs": [2, 3]},
                argument_bindings={"p": 4096, "extra": 0},
            )

    def test_supports_named_derived_declare_and_polymorphic_specs(self) -> None:
        source = """
int sample(int *p)
/*@ base
    Declare (a: (int)[n])
    With {A :: *} (n: Z) (xs: list Z)
    Require (forall (i: Z), 0 <= i && i < n => Znth(i, xs, 0) >= 0) &&
            data_at(p, int, n)
    Ensure exists old, old == n && data_at(p@pre, int, old)
*/
/*@ concrete <= base
    With (n: Z) (xs: list Z)
    Require n >= 0 && data_at(p, int, n)
    Ensure __return == n && data_at(p@pre, int, n)
*/
{
    return *p;
}
"""
        analysis = analyze_source(source, "sample", "concrete")
        self.assertTrue(analysis["supported"])
        self.assertEqual(analysis["derived_by"], "base")
        self.assertEqual(
            [(item["name"], item["type"]) for item in analysis["value_bindings"]],
            [("n", "Z"), ("xs", "list Z")],
        )
        catalog = analyze_catalog(source)
        self.assertEqual(catalog["function_count"], 1)
        self.assertEqual(catalog["spec_count"], 2)

    def test_supports_specs_without_with(self) -> None:
        source = """
int identity(int x)
/*@ Require emp
    Ensure __return == x@pre && emp */
{
    return x;
}
"""
        analysis = analyze_source(source, "identity")
        self.assertEqual(
            [item["name"] for item in analysis["argument_bindings"]], ["x"]
        )
        self.assertEqual(analysis["value_bindings"], [])
        specialized = specialize_source(
            source, "identity", {}, argument_bindings={"x": -7}
        )
        self.assertIn("(x == (-7))", specialized)

    def test_only_derives_logic_values_not_unbound_program_inputs(self) -> None:
        source = """
int sample(int n)
/*@ With (N: Z) (alias: Z) (fixed: Z)
    Require n == N && alias == N && fixed == 3 && emp
    Ensure __return == N && emp
*/
{
    return n;
}
"""
        analysis = analyze_source(source, "sample")
        variables = {item["name"]: item for item in analysis["value_bindings"]}
        self.assertTrue(variables["N"]["required"])
        self.assertFalse(variables["alias"]["required"])
        self.assertEqual(variables["alias"]["derived_from"], "N")
        self.assertFalse(variables["fixed"]["required"])
        self.assertEqual(variables["fixed"]["derived_from"], "3")
        self.assertEqual(analysis["binds_template"][0]["values"], {"N": 0})

    def test_raw_qcp_binding_preserves_supported_assertion_syntax(self) -> None:
        specialized = specialize_source(
            self.source,
            "sll_first_value",
            {
                "x": {"qcp": "#some_logic_name"},
                "xs": {"type": "list Z", "value": [1, -2]},
            },
        )
        self.assertIn("(x == (#some_logic_name))", specialized)
        self.assertIn("(xs == (cons(1, cons(-2, nil))))", specialized)

    def test_repeat_binding_expands_to_a_concrete_list(self) -> None:
        specialized = specialize_source(
            self.source,
            "sll_first_value",
            {
                "x": 7,
                "xs": {"repeat": -2, "count": 3},
            },
        )
        self.assertIn(
            "(xs == (cons(-2, cons(-2, cons(-2, nil)))))",
            specialized,
        )

    def test_symbolic_binding_keeps_large_heap_contents_abstract(self) -> None:
        specialized = specialize_source(
            self.source,
            "sll_first_value",
            {
                "x": 7,
                "xs": {"symbolic": True},
            },
        )
        self.assertIn("(x == (7))", specialized)
        self.assertNotIn("(xs ==", specialized)
        self.assertIn("sll(p, cons(x, xs))", specialized)

    def test_arbitrary_coq_values_use_generic_constructor_trees(self) -> None:
        source = """
/*@ Extern Coq (addr_tree :: *)
                 (empty_tree : addr_tree)
                 (tree_node : Z -> addr_tree -> addr_tree -> addr_tree) */
int root_value(int fallback)
/*@ With (tree: addr_tree)
    Require tree == tree_node(7, empty_tree, empty_tree) && emp
    Ensure __return == fallback@pre &&
           tree == tree_node(7, empty_tree, empty_tree) && emp */
{
    return fallback;
}
"""
        specialized = specialize_source(
            source,
            "root_value",
            {
                "tree": {
                    "type": "addr_tree",
                    "value": {
                        "ctor": "tree_node",
                        "args": [
                            7,
                            {"ctor": "empty_tree"},
                            {"ctor": "empty_tree"},
                        ],
                    },
                }
            },
        )
        self.assertIn(
            "(tree == (tree_node(7, empty_tree, empty_tree)))",
            specialized,
        )

    def test_polymorphic_with_type_can_be_instantiated(self) -> None:
        source = """
/*@ Extern Coq (option :: * => *)
                 (Some: {A} -> A -> option A)
                 (None: {A} -> option A) */
int keep(int n)
/*@ With {A :: *} (value: A)
    Require emp
    Ensure __return == n@pre && emp */
{
    return n;
}
"""
        specialized = specialize_source(
            source,
            "keep",
            {
                "value": {
                    "ctor": "Some",
                    "type_args": ["Z"],
                    "args": [9],
                }
            },
            type_bindings={"A": "option Z"},
        )
        self.assertNotIn("{A :: *}", specialized)
        self.assertIn("(value: option Z)", specialized)
        self.assertIn("(value == (Some(9)))", specialized)

    def test_xizi_include_signatures_infer_non_list_coq_types(self) -> None:
        source_path = (
            EXTERNAL_QCIP
            / "OUTPUT/xizi/xizi_avl_left_rotate/source/xizi_avl_left_rotate.c"
        )
        if not source_path.is_file():
            self.skipTest("xizi AVL output is unavailable")
        source = source_path.read_text(encoding="utf-8")
        signatures = source_with_local_includes(source_path, primary_source=source)
        analysis = analyze_source(
            source,
            "xizi_avl_left_rotate",
            signature_source=signatures,
        )
        types = {item["name"]: item["type"] for item in analysis["value_bindings"]}
        self.assertEqual(types["root_data"], "Z")
        self.assertEqual(types["a"], "addr_avl_tree")
        self.assertEqual(types["before"], "addr_avl_tree")

    @unittest.skipUnless(
        (QCIP / "QCP_examples/QCP_demos_LLM").is_dir(),
        "QCIP examples are unavailable",
    )
    def test_catalogs_every_qcip_demo_source(self) -> None:
        demo_root = QCIP / "QCP_examples/QCP_demos_LLM"
        sources = sorted(demo_root.rglob("*.c"))
        total_specs = 0
        for source_path in sources:
            with self.subTest(source=source_path.name):
                catalog = analyze_catalog(source_path.read_text(encoding="utf-8"))
                self.assertTrue(catalog["supported"])
                total_specs += catalog["spec_count"]
        self.assertGreaterEqual(len(sources), 40)
        self.assertGreaterEqual(total_specs, 170)


@unittest.skipUnless(LOCAL_QCP.is_file(), "local QCP binary is unavailable")
class EndToEndTests(unittest.TestCase):
    def _run(self, relative_job: str) -> dict:
        job_path = ROOT / relative_job
        with tempfile.TemporaryDirectory(prefix="qcp-spectest-test-") as temp:
            return run_job(job_path, Path(temp))

    def test_correct_linked_list_spec_passes(self) -> None:
        report = self._run("cases/sll_first_value/job.json")
        self.assertEqual(report["summary"]["PASS"], 2)
        self.assertEqual(report["summary"]["total"], 2)

    def test_wrong_postcondition_fails(self) -> None:
        report = self._run("cases/sll_first_value_wrong/job.json")
        self.assertEqual(report["results"][0]["status"], "FAIL")
        self.assertFalse(report["results"][0]["satisfied"])

    def test_scalar_and_heap_examples_pass(self) -> None:
        for relative_job in (
            "cases/add_one/job.json",
            "cases/read_cell/job.json",
            "cases/increment_cell/job.json",
        ):
            with self.subTest(job=relative_job):
                report = self._run(relative_job)
                self.assertEqual(report["summary"]["PASS"], report["summary"]["total"])


@unittest.skipUnless(LOCAL_QCP.is_file(), "local concrete QCP binary is unavailable")
class ConcreteLoopEndToEndTests(unittest.TestCase):
    def _run(self, relative_job: str) -> dict:
        job_path = ROOT / relative_job
        with tempfile.TemporaryDirectory(prefix="qcp-spectest-loop-test-") as temp:
            return run_job(job_path, Path(temp))

    def _assert_manual_residual(self, result: dict) -> None:
        self.assertEqual(result["status"], "UNKNOWN")
        self.assertEqual(result["reason"], "residual_vc_requires_proof")
        self.assertEqual(result["vc"]["status"], "residual")
        self.assertNotIn("automatic_concrete_proof", result["vc"])
        self.assertNotIn("automatic_concrete_refutation", result["vc"])

    def test_concrete_loops_need_no_invariant(self) -> None:
        for relative_job in (
            "cases/count_loop/job.json",
            "cases/count_for/job.json",
            "cases/count_do_while/job.json",
            "cases/nested_loop/job.json",
            "cases/sll_length_loop/job.json",
        ):
            with self.subTest(job=relative_job):
                report = self._run(relative_job)
                self.assertEqual(report["summary"]["PASS"], report["summary"]["total"])

    def test_uchar_checksum_loop_ignores_source_invariant(self) -> None:
        report = self._run("cases/ip_check_cal08/job.json")
        self.assertEqual(report["summary"]["UNKNOWN"], 3)
        for result in report["results"]:
            with self.subTest(case=result["id"]):
                self._assert_manual_residual(result)
                self.assertTrue(
                    all(
                        "CheckCal08Inv" not in goal
                        for goal in result["vc"]["residual_goals"]
                    )
                )

    def test_closed_fp64_branches_preserve_facts_and_prove_post(self) -> None:
        report = self._run("cases/double_clamp/job.json")
        self.assertEqual(report["summary"]["UNKNOWN"], 5)
        self.assertEqual(report["summary"]["total"], 5)
        for result in report["results"]:
            with self.subTest(case=result["id"]):
                self._assert_manual_residual(result)

    def test_float_arithmetic_signed_zero_and_struct_store(self) -> None:
        division = self._run("cases/float_operations/job_float_div.json")
        self.assertEqual(division["summary"]["UNKNOWN"], 3)
        self.assertEqual(division["summary"]["ERROR"], 1)
        invalid = next(
            item for item in division["results"] if item["id"] == "zero_divisor_invalid"
        )
        self.assertEqual(invalid["reason"], "bindings_violate_require")
        for result in division["results"]:
            if result["id"] != "zero_divisor_invalid":
                self._assert_manual_residual(result)

        equality = self._run("cases/float_operations/job_double_eq_branch.json")
        self.assertEqual(equality["summary"]["UNKNOWN"], 3)
        self.assertEqual(equality["summary"]["total"], 3)
        for result in equality["results"]:
            self._assert_manual_residual(result)

        struct_store = self._run("cases/float_store/job_struct.json")
        self.assertEqual(struct_store["summary"]["UNKNOWN"], 2)
        self.assertEqual(struct_store["summary"]["total"], 2)
        for result in struct_store["results"]:
            self._assert_manual_residual(result)

    def test_cav_arrays_loops_early_return_and_sll(self) -> None:
        for relative_job in (
            "cases/cav_more/job_double_nonnegative.json",
            "cases/cav_more/job_array_reverse_in_place.json",
            "cases/cav_more/job_prefix_sum.json",
            "cases/cav_more/job_array_move_zeroes_to_end.json",
            "cases/cav_more/job_p003_below_zero.json",
            "cases/cav_more/job_p005_intersperse.json",
            "cases/cav_more/job_sll_head.json",
        ):
            with self.subTest(job=relative_job):
                report = self._run(relative_job)
                self.assertEqual(report["summary"]["FAIL"], 0)
                self.assertEqual(report["summary"]["ERROR"], 0)
                self.assertEqual(
                    report["summary"]["PASS"] + report["summary"]["UNKNOWN"],
                    report["summary"]["total"],
                )

    def test_wrong_loop_postcondition_fails(self) -> None:
        report = self._run("cases/count_loop_wrong/job.json")
        self.assertEqual(report["results"][0]["status"], "FAIL")
        self.assertFalse(report["results"][0]["satisfied"])

    def test_loop_limit_is_unknown_not_pass(self) -> None:
        report = self._run("cases/count_loop/job_limit.json")
        self.assertEqual(report["results"][0]["status"], "UNKNOWN")
        self.assertEqual(report["results"][0]["reason"], "loop_unroll_limit_exceeded")

    def test_callee_arguments_and_heap_are_bound_at_call_time(self) -> None:
        for relative_job in (
            "cases/callee_loop/job.json",
            "cases/callee_heap/job.json",
            "cases/callee_ignores_spec/job.json",
            "cases/callee_switch/job.json",
            "cases/callee_recursive/job.json",
        ):
            with self.subTest(job=relative_job):
                report = self._run(relative_job)
                self.assertEqual(report["summary"]["FAIL"], 0)
                self.assertEqual(report["summary"]["ERROR"], 0)
                self.assertEqual(
                    report["summary"]["PASS"] + report["summary"]["UNKNOWN"],
                    report["summary"]["total"],
                )

    def test_defined_separation_predicate_is_executed_by_definition(self) -> None:
        report = self._run("cases/generic_predicate/job.json")
        self.assertEqual(report["summary"]["PASS"], 1)

    def test_arbitrary_coq_type_constructor_binding_executes(self) -> None:
        report = self._run("cases/arbitrary_type/job.json")
        self.assertEqual(report["summary"]["PASS"], 1)

    def test_polymorphic_type_binding_executes_after_instantiation(self) -> None:
        report = self._run("cases/polymorphic_type/job.json")
        self.assertEqual(report["summary"]["PASS"], 1)

    def test_xizi_custom_single_link_layout_executes(self) -> None:
        report = self._run("cases/xizi_single_link_empty/job.json")
        self.assertEqual(report["summary"]["FAIL"], 0)
        self.assertEqual(report["summary"]["ERROR"], 0)
        self.assertEqual(report["results"][0]["status"], "PASS")
        self.assertIn(report["results"][1]["status"], {"PASS", "UNKNOWN"})

    def test_xizi_custom_double_link_layout_executes(self) -> None:
        report = self._run("cases/xizi_double_link_empty/job.json")
        self.assertEqual(report["summary"]["FAIL"], 0)
        self.assertEqual(report["summary"]["ERROR"], 0)
        self.assertEqual(report["summary"]["PASS"] + report["summary"]["UNKNOWN"], 2)

    def test_recursive_sll_nodes_can_contain_struct_arrays(self) -> None:
        report = self._run("cases/composite_recursive_sll/job.json")
        self.assertEqual(report["summary"]["PASS"], 2)

    def test_dll_nodes_with_struct_arrays_cross_loops_and_callees(self) -> None:
        report = self._run("cases/composite_loop_dll/job.json")
        self.assertEqual(report["summary"]["PASS"], 2)

    def test_recursive_sll_and_dll_compose_inside_closed_struct(self) -> None:
        report = self._run("cases/composite_recursive_bundle/job.json")
        self.assertEqual(report["summary"]["PASS"], 2)

    def test_recursive_predicates_can_nest_and_compose_arrays(self) -> None:
        report = self._run("cases/recursive_nested_composition/job.json")
        self.assertEqual(
            [result["status"] for result in report["results"]],
            ["PASS", "PASS", "UNKNOWN"],
        )

    def test_arrays_of_closed_structs_can_contain_arrays(self) -> None:
        report = self._run("cases/closed_struct_array/job.json")
        self.assertEqual(report["summary"]["PASS"], 2)

    def test_concrete_output_list_witness_is_a_manual_residual(self) -> None:
        report = self._run("cases/ip_thruster_ctrl_logic/job.json")
        self.assertEqual(report["summary"]["UNKNOWN"], 3)
        for result in report["results"]:
            with self.subTest(case=result["id"]):
                self._assert_manual_residual(result)

    def test_concrete_callees_compose_with_external_spec_call(self) -> None:
        report = self._run("cases/ip_jet_ctrl_send/job.json")
        self.assertEqual(report["summary"]["UNKNOWN"], 3)
        for result in report["results"]:
            with self.subTest(case=result["id"]):
                self._assert_manual_residual(result)

    def test_binding_that_contradicts_require_is_rejected(self) -> None:
        report = self._run("cases/invalid_binding/job.json")
        self.assertEqual(report["results"][0]["status"], "ERROR")
        self.assertEqual(report["results"][0]["reason"], "bindings_violate_require")

    def test_closed_znth_safety_vc_is_classified_as_auto(self) -> None:
        job = ROOT / "cases/znth_concrete_auto/job.json"
        with tempfile.TemporaryDirectory(prefix="qcp-spectest-znth-test-") as temp:
            report = run_job(job, Path(temp))
            self.assertEqual(report["summary"]["PASS"], 4)
            for result in report["results"]:
                with self.subTest(case=result["id"]):
                    self.assertEqual(result["vc"]["status"], "auto_proved")

                    files = result["vc"]["files"]
                    proof_auto = Path(files["proof_auto"]).read_text(encoding="utf-8")
                    proof_manual = Path(files["proof_manual"]).read_text(
                        encoding="utf-8"
                    )
                    self.assertIn("proof_of_square_first_safety_wit_", proof_auto)
                    self.assertNotIn("proof_of_square_first_safety_wit_", proof_manual)

    def test_call_depth_limit_is_unknown_not_pass(self) -> None:
        report = self._run("cases/callee_recursive/job_limit.json")
        self.assertEqual(report["results"][0]["status"], "UNKNOWN")
        self.assertEqual(report["results"][0]["reason"], "call_depth_limit_exceeded")


if __name__ == "__main__":
    unittest.main()
