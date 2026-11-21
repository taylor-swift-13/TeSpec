"""The layout preparation boundary is independent of predicate, field and case names."""

import json
import os
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest

from spectest.errors import FieldLayoutMismatch
from spectest.layout_job import (
    prepare_layout_job,
    reject_old_qualifiers,
    rewrite_imports,
    validate_layout_context,
)
from spectest.core import run_job


class LayoutJobTest(unittest.TestCase):
    def test_only_real_imports_are_rebound(self):
        names = {"Pkg.Left": "BoundLeft"}
        command = "/*@ Import Coq From Pkg Require Import Left Right */"
        src = f'char *example = "{command}";\n// {command}\n{command}'
        self.assertEqual(
            rewrite_imports(src, names),
            src[: src.rindex(command)]
            + "/*@ Import Coq Require Import BoundLeft Pkg.Right */",
        )
        coq = '(* Require Pkg.Left. *) Definition s := "Require Pkg.Left.". From Pkg Require Export Left Right.'
        self.assertEqual(
            rewrite_imports(coq, names, coq=True),
            coq.replace(
                "From Pkg Require Export Left Right.",
                "Require Export BoundLeft Pkg.Right.",
            ),
        )

    def test_old_qualified_references_are_rejected(self):
        names = {"Pkg.OldFields": "PreparedFields"}
        reject_old_qualifiers(
            '(* Pkg.OldFields.p *) Definition s := "OldFields.p". Check PreparedFields.p.',
            names,
        )
        for prefix in ("Pkg.OldFields", "OldFields"):
            with self.subTest(prefix=prefix), self.assertRaises(FieldLayoutMismatch):
                reject_old_qualifiers(f"Definition stale := {prefix}.p.", names)

    def test_use_target_layout_in_ordinary_jobs(self):
        compiler = shutil.which(os.environ.get("COQC", "coqc"))
        if not compiler or "version 8.20" not in subprocess.check_output(
            [compiler, "-v"], text=True
        ):
            self.skipTest(
                "Coq 8.20 is required to compile complete predicate libraries"
            )
        try:
            from spectest.auto_route import run_auto
            import z3  # noqa: F401
        except ImportError:
            self.skipTest("optional Z3 backend")
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            dep = root / "ParcelCells.v"
            (root / "ParcelAPI.v").write_text(
                "From SimpleC.Verification Require Import VCPrelude.\n"
                "Import naive_C_Rules.\nRequire Import ParcelCells.\n"
                "Definition owns_slot (p : Z) : Assertion := slot_field p.\n"
            )
            header = root / "types.h"
            header.write_text(
                "struct envelope { int padding; int contents; };\n"
                "struct parcel { int stamp; struct envelope box; };\n"
                "/*@ Extern Coq (owns_slot : Z -> Assertion) */\n"
                "/*@ Import Coq Require Import ParcelAPI */\n"
            )
            src = root / "inspect.c"
            src.write_text(
                '#include "types.h"\nint inspect(struct parcel *p)\n'
                "/*@ Require owns_slot(p) * data_at(&(p->stamp), int, 7)\n"
                "    Ensure __return == 0 && owns_slot(p) * data_at(&(p->stamp), int, 7) */\n"
                "{ return 0; }"
            )
            original = src.read_bytes(), header.read_bytes()
            job = root / "original.json"
            job.write_text(
                json.dumps(
                    {
                        "source": str(src),
                        "function": "inspect",
                        "binds": [{"args": {"p": 4096}, "values": {}}],
                        "qcp": {"vc_scope": "all-boundaries"},
                    }
                )
            )
            for field, entry, status in [
                ('"box" .ₛ "contents"', "SAT", "PASS"),
                ('"stamp"', "UNSAT", "FAIL"),
            ]:
                dep.write_text(
                    "From SimpleC.Verification Require Import VCPrelude.\n"
                    "Import naive_C_Rules.\nLocal Open Scope Z_scope.\nLocal Open Scope sac.\n"
                    f'Definition offset_of (base : Z) : Z := &(base # "parcel" ->ₛ {field}).\n'
                    "Definition slot_at (p : Z) : Assertion := p # Int |-> 9.\n"
                    "Definition slot_field (base : Z) : Assertion := slot_at (offset_of base).\n"
                )
                dest = root / status
                prepare_layout_job(job, ["ParcelCells"], dest, coqc_command=[compiler])
                derived = dest / "job.json"
                native = run_job(derived, dest / "native")
                result = run_auto(native, dest / "auto")["results"][0]
                self.assertEqual(
                    (result["status"], result["auto_route"]["entry"]["status"]),
                    (status, entry),
                )
                manifest = native["results"][0]["vc"]
                context = json.loads(derived.read_text())["field_layout_context"]
                self.assertEqual(set(context["modules"]), {"ParcelCells", "ParcelAPI"})
                runtime = context["runtime_source_sha256"]
                with self.assertRaises(FieldLayoutMismatch):
                    validate_layout_context(
                        dict(context, target_layout_sha256="0" * 64), manifest, runtime
                    )
                with self.assertRaises(FieldLayoutMismatch):
                    validate_layout_context(context, manifest, "1" * 64)
                wrong_modules = dict(context, modules={"ParcelCells": "OtherModule"})
                with self.assertRaises(FieldLayoutMismatch):
                    validate_layout_context(wrong_modules, manifest, runtime)
                other = context["modules"]["ParcelCells"]
                wrong_hash = {**context["dependencies"], other: "0" * 64}
                with self.assertRaises(FieldLayoutMismatch):
                    validate_layout_context(
                        dict(context, dependencies=wrong_hash), manifest, runtime
                    )
            self.assertEqual((src.read_bytes(), header.read_bytes()), original)
