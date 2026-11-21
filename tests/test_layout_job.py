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

    def test_hidden_scalar_guard_survives_native_unfolding(self):
        compiler = shutil.which(os.environ.get("COQC", "coqc"))
        if not compiler or "version 8.20" not in subprocess.check_output(
            [compiler, "-v"], text=True
        ):
            self.skipTest(
                "Coq 8.20 is required to check the projection and its bindings"
            )
        try:
            from spectest.auto_route import run_auto
            import z3  # noqa: F401
        except ImportError:
            self.skipTest("optional Z3 backend")
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            (root / "Tags.v").write_text(
                "From SimpleC.Verification Require Import VCPrelude.\n"
                "Import naive_C_Rules.\nLocal Open Scope Z_scope.\nLocal Open Scope sac.\n"
                "Definition stamp (v : Z) : Assertion := “ 7 <= v ” && emp.\n"
                "Definition box (base : Z) : Assertion := EX v : Z, (base # Int |-> v) ** stamp v.\n"
            )
            (root / "weak.strategies").write_text(
                "id : 4\npriority : core(3)\nleft : box(?base) at 0\n"
                "action : left_erase(0); left_exist_add(v : Z); left_add(data_at(base,int,v)); left_add(stamp(v));\n\n"
                "id : 5\npriority : core(3)\nleft : stamp(?v) at 0\naction : left_erase(0);\n"
            )
            source = root / "sample.c"
            source.write_text(
                "/*@ Extern Coq (box : Z -> Assertion) (stamp : Z -> Assertion) */\n"
                '/*@ Import Coq Require Import Tags */\n/*@ include strategies "weak.strategies" */\n'
                "int check_tag(int *p) /*@ Require box(p) Ensure __return >= 7 && data_at(p,int,__return) */ {return *p;}\n"
                "int stricter(int *p) /*@ Require box(p) Ensure __return >= 8 && data_at(p,int,__return) */ {return *p;}\n"
                "int invalid_input(int *p) /*@ Require stamp(6) Ensure __return == 0 && emp */ {return 0;}\n"
            )
            original = root / "job.json"
            original.write_text(
                json.dumps(
                    {
                        "source": str(source),
                        "function": "check_tag",
                        "binds": [{"args": {"p": 4096}, "values": {}}],
                    }
                )
            )
            bundle = root / "prepared"
            receipt = prepare_layout_job(
                original, ["Tags"], bundle, coqc_command=[compiler]
            )
            proved = receipt["guard_projection"]["proved"]
            self.assertEqual(
                [(r["predicate"].split(".")[-1], r["guards"]) for r in proved],
                [("stamp", 1)],
            )
            job = json.loads((bundle / "job.json").read_text())
            guard = job["field_layout_context"]["guard_projection"]

            def run(function, label, config):
                file = root / (label + ".json")
                file.write_text(json.dumps(dict(config, function=function)))
                native = run_job(file, root / (label + "-native"))
                return run_auto(native, root / (label + "-auto"))["results"][0]

            positive = run("check_tag", "checked", job)
            self.assertEqual(
                positive["status"], "PASS", positive.get("error", positive["phases"])
            )
            stricter = run("stricter", "negative", job)
            self.assertNotEqual(stricter["status"], "PASS", stricter["phases"])
            self.assertNotEqual(stricter["phases"]["postcondition"], "PASS")
            self.assertIn(stricter["status"], ("FAIL", "UNKNOWN"))
            invalid = run("invalid_input", "wrong-input", job)
            self.assertEqual(
                invalid["status"], "FAIL", invalid.get("error", invalid.get("phases"))
            )
            self.assertEqual(invalid["phases"]["precondition"], "UNSAT")
            unchecked = dict(
                job, field_layout_context=dict(job["field_layout_context"])
            )
            del unchecked["field_layout_context"]["guard_projection"]
            self.assertNotEqual(
                run("check_tag", "weak", unchecked)["phases"]["postcondition"], "PASS"
            )
            binding = next((bundle / "guards").glob("*_Bindings.v"))
            checked_source = binding.read_bytes()
            binding.write_bytes(checked_source + b"(* stale *)")
            altered = run("check_tag", "altered-proof", job)
            self.assertEqual(
                (altered["status"], altered["reason"]),
                ("ERROR", "field_layout_context_mismatch"),
            )
            binding.write_bytes(checked_source)
            Path(guard["path"]).write_text(
                Path(guard["path"]).read_text().replace("7", "8")
            )
            stale = run("check_tag", "stale", job)
            self.assertEqual(
                (stale["status"], stale["reason"]),
                ("ERROR", "field_layout_context_mismatch"),
            )

            # The same C spelling can resolve to a different Coq definition.
            # The equation from Tags still holds, but its binding check must fail.
            (root / "Different.v").write_text(
                "From SimpleC.Verification Require Import VCPrelude.\n"
                "Import naive_C_Rules. Local Open Scope sac.\n"
                "Definition stamp (v : Z) : Assertion := emp.\n"
            )
            source.write_text(
                source.read_text().replace(
                    "Require Import Tags */", "Require Import Tags Different */"
                )
            )
            shadow = root / "shadowed"
            omitted = prepare_layout_job(
                original, ["Tags"], shadow, coqc_command=[compiler]
            )
            self.assertIn("stamp", omitted["guard_projection"]["skipped"])
            self.assertNotIn(
                "guard_projection",
                json.loads((shadow / "job.json").read_text())["field_layout_context"],
            )
