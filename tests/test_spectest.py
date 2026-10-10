from __future__ import annotations

import json
import os
import re
import subprocess
import sys
import tempfile
import unittest
from pathlib import Path
from unittest.mock import patch

from spectest.core import (
    _FORBIDDEN_MANUAL_PROOF,
    JobError,
    attach_spec_to_source,
    _executor_result,
    _relocate_strategy_includes,
    _coq_required_modules,
    _default_coqc_command,
    _qcp_command,
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
LOCAL_QCP = bundled_qcp_binary()


class SpecializationTests(unittest.TestCase):
    def test_instance_trace_option_is_typed_and_opt_in(self):
        self.assertFalse(_parse_qcp_config({}, ROOT, ROOT).instance_trace)
        self.assertTrue(
            _parse_qcp_config(
                {"qcp": {"instance_trace": True}}, ROOT, ROOT
            ).instance_trace
        )
        with self.assertRaises(JobError):
            _parse_qcp_config({"qcp": {"instance_trace": "false"}}, ROOT, ROOT)

    def test_legacy_executor_cannot_claim_initial_sat(self):
        result = _executor_result(
            json.dumps({"verificationStatus": "proved"}),
            0,
            {"status": "auto_proved", "residual_goals": []},
        )
        self.assertEqual(result["status"], "UNKNOWN")
        self.assertEqual(result["phases"]["precondition"], "NOT_CHECKED")
        self.assertEqual(result["reason"], "legacy_executor_missing_test_semantics")

    def test_natural_language_success_is_not_a_verdict(self):
        result = _executor_result(
            "Successfully finished full automation check",
            0,
            {"status": "auto_proved", "residual_goals": []},
        )
        self.assertEqual(result["status"], "ERROR")
        self.assertEqual(result["reason"], "invalid_executor_json")

    def test_relative_strategy_import_survives_source_relocation(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            (root / "src").mkdir()
            strategy = root / "rules.strategies"
            strategy.write_text("/* domain rules */")
            source = '/*@ include strategies "../rules.strategies" */\nvoid f(void) {}'
            relocated = _relocate_strategy_includes(source, root / "src" / "case.c")
            self.assertIn(str(strategy), relocated)
            self.assertIn("void f(void) {}", relocated)

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

    def test_no_expand_mode_uses_ordinary_qcp_vcs(self) -> None:
        config = _parse_qcp_config({"qcp": {"execution_mode": "no-expand"}}, ROOT, ROOT)
        command = _qcp_command(
            config, ROOT / "generated.c", "sample", None, ROOT / "vc"
        )
        self.assertIn("--spec-test-no-expand", command)
        self.assertNotIn("--concrete-bindings", command)
        self.assertNotIn("--loop-unroll-limit", command)

    def test_no_expand_mode_passes_execution_budget(self) -> None:
        config = _parse_qcp_config(
            {"qcp": {"execution_mode": "no-expand", "loop_unroll_limit": 8}}, ROOT, ROOT
        )
        command = _qcp_command(
            config, ROOT / "generated.c", "sample", None, ROOT / "vc"
        )
        self.assertEqual(command[command.index("--loop-unroll-limit") + 1], "8")

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

    def test_attaches_a_separate_spec_without_model_rewriting(self) -> None:
        annotated = (ROOT / "cases/add_one/add_one.c").read_text(encoding="utf-8")
        match = re.search(r"/\*@(?P<body>.*?)\*/", annotated, re.DOTALL)
        assert match is not None
        implementation = annotated[: match.start()] + annotated[match.end() :]
        combined = attach_spec_to_source(
            implementation,
            match.group("body"),
            "add_one",
        )
        analysis = analyze_source(combined, "add_one")
        self.assertEqual(
            [item["name"] for item in analysis["argument_bindings"]],
            ["x"],
        )
        self.assertEqual(
            [item["name"] for item in analysis["value_bindings"]],
            ["v"],
        )

    def test_separate_spec_file_runs_with_model_written_binds_only(self) -> None:
        annotated = (ROOT / "cases/add_one/add_one.c").read_text(encoding="utf-8")
        match = re.search(r"/\*@(?P<body>.*?)\*/", annotated, re.DOTALL)
        assert match is not None
        implementation = annotated[: match.start()] + annotated[match.end() :]
        with tempfile.TemporaryDirectory(prefix="qcp-separate-spec-") as temp:
            root = Path(temp)
            impl_path = root / "impl.c"
            spec_path = root / "spec.qcp"
            job_path = root / "job.json"
            impl_path.write_text(implementation, encoding="utf-8")
            spec_path.write_text(match.group("body"), encoding="utf-8")
            job_path.write_text(
                json.dumps(
                    {
                        "source": "impl.c",
                        "spec_file": "spec.qcp",
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
            report = run_job(job_path, root / "output")
            self.assertEqual(report["summary"]["PASS"], 1)
            self.assertEqual(report["spec_file"], str(spec_path))

    def test_cli_accepts_impl_spec_and_only_a_binds_edit(self) -> None:
        annotated = (ROOT / "cases/add_one/add_one.c").read_text(encoding="utf-8")
        match = re.search(r"/\*@(?P<body>.*?)\*/", annotated, re.DOTALL)
        assert match is not None
        implementation = annotated[: match.start()] + annotated[match.end() :]
        with tempfile.TemporaryDirectory(prefix="qcp-separate-spec-cli-") as temp:
            root = Path(temp)
            impl_path = root / "impl.c"
            spec_path = root / "spec.qcp"
            binds_path = root / "binds.json"
            output_path = root / "output"
            impl_path.write_text(implementation, encoding="utf-8")
            spec_path.write_text(match.group("body"), encoding="utf-8")

            analyze = subprocess.run(
                [
                    sys.executable,
                    "-m",
                    "spectest",
                    "analyze",
                    str(impl_path),
                    "--spec-file",
                    str(spec_path),
                    "--function",
                    "add_one",
                    "--write-binds",
                    str(binds_path),
                ],
                cwd=ROOT,
                text=True,
                capture_output=True,
                check=False,
            )
            self.assertEqual(analyze.returncode, 0, analyze.stderr)
            template = json.loads(binds_path.read_text(encoding="utf-8"))
            self.assertEqual(set(template[0]["args"]), {"x"})
            self.assertEqual(set(template[0]["values"]), {"v"})

            # This is the sole model-authored artifact in the tool workflow.
            binds_path.write_text(
                json.dumps(
                    [
                        {
                            "id": "boundary",
                            "args": {"x": 2147483646},
                            "values": {"v": 2147483646},
                        }
                    ]
                ),
                encoding="utf-8",
            )
            run = subprocess.run(
                [
                    sys.executable,
                    "-m",
                    "spectest",
                    "run",
                    str(impl_path),
                    "--spec-file",
                    str(spec_path),
                    "--function",
                    "add_one",
                    "--binds",
                    str(binds_path),
                    "--output-dir",
                    str(output_path),
                ],
                cwd=ROOT,
                text=True,
                capture_output=True,
                check=False,
            )
            self.assertEqual(run.returncode, 0, run.stderr)
            report = json.loads((output_path / "report.json").read_text())
            self.assertEqual(report["summary"]["PASS"], 1)

    def test_separate_spec_rejects_an_already_annotated_function(self) -> None:
        annotated = (ROOT / "cases/add_one/add_one.c").read_text(encoding="utf-8")
        with self.assertRaisesRegex(JobError, "already has a full QCP spec"):
            attach_spec_to_source(
                annotated,
                "With (v: Z) Require x == v Ensure __return == v + 1",
                "add_one",
            )

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

    def test_partial_logic_binding_is_accepted(self) -> None:
        specialized = specialize_source(self.source, "sll_first_value", {"x": "1"})
        self.assertIn("(x == (1))", specialized)
        self.assertNotIn("(xs ==", specialized)

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
            case_dir = output / "artifacts" / "small"
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
            with patch(
                "spectest.core._run_measured", return_value=(completed, None, None)
            ):
                report = run_job(job, output)

            self.assertEqual(report["results"][0]["reason"], "invalid_executor_json")
            self.assertIn("duration_seconds", report["results"][0])
            self.assertIn("peak_rss_kb", report["results"][0])
            self.assertIn("peak_rss_kb", report["summary"])
            self.assertFalse(stale_marker.exists())

    def test_leaves_derived_length_to_shared_executor_normalizer(self) -> None:
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
        self.assertNotIn("(n == (3))", specialized)
        self.assertIn("Zlength(contents) == n", specialized)

    def test_analyzes_required_bindings(self) -> None:
        analysis = analyze_source(self.source, "sll_first_value")
        self.assertTrue(analysis["supported"])
        self.assertEqual(
            [
                (item["name"], item["declaration"], item["required"])
                for item in analysis["argument_bindings"]
            ],
            [("p", "struct list *p", False)],
        )
        self.assertEqual(
            [(item["name"], item["type"]) for item in analysis["value_bindings"]],
            [("x", "Z"), ("xs", "list Z")],
        )
        self.assertEqual(
            analysis["binds_template"][0]["values"],
            {"x": 0, "xs": [1, 2, 3]},
        )
        self.assertEqual(
            analysis["binds_template"][0]["args"], {"p": {"symbolic": True}}
        )

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

    def test_pointer_arguments_can_remain_symbolic(self) -> None:
        for arguments in ({}, {"p": {"symbolic": True}}):
            specialized = specialize_source(
                self.source,
                "sll_first_value",
                {"x": 1, "xs": [2, 3]},
                argument_bindings=arguments,
            )
            self.assertNotIn("(p == (", specialized)
        analysis = analyze_source(self.source, "sll_first_value")
        self.assertFalse(analysis["argument_bindings"][0]["required"])
        self.assertEqual(analysis["binds_template"][0]["args"]["p"], {"symbolic": True})
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

    def test_include_signatures_infer_non_list_coq_types(self) -> None:
        # Generated external OUTPUT/ files change with proof sessions. Keep
        # this include/type-inference contract independent of those outputs.
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            (root / "tree.h").write_text(
                "/*@ Extern Coq (addr_avl_tree :: *)\n"
                " (node : Z -> addr_avl_tree -> addr_avl_tree -> addr_avl_tree)\n"
                " (tree_store : Z -> addr_avl_tree -> Assertion) */\n"
            )
            source = """#include "tree.h"
int sample(int *p)
/*@ With root_data a b before
    Require before == node(root_data,a,b) && tree_store(p,before)
    Ensure tree_store(p,before) */;
"""
            source_path = root / "sample.c"
            source_path.write_text(source)
            signatures = source_with_local_includes(source_path, primary_source=source)
            analysis = analyze_source(source, "sample", signature_source=signatures)
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

    def test_opaque_list_requires_existence_proof(self) -> None:
        report = self._run("cases/sll_first_value/job.json")
        self.assertEqual(report["summary"]["UNKNOWN"], 2)
        self.assertEqual(report["summary"]["total"], 2)
        for result in report["results"]:
            self.assertEqual(result["phases"]["precondition"], "UNKNOWN")
            self.assertEqual(result["phases"]["postcondition"], "PASS")

    def test_wrong_postcondition_retains_unproved_vc(self) -> None:
        report = self._run("cases/sll_first_value_wrong/job.json")
        self.assertEqual(report["results"][0]["status"], "UNKNOWN")
        self.assertIsNone(report["results"][0]["satisfied"])
        self.assertTrue(report["results"][0]["vc"]["residual_goals"])

    def test_scalar_and_heap_examples_pass(self) -> None:
        for relative_job in (
            "cases/add_one/job.json",
            "cases/read_cell/job.json",
            "cases/increment_cell/job.json",
        ):
            with self.subTest(job=relative_job):
                report = self._run(relative_job)
                self.assertEqual(report["summary"]["PASS"], report["summary"]["total"])
                self.assertEqual(report["itp_vcs"], [])


@unittest.skipUnless(LOCAL_QCP.is_file(), "local concrete QCP binary is unavailable")
class ConcreteLoopEndToEndTests(unittest.TestCase):
    def _run(self, relative_job: str) -> dict:
        job_path = ROOT / relative_job
        with tempfile.TemporaryDirectory(prefix="qcp-spectest-loop-test-") as temp:
            return run_job(job_path, Path(temp))

    def _assert_manual_residual(self, result: dict) -> None:
        self.assertEqual(result["status"], "UNKNOWN")
        self.assertIn(
            result["reason"],
            {"residual_vc_requires_proof", "precondition_requires_proof"},
        )
        self.assertEqual(result["vc"]["status"], "residual")
        self.assertNotIn("automatic_concrete_proof", result["vc"])
        self.assertNotIn("automatic_concrete_refutation", result["vc"])

    def test_concrete_loops_need_no_invariant(self) -> None:
        for relative_job in (
            "cases/count_loop/job.json",
            "cases/count_for/job.json",
            "cases/count_do_while/job.json",
            "cases/nested_loop/job.json",
        ):
            with self.subTest(job=relative_job):
                report = self._run(relative_job)
                self.assertEqual(report["summary"]["PASS"], report["summary"]["total"])

    def test_opaque_list_loop_preserves_execution_proofs(self) -> None:
        report = self._run("cases/sll_length_loop/job.json")
        self.assertEqual(report["summary"]["UNKNOWN"], 3)
        for result in report["results"]:
            self.assertEqual(result["phases"]["precondition"], "UNKNOWN")
            self.assertEqual(result["phases"]["execution"], "PASS")

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
        self.assertEqual(division["summary"]["PASS"], 3)
        self.assertEqual(division["summary"]["INVALID"], 1)
        invalid = next(
            item for item in division["results"] if item["id"] == "zero_divisor_invalid"
        )
        self.assertEqual(invalid["reason"], "bindings_violate_require")
        for result in division["results"]:
            if result["id"] != "zero_divisor_invalid":
                self.assertEqual(result["phases"]["postcondition"], "PASS")

        equality = self._run("cases/float_operations/job_double_eq_branch.json")
        self.assertEqual(equality["summary"]["PASS"], 3)
        self.assertEqual(equality["summary"]["total"], 3)
        for result in equality["results"]:
            self.assertEqual(result["phases"]["postcondition"], "PASS")

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

    def test_wrong_loop_postcondition_retains_unproved_vc(self) -> None:
        report = self._run("cases/count_loop_wrong/job.json")
        self.assertEqual(report["results"][0]["status"], "UNKNOWN")
        self.assertIsNone(report["results"][0]["satisfied"])
        self.assertTrue(report["results"][0]["vc"]["residual_goals"])

    def test_loop_limit_is_unknown_not_pass(self) -> None:
        report = self._run("cases/count_loop/job_limit.json")
        self.assertEqual(report["results"][0]["status"], "UNKNOWN")
        self.assertEqual(report["results"][0]["reason"], "loop_unroll_limit")

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
        self.assertEqual(report["results"][0]["status"], "UNKNOWN")
        self.assertEqual(report["results"][0]["phases"]["postcondition"], "PASS")
        self.assertEqual(report["results"][0]["phases"]["precondition"], "UNKNOWN")
        self.assertEqual(report["results"][1]["status"], "UNKNOWN")

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
        self.assertEqual(len(report["itp_vcs"]), 3)
        self.assertEqual(
            report["vc_policy"]["loops"],
            "execute_iterations",
        )
        self.assertEqual(
            report["vc_policy"]["defined_function_calls"], "execute_bodies"
        )
        for result in report["results"]:
            with self.subTest(case=result["id"]):
                self._assert_manual_residual(result)

    def test_concrete_callees_stop_at_bodyless_external_call(self) -> None:
        report = self._run("cases/ip_jet_ctrl_send/job.json")
        self.assertEqual(report["summary"]["UNKNOWN"], 3)
        for result in report["results"]:
            with self.subTest(case=result["id"]):
                self.assertEqual(result["reason"], "missing_function_body")
                self.assertEqual(result["phases"]["execution"], "UNKNOWN")

    def test_binding_that_contradicts_require_is_rejected(self) -> None:
        report = self._run("cases/invalid_binding/job.json")
        self.assertEqual(report["results"][0]["status"], "INVALID")
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
        self.assertEqual(report["results"][0]["reason"], "call_depth_limit")


if __name__ == "__main__":
    unittest.main()
