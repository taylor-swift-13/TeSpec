"""Exact, bounded reduction of transparent first-order definitions on a query copy.

A branch describes a *whole* finite heap. Pure guards constrain that heap;
they cannot replace emp or be interpreted as owning an empty heap themselves.
Unsupported syntax, dependency contexts and exhausted budgets fail closed.
"""

from __future__ import annotations

import hashlib
import json
import re
from dataclasses import dataclass
from functools import lru_cache
from pathlib import Path

from .certificates import strip_comments
from .core import JobError, _coq_required_modules
from .layout import generate_layout_source, resolve_field_path
from .layout_libraries import ADDRESS_ALIASES
from .rocq_predicates import _application_parts, _strip_outer_parens, field_access
from tools.finite_spatial_smt.finite_spatial_smt import (
    CONSTANTS,
    Unsupported,
    check,
    encode,
)
from tools.finite_spatial_smt import qcp_import as qcp
from tools.finite_spatial_smt.finite_qcp_terms import normalize_builtin_type_arguments
import z3


ID = r"[A-Za-z_][A-Za-z0-9_]*"
RESERVED = {
    "nil",
    "cons",
    "emp",
    "True",
    "False",
    "Z",
    "list",
    "store",
    "has_permission",
    "INT_MIN",
    "INT_MAX",
    "prop_true",
    "prop_false",
    "Z_1",
}
TYPES = {
    "Int": "signed int",
    "UInt": "unsigned int",
    "Ptr": "PTR",
    "Char": "signed char",
    "UChar": "unsigned char",
    "Short": "signed short",
    "UShort": "unsigned short",
    "Int64": "signed I64",
    "UInt64": "unsigned I64",
}
SCOPES = {"sac", "Z_scope", "list", "list_scope", "sets", "string_scope"}
# The known preludes establish the concrete meanings of cells, sepcon, pure
# quotation, list constructors and integers. Extra notations/imports are opaque.
PRELUDE = {
    "Coq.ZArith.ZArith",
    "Coq.Bool.Bool",
    "Coq.Strings.String",
    "Coq.Strings.Ascii",
    "Coq.Lists.List",
    "Coq.Classes.RelationClasses",
    "Coq.Classes.Morphisms",
    "Coq.micromega.Psatz",
    "Coq.Sorting.Permutation",
    "SetsClass.SetsClass",
    "Logic.LogicGenerator.demo932.Interface",
    "SimpleC.SL.Mem",
    "SimpleC.SL.SeparationLogic",
    "SimpleC.Verification.VCPrelude",
    "AUXLib.int_auto",
    "AUXLib.Axioms",
    "AUXLib.Feq",
    "AUXLib.Idents",
    "AUXLib.ListLib",
    "AUXLib.VMap",
}


RESERVED.update(CONSTANTS)
RESERVED.update(TYPES)
RESERVED.update(
    {
        "Assertion",
        "TT",
        "Zlength",
        "Znth",
        "repeat_Z",
        "app",
        "pointer_offset",
        "nil",
        "prop_false",
        "prop_true",
        "truep",
    }
)


def require(ok, reason):
    if not ok:
        raise Unsupported(reason)


def split_operator(text, op, *, stop_at_binder=False):
    """Find a top-level operator; protect field strings and quoted propositions."""
    depth = 0
    quote = ""
    for i, ch in enumerate(text):
        if quote:
            if ch == quote:
                quote = ""
        elif ch in '"“':
            quote = "”" if ch == "“" else '"'
        elif ch == "(":
            depth += 1
        elif ch == ")":
            depth -= 1
            require(depth >= 0, "unbalanced_definition")
        elif not depth:
            if stop_at_binder and text[i : i + 3] == "EX ":
                return None
            if text.startswith(op, i):
                return text[:i].strip(), text[i + len(op) :].strip()
    require(not depth and not quote, "unbalanced_definition")
    return None


def unparen(text):
    return _strip_outer_parens(text.strip()).strip()


def typ(text):
    text = " ".join(unparen(text).split()).replace("@list Z", "list Z")
    require(text in ("Z", "list Z", "Assertion"), "unsupported_definition_type:" + text)
    return text


@dataclass(frozen=True)
class Definition:
    args: tuple
    result: str
    body: str
    field_notation: bool
    recursive: bool
    visible: frozenset = frozenset()


def proof_tactics(command):
    # Tactics are inert here. Vernacular commands can change the interpretation
    # of later declarations and must still be rejected.
    text = re.sub(r"^[-+*] +", "", command)
    assertion = re.fullmatch(r"assert \([\w ():*=+\-]+\) by \(([^()]*)\)", text)
    if assertion:
        text = assertion[1]
    # Only recognize complete tactic phrases, including the tactics in a
    # branch or in a replacement proof. Vernacular commands remain barriers.
    replacement = re.fullmatch(
        r"replace [\w ()*+\-]+ with [\w ()*+\-]+ by \(([^()]*)\)", text
    )
    if replacement:
        text = replacement[1]
    text = re.sub(r"destruct (\w+) as \[\|(\w+) (\w+)\]", r"destruct \1", text)
    branches = re.fullmatch(r"(.*); \[([^][]*)\]", text)
    if branches:
        return proof_tactics(branches[1]) and all(
            not branch.strip() or proof_tactics(branch.strip())
            for branch in branches[2].split("|")
        )
    return all(
        re.fullmatch(
            r"(?:try )?(?:intros?|Intros|Exists|simpl|revert|subst|induction|destruct|"
            r"congruence|constructor|entailer!|tauto|easy|lia|sep_apply|prop_apply|rewrite|"
            r"cancel|simpl_nonptr_sizeof|ring)"
            r"(?: [\w ()',:\-=+*]+)?",
            tactic.strip(),
        )
        for tactic in text.split(";")
    )


def parse_library(source, module_exports):
    definitions = {}
    known_modules = set(module_exports)
    imported = set()
    field_notation = False
    address_prelude = False
    address_aliases = False
    checked_aliases = {}
    # Keep proof scripts opaque. Only a restricted, tactic-only proof body
    # is inert here: vernacular syntax, scope and import changes are barriers.
    in_proof = False
    opaque = Definition((), "opaque", "", False, False)
    commands = re.split(r"\.(?=\s|$)", strip_comments(source).strip())
    commands = [" ".join(command.split()) for command in commands]
    layout_context = (
        "GeneratedLayout" in known_modules
        and "Import GeneratedLayout.AddressNotations" in commands
    )
    for command in commands:
        if not command:
            continue
        if in_proof:
            if command in {"Qed", "Defined"}:
                in_proof = False
                continue
            require(
                command == "Proof"
                or proof_tactics(command)
                or re.fullmatch(
                    r"(?:[-+*] )?(?:intros?|reflexivity|assumption|apply|exact|unfold|simpl|cbn|lia|split|constructor|destruct|induction|rewrite)(?: [\w ()',:\-=+*]+)?",
                    command,
                ),
                "unsupported_vernacular_in_auxiliary_proof",
            )
            continue
        record = re.fullmatch(
            rf"Record ({ID}) : Type := ({ID}) \{{\s*((?:{ID}\s*:\s*Z\s*;\s*)*{ID}\s*:\s*Z)\s*\}}",
            command,
        )
        if record:
            # These declarations do not introduce any notation or coercion.
            # Reserve their names even when the current goal uses only cells.
            rec, constructor, fields = record.groups()
            exported = [rec, constructor, *re.findall(rf"({ID})\s*:", fields)]
            exported.extend(
                rec + suffix for suffix in ("_ind", "_rec", "_rect", "_sind")
            )
            require(
                len(set(exported)) == len(exported)
                and not set(exported)
                & (
                    definitions.keys()
                    | RESERVED
                    | imported
                    | {"addr", "NULL", "tt", "andp", "emp"}
                ),
                "reserved_or_duplicate_record_name",
            )
            definitions.update(dict.fromkeys(exported, opaque))
            imported.update(exported)
            continue
        if field_notation and address_aliases:
            checks = {check: name for name, (check, _) in ADDRESS_ALIASES.items()}
            if command in checks:
                name = checks[command]
                checked_aliases[name] = ADDRESS_ALIASES[name][1]
                continue
        if checked_aliases:
            require(
                not ({"NULL", "addr"} & (definitions.keys() | imported)),
                "shadowed_address_alias",
            )
            # Preserve quoted field names. Only normalize aliases from the
            # admitted QCP prelude in the computational notation context.
            command = re.sub(
                r'"(?:[^"]|"")*"|(?<![\w.\'])(?:NULL|addr)(?![\w\'])',
                lambda m: checked_aliases.get(m[0], m[0]),
                command,
            )
        declared = re.match(
            r"(?:Definition|Fixpoint|Lemma|Theorem|Corollary|Fact) ("
            + ID
            + r"'*)(?![\w'])",
            command,
        )
        if declared:
            name = declared[1]
            require(
                name not in definitions and name not in RESERVED,
                "reserved_or_duplicate_definition",
            )
            require(
                not re.search(
                    r"\b(?:where|Notation|ltac|with_definition)\b|[;#]\[", command
                ),
                "unsupported_definition_notation",
            )
            if command.split()[0] in {"Lemma", "Theorem", "Corollary", "Fact"}:
                definitions[name] = opaque
                in_proof = ":=" not in command
                continue
        m = re.fullmatch(r"(?:From ([\w.]+) )?Require Import ([\w. ]+)", command)
        if m:
            modules = [(m[1] + "." if m[1] else "") + n for n in m[2].split()]
            allowed = set(PRELUDE)
            if layout_context:
                allowed.update({"Permutation", "String", "compcert.lib.Integers"})
                require(
                    not set(modules) & {"Permutation", "String"} & known_modules,
                    "ambiguous_standard_import",
                )
            if (
                "SimpleC.SL.SeparationLogic" in modules
                or "SimpleC.Verification.VCPrelude" in modules
            ):
                address_prelude = True
            if set(modules) - {"GeneratedLayout"}:
                address_aliases = False
                field_notation = False
                checked_aliases.clear()
            require(
                set(modules) <= allowed | known_modules, "unverified_definition_import"
            )
            for module in modules:
                if module in allowed:
                    imported.clear()
                else:
                    imported.update(module_exports[module])
            continue
        if command == "Import GeneratedLayout.AddressNotations":
            require("GeneratedLayout" in known_modules, "missing_generated_layout")
            imported.clear()
            field_notation = True
            continue
        if command in (
            "Import naive_C_Rules",
            "Import SetsNotation",
            "Import ListNotations",
        ):
            imported.clear()
            field_notation = False
            checked_aliases.clear()
            address_aliases = address_prelude and command == "Import naive_C_Rules"
            continue
        m = re.fullmatch(r"Local Open Scope (\w+)", command)
        if m and (m[1] in SCOPES or (layout_context and m[1] == "string")):
            continue
        m = re.fullmatch(
            r"(Definition|Fixpoint) ("
            + ID
            + r")\s*((?:\([^()]*\)\s*)*)(?::\s*(Z|list Z|Assertion)\s*)?:=\s*(.+)",
            command,
        )
        if not m and declared and ":=" in command:
            definitions[name] = opaque
            continue
        require(m, "unsupported_definition_context:" + command[:65])
        if any(
            unparen(arg[2].strip()) not in {"Z", "list Z"}
            for arg in re.finditer(r"\(([^():]+):([^()]*)\)", m[3])
        ):
            definitions[name] = opaque
            continue
        args = []
        for binder in re.finditer(r"\(([^():]+):([^()]*)\)", m[3]):
            args.extend((name, typ(binder[2])) for name in binder[1].split())
        require(
            len(re.findall(r"\(", m[3]))
            == len(re.findall(r"\(([^():]+):([^()]*)\)", m[3]))
            and len({n for n, t in args}) == len(args)
            and all(
                re.fullmatch(ID, n) and n not in RESERVED and n != "_" and n != name
                for n, t in args
            ),
            "unsupported_definition_binders",
        )
        require(
            m[2] not in definitions and m[2] not in RESERVED,
            "reserved_or_duplicate_definition",
        )
        definitions[m[2]] = Definition(
            tuple(args),
            m[4] or "inferred",
            m[5],
            field_notation,
            m[1] == "Fixpoint",
            frozenset(imported | ({name} if m[1] == "Fixpoint" else set())),
        )
        imported.add(name)
    require(not in_proof, "unfinished_auxiliary_proof")
    return definitions


def frozen_bytes(path, expected):
    raw = Path(path).read_bytes()
    require(
        hashlib.sha256(raw).hexdigest() == expected,
        "definition_dependency_hash_mismatch",
    )
    return raw


@lru_cache(maxsize=32)
def parsed_module(raw, modules):
    return parse_library(raw.decode("utf-8"), dict(modules))


# The legacy library's field_address is abstract in its Rocq context.
# Admit its exact transparent definitions, while leaving that notation opaque.
_LEGACY_LIST_MODULE = "SimpleC.EE.QCP_demos_human.sll_lib"
_LEGACY_LIST_SHA256 = "91d172559c4b3e21b108c7e2a005476cc76d56337213ef65fb5a9ef1d433a9ad"
_QCP_ADDRESS_PRELUDE = {
    "Mem.v": "a4a92713ca60c93a5e2b65522d319de25eee1d78e53040d363bffc52f3ecc730",
    "CNotation.v": "a86a024fc3bb1fb5caedd5c522c3c29cd6cdf6ef7f029df14e252f366e670f6e",
}


def runtime_module(dep, raw, qcip_root, modules):
    if dep["module"] != _LEGACY_LIST_MODULE or dep["sha256"] != _LEGACY_LIST_SHA256:
        return parsed_module(raw, modules)

    base = Path(qcip_root) / "SeparationLogic/SeparationLogic"
    for file, sha in _QCP_ADDRESS_PRELUDE.items():
        frozen_bytes(base / file, sha)

    # The pinned file has three Fixpoints followed by opaque lemmas.
    # addr and NULL are definitional aliases in the pinned runtime prelude.
    source = raw.decode("utf-8")
    bodies, lemmas = source[source.index("Fixpoint ") :].split("Lemma ", 1)
    bodies = re.sub(r"\baddr\b", "Z", bodies)
    bodies = re.sub(r"\bNULL\b", "0", bodies)
    definitions = dict(parsed_module(bodies.encode("utf-8"), modules))
    opaque = Definition((), "opaque", "", False, False)
    for name in re.findall(r"(?m)^Lemma (" + ID + r")(?![\w'])", "Lemma " + lemmas):
        definitions[name] = opaque
    return definitions


def definitions_for(case):
    vc = case["vc"]
    layout = vc["target_layout"]
    frozen = json.loads(Path(vc["manifest"]).read_bytes())
    require(
        all(
            frozen.get(k) == vc.get(k)
            for k in (
                "target_layout",
                "coq_dependencies",
                "generated_coq_dependencies",
                "opaque_imports",
                "runtime_dependencies",
                "files",
                "immutable_sha256",
            )
        ),
        "definition_manifest_mismatch",
    )
    exports = {}
    definitions = {}
    runtime = {
        dep["module"]: dep
        for dep in vc["runtime_dependencies"]
        if dep["module"] not in PRELUDE
    }
    for dep in vc.get("generated_coq_dependencies", []):
        name = dep["module"]
        require(
            name not in runtime and name not in PRELUDE, "ambiguous_definition_module"
        )
        runtime[name] = dep | {"source": dep["staged"]}
    loading = set()

    def register(name, parsed):
        require(not definitions.keys() & parsed.keys(), "ambiguous_definition_name")
        definitions.update(parsed)
        exports[name] = tuple(sorted(parsed))

    def load_runtime(name):
        if name not in runtime or name in exports:
            return
        require(name not in loading, "cyclic_runtime_definition_import")
        loading.add(name)
        dep = runtime[name]
        raw = frozen_bytes(dep["source"], dep["sha256"])
        pinned = name == _LEGACY_LIST_MODULE and dep["sha256"] == _LEGACY_LIST_SHA256
        if not pinned:
            for imported in _coq_required_modules(raw.decode("utf-8")):
                load_runtime(imported)
        modules = tuple(sorted(exports.items()))
        register(name, runtime_module(dep, raw, vc.get("qcip_root"), modules))
        loading.remove(name)

    for dep in vc["coq_dependencies"]:
        name = dep["module"]
        require(
            name not in exports and name not in PRELUDE and name not in runtime,
            "ambiguous_definition_module",
        )
        raw = frozen_bytes(dep["staged"], dep["sha256"])
        if name == "GeneratedLayout":
            require(
                "LayoutAddress" in exports
                and raw.decode() == generate_layout_source(layout),
                "different_generated_layout",
            )
            register(name, {})
        elif name == "LayoutAddress":
            require(
                raw
                == (
                    Path(__file__).resolve().parents[1]
                    / "runtime/tespec/LayoutAddress.v"
                ).read_bytes(),
                "different_layout_semantics",
            )
            register(name, {})
        else:
            source = raw.decode("utf-8")
            with_layout = (
                "GeneratedLayout" in exports
                and "GeneratedLayout" in _coq_required_modules(source)
            )
            if with_layout and re.search(r"\b(?:addr|NULL)\b", source):
                root = Path(vc["qcip_root"]) / "SeparationLogic/SeparationLogic"
                for file, sha in _QCP_ADDRESS_PRELUDE.items():
                    frozen_bytes(root / file, sha)
            for imported in _coq_required_modules(source):
                if with_layout and imported == "compcert.lib.Integers":
                    continue
                load_runtime(imported)
            try:
                parsed = parsed_module(raw, tuple(sorted(exports.items())))
            except Unsupported:
                interfaces = vc.get("opaque_imports", {})
                if name not in interfaces:
                    raise
                from .opaque_imports import checked_names

                require(
                    not any(
                        d["module"].startswith("Coq.")
                        for d in vc["coq_dependencies"]
                        + vc.get("generated_coq_dependencies", [])
                    ),
                    "shadowed_standard_library",
                )
                names = checked_names(raw, interfaces[name])
                require(
                    not set(names) & (RESERVED | {"addr", "NULL"}),
                    "reserved_opaque_export",
                )
                parsed = dict.fromkeys(
                    names, Definition((), "opaque", "", False, False)
                )
            register(name, parsed)
    goal = frozen_bytes(vc["files"]["goal"], vc["immutable_sha256"]["goal"]).decode()
    header = re.split(r"(?m)^Definition\s", strip_comments(goal), maxsplit=1)[0]
    visible = set()
    for original in re.split(r"\.(?=\s|$)", header):
        command = " ".join(original.split())
        if not command:
            continue
        imp = re.fullmatch(r"(?:From ([\w.]+) )?Require Import ([\w. ]+)", command)
        if imp:
            for n in imp[2].split():
                module = (imp[1] + "." if imp[1] else "") + n
                load_runtime(module)
                require(
                    module in exports or module in PRELUDE,
                    "unresolved_original_import:" + module,
                )
                if module in PRELUDE:
                    visible.clear()
                else:
                    visible.update(exports[module])
            continue
        if command.startswith("Import "):
            visible.clear()
        require(
            command
            in {
                "Import naive_C_Rules",
                "Import naive_C_Rules64",
                "Import ListNotations",
            }
            or (command.startswith("Local Open Scope ") and command[17:] in SCOPES),
            "unsupported_original_goal_context:" + command,
        )
    return definitions, layout, frozenset(visible)


@dataclass
class Branch:
    pure: list
    cells: list
    exists: list
    exact: bool


def product(left, right, op):
    require(len(left) * len(right) <= 64, "definition_alternative_budget")
    result = []
    for a in left:
        for b in right:
            if op == "**":
                require(
                    a.exact and b.exact,
                    "spatial_product_with_heap_independent_assertion",
                )
            else:
                require(not (a.exact and b.exact), "conjunction_of_two_spatial_heaps")
            result.append(
                Branch(
                    a.pure + b.pure,
                    a.cells + b.cells,
                    a.exists + b.exists,
                    a.exact or b.exact,
                )
            )
    return result


class Reduction:
    def __init__(self, defs, layout, visible):
        self.defs = defs
        self.layout = layout
        self.visible = visible
        self.field_notation = False
        self.count = 0
        self.serial = 0
        self.used = set()

    def budget(self, depth):
        self.count += 1
        require(depth <= 64 and self.count <= 8192, "definition_expansion_budget")

    def fresh(self):
        self.serial += 1
        return "tespec_auto_local_" + str(self.serial)

    def term(self, text, env, depth):
        self.budget(depth)
        t = unparen(text)
        if t in env:
            value = env[t]
            # Each substituted expression is atomic, regardless of its caller's
            # operator precedence. List elements receive the same treatment when bound.
            return "(" + value + ")" if isinstance(value, str) else value
        if t.startswith("&("):
            access = field_access(t)
            require(access is not None, "unsupported_field_address")
            base, tag, path = access
            require(
                self.field_notation and isinstance(env.get(base), str),
                "unbound_computational_field_notation",
            )
            offset = sum(resolve_field_path(self.layout, tag, path))
            return "((" + env[base] + ") + " + str(offset) + ")"
        # Exactly the integer notations exported by QCP's IntLib.
        if t in ("INT_MIN", "INT_MAX", "UINT_MAX"):
            return str(CONSTANTS[t])
        if re.fullmatch(r"-?\d+", t):
            return t
        if t in ("@nil Z", "nil"):
            return ()
        parts = _application_parts(t)
        if parts and parts[0] in (
            "Zlength",
            "Coq.ZArith.Zcomplements.Zlength",
            "@Zlength",
            "@Coq.ZArith.Zcomplements.Zlength",
        ):
            if parts[0].startswith("@"):
                require(
                    len(parts) == 3 and unparen(parts[1]) == "Z", "noninteger_list_type"
                )
            else:
                require(len(parts) == 2, "invalid_list_length_arity")
            items = self.term(parts[-1], env, depth + 1)
            require(isinstance(items, tuple), "unknown_list_length")
            return str(len(items))
        if parts and parts[0] in ("app", "Coq.Init.Datatypes.app") and len(parts) == 3:
            left, right = [self.term(a, env, depth + 1) for a in parts[1:]]
            require(
                isinstance(left, tuple)
                and isinstance(right, tuple)
                and len(left) + len(right) <= 512,
                "unsupported_list_append",
            )
            return left + right
        if parts and parts[0] == "cons" and len(parts) == 3:
            h = self.term(parts[1], env, depth + 1)
            tail = self.term(parts[2], env, depth + 1)
            require(
                isinstance(h, str) and isinstance(tail, tuple) and len(tail) < 512,
                "unsupported_cons",
            )
            return (h,) + tail
        if parts and parts[0] in self.defs:
            values = [self.term(a, env, depth + 1) for a in parts[1:]]
            return self.apply(parts[0], values, False, depth + 1)
        # Lower QCP integer operations to their diagnostic equivalents. In
        # particular, the prelude's % is Z.rem (truncation toward zero).
        if len(parts) == 3 and parts[0] == "Z.rem":
            parts = [parts[1], "%", parts[2]]
        if len(parts) == 3 and parts[1] in ("+", "-", "*", "%"):
            a = self.term(parts[0], env, depth + 1)
            b = self.term(parts[2], env, depth + 1)
            require(isinstance(a, str) and isinstance(b, str), "noninteger_arithmetic")
            op = "%%" if parts[1] == "%" else parts[1]
            return "(" + a + " " + op + " " + b + ")"
        raise Unsupported("unsupported_definition_term:" + t[:80])

    def prop(self, t, env, depth):
        t = unparen(t)
        if t in ("False", "True"):
            return t
        for op, out in [
            ("/\\", " and "),
            ("<>", "!="),
            ("<=", "<="),
            (">=", ">="),
            ("=", "=="),
            ("<", "<"),
            (">", ">"),
        ]:
            pair = split_operator(t, op)
            if pair is None:
                continue
            if op == "/\\":
                return (
                    "("
                    + self.prop(pair[0], env, depth + 1)
                    + ") and ("
                    + self.prop(pair[1], env, depth + 1)
                    + ")"
                )
            a, b = [self.term(x, env, depth + 1) for x in pair]
            if isinstance(a, tuple) or isinstance(b, tuple):
                require(
                    isinstance(a, tuple) and isinstance(b, tuple) and op in ("=", "<>"),
                    "invalid_list_comparison",
                )
                eq = (
                    "False"
                    if len(a) != len(b)
                    else (
                        " and ".join("(" + x + " == " + y + ")" for x, y in zip(a, b))
                        or "True"
                    )
                )
                return eq if op == "=" else "not (" + eq + ")"
            return a + " " + out + " " + b
        raise Unsupported("unsupported_definition_prop:" + t[:80])

    def apply(self, name, values, spatial, depth):
        require(name in self.visible, "unbound_definition_at_declaration:" + name)
        caller = self.visible, self.field_notation
        self.visible = self.defs[name].visible
        self.field_notation = self.defs[name].field_notation
        try:
            return self._apply(name, values, spatial, depth)
        finally:
            self.visible, self.field_notation = caller

    def _apply(self, name, values, spatial, depth):
        self.budget(depth)
        d = self.defs[name]
        require(d.result != "opaque", "opaque_definition:" + name)
        require(
            len(values) == len(d.args) and (d.result == "Assertion") == spatial,
            "wrong_definition_application:" + name,
        )
        require(
            all(
                isinstance(v, tuple) == (k == "list Z")
                for v, (_, k) in zip(values, d.args)
            ),
            "wrong_definition_argument:" + name,
        )
        env = {k: v for (k, t), v in zip(d.args, values)}
        self.used.add(name)
        body = d.body
        if body.startswith("match "):
            match = re.fullmatch(
                r"match ("
                + ID
                + r") with\s*\|?\s*nil\s*=>\s*(.+?)\s*\|\s*("
                + ID
                + r")\s*::\s*("
                + ID
                + r")\s*=>\s*(.+?)\s+end",
                body,
            )
            require(
                match and isinstance(env.get(match[1]), tuple),
                "unsupported_definition_match:" + name,
            )
            require(
                all(
                    k == "_"
                    or (k not in env and k not in RESERVED and k not in self.visible)
                    for k in (match[3], match[4])
                ),
                "shadowed_match_binder",
            )
            xs = env[match[1]]
            require(match[3] != match[4] or match[3] == "_", "duplicate_match_binder")
            if xs:
                if match[3] != "_":
                    env[match[3]] = xs[0]
                if match[4] != "_":
                    env[match[4]] = xs[1:]
            body = match[5] if xs else match[2]
        else:
            require(not d.recursive, "unsupported_recursive_definition:" + name)
        if spatial:
            return self.formula(body, env, depth + 1)
        value = self.term(body, env, depth + 1)
        require(
            d.result == "inferred"
            or isinstance(value, tuple) == (d.result == "list Z"),
            "wrong_definition_result",
        )
        return value

    def formula(self, text, env, depth, lists=frozenset()):
        self.budget(depth)
        t = unparen(text)
        if t.startswith("EX "):
            header = split_operator(t[3:], ",")
            require(header, "unsupported_existential_binders")
            binders, body = header
            require(
                split_operator(body, "||") is None,
                "ambiguous_existential_disjunction_scope",
            )
            if binders.startswith("("):
                groups = _application_parts(binders)
                require(
                    all(
                        group.startswith("(") and group.endswith(")")
                        for group in groups
                    ),
                    "unsupported_existential_binders",
                )
            else:
                groups = [binders]
            scoped = env.copy()
            pending = set(lists)
            fresh = []
            for group in groups:
                names, sep, annotation = unparen(group).partition(":")
                require(sep and names.strip(), "unsupported_existential_binders")
                kind = typ(annotation)
                require(kind in ("Z", "list Z"), "unsupported_existential_type")
                for name in names.split():
                    require(
                        re.fullmatch(ID, name)
                        and name not in scoped
                        and name not in pending
                        and name not in RESERVED
                        and name not in self.visible
                        and name != "_",
                        "shadowed_existential",
                    )
                    if kind == "Z":
                        scoped[name] = self.fresh()
                        fresh.append(scoped[name])
                    else:
                        pending.add(name)
            branches = self.formula(body, scoped, depth + 1, pending)
            for branch in branches:
                branch.exists.extend(fresh)
            return branches

        alternatives = split_operator(t, "||", stop_at_binder=True)
        if alternatives:
            branches = [
                branch
                for part in alternatives
                for branch in self.formula(part, env, depth + 1, lists)
            ]
            require(len(branches) <= 64, "definition_alternative_budget")
            return branches
        if lists:
            env = bind_list_witnesses(t, env, lists, self, depth)
        for op in ("&&", "**"):
            pair = split_operator(t, op, stop_at_binder=True)
            if pair:
                a, b = [self.formula(x, env, depth + 1) for x in pair]
                return product(a, b, op)
        if t == "emp":
            return [Branch([], [], [], True)]
        if t.startswith("“") and t.endswith("”"):
            return [Branch([self.prop(t[1:-1], env, depth + 1)], [], [], False)]
        cell = re.fullmatch(r"(.+?)\s*#\s*(" + "|".join(TYPES) + r")\s*\|->\s*(.+)", t)
        if cell:
            address = self.term(cell[1], env, depth + 1)
            value = self.term(cell[3], env, depth + 1)
            require(
                isinstance(address, str) and isinstance(value, str), "noninteger_cell"
            )
            return [
                Branch(
                    [],
                    ["store(" + address + ", " + value + ", " + TYPES[cell[2]] + ")"],
                    [],
                    True,
                )
            ]
        parts = _application_parts(t)
        require(
            parts and parts[0] in self.defs,
            "unsupported_assertion_definition:" + t[:70],
        )
        return self.apply(
            parts[0], [self.term(x, env, depth + 1) for x in parts[1:]], True, depth + 1
        )


def native_term(red, t, kind):
    t = normalize_builtin_type_arguments(t)
    try:
        head, args = qcp.call(t)
    except Unsupported:
        head, args = None, []
    if head in red.defs:
        d = red.defs[head]
        require(
            d.result in (kind, "inferred") and len(args) == len(d.args),
            "native_definition_type:" + head,
        )
        return red.apply(
            head, [native_term(red, a, k) for a, (_, k) in zip(args, d.args)], False, 1
        )
    if kind == "list Z":
        return tuple(qcp.list_values(t))
    return qcp.scalar(t)


def lower_native_helpers(red, text, depth=0):
    """Evaluate transparent scalar/list calls inside guards and cell arguments."""
    red.budget(depth)
    pattern = re.compile(r"(?<![\w.])(" + ID + r")\s*\(")
    result, pos = [], 0
    while match := pattern.search(text, pos):
        head = match[1]
        if head not in red.defs or red.defs[head].result in {"opaque", "Assertion"}:
            result.append(text[pos : match.end()])
            pos = match.end()
            continue
        balance = 1
        end = match.end()
        while end < len(text) and balance:
            ch = text[end]
            balance += (ch == "(") - (ch == ")")
            end += 1
        require(not balance, "unbalanced_native_helper")
        inner = lower_native_helpers(red, text[match.end() : end - 1], depth + 1)
        definition = red.defs[head]
        args = qcp.split_top(inner)
        require(len(args) == len(definition.args), "native_helper_arity:" + head)
        value = red.apply(
            head,
            [native_term(red, a, k) for a, (_, k) in zip(args, definition.args)],
            False,
            depth + 1,
        )
        result.append(text[pos : match.start()])
        result.append(
            native_list(value) if isinstance(value, tuple) else "(" + value + ")"
        )
        pos = end
    return "".join(result) + text[pos:]


def native_list(xs):
    term = "nil(Z_1)"
    for v in reversed(xs):
        term = "cons(Z_1, " + v + ", " + term + ")"
    return term


def write_branch(b, local=""):
    require(b.exact, "heap_independent_assertion_requires_truep")
    return (("EX " + " ".join(b.exists) + " \n") if b.exists else "") + (
        "PROP["
        + "; ".join(b.pure)
        + "]\nLOCAL["
        + local
        + "]\nSEP["
        + "; ".join(b.cells)
        + "]\n"
    )


def expand_part(red, m, inherited, *, single_antecedent=False):
    orig = qcp.split_top(m["pure"], ";")
    names = qcp.existential_names(m)
    if "prop_false" in orig:
        return "PROP[prop_false]\nLOCAL[]\nSEP[]\n", {}
    substitutions = {k: v for k, v in inherited.items() if k not in names}
    for prop in orig:
        sides = prop.split("==")
        if len(sides) != 2:
            continue
        for left, right in (sides, sides[::-1]):
            variable = left.strip()
            if (
                re.fullmatch(ID, variable)
                and variable not in substitutions
                and (variable in names or single_antecedent)
                and variable not in RESERVED
            ):
                try:
                    xs = qcp.list_values(right.strip())
                except Unsupported:
                    continue
                if all(re.fullmatch(r"-?\d+", element) for element in xs):
                    substitutions[variable] = native_list(xs)

    def subst(text):
        require(
            not substitutions or not re.search(r"\b(?:forall|exists)\b", text),
            "substitution_under_quantifier",
        )
        return re.sub(r"\b" + ID + r"\b", lambda m: substitutions.get(m[0], m[0]), text)

    # Keep the now-substituted binding equations in PROP; contradictions survive.
    pure = []
    for prop in orig:
        rewritten = lower_native_helpers(red, subst(prop))
        equality = re.fullmatch(r"(.+?)\s*(==|!=)\s*(.+)", rewritten)
        if equality:
            try:
                left, right = (qcp.list_values(equality[i]) for i in (1, 3))
            except Unsupported:
                pass
            else:
                eq = (
                    "False"
                    if len(left) != len(right)
                    else (
                        " && ".join(
                            "(" + x + " == " + y + ")" for x, y in zip(left, right)
                        )
                        or "True"
                    )
                )
                rewritten = eq if equality[2] == "==" else "!(" + eq + ")"
        pure.append(rewritten)
    branches = [Branch(pure, [], [v for v in names if v not in substitutions], True)]
    for cell in qcp.split_top(m["spatial"], ";"):
        text = lower_native_helpers(red, subst(cell))
        try:
            name, args = qcp.call(text)
        except Unsupported:
            name = None
        if name not in red.defs:
            for branch in branches:
                branch.cells.append(text)
            continue
        definition = red.defs[name]
        require(len(args) == len(definition.args), "definition_arity:" + name)
        values = [native_term(red, a, k) for a, (_, k) in zip(args, definition.args)]
        expansion = red.apply(name, values, True, 1)
        branches = product(branches, expansion, "**")
    return "".join(write_branch(b, m["local"]) for b in branches), {
        k: v for k, v in substitutions.items() if k not in names
    }


def solve_path(record, case, *, timeout_ms):
    try:
        defs, layout, visible = definitions_for(case)
        require(layout == record["layout"], "definition_layout_mismatch")
        red = Reduction(defs, layout, visible)
        vc = record["vc"]
        text = vc["path"] + "\n" + vc["goal"]
        require("tespec_auto_local_" not in text, "generated_binder_collision")
        # A bare Coq constant in a diagnostic expression is not a free SMT
        # integer. Check the original text before list/term substitution.
        for token in set(re.findall(r"[A-Za-z_][A-Za-z0-9_']*", text)) & defs.keys():
            require(defs[token].result != "opaque", "opaque_definition:" + token)
        pre = qcp.assertion_parts(vc["path"])
        post = qcp.assertion_parts(vc["goal"])
        source_bound = {v for m in pre for v in qcp.existential_names(m)}
        for m in post:
            for v in source_bound - set(qcp.existential_names(m)):
                require(
                    not re.search(r"\b" + re.escape(v) + r"\b", m[0]),
                    "native_shared_existential_requires_scope_mapping:" + v,
                )
        qcp.checked_local_symbols(pre, post, text, record.get("local_semantics"))
        ant = [expand_part(red, m, {}, single_antecedent=len(pre) == 1) for m in pre]
        globals_ = ant[0][1] if len(ant) == 1 else {}
        post_text = "".join(expand_part(red, m, globals_)[0] for m in post)
        copied = record | {
            "vc": vc | {"path": "".join(s for s, _ in ant), "goal": post_text}
        }
        ir = qcp.import_record(
            copied,
            check_mode=record.get("check_mode"),
            local_semantics=record.get("local_semantics"),
        )
        result = check(ir, timeout_ms=timeout_ms, include_smt=True)
        result.update(normalized_vc=ir, expanded_definitions=sorted(red.used))
        return result
    except (
        Unsupported,
        JobError,
        OSError,
        ValueError,
        KeyError,
        TypeError,
        RecursionError,
    ) as exc:
        return {"status": "UNKNOWN", "supported": False, "reason": str(exc)}


def entry_formula(source, goal, red):
    match = re.findall(
        r"(?m)^Definition " + re.escape(goal) + r"\s*:=\s*([\s\S]+?)\.(?=\s|$)",
        strip_comments(source),
    )
    require(len(match) == 1, "ambiguous_entry_goal")
    body = " ".join(match[0].split())
    env = {}
    lists = set()
    while m := re.match(r"exists \((" + ID + r")\s*:\s*([^,]+)\),\s*", body):
        name = m[1]
        require(
            name not in env
            and name not in lists
            and name not in RESERVED
            and name not in red.visible
            and name != "_",
            "shadowed_entry_binder",
        )
        if typ(m[2]) == "list Z":
            lists.add(name)
        else:
            require(typ(m[2]) == "Z", "invalid_entry_binder_type")
            env[name] = red.fresh()
        body = body[m.end() :].strip()
    require(body.startswith("~"), "unsupported_entry_proposition")
    expr = split_operator(unparen(body[1:]), "|--")
    require(expr and expr[1] == "“ False ”", "entry_goal_not_heap_satisfiability")
    branches = red.formula(expr[0], env, 1, lists)
    return qcp.assertions("".join(write_branch(b) for b in branches))


def bind_list_witnesses(formula, env, lists, red, depth):
    """Eliminate existential lists using equalities required by this branch.

    Re-evaluate the original equalities after substitution. A binding from an
    alternative or a nested quantifier cannot constrain its siblings.
    """
    equations = []

    def collect(text, level):
        red.budget(level)
        t = unparen(text)
        if t.startswith("EX ") or split_operator(t, "||", stop_at_binder=True):
            return
        pair = split_operator(t, "&&", stop_at_binder=True)
        if pair:
            for part in pair:
                collect(part, level + 1)
        elif (
            t.startswith("“") and t.endswith("”") and t.count("“") == t.count("”") == 1
        ):
            sides = split_operator(unparen(t[1:-1]), "=")
            if sides:
                equations.extend([sides, sides[::-1]])

    collect(formula, depth)
    scoped = env.copy()
    while not lists <= scoped.keys():
        count = len(scoped)
        for lhs, rhs in equations:
            lhs = unparen(lhs)
            parts = _application_parts(lhs)
            if lhs in lists - scoped.keys():
                variable, fixed, side = lhs, None, None
            elif len(parts) == 3 and parts[0] in ("app", "Coq.Init.Datatypes.app"):
                prefix, suffix = map(unparen, parts[1:])
                if prefix in lists - scoped.keys():
                    variable, fixed, side = prefix, suffix, "prefix"
                elif suffix in lists - scoped.keys():
                    variable, fixed, side = suffix, prefix, "suffix"
                else:
                    continue
            else:
                continue
            try:
                value = red.term(rhs, scoped, depth + 1)
                if not isinstance(value, tuple):
                    continue
                if fixed is not None:
                    other = red.term(fixed, scoped, depth + 1)
                    if not isinstance(other, tuple):
                        continue
                    # List concatenation fixes the missing slice uniquely. The
                    # original equality is checked again, including its length
                    # and each symbolic element of the opposite slice.
                    value = (
                        value[: max(0, len(value) - len(other))]
                        if side == "prefix"
                        else value[len(other) :]
                    )
            except Unsupported:
                continue
            scoped[variable] = value
        require(len(scoped) > count, "unknown_entry_list_spine")
    return scoped


def solve_entry(case, native, binding, *, timeout_ms):
    try:
        items = [x for x in native["preconditions"] if x["status"] == "UNKNOWN"]
        require(len(items) == 1, "entry_requires_one_original_target")
        goal = items[0]["goal"]
        target = "proof_of_" + goal
        require(target in binding["interface_roots"], "unbound_entry_target")
        expected = case["vc"]["immutable_sha256"]["goal"]
        path = case["vc"]["files"]["goal"]
        require(
            Path(path).resolve() == Path(binding["files"]["goal"]).resolve(),
            "wrong_entry_goal_file",
        )
        source = frozen_bytes(path, expected).decode()
        require(
            re.search(
                r"^Axiom "
                + re.escape(target)
                + r"\s*:\s*"
                + re.escape(goal)
                + r"\s*\.",
                source,
                re.M,
            ),
            "entry_root_type_mismatch",
        )
        defs, layout, visible = definitions_for(case)
        red = Reduction(defs, layout, visible)
        alternatives = entry_formula(source, goal, red)
        ir = {
            "mode": "exact",
            "layout": {
                k: layout[k]
                for k in ("architecture_bits", "byte_order", "memory_rules")
            },
            "pre": alternatives,
            "post": [],
        }
        enc = encode(ir)
        solver = z3.Solver()
        solver.set(timeout=max(1, timeout_ms))
        solver.add(enc.pre)
        answer = solver.check()
        result = {
            "status": str(answer).upper(),
            "targets": [target],
            "reason": "entry_heap_satisfiability",
            "expanded_definitions": sorted(red.used),
            "solver_result": str(answer),
            "normalized_vc": ir,
        }
        if answer == z3.unknown:
            result["reason"] = solver.reason_unknown()
        if answer == z3.sat:
            model = solver.model()
            result["owned_addresses"] = sorted(
                {
                    model.eval(a, model_completion=True).as_long()
                    for a in enc.pre_addresses
                    if z3.is_true(
                        model.eval(z3.Select(enc.owned, a), model_completion=True)
                    )
                }
            )
        return result
    except (
        Unsupported,
        JobError,
        OSError,
        ValueError,
        KeyError,
        TypeError,
        RecursionError,
    ) as exc:
        return {
            "status": "UNKNOWN",
            "supported": False,
            "reason": str(exc),
            "targets": [],
        }
