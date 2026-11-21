"""Closed first-order Coq applications on a diagnostic copy of a spatial VC."""

from collections import defaultdict
from dataclasses import dataclass
import hashlib
import os
from pathlib import Path
import re
import shutil
import subprocess
from tempfile import TemporaryDirectory, TemporaryFile
import time

from .core import _consume_balanced, _default_coqc_command
from .rocq_predicates import _strip_outer_parens
from tools.finite_spatial_smt import qcp_import as qcp
from tools.finite_spatial_smt.finite_qcp_terms import normalize_builtin_type_arguments
from tools.finite_spatial_smt.finite_spatial_smt import CONSTANTS, Unsupported


@dataclass(frozen=True)
class GroundFunction:
    module: str
    name: str
    signature: tuple
    source: bytes
    object_sha256: str


def functions_for(module, source, interface, exports):
    """Legacy name inventories do not bind a compiled implementation."""
    signatures = interface.get("ground_signatures", {})
    if not signatures:
        return {}
    if (
        not re.fullmatch(r"[A-Za-z_][\w']*(?:\.[A-Za-z_][\w']*)*", module)
        or not re.fullmatch(r"[0-9a-f]{64}", interface.get("object_sha256", ""))
        or not isinstance(signatures, dict)
        or not signatures.keys() <= set(exports)
    ):
        raise Unsupported("invalid_ground_interface")
    functions = {}
    for name, sig in signatures.items():
        if (
            not isinstance(sig, list)
            or not 2 <= len(sig) <= 9
            or any(t not in ("Z", "list Z") for t in sig)
        ):
            raise Unsupported("invalid_ground_signature")
        functions[name] = GroundFunction(
            module, name, tuple(sig), source, interface["object_sha256"]
        )
    return functions


def integer_literal(text):
    text = _strip_outer_parens(text.strip())
    if text in ("INT_MAX", "INT_MIN", "UINT_MAX"):
        return CONSTANTS[text]
    if not re.fullmatch(r"-?\s*[0-9]{1,80}", text):
        raise Unsupported("ground_argument_is_not_an_integer_literal")
    return int("".join(text.split()))


def argument(text, typ):
    if typ == "Z":
        return integer_literal(text)
    text = normalize_builtin_type_arguments(text)
    values = []
    while True:
        constructor, args = qcp.call(_strip_outer_parens(text.strip()))
        if constructor == "nil" and args == ["Z_1"]:
            return tuple(values)
        if (
            constructor != "cons"
            or len(args) != 3
            or args[0] != "Z_1"
            or len(values) >= 128
        ):
            raise Unsupported("ground_argument_is_not_a_finite_integer_list")
        values.append(integer_literal(args[1]))
        text = args[2]


def literal(value):
    if isinstance(value, tuple):
        return "([" + ";".join(map(str, value)) + "] : list Z)"
    return f"({value} : Z)"


def diagnostic_literal(value):
    if not isinstance(value, tuple):
        return f"({value})"
    term = "nil(Z_1)"
    for n in reversed(value):
        term = f"cons(Z_1, {n}, {term})"
    return term


def read_value(text, typ):
    if typ == "Z":
        return integer_literal(text)
    m = re.fullmatch(r"\[\s*(.*?)\s*\]", text.strip(), re.S)
    if not m:
        raise Unsupported("ground_result_is_not_a_list_literal")
    values = m[1].split(";") if m[1] else []
    if len(values) > 128:
        raise Unsupported("ground_result_size_limit")
    return tuple(integer_literal(n) for n in values)


def checked_batch(calls, deadline):
    """Check each proposed literal by kernel conversion in the pinned module."""
    fun = calls[0][0]
    with TemporaryDirectory(prefix="tespec-ground-") as tmp:
        work = Path(tmp)
        unit = work.joinpath(*fun.module.split(".")).with_suffix(".v")
        unit.parent.mkdir(parents=True, exist_ok=True)
        unit.write_bytes(fun.source)

        def compile_with(compiler, path):
            remaining = deadline - time.monotonic()
            if remaining <= 0:
                raise Unsupported("ground_evaluation_timeout")
            try:
                command = [*compiler, "-q", "-Q", str(work), "", str(path)]
                limiter = shutil.which("prlimit")
                if limiter:
                    command = [
                        limiter,
                        "--as=1073741824",
                        "--fsize=67108864",
                        "--",
                        *command,
                    ]
                with TemporaryFile() as log:
                    result = subprocess.run(
                        command,
                        cwd=work,
                        stdout=log,
                        stderr=subprocess.DEVNULL,
                        timeout=remaining,
                    )
                    if log.tell() > 1_000_000:
                        raise Unsupported("ground_output_size_limit")
                    log.seek(0)
                    result.stdout = log.read()
            except subprocess.TimeoutExpired:
                raise Unsupported("ground_evaluation_timeout") from None
            return result

        candidates = (
            [[os.environ["COQC"]]]
            if os.environ.get("COQC")
            else [_default_coqc_command()]
        )
        opam = shutil.which("opam")
        if opam and not os.environ.get("COQC") and candidates[0][0] != opam:
            candidates.append([opam, "exec", "--switch=qcp-8.20", "--", "coqc"])
        for compiler in candidates:
            if compile_with(compiler, unit).returncode == 0:
                digest = hashlib.sha256(
                    unit.with_suffix(".vo").read_bytes()
                ).hexdigest()
                if digest == fun.object_sha256:
                    break
        else:
            raise Unsupported("ground_compiled_module_mismatch")

        header = (
            f"From Coq Require Import ZArith List.\nRequire {fun.module}.\n"
            "Import ListNotations.\nLocal Open Scope Z_scope.\n"
            "Set Printing Width 100000.\nSet Printing Depth 300.\n"
        )
        terms = []
        for function, args in calls:
            signature = " -> ".join(function.signature)
            terms.append(
                f"(({function.module}.{function.name} : {signature}) "
                + " ".join(map(literal, args))
                + ")"
            )
        # Fresh driver basename, distinct from every accepted compiled unit.
        driver = work / "TeSpecGroundValues.v"
        if driver == unit:
            driver = work / "TeSpecGroundCheck.v"
        driver.write_text(header + "".join(f"Eval vm_compute in {t}.\n" for t in terms))
        result = compile_with(compiler, driver)
        if result.returncode:
            raise Unsupported("ground_evaluation_failed")
        matches = re.findall(
            r"(?ms)^\s*=\s*(.*?)\s*:\s*(list Z|Z)\s*(?=^\s*=|\Z)",
            result.stdout.decode(),
        )
        if len(matches) != len(calls):
            raise Unsupported("ground_result_not_canonical")
        values, equations = [], []
        for i, ((text, typ), (function, _), term) in enumerate(
            zip(matches, calls, terms)
        ):
            if typ != function.signature[-1]:
                raise Unsupported("ground_result_type_mismatch")
            value = read_value(text, typ)
            values.append(value)
            equations.append(
                f"Definition checked_{i} : {term} = {literal(value)} := eq_refl.\n"
                f"Print Assumptions checked_{i}.\n"
            )
        driver.write_text(header + "".join(equations))
        check = compile_with(compiler, driver)
        if check.returncode or check.stdout.splitlines() != [
            b"Closed under the global context"
        ] * len(calls):
            raise Unsupported("ground_conversion_not_closed")
        return values


def rewrite_closed_calls(text, functions, cache, timeout_ms):
    """Reduce innermost explicit applications first, sharing checked results per case."""
    deadline = time.monotonic() + min(30, 4 * timeout_ms / 1000)
    used = set()
    pattern = r"(?<![\w.'])([A-Za-z_][\w']*)\s*\("
    while True:
        matches = [m for m in re.finditer(pattern, text) if m[1] in functions]
        if not matches:
            return text, used
        if len(matches) > 512:
            raise Unsupported("ground_application_budget")
        spans, pending = [], defaultdict(dict)
        for i, match in enumerate(matches):
            body, end = _consume_balanced(text, match.end() - 1, "(", ")")
            if i + 1 < len(matches) and matches[i + 1].start() < end:
                continue
            function = functions[match[1]]
            raw = qcp.split_top(body)
            if len(raw) != len(function.signature) - 1:
                raise Unsupported("ground_argument_arity")
            args = tuple(argument(a, t) for a, t in zip(raw, function.signature))
            key = function, args
            used.add(key)
            spans.append((match.start(), end, key))
            if key not in cache:
                pending[function.module][key] = None
        if not spans or sum(map(len, pending.values())) + len(cache) > 64:
            raise Unsupported("ground_application_budget")
        for batch in pending.values():
            keys = list(batch)
            cache.update(zip(keys, checked_batch(keys, deadline)))
        fragments, pos = [], 0
        for start, end, key in spans:
            fragments.extend([text[pos:start], diagnostic_literal(cache[key])])
            pos = end
        fragments.append(text[pos:])
        text = "".join(fragments)
