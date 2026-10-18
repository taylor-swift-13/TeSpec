from __future__ import annotations

import json
import os
from pathlib import Path
import re
import subprocess
import sys
import tempfile
import time
import unittest

from spectest.core import _run_measured, bundled_qcip_root, run_job
from spectest.rocq_predicates import (
    emit_rules,
    emit_pure_projection_rules,
    parse_predicate,
)

CANDIDATE = os.environ.get("SAC_SYMEXEC")
if CANDIDATE:
    # Resolve the environment override at invocation time, before temporary
    # jobs interpret relative QCP configuration paths against their runtime.
    CANDIDATE = str(Path(CANDIDATE).resolve())


class ResourceMeasurementTests(unittest.TestCase):
    def test_nonzero_exit_still_records_memory(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            completed, rss, cpu = _run_measured(
                [sys.executable, "-c", "a = bytearray(2000000); raise SystemExit(3)"],
                cwd=root,
                timeout=5,
                metrics_path=root / "rss",
            )
            self.assertEqual(completed.returncode, 3)
            if Path("/usr/bin/time").is_file():
                self.assertIsInstance(rss, int)
                self.assertGreater(rss, 0)
                self.assertIsInstance(cpu, float)

    def test_timeout_kills_process_group(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            started = time.monotonic()
            with self.assertRaises(subprocess.TimeoutExpired):
                _run_measured(
                    [
                        sys.executable,
                        "-c",
                        "import subprocess,sys,time; "
                        'subprocess.Popen([sys.executable,"-c","import time; time.sleep(10)"]); '
                        "time.sleep(10)",
                    ],
                    cwd=root,
                    timeout=0.1,
                    metrics_path=root / "rss",
                )
            self.assertLess(time.monotonic() - started, 3)


@unittest.skipUnless(CANDIDATE, "set SAC_SYMEXEC to test the candidate sac binary")
class CandidateExecutorTests(unittest.TestCase):
    def test_quoted_conjunction_unfolding_checks_bounds_and_preserves_cells(self):
        # Generic provider fixture. Real definition equivalence is independently
        # checked through the normalization controller, not by this DSL test.
        definition = r"""Definition bounded_cell(p: addr)(n: Z): Assertion :=
EX q: Z, “ (0 <= n /\ n <= 8) /\ q = n ” && p # Int |-> q."""
        clauses = parse_predicate(definition, "bounded_cell")
        for mode in ("--spec-test", "--spec-test-no-expand"):
            for value in (-1, 0, 3, 8, 9):
                with (
                    self.subTest(mode=mode, value=value),
                    tempfile.TemporaryDirectory() as directory,
                ):
                    root = Path(directory)
                    rules = root / "certified.strategies"
                    rules.write_text(
                        emit_rules(clauses, first_id=91, scope="checked_bounds")
                    )
                    source = root / "input.c"
                    source.write_text(
                        "/*@ Extern Coq (bounded_cell: Z -> Z -> Assertion) */\n"
                        f'/*@ include strategies "{rules}" */\n'
                        f"int sample(int *p) /*@ Require bounded_cell(p,{value}) "
                        f"Ensure __return=={value} && data_at(p,int,{value}) */ {{ return *p; }}"
                    )
                    result = subprocess.run(
                        [
                            CANDIDATE,
                            "--input-file=" + str(source),
                            mode,
                            "--function=sample",
                            "--Json-output",
                            "--full-auto",
                            "--emit-residual-vc",
                            "--no-strategy-gen",
                            "--coq-output-dir=" + str(root / "vc"),
                            "--spec-test-normalization-scope=checked_bounds",
                            "--spec-test-normalization-file=certified",
                            "--spec-test-normalization-rule-ids=91",
                        ],
                        capture_output=True,
                        text=True,
                        timeout=10,
                    )
                    self.assertIn(
                        result.returncode, (0, 2, 3), result.stdout + result.stderr
                    )
                    payload = json.loads(result.stdout)["spec_test"]
                    if value in (-1, 9):
                        self.assertEqual(payload["overall"], "FAIL", payload)
                        self.assertEqual(
                            payload["phases"]["precondition"], "UNSAT", payload
                        )
                        self.assertEqual(
                            payload["phases"]["safety"], "NOT_RUN", payload
                        )
                    else:
                        self.assertEqual(
                            payload["phases"]["precondition"], "SAT", payload
                        )
                        self.assertEqual(payload["overall"], "PASS", payload)

    def test_pure_consequences_of_newly_exposed_predicates_survive_search(self):
        # Provider fixture: outer(p,q) := cell(p,13) * inner(q), where
        # inner(q) := pure(q != 0) && emp. The weak inner rule deliberately
        # omits its pure condition. Only the pinned projection recovers it.
        clauses = parse_predicate(
            "Definition inner(q: addr): Assertion := “ q <> NULL ” && emp.", "inner"
        )
        for mode in ("--spec-test", "--spec-test-no-expand"):
            with self.subTest(mode=mode), tempfile.TemporaryDirectory() as directory:
                root = Path(directory)
                certified = root / "certified.strategies"
                certified.write_text(
                    emit_pure_projection_rules(
                        clauses, first_id=91, scope="checked_facts"
                    )
                )
                ordinary = root / "ordinary.strategies"
                ordinary.write_text(
                    "id : 92\npriority : core(3)\nleft : outer(?p,?q) at 0\n"
                    "action : left_erase(0); left_add(data_at(p,int,13)); left_add(inner(q));\n\n"
                    "id : 93\npriority : core(3)\nleft : inner(?q) at 0\n"
                    "action : left_erase(0);\n"
                )
                source = root / "input.c"
                source.write_text(
                    "/*@ Extern Coq (outer: Z -> Z -> Assertion) (inner: Z -> Assertion) */\n"
                    f'/*@ include strategies "{certified}" */\n'
                    f'/*@ include strategies "{ordinary}" */\n'
                    "int sample(int *p, int *q) /*@ Require outer(p,q) "
                    "Ensure __return==13 && q!=0 && data_at(p,int,13) */ { return *p; }"
                )
                result = subprocess.run(
                    [
                        CANDIDATE,
                        "--input-file=" + str(source),
                        mode,
                        "--function=sample",
                        "--Json-output",
                        "--full-auto",
                        "--emit-residual-vc",
                        "--no-strategy-gen",
                        "--coq-output-dir=" + str(root / "vc"),
                        "--spec-test-normalization-scope=checked_facts",
                        "--spec-test-normalization-file=certified",
                        "--spec-test-normalization-rule-ids=91",
                    ],
                    capture_output=True,
                    text=True,
                    timeout=10,
                )
                self.assertIn(result.returncode, (0, 3), result.stdout + result.stderr)
                payload = json.loads(result.stdout)["spec_test"]
                self.assertEqual(payload["phases"]["precondition"], "UNKNOWN", payload)
                self.assertEqual(payload["phases"]["safety"], "PASS", payload)
                self.assertEqual(payload["phases"]["postcondition"], "PASS", payload)

    def test_pure_projection_closure_retains_predicate_and_terminates(self):
        # Trusted provider fixture, marker(p) := pure(p != 0) && emp. This
        # tests rule execution; actual definition proofs use the controller.
        clauses = parse_predicate(
            "Definition marker(p: addr): Assertion := “ p <> NULL ” && emp.", "marker"
        )
        for mode in ("--spec-test", "--spec-test-no-expand"):
            for argument in ("p", "4096", "0"):
                with (
                    self.subTest(mode=mode, argument=argument),
                    tempfile.TemporaryDirectory() as directory,
                ):
                    root = Path(directory)
                    rules = root / "certified.strategies"
                    rules.write_text(
                        emit_pure_projection_rules(
                            clauses, first_id=91, scope="checked_facts"
                        )
                    )
                    source = root / "input.c"
                    source.write_text(
                        "/*@ Extern Coq (marker: Z -> Assertion) */\n"
                        f'/*@ include strategies "{rules}" */\n'
                        f"int sample(int *p) /*@ Require marker({argument}) "
                        f"Ensure __return==0 && {argument}!=0 && marker({argument}) */ {{ return 0; }}"
                    )
                    result = subprocess.run(
                        [
                            CANDIDATE,
                            "--input-file=" + str(source),
                            mode,
                            "--function=sample",
                            "--Json-output",
                            "--full-auto",
                            "--emit-residual-vc",
                            "--no-strategy-gen",
                            "--coq-output-dir=" + str(root / "vc"),
                            "--spec-test-normalization-scope=checked_facts",
                            "--spec-test-normalization-file=certified",
                            "--spec-test-normalization-rule-ids=91",
                        ],
                        capture_output=True,
                        text=True,
                        timeout=10,
                    )
                    self.assertIn(
                        result.returncode, (0, 2, 3), result.stdout + result.stderr
                    )
                    payload = json.loads(result.stdout)["spec_test"]
                    self.assertNotIn("predicate_unfold_limit", json.dumps(payload))
                    if argument == "0":
                        self.assertEqual(payload["overall"], "FAIL", payload)
                    else:
                        self.assertEqual(
                            payload["phases"]["precondition"], "UNKNOWN", payload
                        )
                        self.assertEqual(
                            payload["phases"]["postcondition"], "PASS", payload
                        )
                        goal = (root / "vc/input_goal.v").read_text()
                        self.assertIn("marker", goal)

    def test_heap_ownership_does_not_invent_nonnull_facts(self):
        # The QCP heap model permits address zero. Observations and contracts
        # must not turn ownership into an unproved non-null assumption.
        for declaration, cell in (
            ("", "data_at(p,int,13)"),
            ("struct record { int value; };\n", "data_at(&p->value,int,13)"),
        ):
            for explicit in (False, True):
                requirement = ("p!=0 && " if explicit else "") + cell
                parameter = "struct record *p" if declaration else "int *p"
                source = declaration + "int sample(" + parameter + ") "
                source += (
                    "/*@ Require "
                    + requirement
                    + " Ensure __return==0 && p!=0 && "
                    + cell
                    + " */ "
                    "{ /*@ Assert p!=0 && " + cell + " */ return 0; }"
                )
                for mode in ("entry-exit", "all-boundaries"):
                    with self.subTest(
                        record=bool(declaration), explicit=explicit, mode=mode
                    ):
                        result = self.run_source(
                            source, mode, annotation_policy="check-preserve"
                        )
                        self.assertEqual(
                            result["status"], "PASS" if explicit else "FAIL", result
                        )
                        self.assertEqual(result["phases"]["execution"], "PASS", result)
                        if not explicit:
                            self.assertEqual(
                                result["phases"]["annotations"], "UNKNOWN", result
                            )
                            self.assertEqual(
                                result["phases"]["postcondition"], "UNKNOWN", result
                            )

    def test_unused_nominal_existentials_remain_obligations(self):
        # Nominal types may be empty. Renaming the type must not change the
        # result, and the witness must survive both parsing and VC printing.
        for mode in ("--spec-test", "--spec-test-no-expand"):
            for type_name in ("WitnessDomain", "AbstractHistory"):
                for boundary in ("Require", "Ensure"):
                    with (
                        self.subTest(mode=mode, type=type_name, boundary=boundary),
                        tempfile.TemporaryDirectory() as directory,
                    ):
                        root = Path(directory)
                        requirement = "data_at(p,int,7)"
                        postcondition = "__return==7 && data_at(p,int,7)"
                        if boundary == "Require":
                            requirement = f"exists(w:{type_name}), {requirement}"
                        else:
                            postcondition = f"exists(w:{type_name}), {postcondition}"
                        source = root / "input.c"
                        source.write_text(
                            f"/*@ Extern Coq ({type_name} :: *) */\n"
                            f"int sample(int *p) /*@ Require {requirement} "
                            f"Ensure {postcondition} */ {{ return *p; }}"
                        )
                        result = subprocess.run(
                            [
                                CANDIDATE,
                                "--input-file=" + str(source),
                                mode,
                                "--function=sample",
                                "--Json-output",
                                "--full-auto",
                                "--emit-residual-vc",
                                "--no-strategy-gen",
                                "--coq-output-dir=" + str(root / "vc"),
                            ],
                            capture_output=True,
                            text=True,
                            timeout=10,
                        )
                        self.assertIn(result.returncode, (0, 3), result.stderr)
                        payload = json.loads(result.stdout)["spec_test"]
                        self.assertEqual(payload["overall"], "UNKNOWN", payload)
                        phase = (
                            "precondition" if boundary == "Require" else "postcondition"
                        )
                        self.assertEqual(payload["phases"][phase], "UNKNOWN", payload)
                        self.assertEqual(payload["phases"]["safety"], "PASS", payload)
                        self.assertRegex(
                            (root / "vc/input_goal.v").read_text(),
                            rf"EX \(\w+: {type_name}\)",
                        )

    def test_generated_nominal_witness_keeps_type(self):
        definition = (
            "Definition owned(p:addr):Assertion := EX w:WitnessDomain, p # Int |-> 7."
        )
        for mode in ("--spec-test", "--spec-test-no-expand"):
            with self.subTest(mode=mode), tempfile.TemporaryDirectory() as directory:
                root = Path(directory)
                rules = root / "certified.strategies"
                rules.write_text(
                    emit_rules(
                        parse_predicate(definition, "owned"),
                        scope="checked_defs",
                        first_id=91,
                    )
                )
                source = root / "input.c"
                source.write_text(
                    "/*@ Extern Coq (WitnessDomain :: *) */\n"
                    "/*@ Extern Coq (owned: Z -> Assertion) */\n"
                    f'/*@ include strategies "{rules}" */\n'
                    "int sample(int *p) /*@ Require owned(p) Ensure __return==7 && data_at(p,int,7) */ { return *p; }"
                )
                result = subprocess.run(
                    [
                        CANDIDATE,
                        "--input-file=" + str(source),
                        mode,
                        "--function=sample",
                        "--Json-output",
                        "--full-auto",
                        "--emit-residual-vc",
                        "--no-strategy-gen",
                        "--coq-output-dir=" + str(root / "vc"),
                        "--spec-test-normalization-scope=checked_defs",
                        "--spec-test-normalization-file=certified",
                        "--spec-test-normalization-rule-ids=91",
                    ],
                    capture_output=True,
                    text=True,
                    timeout=10,
                )
                self.assertIn(result.returncode, (0, 3), result.stderr)
                payload = json.loads(result.stdout)["spec_test"]
                self.assertEqual(payload["phases"]["precondition"], "UNKNOWN", payload)
                self.assertEqual(payload["phases"]["postcondition"], "PASS", payload)
                self.assertRegex(
                    (root / "vc/input_goal.v").read_text(), r"EX \(\w+: WitnessDomain\)"
                )

    def test_nominal_witness_annotations_do_not_restrict_actual_loop_state(self):
        for mode in ("--spec-test", "--spec-test-no-expand"):
            for boundary in ("Assert", "Inv"):
                with (
                    self.subTest(mode=mode, boundary=boundary),
                    tempfile.TemporaryDirectory() as directory,
                ):
                    root = Path(directory)
                    annotation = "/*@ " + boundary + " exists(w:WitnessDomain), emp */"
                    source = root / "input.c"
                    source.write_text(
                        "/*@ Extern Coq (WitnessDomain :: *) */\n"
                        "int sample(void) /*@ Require emp Ensure __return==2 && emp */ "
                        "{ int i=0; " + annotation + " while(i<2) {i++;} return i; }"
                    )
                    result = subprocess.run(
                        [
                            CANDIDATE,
                            "--input-file=" + str(source),
                            mode,
                            "--function=sample",
                            "--Json-output",
                            "--full-auto",
                            "--emit-residual-vc",
                            "--no-strategy-gen",
                            "--annotation-policy=check-preserve",
                            "--coq-output-dir=" + str(root / "vc"),
                        ],
                        capture_output=True,
                        text=True,
                        timeout=10,
                    )
                    self.assertEqual(
                        result.returncode, 0, result.stdout + result.stderr
                    )
                    payload = json.loads(result.stdout)["spec_test"]
                    self.assertTrue(payload["completed"], payload)
                    self.assertEqual(payload["overall"], "UNKNOWN", payload)
                    self.assertEqual(payload["phases"]["precondition"], "SAT", payload)
                    self.assertEqual(
                        payload["phases"]["annotations"], "UNKNOWN", payload
                    )
                    self.assertEqual(
                        payload["phases"]["postcondition"], "PASS", payload
                    )
                    self.assertRegex(
                        (root / "vc/input_goal.v").read_text(),
                        r"EX \(\w+: WitnessDomain\)",
                    )

    def test_nested_constructor_lists_select_memory_branch_in_both_modes(self):
        definition = """Inductive Token : Type := Tag : Z -> Token | Other : Z -> Token.
Definition Sequence : Type := list Token.
Definition owned(p: addr)(xs: Sequence): Assertion :=
match xs with
| nil => emp
| Tag v :: tail => “ p <> NULL ” && p # Int |-> v
| Other v :: tail => “ v = 0 ” && p # Int |-> v
end."""
        for mode in ("--spec-test", "--spec-test-no-expand"):
            for tag, value, expected, verdict in [
                ("Tag", 7, 7, "PASS"),
                ("Tag", -5, -5, "PASS"),
                ("Tag", 7, 8, "FAIL"),
                ("Other", 0, 0, "PASS"),
                ("Other", 7, 7, "FAIL"),
            ]:
                with (
                    self.subTest(mode=mode, tag=tag, value=value, expected=expected),
                    tempfile.TemporaryDirectory() as directory,
                ):
                    root = Path(directory)
                    rules = root / "certified.strategies"
                    rules.write_text(
                        emit_rules(
                            parse_predicate(definition, "owned"),
                            scope="checked_defs",
                            first_id=91,
                        )
                    )
                    source = root / "input.c"
                    source.write_text(
                        "/*@ Extern Coq (Token :: *) */\n"
                        "/*@ Extern Coq (Tag: Z -> Token) (Other: Z -> Token) (owned: Z -> list Token -> Assertion) */\n"
                        f'/*@ include strategies "{rules}" */\n'
                        "int fetch(int *q) /*@ With n Require data_at(q,int,n) Ensure __return==n && data_at(q,int,n) */ { return *q; }\n"
                        f"int sample(int *p) /*@ Require owned(p,cons({tag}({value}),nil)) Ensure __return=={expected} && data_at(p,int,{value}) */ {{ int t=0; while(t<2) {{t++;}} return fetch(p); }}"
                    )
                    result = subprocess.run(
                        [
                            CANDIDATE,
                            "--input-file=" + str(source),
                            mode,
                            "--function=sample",
                            "--Json-output",
                            "--full-auto",
                            "--emit-residual-vc",
                            "--no-strategy-gen",
                            "--coq-output-dir=" + str(root / "vc"),
                            "--spec-test-normalization-scope=checked_defs",
                            "--spec-test-normalization-file=certified",
                            "--spec-test-normalization-rule-ids=91,93,95",
                        ],
                        capture_output=True,
                        text=True,
                        timeout=10,
                    )
                    self.assertEqual(
                        result.returncode,
                        2 if tag == "Other" and value != 0 else 0,
                        result.stdout + result.stderr,
                    )
                    payload = json.loads(result.stdout)
                    self.assertEqual(payload["spec_test"]["overall"], verdict, payload)
                    if tag == "Other" and value != 0:
                        self.assertEqual(
                            payload["spec_test"]["phases"]["safety"], "NOT_RUN", payload
                        )

    def test_integer_field_rules_keep_width_and_signedness(self):
        for coq, ctype in [
            ("Char", "signed char"),
            ("UChar", "unsigned char"),
            ("Short", "short"),
            ("UShort", "unsigned short"),
            ("Int", "int"),
            ("UInt", "unsigned int"),
            ("Int64", "long long"),
            ("UInt64", "unsigned long long"),
        ]:
            for mode in ("--spec-test", "--spec-test-no-expand"):
                with (
                    self.subTest(coq=coq, mode=mode),
                    tempfile.TemporaryDirectory() as directory,
                ):
                    root = Path(directory)
                    rules = root / "certified.strategies"
                    rules.write_text(
                        emit_rules(
                            parse_predicate(
                                'Definition owned (p: addr)(v: Z): Assertion := &(p # "Box" ->ₛ "slot") # '
                                + coq
                                + " |-> v.",
                                "owned",
                            ),
                            scope="checked_defs",
                            first_id=91,
                        )
                    )
                    source = root / "input.c"
                    source.write_text(
                        "struct Box { "
                        + ctype
                        + " slot; };\n/*@ Extern Coq (owned : Z -> Z -> Assertion) */\n"
                        + f'/*@ include strategies "{rules}" */\n'
                        + "int sample(struct Box *p) /*@ Require owned(p,7) Ensure __return==7 && data_at(&p@pre->slot,"
                        + ctype
                        + ",7) */ { return p->slot; }"
                    )
                    result = subprocess.run(
                        [
                            CANDIDATE,
                            "--input-file=" + str(source),
                            mode,
                            "--function=sample",
                            "--Json-output",
                            "--full-auto",
                            "--emit-residual-vc",
                            "--no-strategy-gen",
                            "--coq-output-dir=" + str(root / "vc"),
                            "--spec-test-normalization-scope=checked_defs",
                            "--spec-test-normalization-file=certified",
                            "--spec-test-normalization-rule-ids=91",
                        ],
                        capture_output=True,
                        text=True,
                        timeout=10,
                    )
                    self.assertEqual(
                        result.returncode, 0, result.stdout + result.stderr
                    )
                    self.assertEqual(
                        json.loads(result.stdout)["spec_test"]["overall"], "PASS"
                    )

    def test_nested_union_updates_and_alias_conflicts(self):
        declarations = "struct Item { int padding; int value; }; union Payload { struct Item node; int raw; }; struct Envelope { int code; union Payload payload; };\n/*@ Extern Coq (owned : Z -> Z -> Assertion) */\n"
        cases = [
            (
                "owned(p,7)",
                "__return==8 && data_at(&p@pre->payload.node.value,int,8)",
                "p->payload.node.value += 1; return p->payload.node.value;",
                "PASS",
            ),
            ("p==q && owned(p,7) * owned(q,8)", "emp", "return 0;", "FAIL"),
            (
                "owned(p,7) * data_at((char*)(&p->payload.node.value)+2,int,8)",
                "emp",
                "return 0;",
                "FAIL",
            ),
        ]
        definition = 'Definition owned(p: addr)(v: Z): Assertion := (&((p) # "Envelope" ->ₛ "payload" .ₛ "node" .ₛ "value") # Int |-> v).'
        for require, ensure, body, expected in cases:
            for mode in ("--spec-test", "--spec-test-no-expand"):
                with (
                    self.subTest(expected=expected, mode=mode, require=require),
                    tempfile.TemporaryDirectory() as directory,
                ):
                    root = Path(directory)
                    source = root / "input.c"
                    rules = root / "certified.strategies"
                    source.write_text(
                        declarations
                        + "int sample(struct Envelope *p, struct Envelope *q) /*@ Require "
                        + require
                        + " Ensure "
                        + ensure
                        + " */ { "
                        + body
                        + " }"
                    )
                    discovery = subprocess.run(
                        [
                            CANDIDATE,
                            "--input-file=" + str(source),
                            "--spec-test-preflight",
                            "--coq-output-dir=" + str(root / "discovery"),
                        ],
                        capture_output=True,
                        text=True,
                        timeout=10,
                    )
                    self.assertEqual(
                        discovery.returncode, 0, discovery.stdout + discovery.stderr
                    )
                    layout = json.loads(discovery.stdout)["target_layout"]
                    rules.write_text(
                        emit_rules(
                            parse_predicate(definition, "owned", target_layout=layout),
                            scope="checked_defs",
                            first_id=91,
                        )
                    )
                    source.write_text(
                        source.read_text() + f'\n/*@ include strategies "{rules}" */\n'
                    )
                    result = subprocess.run(
                        [
                            CANDIDATE,
                            "--input-file=" + str(source),
                            mode,
                            "--function=sample",
                            "--Json-output",
                            "--full-auto",
                            "--emit-residual-vc",
                            "--no-strategy-gen",
                            "--coq-output-dir=" + str(root / "vc"),
                            "--spec-test-normalization-scope=checked_defs",
                            "--spec-test-normalization-file=certified",
                            "--spec-test-normalization-rule-ids=91",
                        ],
                        capture_output=True,
                        text=True,
                        timeout=10,
                    )
                    payload = json.loads(result.stdout)
                    self.assertEqual(payload["spec_test"]["overall"], expected, payload)
                    self.assertEqual(payload["spec_test"]["target_layout"], layout)

    def test_definition_list_witnesses_are_typed_fresh_and_remain_unknown(self):
        # Trusted provider fixture tests allocation and residual preservation.
        # Original-library equation certification is checked separately.
        definition = "Definition owned (p: addr): Assertion := EX xs: list Z, tag p xs."
        for mode in ("--spec-test", "--spec-test-no-expand"):
            with self.subTest(mode=mode), tempfile.TemporaryDirectory() as directory:
                root = Path(directory)
                rules = root / "certified.strategies"
                rules.write_text(
                    emit_rules(
                        parse_predicate(definition, "owned"),
                        scope="checked_defs",
                        first_id=91,
                    )
                )
                source = root / "input.c"
                source.write_text(
                    "/*@ Extern Coq (owned : Z -> Assertion) (tag : Z -> list Z -> Assertion) */\n"
                    f'/*@ include strategies "{rules}" */\n'
                    "int sample(int *p, int *q) /*@ Require owned(p) * owned(q) "
                    "Ensure __return==0 */ { return 0; }"
                )
                result = subprocess.run(
                    [
                        CANDIDATE,
                        "--input-file=" + str(source),
                        mode,
                        "--function=sample",
                        "--Json-output",
                        "--full-auto",
                        "--emit-residual-vc",
                        "--no-strategy-gen",
                        "--coq-output-dir=" + str(root / "vc"),
                        "--spec-test-normalization-scope=checked_defs",
                        "--spec-test-normalization-file=certified",
                        "--spec-test-normalization-rule-ids=91",
                    ],
                    capture_output=True,
                    text=True,
                    timeout=10,
                )
                payload = json.loads(result.stdout)["spec_test"]
                self.assertTrue(payload["completed"], payload)
                self.assertEqual(payload["overall"], "UNKNOWN", payload)
                self.assertEqual(payload["phases"]["precondition"], "UNKNOWN")
                goal = (root / "vc/input_goal.v").read_text()
                witnesses = set(re.findall(r"\(([A-Za-z_]\w*):\s*\(@list Z\)\)", goal))
                self.assertEqual(len(witnesses), 2, goal)
                pointers = re.findall(r"\(tag ([pq]_pre) ([A-Za-z_]\w*)\s*\)", goal)
                by_pointer = {pointer: witness for pointer, witness in pointers}
                self.assertEqual(set(by_pointer), {"p_pre", "q_pre"}, goal)
                self.assertNotEqual(by_pointer["p_pre"], by_pointer["q_pre"], goal)

    def test_shared_base_offsets_simplify_without_binding_the_base(self):
        requirements = (
            ("p + 1 < p + 2", "PASS"),
            ("p + 2 < p + 1", "FAIL"),
            ("p == q && p + 1 == q + 2", "FAIL"),
            ("p + 1 == p + 1", "PASS"),
        )
        for mode in ("entry-exit", "all-boundaries"):
            for requirement, expected in requirements:
                with self.subTest(mode=mode, requirement=requirement):
                    result = self.run_source(
                        "int sample(int *p, int *q) /*@ Require "
                        + requirement
                        + " && emp Ensure __return==0 && emp */ { return 0; }",
                        mode,
                    )
                    self.assertEqual(result["status"], expected, result)

    def test_large_symbolic_array_retains_opaque_require_without_solver_blowup(self):
        source = (
            "/*@ Extern Coq (opaque : Z -> Prop) */\n"
            "int sample(int *p) /*@ With l Require opaque(7) && IntArray::full(p,100,l) "
            "Ensure __return==0 && IntArray::full(p,100,l) */ { return p[99]; }"
        )
        for mode in ("entry-exit", "all-boundaries"):
            result = self.run_source(
                source, mode, values={"l": [0] * 100}, timeout_seconds=5
            )
            self.assertEqual(result["status"], "UNKNOWN", result)
            self.assertEqual(result["phases"]["precondition"], "UNKNOWN", result)
            self.assertEqual(result["phases"]["execution"], "PASS", result)
            self.assertEqual(result["phases"]["postcondition"], "PASS", result)

    def test_relative_byte_overlap_remains_invalid(self):
        for mode in ("entry-exit", "all-boundaries"):
            result = self.run_source(
                "int sample(int *p) /*@ Require data_at(p,int,1) * "
                "data_at((char*)p+2,int,2) Ensure emp */ { return 0; }",
                mode,
            )
            self.assertEqual(result["status"], "FAIL", result)

    def test_preflight_exports_layout_without_executing_or_checking_require(self):
        for mode in ((), ("--spec-test-no-expand",)):
            with self.subTest(mode=mode), tempfile.TemporaryDirectory() as temporary:
                root = Path(temporary)
                source = root / "input.c"
                source.write_text(
                    "struct Record { int value; struct Record *next; };\n"
                    "/*@ Import Coq Require Import UnavailableDefinitions */\n"
                    "int sample(void) /*@ Require 1==2 && emp Ensure emp */ "
                    "{ while(1) { sample(); } }"
                )
                result = subprocess.run(
                    [
                        CANDIDATE,
                        "--input-file=" + str(source),
                        "--spec-test-preflight",
                        "--coq-output-dir=" + str(root / "context"),
                        *mode,
                    ],
                    capture_output=True,
                    text=True,
                    timeout=5,
                )
                self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
                payload = json.loads(result.stdout)
                self.assertEqual(payload["schema"], "sac-spec-test-preflight/v1")
                self.assertEqual(payload["status"], "PARSED")
                self.assertEqual(payload["execution"], "NOT_RUN")
                self.assertEqual(payload["precondition"], "NOT_CHECKED")
                record = next(
                    r
                    for r in payload["target_layout"]["aggregates"]
                    if r["name"] == "Record"
                )
                self.assertEqual(record["size"], 8)
                self.assertEqual(
                    {f["name"]: f["offset"] for f in record["fields"]},
                    {"value": 0, "next": 4},
                )
                header = Path(payload["coq_header"]).read_text()
                self.assertIn("Require Import UnavailableDefinitions.", header)
                self.assertNotIn("Definition sample_", header)
                self.assertNotIn("spec_test", payload)

    def test_normalization_file_and_id_selection_excludes_unchecked_rules(self):
        # Trusted provider fixture: marker(0) is defined as emp. These tests
        # exercise selection, not Rocq certification of the fixture definition.
        good = "id : 91\npriority : checked_defs(3)\nleft : marker(0) at 0\naction : left_erase(0);\n"
        bad = "id : 92\npriority : checked_defs(1)\nleft : marker(0) at 0\naction : left_erase(0); left_add(0 != 0);\n"
        for duplicate in (False, True):
            for mode in ("--spec-test", "--spec-test-no-expand"):
                with (
                    self.subTest(duplicate=duplicate, mode=mode),
                    tempfile.TemporaryDirectory() as temporary,
                ):
                    root = Path(temporary)
                    rules = root / "certified.strategies"
                    rules.write_text(good + (good if duplicate else bad))
                    unrelated = root / "unrelated.strategies"
                    unrelated.write_text(bad.replace("92", "91"))
                    source = root / "input.c"
                    source.write_text(
                        "/*@ Extern Coq (marker : Z -> Assertion) */\n"
                        f'/*@ include strategies "{rules}" */\n'
                        f'/*@ include strategies "{unrelated}" */\n'
                        "int sample(void) /*@ Require marker(0) Ensure __return==0 && emp */ { return 0; }"
                    )
                    result = subprocess.run(
                        [
                            CANDIDATE,
                            "--input-file=" + str(source),
                            mode,
                            "--function=sample",
                            "--Json-output",
                            "--full-auto",
                            "--emit-residual-vc",
                            "--no-strategy-gen",
                            "--coq-output-dir=" + str(root / "vc"),
                            "--spec-test-normalization-scope=checked_defs",
                            "--spec-test-normalization-file=certified",
                            "--spec-test-normalization-rule-ids=91",
                        ],
                        capture_output=True,
                        text=True,
                        timeout=10,
                    )
                    if duplicate:
                        self.assertNotEqual(result.returncode, 0)
                        self.assertIn(
                            "exactly one loaded rule", result.stdout + result.stderr
                        )
                    else:
                        self.assertEqual(
                            result.returncode, 0, result.stdout + result.stderr
                        )
                        self.assertEqual(
                            json.loads(result.stdout)["spec_test"]["overall"], "PASS"
                        )

    def test_normalization_cannot_select_an_ordinary_entailment_scope(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            source = root / "input.c"
            source.write_text(
                "int sample(void) /*@ Require emp Ensure emp */ { return 0; }"
            )
            result = subprocess.run(
                [
                    CANDIDATE,
                    "--input-file=" + str(source),
                    "--spec-test",
                    "--function=sample",
                    "--spec-test-normalization-scope=core",
                    "--coq-output-dir=" + str(root / "vc"),
                ],
                capture_output=True,
                text=True,
                timeout=10,
            )
            self.assertNotEqual(result.returncode, 0)
            self.assertIn("dedicated strategy scope", result.stdout + result.stderr)

    def test_mismatched_frontend_and_runtime_architecture_is_rejected(self):
        # The distributed frontend is built for 32-bit long/ptrdiff_t.
        with tempfile.TemporaryDirectory() as directory:
            source = Path(directory) / "input.c"
            source.write_text(
                "int sample(void) /*@ Require emp Ensure emp */ { return 0; }"
            )
            for mode in (
                "--concrete-bindings",
                "--spec-test-no-expand",
                "--spec-test-preflight",
            ):
                result = subprocess.run(
                    [CANDIDATE, "--input-file=" + str(source), "--arch=64", mode],
                    capture_output=True,
                    text=True,
                    timeout=10,
                )
                self.assertNotEqual(result.returncode, 0)
                self.assertIn(
                    "spec-test target mismatch", result.stdout + result.stderr
                )

    def test_disjunctive_boundaries_check_all_iterations_without_replacing_state(self):
        for annotation in ("i==0 || i==1 || i==2", "i==0 || i==1"):
            source = (
                "int sample(void) /*@ Require emp Ensure __return==2 && emp */ "
                "{ int i=0; /*@ Inv (" + annotation + ") && emp */ "
                "while(i<2) { i++; } return i; }"
            )
            for mode in ("entry-exit", "all-boundaries"):
                with self.subTest(annotation=annotation, mode=mode):
                    result = self.run_source(source, mode)
                    wrong_checked = annotation == "i==0 || i==1" and mode == "all-boundaries"
                    self.assertEqual(
                        result["status"], "FAIL" if wrong_checked else "PASS", result
                    )
                    self.assertTrue(result["execution_completed"], result)
                    self.assertEqual(result["phases"]["postcondition"], "PASS", result)

    def test_inline_parameter_rebinding_preserves_caller_pointer_and_shared_write(self):
        source = (
            "void rebind(int *p, int *q) "
            "/*@ With a b Require 0<=a && a<100 && 0<=b && b<100 && "
            "data_at(p,int,a) * data_at(q,int,b) "
            "Ensure data_at(p,int,a) * data_at(q,int,b+1) */ "
            "{ p=q; *p=*p+1; } "
            "int sample(int *p, int *q) "
            "/*@ Require data_at(p,int,3) * data_at(q,int,7) "
            "Ensure __return==11 && data_at(p,int,3) * data_at(q,int,8) */ "
            "{ rebind(p,q); return *p+*q; }"
        )
        for mode in ("entry-exit", "all-boundaries"):
            with self.subTest(mode=mode):
                result = self.run_source(source, mode)
                self.assertEqual(result["status"], "PASS", result)

    def test_escaped_parameter_slot_is_not_live_after_return(self):
        source = (
            "int **escape(int *p) "
            "/*@ With v Require data_at(p,int,v) Ensure data_at(p,int,v) */ "
            "{ return &p; } "
            "int sample(int *p) "
            "/*@ Require data_at(p,int,3) Ensure __return==3 && data_at(p,int,3) */ "
            "{ int **q=escape(p); return **q; }"
        )
        for mode in ("entry-exit", "all-boundaries"):
            with self.subTest(mode=mode):
                result = self.run_source(source, mode)
                self.assertEqual(result["status"], "ERROR", result)
                self.assertIn(
                    "cannot read memory through this pointer",
                    result["executor_error"]["Main Error Message"],
                )
                self.assertFalse(result["execution_completed"], result)

    def test_imported_predicate_boundaries_preserve_inline_heap_values(self):
        fixture = (
            Path(__file__).resolve().parents[1]
            / "benchmark/comparison/proof-oriented/square-boundaries/subject.c"
        )
        for mode in ("entry-exit", "all-boundaries"):
            with self.subTest(mode=mode), tempfile.TemporaryDirectory() as directory:
                root = Path(directory)
                job = root / "job.json"
                job.write_text(
                    json.dumps(
                        {
                            "source": str(fixture),
                            "function": "square_loop",
                            "binds": [{"id": "zero", "values": {"n": 0}}],
                            "qcp": {
                                "binary": CANDIDATE,
                                "qcip_root": str(bundled_qcip_root()),
                                "execution_mode": mode,
                                "instance_trace": True,
                            },
                        }
                    )
                )
                result = run_job(job, root / "output")["results"][0]
                self.assertEqual(result["status"], "UNKNOWN", result)
                self.assertTrue(result["execution_completed"], result)
                self.assertEqual(result["phases"]["precondition"], "SAT")
                events = {
                    event["kind"]: event["count"]
                    for event in result["abstraction_events"]
                }
                self.assertEqual(events["inline-call"], 3)
                if mode == "all-boundaries":
                    self.assertEqual(events["annotation-check"], 3)
                    self.assertEqual(events["contract-check"], 3)
                    self.assertEqual(events["loop-invariant"], 4)
                else:
                    self.assertEqual(events, {"inline-call": 3})
                execution = json.loads(Path(result["stdout"]).read_text())
                returns = [
                    item["goal"]
                    for item in execution["manual_obligations"]
                    if item["kind"] == "return_checker_wit"
                ]
                self.assertEqual(len(returns), 1)
                before, after = returns[0].split("|--")
                self.assertIn("n == 0", before)
                self.assertRegex(before, r"__return == n \+")
                self.assertRegex(before, r"\*p@pre == n \+")
                self.assertNotIn("is_square", before)
                self.assertIn("is_square(", after)
                trace = execution["spec_test"]["instance_trace"]
                self.assertTrue(trace)
                self.assertNotIn("is_square", trace[-1]["P"])
                self.assertEqual(trace[-1]["state_role"], "execution")
                runtime_points = [p for p in trace if p["state_role"] == "execution"]
                self.assertTrue(runtime_points)
                self.assertTrue(all("is_square" not in p["P"] for p in runtime_points))
                copied_points = [p for p in trace if p["state_role"] == "boundary-copy"]
                if mode == "all-boundaries":
                    self.assertTrue(copied_points)
                    self.assertTrue(any("is_square" in p["P"] for p in copied_points))
                else:
                    self.assertFalse(copied_points)

    def test_closed_sublist_matches_qcp_negative_and_clamped_bounds(self):
        cases = [
            (-3, 2, "cons(5,cons(6,nil))"),
            (0, -1, "nil"),
            (2, 1, "nil"),
            (1, 100, "cons(6,cons(7,nil))"),
            (0, "4294967296*4294967296", "cons(5,cons(6,cons(7,nil)))"),
        ]
        for mode in ("entry-exit", "all-boundaries"):
            for lo, hi, expected in cases:
                with self.subTest(mode=mode, lo=lo, hi=hi):
                    source = (
                        "int sample(void) /*@ Require emp Ensure __return==0 && emp */ "
                        "{ /*@ Assert sublist("
                        + str(lo)
                        + ","
                        + str(hi)
                        + ",cons(5,cons(6,cons(7,nil)))) == "
                        + expected
                        + " && emp */ return 0; }"
                    )
                    result = self.run_source(source, mode)
                    self.assertEqual(result["status"], "PASS", result)

    def test_closed_sublist_preserves_symbolic_elements(self):
        source = (
            "/*@ Extern Coq (opaque_value: Z) */ "
            "int sample(void) /*@ Require emp Ensure __return==0 && emp */ "
            "{ /*@ Assert sublist(1,2,cons(opaque_value,cons(opaque_value+1,nil))) "
            "== cons(opaque_value+1,nil) && emp */ return 0; }"
        )
        result = self.run_source(source, "all-boundaries")
        self.assertEqual(result["status"], "PASS", result)

    def test_sublist_with_unknown_spine_remains_an_obligation(self):
        source = (
            "/*@ Extern Coq (opaque_tail: list Z) */ "
            "int sample(void) /*@ Require emp Ensure __return==0 && emp */ "
            "{ /*@ Assert sublist(0,1,opaque_tail)==nil && emp */ return 0; }"
        )
        result = self.run_source(source, "all-boundaries")
        self.assertEqual(result["status"], "UNKNOWN", result)
        self.assertEqual(result["phases"]["annotations"], "UNKNOWN", result)
        self.assertEqual(result["phases"]["postcondition"], "PASS", result)

    def test_wrong_sublist_observation_does_not_change_continuation(self):
        source = (
            "int sample(void) /*@ Require emp Ensure __return==0 && emp */ "
            "{ /*@ Assert sublist(1,2,cons(5,cons(6,nil))) == cons(5,nil) && emp */ return 0; }"
        )
        result = self.run_source(source, "all-boundaries")
        self.assertEqual(result["status"], "FAIL", result)
        self.assertEqual(result["phases"]["annotations"], "UNKNOWN", result)
        self.assertEqual(result["phases"]["postcondition"], "PASS", result)

    def test_same_base_pointer_difference_terminates_array_iteration(self):
        for mode in ("entry-exit", "all-boundaries"):
            source = (
                "int sample(int *p) /*@ With l Require IntArray::full(p,3,l) "
                "Ensure __return==12 && IntArray::full(p,3,l) */ "
                "{ int i=0; int total=0; int *end=p+3; "
                "while(end-(p+i)!=0) { total+=p[i]; i++; } return total; }"
            )
            with self.subTest(mode=mode):
                result = self.run_source(source, mode, values={"l": [2, 4, 6]})
                self.assertEqual(result["status"], "PASS", result)
                self.assertTrue(result["execution_completed"], result)

    def test_pointer_difference_cancels_offsets_with_both_signs(self):
        for mode in ("entry-exit", "all-boundaries"):
            for expression, expected in [
                ("(p+2)-p", 2),
                ("p-(p+2)", -2),
                ("(p+2)-(p+1)", 1),
            ]:
                with self.subTest(mode=mode, expression=expression):
                    source = (
                        "int sample(int *p) /*@ With l Require IntArray::full(p,3,l) "
                        "Ensure __return=="
                        + str(expected)
                        + " && IntArray::full(p,3,l) */ "
                        "{ return " + expression + "; }"
                    )
                    result = self.run_source(source, mode, values={"l": [2, 4, 6]})
                    self.assertEqual(result["status"], "PASS", result)

    def test_distinct_symbolic_bases_are_not_cancelled(self):
        source = (
            "int sample(int *p,int *q) /*@ Require p!=q && "
            "data_at(p,int,3) * data_at(q,int,4) "
            "Ensure __return==0 && data_at(p,int,3) * data_at(q,int,4) */ "
            "{ /*@ Assert (p+4)-(q+4)==0 && data_at(p,int,3) * data_at(q,int,4) */ "
            "return 0; }"
        )
        result = self.run_source(source, "all-boundaries")
        self.assertEqual(result["status"], "UNKNOWN", result)
        self.assertEqual(result["phases"]["annotations"], "UNKNOWN", result)
        self.assertEqual(result["phases"]["postcondition"], "PASS", result)

    def test_named_observation_cases_without_proof_routing_are_a_disjunction(self):
        for mode in ("entry-exit", "all-boundaries"):
            for reverse in (False, True):
                for valid in (False, True):
                    with self.subTest(mode=mode, reverse=reverse, valid=valid):
                        cases = [
                            "lower: 0 <= i && i <= 1 && emp",
                            "upper: 2 <= i && i <= "
                            + ("3" if valid else "2")
                            + " && emp",
                        ]
                        if reverse:
                            cases.reverse()
                        source = (
                            "int sample(void) /*@ Require emp Ensure __return==3 && emp */ "
                            "{ int i=0; /*@ Inv " + "; ".join(cases) + " */ "
                            "while(i<3) { i++; } return i; }"
                        )
                        result = self.run_source(source, mode, instance_trace=True)
                        self.assertTrue(result["execution_completed"], result)
                        self.assertEqual(
                            result["phases"]["postcondition"], "PASS", result
                        )
                        if mode == "entry-exit" or valid:
                            self.assertEqual(result["status"], "PASS", result)
                        else:
                            self.assertEqual(result["status"], "FAIL", result)
                            self.assertEqual(
                                result["phases"]["annotations"], "UNKNOWN", result
                            )
                            self.assertTrue(result["residual_vcs"], result)

    def test_instance_trace_through_binary_controller(self):
        for mode in ("entry-exit", "all-boundaries"):
            result = self.run_source(
                "int sample(void) /*@ Require emp Ensure __return==4 && emp */ "
                "{ int x=2; x++; /*@ Assert x>=0 */ x++; return x; }",
                mode,
                instance_trace=True,
            )
            self.assertEqual(result["status"], "PASS", result)
            self.assertIn("--instance-trace", result["command"])

    def test_bodyless_call_uses_contract_and_missing_contract_is_unknown(self):
        for mode in ("entry-exit", "all-boundaries"):
            result = self.run_source(
                "int external(int x) /*@ Require x == 2 && emp "
                "Ensure __return == 3 && emp */;\n"
                "int sample(void) /*@ Require emp Ensure __return == 3 && emp */ "
                "{ return external(2); }",
                mode,
            )
            self.assertEqual(result["status"], "PASS", result)
            self.assertEqual(result["declaration_call_policy"], "contract-sample/v1")
            self.assertTrue(any(event["status"] == "SAMPLED"
                                for event in result["sampling_events"]), result)
            result = self.run_source(
                "int external(int x);\n"
                "int sample(void) /*@ Require emp Ensure __return == 3 && emp */ "
                "{ return external(2); }",
                mode,
            )
            self.assertEqual(result["status"], "UNKNOWN", result)
            self.assertEqual(result["reason"], "missing_function_contract")

    def run_source(self, source, mode, spec=None, values=None, **options):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            path = root / "input.c"
            path.write_text(source)
            job = root / "job.json"
            job.write_text(
                json.dumps(
                    {
                        "source": str(path),
                        "function": "sample",
                        "binds": [{"id": "one", "values": values or {}, "spec": spec}],
                        "qcp": {
                            "binary": CANDIDATE,
                            "qcip_root": str(bundled_qcip_root()),
                            "execution_mode": mode,
                            **options,
                        },
                    }
                )
            )
            return run_job(job, root / "output")["results"][0]

    def test_contract_cannot_forget_executed_memory_write(self):
        for forgotten in (False, True):
            ensures = (
                "exists w, data_at(p, int, w)"
                if forgotten
                else "data_at(p, int, v + 1)"
            )
            source = (
                "void step(int *p) /*@ With v Require data_at(p, int, v) Ensure "
                + ensures
                + " */ { *p = *p + 1; }\n"
                "int sample(int *p) /*@ Require data_at(p, int, 3) "
                "Ensure __return == 4 && data_at(p, int, 4) */ "
                "{ step(p); return *p; }"
            )
            for mode in ("entry-exit", "all-boundaries"):
                with self.subTest(forgotten=forgotten, mode=mode):
                    result = self.run_source(source, mode)
                    expected = "PASS"
                    self.assertEqual(result["status"], expected, result)

    def test_alias_write_invalidates_old_value(self):
        for mode in ("entry-exit", "all-boundaries"):
            result = self.run_source(
                "int sample(int *p, int *q) /*@ Require p == q && data_at(p, int, 3) "
                "Ensure __return == 4 && data_at(p, int, 4) */ "
                "{ *q = 4; return *p; }",
                mode,
            )
            self.assertEqual(result["status"], "PASS", result)

    def test_closed_list_relation_preconditions_are_checked_before_execution(self):
        source = (
            '#include "verification_stdlib.h"\n#include "verification_list.h"\n'
            "int sample(int *p) /*@ With (xs: list Z) (ys: list Z) (zs: list Z) "
            "Require zs==app(xs,rev(ys)) && data_at(p,int,7) "
            "Ensure __return==7 && data_at(p@pre,int,7) */ { return *p; }"
        )
        for xs, ys in (([1], [2, 3]), ([], []), ([-1], [-2, 3])):
            correct = xs + list(reversed(ys))
            for result_list, expected in (
                (correct, "PASS"),
                (correct + [99], "FAIL"),
                ([98] + correct, "FAIL"),
            ):
                for mode in ("entry-exit", "all-boundaries"):
                    with self.subTest(xs=xs, ys=ys, result_list=result_list, mode=mode):
                        result = self.run_source(
                            source, mode, values={"xs": xs, "ys": ys, "zs": result_list}
                        )
                        self.assertEqual(result["status"], expected, result)
                        self.assertEqual(
                            result["phases"]["precondition"],
                            "SAT" if expected == "PASS" else "UNSAT",
                            result,
                        )

    def test_annotation_check_preserves_execution_state(self):
        source = (
            "int sample(void) /*@ Require emp Ensure __return == 4 && emp */ "
            "{ int x = 3; /*@ Assert x == 99 */ x = x + 1; return x; }"
        )
        ignored = self.run_source(source, "entry-exit", annotation_policy="ignore")
        checked = self.run_source(source, "entry-exit", annotation_policy="check-preserve")
        self.assertEqual(ignored["status"], "PASS", ignored)
        self.assertEqual(checked["status"], "FAIL", checked)
        self.assertEqual(checked["phases"]["postcondition"], "PASS", checked)
        self.assertEqual(checked["phases"]["annotations"], "UNKNOWN", checked)

    def test_auxiliary_heap_assertions_frame_only_unmentioned_scalar_locals(self):
        for assertion, expected in (
            ("data_at(p,int,9)", "PASS"),
            ("data_at(p,int,10)", "FAIL"),
            ("data_at(p,int,9) * data_at(&i,int,2)", "PASS"),
            ("data_at(p,int,9) * data_at(&i,int,99)", "FAIL"),
        ):
            source = (
                "void bump(int *p) /*@ With v Require data_at(p,int,v) "
                "Ensure exists w,data_at(p@pre,int,w) */ { *p += 1; }\n"
                "int sample(int *p) /*@ Require data_at(p,int,7) "
                "Ensure __return==9 && data_at(p@pre,int,9) */ "
                "{ int i=0; /*@ Inv 0<=i && i<=2 && data_at(p,int,7+i) */ "
                "while(i<2) { bump(p); i++; } /*@ Assert "
                + assertion
                + " */ return *p; }"
            )
            for mode in ("entry-exit", "all-boundaries"):
                with self.subTest(assertion=assertion, mode=mode):
                    result = self.run_source(
                        source, mode, annotation_policy="check-preserve"
                    )
                    self.assertEqual(result["status"], expected, result)
                    self.assertEqual(result["phases"]["execution"], "PASS", result)
                    self.assertEqual(result["phases"]["postcondition"], "PASS", result)

    def test_auxiliary_stack_frame_does_not_discard_unmentioned_user_heap(self):
        result = self.run_source(
            "int sample(int *p,int *q) /*@ Require data_at(p,int,7) * data_at(q,int,8) "
            "Ensure __return==7 && data_at(p@pre,int,7) * data_at(q@pre,int,8) */ "
            "{ int unused=2; /*@ Assert data_at(p,int,7) */ return *p; }",
            "all-boundaries",
        )
        self.assertEqual(result["status"], "UNKNOWN", result)
        self.assertEqual(result["phases"]["execution"], "PASS", result)
        self.assertEqual(result["phases"]["postcondition"], "PASS", result)

    def test_uninitialized_scalar_local_is_preserved_in_observation_frame(self):
        result = self.run_source(
            "int sample(int *p) /*@ Require data_at(p,int,7) "
            "Ensure __return==7 && data_at(p@pre,int,7) */ "
            "{ int unused; /*@ Assert data_at(p,int,7) */ return *p; }",
            "all-boundaries",
        )
        self.assertEqual(result["status"], "PASS", result)

    def test_local_pointer_observations_resolve_current_existential_values(self):
        for declaration, statement, assertion, expected in (
            ("int i=1; int *q=&i;", "", "data_at(q,int,1)", "PASS"),
            ("int i=1; int *q=&i;", "", "data_at(q,int,99)", "FAIL"),
            ("int i=1; int *q=&i;", "*q=3;", "data_at(q,int,3)", "PASS"),
            ("int i=1; int *q=&i;", "*q=3;", "data_at(q,int,1)", "FAIL"),
            ("int i=1; int *q=&i; int **r=&q;", "", "data_at(*r,int,1)", "PASS"),
            ("int i=1; int *q=&i; int **r=&q;", "", "data_at(*r,int,99)", "FAIL"),
            ("int i=1; int j=4; int *q=&j;", "q=&i;", "data_at(q,int,1)", "PASS"),
            ("int i=1; int j=4; int *q=&j;", "q=&i;", "data_at(q,int,4)", "FAIL"),
        ):
            source = (
                "int sample(void) /*@ Require emp Ensure __return==2 && emp */ { "
                + declaration
                + statement
                + " /*@ Assert "
                + assertion
                + " */ *q=2; return i; }"
            )
            for mode in ("entry-exit", "all-boundaries"):
                with self.subTest(assertion=assertion, statement=statement, mode=mode):
                    result = self.run_source(
                        source, mode, annotation_policy="check-preserve"
                    )
                    self.assertEqual(result["status"], expected, result)
                    self.assertEqual(result["phases"]["execution"], "PASS", result)
                    self.assertEqual(result["phases"]["postcondition"], "PASS", result)

    def test_local_pointer_observations_use_each_current_execution_path(self):
        for second_value, expected in ((1, "PASS"), (4, "FAIL")):
            source = (
                "int sample(int *x) /*@ Require emp Ensure __return==2 && emp */ { "
                f"int i=1; int j={second_value}; int *q; "
                "if(x==0) q=&i; else q=&j; /*@ Assert data_at(q,int,1) */ "
                "*q=2; return *q; }"
            )
            for mode in ("entry-exit", "all-boundaries"):
                with self.subTest(second_value=second_value, mode=mode):
                    result = self.run_source(
                        source, mode, annotation_policy="check-preserve"
                    )
                    self.assertEqual(result["status"], expected, result)
                    self.assertEqual(result["phases"]["execution"], "PASS", result)
                    self.assertEqual(result["phases"]["postcondition"], "PASS", result)

    def test_local_pointer_observations_follow_loop_and_inline_call_updates(self):
        source = (
            "void step(int *p) /*@ With v Require data_at(p,int,v) "
            "Ensure data_at(p@pre,int,v+1) */ { *p+=1; } "
            "int sample(void) /*@ Require emp Ensure __return==3 && emp */ { "
            "int value=1; int *alias=&value; int round=0; "
            "/*@ Inv 0<=round && round<=2 && data_at(alias,int,1+round) */ "
            "while(round<2) { step(alias); round++; } "
            "/*@ Assert data_at(alias,int,3) */ return *alias; }"
        )
        for mode in ("entry-exit", "all-boundaries"):
            with self.subTest(mode=mode):
                result = self.run_source(
                    source, mode, annotation_policy="check-preserve"
                )
                self.assertEqual(result["status"], "PASS", result)

    def test_field_strategy_matches_normalized_symbolic_offset_without_name_dispatch(
        self,
    ):
        # Trusted provider fixture: observed(p,v) means ownership of the named
        # scalar field. This exercises the existing QCP strategy matcher, not
        # independent proof authorization of a user-provided strategy.
        for tag, field in (("Packet", "payload"), ("RenamedBox", "answer")):
            with tempfile.TemporaryDirectory() as directory:
                strategy = Path(directory) / "field.strategies"
                strategy.write_text(
                    "id : 810\npriority : core(3)\n"
                    f"left : store(field_addr(?p, {tag}, {field}), I32, ?v) at 0\n"
                    "right : observed(p, v) at 1\n"
                    "action : left_erase(0); right_erase(1);\n"
                )
                for expected_value in (8, 99):
                    for mode in ("entry-exit", "all-boundaries"):
                        source = (
                            f"struct {tag} {{ int pad; int {field}; }};\n"
                            "/*@ Extern Coq (observed : Z -> Z -> Assertion) */\n"
                            f"int sample(struct {tag} *p) /*@ Require p!=0 && data_at(&p->{field},int,7) "
                            f"Ensure __return==8 && observed(p@pre,{expected_value}) */ "
                            f"{{ p->{field}++; return p->{field}; }}\n"
                            f'/*@ include strategies "{strategy}" */\n'
                        )
                        with self.subTest(
                            tag=tag, expected_value=expected_value, mode=mode
                        ):
                            result = self.run_source(source, mode)
                            self.assertEqual(
                                result["status"],
                                "PASS" if expected_value == 8 else "UNKNOWN",
                                result,
                            )

    def test_invariant_checked_at_each_actual_iteration(self):
        for correct in (True, False):
            invariant = "0 <= i && i <= 2" if correct else "i == 0"
            source = (
                "int sample(void) /*@ Require emp Ensure __return == 2 && emp */ "
                "{ int i = 0; /*@ Inv " + invariant + " */ "
                "while (i < 2) { i++; } return i; }"
            )
            for mode in ("entry-exit", "all-boundaries"):
                with self.subTest(correct=correct, mode=mode):
                    result = self.run_source(source, mode)
                    expected = "FAIL" if not correct and mode == "all-boundaries" else "PASS"
                    self.assertEqual(result["status"], expected, result)

    def test_shape_array_goal_does_not_fix_existential_contents_to_zero(self):
        header = bundled_qcip_root() / "QCP_examples/QCP_demos_LLM/sll_shape_def.h"
        for value in (-13, 0, 7, 41):
            for form, bounds in (("full_shape", "1"), ("seg_shape", "0,1")):
                with self.subTest(value=value, form=form):
                    result = self.run_source(
                        f'#include "{header}"\n'
                        'int sample(int *p) /*@ Require data_at(p,int,'
                        f'{value}) Ensure __return=={value} && '
                        f'IntArray::{form}(p,{bounds}) */ {{ return *p; }}',
                        "all-boundaries",
                    )
                    self.assertEqual(result["precondition_result"], "SAT", result)
                    self.assertTrue(result["execution_completed"], result)
                    self.assertNotEqual(result["test_result"], "FAIL", result)
                    self.assertFalse(any(v["status"] == "INVALID"
                                         for v in result["vc_results"]), result)

    def test_loop_limit_is_unknown(self):
        result = self.run_source(
            "int sample(void) /*@ Require emp Ensure emp */ { while(1) {} return 0; }",
            "entry-exit",
            loop_unroll_limit=2,
        )
        self.assertEqual(result["status"], "UNKNOWN", result)
        self.assertEqual(result["reason"], "loop_unroll_limit", result)

    def test_selects_contract_from_an_earlier_declaration(self):
        source = (
            "int sample(int *p) /*@ chosen Require data_at(p, int, 3) "
            "Ensure __return == 3 && data_at(p, int, 3) */; "
            "int sample(int *p) /*@ implementation Require data_at(p, int, 9) "
            "Ensure __return == 9 && data_at(p, int, 9) */ { return *p; }"
        )
        for mode in ("entry-exit", "all-boundaries"):
            result = self.run_source(source, mode, spec="chosen")
            self.assertEqual(result["status"], "PASS", result)

    def test_partial_instance_keeps_unbound_logic_variables(self):
        source = (
            "int sample(int *p) /*@ With (n: Z) (v: Z) "
            "Require n == 2 && data_at(p, int, v) "
            "Ensure __return == v && data_at(p, int, v) */ { return *p; }"
        )
        for mode in ("entry-exit", "all-boundaries"):
            result = self.run_source(source, mode, values={"n": 2})
            self.assertEqual(result["status"], "PASS", result)

    def test_shape_cells_are_fresh_symbolic_values(self):
        result = self.run_source(
            "int sample(int *p) /*@ Require IntArray::full_shape(p, 2) "
            "Ensure __return == 0 && IntArray::full_shape(p, 2) */ "
            "{ return p[0] + p[1]; }",
            "entry-exit",
        )
        self.assertEqual(result["phases"]["precondition"], "SAT", result)
        self.assertEqual(result["status"], "FAIL", result)
        self.assertEqual(result["phases"]["postcondition"], "UNKNOWN", result)

    def test_repeated_contract_calls_use_updated_contents(self):
        source = (
            "void step(int *p) /*@ With v Require data_at(p, int, v) "
            "Ensure data_at(p, int, v + 1) */ { *p = *p + 1; } "
            "int sample(int *p, int *q) /*@ Require data_at(p, int, 3) * data_at(q, int, 8) "
            "Ensure __return == 5 && data_at(p, int, 5) * data_at(q, int, 8) */ "
            "{ step(p); step(p); return *p; }"
        )
        for mode in ("entry-exit", "all-boundaries"):
            result = self.run_source(source, mode)
            self.assertEqual(result["status"], "PASS", result)

    def test_empty_nested_loop_state_does_not_crash_on_following_if(self):
        source = (
            "int sample(void) /*@ Require emp Ensure __return == 0 && emp */ "
            "{ int i; /*@ Inv 0 <= i && i <= 0 */ for(i=0;i<0;i++) { "
            "int j; /*@ Inv 0 <= i && i < 0 && 0 <= j && j <= 0 */ "
            "for(j=0;j<0;j++) {} if(i) i++; } return 0; }"
        )
        result = self.run_source(source, "all-boundaries")
        self.assertEqual(result["status"], "PASS", result)

    def test_invalid_require_stops_execution_in_both_modes(self):
        source = (
            "int sample(int *p) /*@ Require 0 == 1 && emp Ensure emp */ { return *p; }"
        )
        for mode in ("entry-exit", "all-boundaries"):
            result = self.run_source(source, mode)
            self.assertEqual(result["status"], "FAIL", result)
            self.assertEqual(result["phases"]["safety"], "NOT_RUN", result)
            self.assertEqual(result["phases"]["postcondition"], "NOT_RUN", result)

    def test_declaration_only_reports_checked_scope(self):
        for mode in ("entry-exit", "all-boundaries"):
            with self.subTest(mode=mode):
                result = self.run_source(
                    "int sample(void) /*@ Require emp Ensure emp */;", mode
                )
                self.assertEqual(result["status"], "PASS")
                self.assertEqual(result["scope"], "specification-only")
                self.assertEqual(
                    result["phases"],
                    {
                        "precondition": "SAT",
                        "execution": "NOT_RUN",
                        "safety": "NOT_RUN",
                        "postcondition": "NOT_RUN",
                        "annotations": "NOT_RUN",
                    },
                )
                self.assertEqual(result["vc"]["status"], "auto_proved")

    def test_declaration_unknown_keeps_residual_vc(self):
        for mode in ("entry-exit", "all-boundaries"):
            result = self.run_source(
                "/*@ Extern Coq (opaque : Z -> Assertion) */\n"
                "int sample(void) /*@ Require opaque(0) Ensure emp */;",
                mode,
            )
            self.assertEqual(result["status"], "UNKNOWN")
            self.assertEqual(result["phases"]["execution"], "NOT_RUN")
            self.assertTrue(result["vc"]["residual_goals"])

    def test_declaration_without_spec_is_error(self):
        for mode in ("entry-exit", "all-boundaries"):
            self.assertEqual(
                self.run_source("int sample(void);", mode)["status"], "ERROR"
            )

    def test_symbolic_overlapping_cells_are_unsatisfiable(self):
        for mode in ("entry-exit", "all-boundaries"):
            result = self.run_source(
                "void sample(int *p, int *q) /*@ Require "
                "(p == q + 0) && data_at(p, int, 1) * data_at(q, int, 2) "
                "Ensure emp */;",
                mode,
            )
            self.assertEqual(result["phases"]["precondition"], "UNSAT")
            self.assertEqual(result["status"], "FAIL")


if __name__ == "__main__":
    unittest.main()
