"""Check previously proved guard rules in the environment of a final Auto VC."""
import hashlib
from pathlib import Path
import re
import tempfile
import time

from .core import _coq_load_path_args, _coq_required_modules
from .errors import FieldLayoutMismatch
from .layout_guards import compile_unit, guard_header


def digest(raw):
    return hashlib.sha256(raw).hexdigest()


def checked(path, expected):
    raw = Path(path).read_bytes()
    if digest(raw) != expected:
        raise FieldLayoutMismatch("guard recheck source hash differs: " + Path(path).name)
    return raw


def alignment_proof_source(source, layout):
    """Change only opaque Qed proof bodies. Coq checks every original statement."""
    ident = r"[A-Za-z_][A-Za-z0-9_]*"
    widths = {"Char": 1, "UChar": 1, "Short": 2, "UShort": 2, "Int": 4, "UInt": 4,
              "Float": 4, "Int64": 8, "UInt64": 8, "Double": 8, "Ptr": layout["pointer_size"]}
    edits = []
    for record in layout["aggregates"]:
        tag = record["name"]
        if not tag or not re.fullmatch(ident, tag) or record["kind"] != "struct" or not record["defined"]:
            continue
        if sum(r["name"] == tag and r["kind"] == "struct" for r in layout["aggregates"]) != 1:
            continue
        pred = "UndefStructPred" + tag
        definition = re.search(r"(?m)^Definition " + pred + r" \(x : Z\) : Assertion :=\s*(.*?)\.(?=\s|$)",
                               source, re.S)
        lemma = re.search(r"(?m)^Lemma undefstore_Pred" + tag + r"_to_align : forall x,\s*" + pred
                          + r" x \|-- store_align_n [^.;]+\.\s*Proof\.\s*(?P<body>.*?)^Qed\.", source, re.S)
        if not definition or not lemma:
            continue
        # Restrict replacement to the tactics emitted in an opaque alignment proof.
        # A Defined/Admitted terminator or a following declaration must never be swallowed.
        tactic = r"(?:intros\.|unfold \w+\.|sep_apply [^.\n]+\.|replace [^.\n]+ by\s+\(simpl_nonptr_sizeof; ring\)\.|cancel\.)"
        if not re.fullmatch(r"(?:\s*" + tactic + r")+\s*", lemma["body"]):
            continue
        cells = definition[1].split("**")
        fields = sorted(record["fields"], key=lambda f: f.get("offset", -1))
        if not fields or len(fields) != len(cells):
            continue
        steps = ["  intros x.", "  unfold " + pred + "."]
        sizes = []
        for f, atom in zip(fields, cells):
            field = f["name"]
            if not field or not re.fullmatch(ident, field) or not f["computational"] or f["offset"] != sum(sizes):
                break
            addr = f'&(x # "{tag}" ->ₛ "{field}")'
            cell = re.fullmatch(r"\(\(" + re.escape(addr) + r"\)\s*#\s*(\w+)\s*\|->_\)", atom.strip())
            if not cell or widths.get(cell[1]) != f["size"] or cell[1] == "Ptr" and f["size"] != 4:
                break
            size = f["size"]
            lemma_name = "undef_store_" + cell[1].lower() + ("_align4" if size >= 4 else "_align")
            steps.append(f"  sep_apply ({lemma_name} ({addr})).")
            if size >= 4:
                steps.append(f"  sep_apply (store_align4_to_store_align {size // 4}).")
                if len(fields) > 2:
                    steps.append(f"  change (4 * {size // 4})%Z with {size}%Z.")
            sizes.append(size)
        else:
            if sum(sizes) != record["size"]:
                continue
            total = sizes[0]
            for index, size in enumerate(sizes[1:], start=1):
                steps.append(f"  sep_apply (store_align_merge {total} {size}).")
                if index < len(sizes) - 1:
                    steps.append(f"  change ({total} + {size})%Z with {total + size}%Z.")
                total += size
            steps.extend([f"  change (store_align_n {total} |-- store_align_n {total}).", "  cancel."])
            edits.append((*lemma.span("body"), "\n".join(steps) + "\n"))
    for start, end, replacement in sorted(edits, reverse=True):
        source = source[:start] + replacement + source[end:]
    return source


def recheck(context, manifest, compiler):
    started = time.monotonic()
    goal = checked(manifest["files"]["goal"], manifest["immutable_sha256"]["goal"]).decode()
    header = guard_header(goal)
    generated = manifest.get("generated_coq_dependencies", [])
    if ({d["module"] for d in generated} != {"input_def"} or context["generated_modules"] or
            header.count("Require Import input_def.\n") != 1 or
            digest(header.replace("Require Import input_def.\n", "").encode()) != context["header_sha256"]):
        raise FieldLayoutMismatch("final guard context has changes beyond the generated definitions")
    src_hashes, checks = {}, {}
    peak = []
    with tempfile.TemporaryDirectory(prefix="tespec-final-guards-") as temp:
        root = Path(temp)
        args = [*compiler, "-q", *_coq_load_path_args(Path(manifest["qcip_root"])/"SeparationLogic", root)]
        def compile_file(path):
            rss = root / "coqc.rss"
            error = compile_unit(["/usr/bin/time", "-q", "-f", "%M", "-o", str(rss), *args], root, path)
            if rss.exists() and rss.read_text().strip().isdigit():
                peak.append(int(rss.read_text().strip()))
            return error

        pending = {}
        for dep in [*manifest["coq_dependencies"], *generated]:
            name = dep["module"]
            if not re.fullmatch(r"[A-Za-z_]\w*(?:\.[A-Za-z_]\w*)*", name) or name in pending:
                raise FieldLayoutMismatch("ambiguous final guard module")
            raw = checked(dep["staged"], dep["sha256"])
            target = root.joinpath(*name.split(".")).with_suffix(".v")
            target.parent.mkdir(parents=True, exist_ok=True)
            target.write_bytes(raw)
            pending[name] = target
        while pending:
            ready = [n for n, p in pending.items() if not set(_coq_required_modules(p.read_text())) & pending.keys()]
            if not ready:
                raise FieldLayoutMismatch("cyclic final guard dependencies")
            for name in ready:
                path = pending.pop(name)
                error = compile_file(path)
                if name == "input_def":
                    original = path.read_bytes()
                    if error:
                        replacement = alignment_proof_source(original.decode(), manifest["target_layout"]).encode()
                        if replacement != original:
                            path.write_bytes(replacement)
                            error = compile_file(path)
                    src_hashes[name] = {"original": digest(original), "compiled_source": digest(path.read_bytes())}
                if error:
                    raise FieldLayoutMismatch("final dependency did not compile: " + name + ": " + error)
        proof_dir = Path(context["path"]).parent
        for name, expected in sorted(context["proof_files"].items()):
            if not re.fullmatch(r"TeSpecGuard_[a-f0-9]{24}(?:_Bindings)?\.v", name) or (root/name).exists():
                raise FieldLayoutMismatch("unexpected or colliding guard proof name")
            raw = checked(proof_dir / name, expected)
            if name.endswith("_Bindings.v"):
                marker = "Require " + name.removesuffix("_Bindings.v") + "."
                prefix, sep, tail = raw.decode().partition(marker)
                if not sep or not prefix.endswith("\n") or digest(prefix[:-1].encode()) != context["header_sha256"]:
                    raise FieldLayoutMismatch("unbound original association header")
                raw = (header + "\n" + marker + tail).encode()
            path = root / name
            path.write_bytes(raw)
            error = compile_file(path)
            if error:
                raise FieldLayoutMismatch("final guard check did not compile: " + name + ": " + error)
            checks[name] = {"original": expected, "compiled_source": digest(raw)}
    return {"status": "checked_final_context", "goal_sha256": manifest["immutable_sha256"]["goal"],
            "header_sha256": digest(header.encode()), "generated": src_hashes, "proofs": checks,
            "wall_seconds": time.monotonic()-started, "max_process_rss_kib": max(peak, default=None),
            "tokens": 0, "model_calls": 0}
