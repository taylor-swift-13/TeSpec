from __future__ import annotations

import json
import math
import hashlib
import os
import re
import signal
import shutil
import subprocess
import time
from dataclasses import dataclass
from functools import lru_cache
from pathlib import Path
from typing import Any

from .errors import JobError
from .modes import (
    execution_semantics, normalize_execution_mode, normalize_execution_strategy,
)
from .verdict import _executor_result, _executor_target_layout


_C_SOURCE_ENCODINGS = ("utf-8-sig", "gb18030")
_C_COMMENT_PATTERN = r"/\*.*?\*/|//[^\n]*(?:\n|$)"
_C_COMMENT_TRIVIA = r"(?:(?:" + _C_COMMENT_PATTERN + r")\s*)"


def _qcp_comments(text: str):
    """Yield annotation comments without interpreting ordinary comment contents."""
    for match in re.finditer(_C_COMMENT_PATTERN, text, re.DOTALL):
        if match.group().startswith("/*@"):
            yield match, match.group()[3:-2]


def read_source_text(path: Path) -> str:
    """Decode C sources without silently replacing specification text.

    QCIP corpora contain both UTF-8 and legacy GBK-family source files.
    GB18030 is a strict superset of GBK, so it is a deterministic fallback
    after UTF-8 while still rejecting byte streams that are valid in neither
    encoding.
    """

    resolved = path.expanduser().resolve()
    try:
        data = resolved.read_bytes()
    except OSError as error:
        raise JobError(f"cannot read source {resolved}: {error}") from error
    failures: list[str] = []
    for encoding in _C_SOURCE_ENCODINGS:
        try:
            return data.decode(encoding)
        except UnicodeDecodeError as error:
            failures.append(f"{encoding}: byte {error.start}")
    raise JobError(
        f"cannot decode source {resolved}; tried "
        + ", ".join(_C_SOURCE_ENCODINGS)
        + " ("
        + "; ".join(failures)
        + ")"
    )


def _relocate_strategy_includes(source: str, original: Path) -> str:
    """Preserve source-relative strategy imports after moving a translation unit."""
    pattern = re.compile(r'(/\*@\s*include\s+strategies\s+")([^"\n]+)("\s*\*/)', re.I)

    def replace(match: re.Match[str]) -> str:
        path = Path(match.group(2))
        if path.is_absolute():
            return match.group(0)
        resolved = (original.parent / path).resolve()
        if not resolved.is_file():
            return match.group(0)
        return match.group(1) + str(resolved) + match.group(3)

    return pattern.sub(replace, source)


def attach_spec_to_source(source: str, spec: str, function: str) -> str:
    """Attach a separate full QCP spec to one C function definition.

    Some workflows keep implementation and specification as separate inputs.
    QCP consumes one annotated translation unit, so this deterministic adapter
    performs the mechanical assembly before analysis or execution.
    """

    if _NAME_RE.fullmatch(function) is None:
        raise JobError(f"invalid C function name: {function!r}")
    stripped = spec.strip()
    if not stripped:
        raise JobError("spec file is empty")
    full_comment = re.fullmatch(r"/\*@(?P<body>.*?)\*/", stripped, re.DOTALL)
    if full_comment is not None:
        body = full_comment.group("body").strip()
    else:
        if "/*" in stripped or "*/" in stripped:
            raise JobError(
                "separate spec must be a raw QCP body or one complete /*@ ... */ block"
            )
        body = stripped
    if re.search(r"\bRequire\b", body) is None:
        raise JobError("separate spec has no Require clause")
    if re.search(r"\bEnsure\b", body) is None:
        raise JobError("separate spec has no Ensure clause")

    pattern = re.compile(
        rf"(?P<head>\b{re.escape(function)}\s*"
        r"\((?P<parameters>[^;{}]*)\))\s*"
        r"(?P<comments>" + _C_COMMENT_TRIVIA + r"*)"
        r"(?P<terminator>{)",
        re.DOTALL,
    )
    matches = [
        match
        for match in pattern.finditer(source)
        if not _inside_block_comment(source, match.start())
    ]
    if len(matches) != 1:
        raise JobError(
            f"expected exactly one definition of function {function!r}, "
            f"found {len(matches)}"
        )
    match = matches[0]
    if any(
        re.search(r"\bRequire\b", body)
        for _, body in _qcp_comments(match.group("comments"))
    ):
        raise JobError(
            f"function {function!r} already has a full QCP spec; "
            "do not also pass spec_file"
        )
    annotation = f"\n/*@ {body}\n*/"
    insertion = match.end("head")
    return source[:insertion] + annotation + source[insertion:]


_NAME_RE = re.compile(r"[A-Za-z_][A-Za-z0-9_]*\Z")
_LOGIC_NAME_RE = re.compile(r"[A-Za-z_][A-Za-z0-9_]*(?:::[A-Za-z_][A-Za-z0-9_]*)*\Z")
_FORBIDDEN_EXPR_PARTS = (
    "/*",
    "*/",
    "//",
    ";",
    "\x00",
)


@dataclass(frozen=True)
class QcpConfig:
    qcip_root: Path
    binary: Path
    include_dirs: tuple[Path, ...]
    timeout_seconds: float
    execution_mode: str
    annotation_policy: str | None
    instance_trace: bool
    loop_unroll_limit: int
    call_depth_limit: int
    architecture_bits: int
    spatial_smt: bool = False
    spatial_smt_timeout_ms: int = 2000
    execution_strategy: str = "inline"
    modular_instantiation: str = "on"


@dataclass(frozen=True)
class WithAnalysis:
    values: dict[str, str | None]
    types: tuple[tuple[str, str | None], ...]
    derived: dict[str, str]


@dataclass(frozen=True)
class SpecCandidate:
    start: int
    end: int
    body: str
    parameters: str
    name: str | None
    derived_by: str | None


@dataclass(frozen=True)
class CParameter:
    name: str
    declaration: str
    pointer_like: bool


@dataclass(frozen=True)
class BindCase:
    case_id: str
    arguments: dict[str, Any]
    values: dict[str, Any]
    types: dict[str, Any]
    spec: str | None


def bundled_qcip_root() -> Path:
    """Return the relocatable QCIP runtime shipped beside the Python package."""

    return Path(__file__).resolve().parents[1] / "runtime" / "qcip"


def bundled_qcp_binary() -> Path:
    """Return the modified QCP executor shipped beside the Python package."""

    return Path(__file__).resolve().parents[1] / "bin" / "tespec-symexec"


def _require_object(value: Any, label: str) -> dict[str, Any]:
    if not isinstance(value, dict):
        raise JobError(f"{label} must be a JSON object")
    return value


def _resolve(base: Path, raw: str, label: str) -> Path:
    if not isinstance(raw, str) or not raw:
        raise JobError(f"{label} must be a non-empty path string")
    path = Path(raw).expanduser()
    if not path.is_absolute():
        path = base / path
    return path.resolve()


def _validate_expression(expression: Any, variable: str) -> str:
    if not isinstance(expression, str):
        raise JobError(f"binding {variable!r} must be a QCP expression string")
    expression = expression.strip()
    if not expression or len(expression) > 16384:
        raise JobError(f"binding {variable!r} is empty or too long")
    if any(part in expression for part in _FORBIDDEN_EXPR_PARTS):
        raise JobError(f"binding {variable!r} contains forbidden syntax")
    pairs = {")": "(", "]": "[", "}": "{"}
    stack: list[str] = []
    quote: str | None = None
    escaped = False
    for char in expression:
        if quote is not None:
            if escaped:
                escaped = False
            elif char == "\\":
                escaped = True
            elif char == quote:
                quote = None
            continue
        if char in "\"'":
            quote = char
            continue
        if char in "([{":
            stack.append(char)
        elif char in ")]}":
            if not stack or stack.pop() != pairs[char]:
                raise JobError(f"binding {variable!r} has unbalanced delimiters")
    if stack or quote is not None:
        raise JobError(f"binding {variable!r} has unbalanced delimiters")
    return expression


def _normalize_type(logic_type: str | None) -> str | None:
    if logic_type is None:
        return None
    return " ".join(logic_type.split())


def _validate_logic_type(logic_type: Any, label: str) -> str:
    if not isinstance(logic_type, str) or not logic_type.strip():
        raise JobError(f"{label} must be a non-empty Coq/QCP type")
    normalized = _normalize_type(logic_type)
    assert normalized is not None
    if len(normalized) > 4096 or any(
        part in normalized for part in _FORBIDDEN_EXPR_PARTS
    ):
        raise JobError(f"{label} contains unsafe type syntax")
    # Reuse the delimiter/quote validator without imposing a closed set of
    # type constructors.  QCP remains the authority for the actual Coq type.
    _validate_expression(normalized, label)
    return normalized


def _strip_outer_parentheses(value: str) -> str:
    value = value.strip()
    while value.startswith("(") and value.endswith(")"):
        depth = 0
        closes_at_end = False
        for index, char in enumerate(value):
            if char == "(":
                depth += 1
            elif char == ")":
                depth -= 1
                if depth == 0:
                    closes_at_end = index == len(value) - 1
                    break
        if not closes_at_end:
            break
        value = value[1:-1].strip()
    return value


def _list_element_type(logic_type: str | None) -> str | None:
    normalized = _normalize_type(logic_type)
    if normalized is None:
        return None
    normalized = _strip_outer_parentheses(normalized)
    match = re.fullmatch(r"list\s+(.+)", normalized)
    return _strip_outer_parentheses(match.group(1)) if match is not None else None


def _is_symbolic_binding(value: Any) -> bool:
    return isinstance(value, dict) and value == {"symbolic": True}


def _format_qcp_list(items: list[str]) -> str:
    """Build a nested QCP list in linear time."""

    return "".join(f"cons({item}, " for item in items) + "nil" + ")" * len(items)


def _format_native_binding(value: Any, logic_type: str | None, variable: str) -> str:
    if isinstance(value, dict):
        if set(value) == {"repeat", "count"}:
            element_type = _list_element_type(logic_type)
            if element_type is None:
                raise JobError(
                    f"binding {variable!r}: repeat/count requires a declared 'list T' type"
                )
            count = value["count"]
            if isinstance(count, bool) or not isinstance(count, int) or count < 0:
                raise JobError(
                    f"binding {variable!r}: repeat count must be a non-negative integer"
                )
            if count > 100000:
                raise JobError(
                    f"binding {variable!r}: repeat count exceeds the 100000 element limit"
                )
            item_expression = _format_native_binding(
                value["repeat"], element_type, f"{variable}.repeat"
            )
            return _format_qcp_list([item_expression] * count)
        if set(value) == {"qcp"}:
            return _validate_expression(value["qcp"], variable)
        if set(value) == {"type", "qcp"}:
            _validate_logic_type(value["type"], f"binding {variable!r} type")
            return _validate_expression(value["qcp"], variable)
        if set(value) == {"type", "value"}:
            explicit_type = _validate_logic_type(
                value["type"], f"binding {variable!r} type"
            )
            return _format_native_binding(value["value"], explicit_type, variable)
        allowed_constructor_keys = {"ctor", "args", "type_args"}
        if "ctor" in value and set(value) <= allowed_constructor_keys:
            constructor = value["ctor"]
            if (
                not isinstance(constructor, str)
                or _LOGIC_NAME_RE.fullmatch(constructor) is None
            ):
                raise JobError(f"binding {variable!r}: ctor must be a QCP logic name")
            arguments = value.get("args", [])
            if not isinstance(arguments, list):
                raise JobError(
                    f"binding {variable!r}: constructor args must be an array"
                )
            raw_type_arguments = value.get("type_args", [])
            if not isinstance(raw_type_arguments, list):
                raise JobError(
                    f"binding {variable!r}: constructor type_args must be an array"
                )
            for index, item in enumerate(raw_type_arguments):
                _validate_logic_type(
                    item, f"binding {variable!r} constructor type_args[{index}]"
                )
            head = constructor
            # Type arguments are metadata for validating/documenting the
            # constructor tree.  QCP's C-assertion parser infers them from the
            # bound With type and does not accept the strategy-DSL `f{T}(...)`
            # spelling here.
            if not arguments:
                return head
            formatted_arguments = [
                _format_native_binding(item, None, f"{variable}.{constructor}[{index}]")
                for index, item in enumerate(arguments)
            ]
            return f"{head}({', '.join(formatted_arguments)})"
        raise JobError(
            f"binding {variable!r} object form must be raw/typed QCP, "
            "a typed value, {'repeat': value, 'count': n}, or "
            "{'ctor': C, 'args': [...], 'type_args': [...]}"
        )
    if isinstance(value, str):
        return _validate_expression(value, variable)
    if isinstance(value, bool):
        return "true" if value else "false"
    if isinstance(value, (int, float)) and logic_type in {"fp32", "fp64"}:
        if not math.isfinite(value):
            raise JobError(
                f"binding {variable!r}: use an explicit QCP term for NaN or infinity"
            )
        # Serialization only: floating evaluation remains in the executor.
        literal = str(value) if isinstance(value, float) else f"{value}.0"
        return f"{logic_type}({literal})"
    if isinstance(value, int):
        return str(value)
    if isinstance(value, list):
        element_type = _list_element_type(logic_type)
        if element_type is None:
            raise JobError(
                f"binding {variable!r}: JSON arrays require a declared 'list T' type"
            )
        items = [
            _format_native_binding(item, element_type, f"{variable}[{index}]")
            for index, item in enumerate(value)
        ]
        return _format_qcp_list(items)
    raise JobError(
        f"binding {variable!r} must be an integer, boolean, typed list, "
        "generic constructor, or QCP expression"
    )


def _spec_header(spec_body: str) -> tuple[str | None, str | None]:
    markers = [
        match.start()
        for match in (
            re.search(r"\bDeclare\b", spec_body),
            re.search(r"\bWith\b", spec_body),
            re.search(r"\bRequire\b", spec_body),
        )
        if match is not None
    ]
    header = spec_body[: min(markers)].strip() if markers else spec_body.strip()
    if not header:
        return None, None
    match = re.fullmatch(
        r"(?P<name>[A-Za-z_][A-Za-z0-9_]*)"
        r"(?:\s*<=\s*(?P<base>[A-Za-z_][A-Za-z0-9_]*))?",
        header,
    )
    if match is None:
        raise JobError(f"cannot parse function spec header: {header!r}")
    return match.group("name"), match.group("base")


def _inside_block_comment(source: str, position: int) -> bool:
    return source.rfind("/*", 0, position) > source.rfind("*/", 0, position)


def _function_specs(source: str, function: str) -> list[SpecCandidate]:
    if _NAME_RE.fullmatch(function) is None:
        raise JobError(f"invalid C function name: {function!r}")
    pattern = re.compile(
        rf"\b{re.escape(function)}\s*"
        r"\((?P<parameters>[^;{}]*)\)\s*"
        r"(?P<comments>" + _C_COMMENT_TRIVIA + r"+)"
        r"(?P<terminator>[;{])",
        re.DOTALL,
    )
    candidates: list[SpecCandidate] = []
    for function_match in pattern.finditer(source):
        if _inside_block_comment(source, function_match.start()):
            continue
        comments_start = function_match.start("comments")
        for comment, body in _qcp_comments(function_match.group("comments")):
            if re.search(r"\bRequire\b", body) is None:
                continue
            if re.search(r"\bEnsure\b", body) is None:
                raise JobError(f"spec for {function!r} has Require but no Ensure")
            name, derived_by = _spec_header(body)
            candidates.append(
                SpecCandidate(
                    start=comments_start + comment.start(),
                    end=comments_start + comment.end(),
                    body=body,
                    parameters=function_match.group("parameters"),
                    name=name,
                    derived_by=derived_by,
                )
            )
    return candidates


def _find_function_spec(
    source: str, function: str, spec_name: str | None = None
) -> SpecCandidate:
    all_candidates = _function_specs(source, function)
    candidates = all_candidates
    if spec_name is not None:
        if _NAME_RE.fullmatch(spec_name) is None:
            raise JobError(f"invalid spec name: {spec_name!r}")
        candidates = [item for item in candidates if item.name == spec_name]
    if len(candidates) != 1:
        available = sorted(
            "<unnamed>" if item.name is None else item.name for item in all_candidates
        )
        raise JobError(
            f"expected exactly one full spec for function {function!r}"
            + (f" named {spec_name!r}" if spec_name is not None else "")
            + f", found {len(candidates)}; available: "
            + (", ".join(available) if available else "none")
        )
    return candidates[0]


def _consume_balanced(
    text: str, start: int, opening: str, closing: str
) -> tuple[str, int]:
    if start >= len(text) or text[start] != opening:
        raise JobError(f"expected {opening!r} in With clause")
    depth = 0
    for index in range(start, len(text)):
        char = text[index]
        if char == opening:
            depth += 1
        elif char == closing:
            depth -= 1
            if depth == 0:
                return text[start + 1 : index], index + 1
    raise JobError(f"unclosed {opening!r} group in With clause")


def _top_level_colon(text: str) -> int | None:
    depths = {"(": 0, "[": 0, "{": 0}
    closing = {")": "(", "]": "[", "}": "{"}
    for index, char in enumerate(text):
        if char in depths:
            depths[char] += 1
        elif char in closing:
            depths[closing[char]] -= 1
        elif char == ":" and not any(depths.values()):
            if index + 1 < len(text) and text[index + 1] == ":":
                continue
            return index
    return None


def _split_top_level(text: str, separator: str) -> list[str]:
    parts: list[str] = []
    start = 0
    depths = {"(": 0, "[": 0, "{": 0}
    closing = {")": "(", "]": "[", "}": "{"}
    index = 0
    while index < len(text):
        char = text[index]
        if char in depths:
            depths[char] += 1
        elif char in closing:
            depths[closing[char]] -= 1
        elif not any(depths.values()) and text.startswith(separator, index):
            parts.append(text[start:index].strip())
            index += len(separator)
            start = index
            continue
        index += 1
    parts.append(text[start:].strip())
    return parts


_C_DECLARATION_QUALIFIERS = {
    "const",
    "restrict",
    "volatile",
    "_Atomic",
    "signed",
    "unsigned",
    "short",
    "long",
    "void",
    "char",
    "int",
    "float",
    "double",
    "struct",
    "union",
    "enum",
}


def _c_parameters(candidate: SpecCandidate) -> tuple[CParameter, ...]:
    text = candidate.parameters.strip()
    if not text or text == "void":
        return ()
    parameters: list[CParameter] = []
    for index, declaration in enumerate(_split_top_level(text, ",")):
        declaration = declaration.strip()
        if not declaration:
            raise JobError(f"empty C parameter declaration at position {index + 1}")
        if declaration == "...":
            raise JobError("variadic target functions cannot be concretely bound")

        function_pointer = re.search(
            r"\(\s*\*\s*(?:const\s+|restrict\s+|volatile\s+)*"
            r"(?P<name>[A-Za-z_][A-Za-z0-9_]*)\s*\)",
            declaration,
        )
        if function_pointer is not None:
            name = function_pointer.group("name")
        else:
            match = re.search(
                r"(?P<name>[A-Za-z_][A-Za-z0-9_]*)"
                r"\s*(?:\[[^\]]*\]\s*)*\Z",
                declaration,
                re.DOTALL,
            )
            if match is None or match.group("name") in _C_DECLARATION_QUALIFIERS:
                raise JobError(
                    "cannot identify the name of C parameter "
                    f"{declaration!r} at position {index + 1}"
                )
            name = match.group("name")
        if any(item.name == name for item in parameters):
            raise JobError(f"duplicate C parameter name: {name}")
        parameters.append(
            CParameter(
                name=name,
                declaration=" ".join(declaration.split()),
                pointer_like=(
                    "*" in declaration
                    or "[" in declaration
                    or function_pointer is not None
                ),
            )
        )
    return tuple(parameters)


_QUOTED_INCLUDE_RE = re.compile(r'(?m)^\s*#\s*include\s*"(?P<path>[^"\r\n]+)"')


def source_with_local_includes(
    source_path: Path,
    include_dirs: tuple[Path, ...] | list[Path] = (),
    *,
    primary_source: str | None = None,
) -> str:
    """Collect a source and recursively reachable quoted headers for analysis.

    This is intentionally a read-only signature view.  The generated test
    source remains unchanged and QCP performs its own preprocessing.
    """

    source_path = source_path.expanduser().resolve()
    roots = tuple(Path(item).expanduser().resolve() for item in include_dirs)
    seen: set[Path] = set()
    chunks: list[str] = []
    total_bytes = 0

    def visit(path: Path, supplied: str | None = None) -> None:
        nonlocal total_bytes
        resolved = path.resolve()
        if resolved in seen:
            return
        if len(seen) >= 512:
            raise JobError("local include analysis exceeded 512 files")
        seen.add(resolved)
        try:
            text = supplied if supplied is not None else read_source_text(resolved)
        except OSError as error:
            raise JobError(f"cannot read source/include {resolved}: {error}") from error
        total_bytes += len(text.encode("utf-8", errors="replace"))
        if total_bytes > 16 * 1024 * 1024:
            raise JobError("local include analysis exceeded 16 MiB")
        chunks.append(f"\n/* qcp-spectest source: {resolved} */\n{text}")

        for match in _QUOTED_INCLUDE_RE.finditer(text):
            relative = Path(match.group("path"))
            candidates = (
                resolved.parent / relative,
                # Some generated QCIP OUTPUT sources retain a worktree-relative
                # path while copying the referenced header beside the source.
                resolved.parent / relative.name,
            ) + tuple(root / relative for root in roots)
            included = next(
                (
                    candidate.resolve()
                    for candidate in candidates
                    if candidate.is_file()
                ),
                None,
            )
            # Missing headers are left to QCP's own preprocessor.  They may be
            # system/provider headers irrelevant to With type inference.
            if included is not None:
                visit(included)

    visit(source_path, primary_source)
    return "\n".join(chunks)


def _extern_logic_signatures(source: str) -> dict[str, tuple[str, ...]]:
    signatures: dict[str, tuple[str, ...]] = {
        "IntArray::full": ("Z", "Z", "list Z"),
        "IntArray::seg": ("Z", "Z", "Z", "list Z"),
        "UIntArray::full": ("Z", "Z", "list Z"),
        "CharArray::full": ("Z", "Z", "list Z"),
        "LongArray::full": ("Z", "Z", "list Z"),
        "sll": ("Z", "list Z"),
    }
    for comment in re.finditer(
        r"/\*@\s*Extern\s+Coq\b(?P<body>.*?)\*/", source, re.DOTALL
    ):
        body = comment.group("body")
        index = 0
        while index < len(body):
            if body[index] != "(":
                index += 1
                continue
            declaration, index = _consume_balanced(body, index, "(", ")")
            colon = _top_level_colon(declaration)
            if colon is None:
                continue
            raw_names = declaration[:colon].strip()
            raw_type = declaration[colon + 1 :].strip()
            names = re.findall(
                r"[A-Za-z_][A-Za-z0-9_]*(?:::[A-Za-z_][A-Za-z0-9_]*)?",
                raw_names,
            )
            arrows = _split_top_level(raw_type, "->")
            if len(arrows) < 2:
                continue
            arguments = tuple(
                _normalize_type(item)
                for item in arrows[:-1]
                if not item.lstrip().startswith("{")
            )
            for name in names:
                signatures[name] = arguments
    return signatures


def _type_from_function_arguments(
    name: str,
    spec_body: str,
    signatures: dict[str, tuple[str, ...]],
) -> str | None:
    application = re.compile(
        r"(?P<function>[A-Za-z_][A-Za-z0-9_]*"
        r"(?:::[A-Za-z_][A-Za-z0-9_]*)?)\s*\("
    )
    for match in application.finditer(spec_body):
        signature = signatures.get(match.group("function"))
        if signature is None:
            continue
        try:
            arguments, _ = _consume_balanced(spec_body, match.end() - 1, "(", ")")
        except JobError:
            continue
        for index, argument in enumerate(_split_top_level(arguments, ",")):
            if index >= len(signature):
                break
            if _strip_outer_parentheses(argument) == name:
                return signature[index]
    return None


def _infer_logic_type(
    name: str,
    spec_body: str,
    signatures: dict[str, tuple[str, ...]],
) -> str | None:
    # A declared logic-function signature is more precise than the lexical
    # fallbacks below.  In particular, a variable used in a nested call such
    # as cons(mk_point(gx, gy), xs) must not be mistaken for cons's list tail
    # merely because a comma occurs inside mk_point.
    signature_type = _type_from_function_arguments(name, spec_body, signatures)
    if signature_type is not None:
        return signature_type
    escaped = re.escape(name)
    list_patterns = (
        rf"\b(?:Zlength|rev)\s*\(\s*{escaped}\b",
        rf"\bsll\s*\([^,]+,\s*{escaped}\s*\)",
        rf"\bcons\s*\([^,]+,\s*{escaped}\s*\)",
        rf"\b(?:IntArray|UIntArray|CharArray)::full"
        rf"\s*\([^)]*,\s*{escaped}\s*\)",
        rf"\b(?:app|Permutation|increasing)\s*\([^)]*\b{escaped}\b",
    )
    if any(re.search(pattern, spec_body, re.DOTALL) for pattern in list_patterns):
        return "list Z"
    numeric_patterns = (
        rf"\b{escaped}\b\s*(?:==|!=|<=|>=|<|>|\+|-|\*|/|%)\s*-?[0-9]",
        rf"-?[0-9]\s*(?:==|!=|<=|>=|<|>|\+|-|\*|/|%)\s*\b{escaped}\b",
        rf"\bcons\s*\(\s*{escaped}\s*,",
    )
    if any(re.search(pattern, spec_body) for pattern in numeric_patterns):
        return "Z"
    return None


def _derived_with_bindings(
    spec_body: str, variables: dict[str, str | None]
) -> dict[str, str]:
    require = re.search(r"\bRequire\b(?P<body>.*?)\bEnsure\b", spec_body, re.DOTALL)
    if require is None:
        return {}
    text = require.group("body")
    derived: dict[str, str] = {}
    atom = (
        r"(?:"
        r"[A-Za-z_][A-Za-z0-9_]*"
        r"|[-+]?[0-9]+"
        r"|Zlength\s*\([^()]*\)"
        r")"
    )
    for name in variables:
        escaped = re.escape(name)
        patterns = (
            rf"\b{escaped}\b\s*==\s*(?P<expr>{atom})",
            rf"(?P<expr>{atom})\s*==\s*\b{escaped}\b",
        )
        for pattern in patterns:
            match = re.search(pattern, text)
            if match is None:
                continue
            expression = match.group("expr").strip()
            dependency = re.fullmatch(
                r"Zlength\s*\(\s*([A-Za-z_][A-Za-z0-9_]*)\s*\)",
                expression,
            )
            is_derivable = (
                re.fullmatch(r"[-+]?[0-9]+", expression) is not None
                or expression in variables
                or (dependency is not None and dependency.group(1) in variables)
            )
            if expression != name and is_derivable:
                derived[name] = expression
                break
    # Equality aliases do not identify which side is input.  Break every
    # alias cycle deterministically so at least one representative remains a
    # user binding and the rest can be derived from it.
    while True:
        removed = False
        for start in sorted(derived):
            order: list[str] = []
            current = start
            while current in derived and derived[current] in variables:
                if current in order:
                    cycle = order[order.index(current) :]
                    del derived[min(cycle)]
                    removed = True
                    break
                order.append(current)
                current = derived[current]
            if removed:
                break
        if not removed:
            break
    return derived


def _with_analysis(
    spec_body: str,
    signatures: dict[str, tuple[str, ...]] | None = None,
) -> WithAnalysis:
    require_match = re.search(r"\bRequire\b", spec_body)
    if require_match is None:
        raise JobError("target function spec has no Require clause")
    prefix = spec_body[: require_match.start()]
    with_match = re.search(r"\bWith\b(?P<body>.*)\Z", prefix, re.DOTALL)
    if with_match is None:
        return WithAnalysis(values={}, types=(), derived={})
    body = with_match.group("body")
    type_variables: list[tuple[str, str | None]] = []
    variables: dict[str, str | None] = {}
    index = 0
    while index < len(body):
        if body[index].isspace():
            index += 1
            continue
        if body[index] == "{":
            declaration, index = _consume_balanced(body, index, "{", "}")
            if "::" in declaration:
                names, kind = declaration.split("::", 1)
                kind = _normalize_type(kind)
            else:
                names, kind = declaration, None
            found = re.findall(r"\b[A-Za-z_][A-Za-z0-9_]*\b", names)
            if not found:
                raise JobError("empty type-variable group in With clause")
            type_variables.extend((name, kind) for name in found)
            continue
        if body[index] == "(":
            declaration, index = _consume_balanced(body, index, "(", ")")
            colon = _top_level_colon(declaration)
            if colon is None:
                names, logic_type = declaration, None
            else:
                names = declaration[:colon]
                logic_type = _normalize_type(declaration[colon + 1 :])
            found = re.findall(r"\b[A-Za-z_][A-Za-z0-9_]*\b", names)
            if not found:
                raise JobError("empty value-variable group in With clause")
            for name in found:
                variables[name] = logic_type
            continue
        match = re.match(r"[A-Za-z_][A-Za-z0-9_]*", body[index:])
        if match is None:
            raise JobError(
                f"cannot parse With clause near {body[index : index + 30]!r}"
            )
        name = match.group(0)
        variables[name] = None
        index += len(name)

    for name, logic_type in tuple(variables.items()):
        if logic_type is None:
            variables[name] = _infer_logic_type(name, spec_body, signatures or {})
    return WithAnalysis(
        values=variables,
        types=tuple(dict.fromkeys(type_variables)),
        derived=_derived_with_bindings(spec_body, variables),
    )


def _input_hint(logic_type: str | None) -> tuple[str, Any]:
    normalized = _normalize_type(logic_type)
    if normalized in {"Z", "nat", "int"}:
        return "JSON integer or raw QCP expression", 0
    if _list_element_type(normalized) is not None:
        element_type = _list_element_type(normalized)
        if element_type in {"Z", "nat", "int"}:
            return (
                "JSON array or {'repeat': value, 'count': n}; "
                "automatically encoded as cons(..., nil)",
                [1, 2, 3],
            )
        return (
            "JSON array when its elements are supported, otherwise raw QCP expression",
            {"qcp": "nil"},
        )
    return (
        "generic {'ctor': C, 'args': [...]}, raw {'qcp': term}, "
        "or typed {'type': T, 'qcp'|'value': ...}",
        {
            "type": normalized or "<Coq type>",
            "qcp": "<well-typed QCP term>",
        },
    )


def _analyze_candidate(
    function: str,
    candidate: SpecCandidate,
    signatures: dict[str, tuple[str, ...]],
) -> dict[str, Any]:
    spec_body = candidate.body
    analysis = _with_analysis(spec_body, signatures)
    parameters = _c_parameters(candidate)
    variables: list[dict[str, Any]] = []
    example_arguments: dict[str, Any] = {}
    example_values: dict[str, Any] = {}
    argument_bindings: list[dict[str, Any]] = []
    for parameter in parameters:
        example = {"symbolic": True} if parameter.pointer_like else 0
        example_arguments[parameter.name] = example
        argument_bindings.append(
            {
                "name": parameter.name,
                "declaration": parameter.declaration,
                "required": not parameter.pointer_like,
                "input": (
                    "symbolic by default; optional numeric address or raw QCP expression"
                    if parameter.pointer_like
                    else "JSON integer/boolean or raw QCP expression"
                ),
                "pointer_like": parameter.pointer_like,
            }
        )
    for name, logic_type in analysis.values.items():
        hint, example = _input_hint(logic_type)
        declared_type = re.search(rf"\([^)]*\b{re.escape(name)}\b[^)]*:", spec_body)
        variables.append(
            {
                "name": name,
                "type": logic_type,
                "required": name not in analysis.derived,
                "binding_mode": ("derived" if name in analysis.derived else "user"),
                "derived_from": analysis.derived.get(name),
                "input": hint,
                "type_source": (
                    "declared"
                    if declared_type is not None
                    else "inferred"
                    if logic_type is not None
                    else "unknown"
                ),
            }
        )
        if name not in analysis.derived:
            example_values[name] = example
    return {
        "schema": "qcp-spectest-analysis/v1",
        "function": function,
        "spec": candidate.name,
        "derived_by": candidate.derived_by,
        "argument_bindings": argument_bindings,
        "value_bindings": variables,
        "type_bindings": [
            {
                "name": name,
                "kind": kind,
                "required": False,
                "mode": "optionally instantiate in binds.types",
                "input": "Coq/QCP type expression",
            }
            for name, kind in analysis.types
        ],
        "supported": True,
        "requires_spec_selection": False,
        "unsupported_reason": None,
        "binds_template": [
            {
                "id": "case_001",
                **(
                    {"types": {name: "<Coq type>" for name, _kind in analysis.types}}
                    if analysis.types
                    else {}
                ),
                "args": example_arguments,
                "values": example_values,
            }
        ],
    }


def analyze_source(
    source: str,
    function: str,
    spec_name: str | None = None,
    *,
    signature_source: str | None = None,
) -> dict[str, Any]:
    """Describe the bindable With variables and produce a friendly template."""

    all_candidates = _function_specs(source, function)
    if spec_name is None and len(all_candidates) > 1:
        return {
            "schema": "qcp-spectest-analysis/v1",
            "function": function,
            "supported": False,
            "requires_spec_selection": True,
            "available_specs": [
                {"name": item.name, "derived_by": item.derived_by}
                for item in all_candidates
            ],
            "argument_bindings": [],
            "value_bindings": [],
            "type_bindings": [],
            "binds_template": [],
            "unsupported_reason": "multiple specs found; select one by name",
        }
    candidate = _find_function_spec(source, function, spec_name)
    return _analyze_candidate(
        function,
        candidate,
        _extern_logic_signatures(signature_source or source),
    )


def analyze_catalog(
    source: str, *, signature_source: str | None = None
) -> dict[str, Any]:
    """Find every full function spec in a source file and analyze its bindings."""

    name_pattern = re.compile(r"\b(?P<name>[A-Za-z_][A-Za-z0-9_]*)\s*\(")
    ignored = {"if", "for", "while", "switch", "sizeof"}
    names = list(
        dict.fromkeys(
            match.group("name")
            for match in name_pattern.finditer(source)
            if match.group("name") not in ignored
            and not _inside_block_comment(source, match.start())
        )
    )
    functions: list[dict[str, Any]] = []
    signatures = _extern_logic_signatures(signature_source or source)
    for name in names:
        candidates = _function_specs(source, name)
        if not candidates:
            continue
        functions.append(
            {
                "function": name,
                "specs": [
                    _analyze_candidate(name, candidate, signatures)
                    for candidate in candidates
                ],
            }
        )
    return {
        "schema": "qcp-spectest-catalog/v1",
        "supported": True,
        "function_count": len(functions),
        "spec_count": sum(len(item["specs"]) for item in functions),
        "functions": functions,
    }


def _substitute_type_names(text: str, type_bindings: dict[str, str]) -> str:
    for name in sorted(type_bindings, key=len, reverse=True):
        text = re.sub(
            rf"(?<![A-Za-z0-9_]){re.escape(name)}(?![A-Za-z0-9_])",
            type_bindings[name],
            text,
        )
    return text


def _instantiate_spec_type_variables(
    spec_body: str,
    declared_types: tuple[tuple[str, str | None], ...],
    type_bindings: dict[str, Any],
) -> str:
    if not type_bindings:
        return spec_body
    declared = {name for name, _kind in declared_types}
    invalid = sorted(name for name in type_bindings if _NAME_RE.fullmatch(name) is None)
    if invalid:
        raise JobError(f"invalid type binding names: {', '.join(invalid)}")
    unknown = sorted(set(type_bindings) - declared)
    if unknown:
        raise JobError("type bindings not declared by With: " + ", ".join(unknown))
    normalized = {
        name: _validate_logic_type(raw_type, f"type binding {name!r}")
        for name, raw_type in type_bindings.items()
    }

    require = re.search(r"\bRequire\b", spec_body)
    with_keyword = re.search(r"\bWith\b", spec_body)
    if require is None or with_keyword is None or with_keyword.end() > require.start():
        raise JobError("cannot locate With type declarations in target spec")

    before = _substitute_type_names(spec_body[: with_keyword.end()], normalized)
    region = spec_body[with_keyword.end() : require.start()]
    rebuilt: list[str] = []
    index = 0
    while index < len(region):
        if region[index] != "{":
            start = index
            while index < len(region) and region[index] != "{":
                index += 1
            rebuilt.append(_substitute_type_names(region[start:index], normalized))
            continue
        declaration, after = _consume_balanced(region, index, "{", "}")
        if "::" in declaration:
            names_text, kind = declaration.split("::", 1)
            suffix = " :: " + kind.strip()
        else:
            names_text = declaration
            suffix = ""
        names = re.findall(r"\b[A-Za-z_][A-Za-z0-9_]*\b", names_text)
        remaining = [name for name in names if name not in normalized]
        if remaining:
            rebuilt.append("{" + " ".join(remaining) + suffix + "}")
        index = after

    after = _substitute_type_names(spec_body[require.start() :], normalized)
    return before + "".join(rebuilt) + after


def specialize_source(
    source: str,
    function: str,
    bindings: dict[str, Any],
    spec_name: str | None = None,
    *,
    type_bindings: dict[str, Any] | None = None,
    signature_source: str | None = None,
    argument_bindings: dict[str, Any] | None = None,
) -> str:
    """Serialize bindings into Require; unbound logical inputs stay symbolic."""

    bindings = _require_object(bindings, "bindings")
    type_bindings = _require_object(type_bindings or {}, "type bindings")
    candidate = _find_function_spec(source, function, spec_name)
    parameters = _c_parameters(candidate)
    normalized_arguments: dict[str, str] = {}
    if argument_bindings is not None:
        argument_bindings = _require_object(argument_bindings, "argument bindings")
        declared_arguments = {parameter.name for parameter in parameters}
        provided_arguments = set(argument_bindings)
        invalid_arguments = sorted(
            name for name in provided_arguments if _NAME_RE.fullmatch(name) is None
        )
        unknown_arguments = sorted(provided_arguments - declared_arguments)
        missing_arguments = sorted(
            parameter.name
            for parameter in parameters
            if not parameter.pointer_like and parameter.name not in provided_arguments
        )
        if invalid_arguments:
            raise JobError(
                "invalid C argument binding names: " + ", ".join(invalid_arguments)
            )
        if unknown_arguments:
            raise JobError(
                "bindings not declared as C parameters: " + ", ".join(unknown_arguments)
            )
        if missing_arguments:
            raise JobError(
                "missing C argument bindings: " + ", ".join(missing_arguments)
            )
        normalized_arguments = {
            parameter.name: _format_native_binding(
                argument_bindings[parameter.name],
                (
                    "fp32"
                    if re.search(r"\bfloat\b", parameter.declaration)
                    else "fp64"
                    if re.search(r"\bdouble\b", parameter.declaration)
                    else None
                )
                if not parameter.pointer_like
                else None,
                f"C argument {parameter.name}",
            )
            for parameter in parameters
            if parameter.name in argument_bindings
            and not _is_symbolic_binding(argument_bindings[parameter.name])
        }
    start, end, spec_body = candidate.start, candidate.end, candidate.body
    signatures = _extern_logic_signatures(signature_source or source)
    initial_analysis = _with_analysis(spec_body, signatures)
    spec_body = _instantiate_spec_type_variables(
        spec_body, initial_analysis.types, type_bindings
    )
    analysis = _with_analysis(spec_body, signatures)
    declared = set(analysis.values)
    provided = set(bindings)

    invalid_names = sorted(
        name for name in provided if _NAME_RE.fullmatch(name) is None
    )
    if invalid_names:
        raise JobError(f"invalid binding names: {', '.join(invalid_names)}")
    unknown = sorted(provided - declared)
    if unknown:
        raise JobError(f"bindings not declared by With: {', '.join(unknown)}")
    if not declared and not normalized_arguments:
        if spec_body == candidate.body:
            return source
        specialized_comment = "/*@" + spec_body + "*/"
        return source[:start] + specialized_comment + source[end:]

    normalized = {
        name: _format_native_binding(bindings[name], analysis.values[name], name)
        for name in sorted(bindings)
        if not _is_symbolic_binding(bindings[name])
    }
    require_match = re.search(r"\bRequire\b", spec_body)
    assert require_match is not None
    constraints = " && ".join(
        [
            *(
                f"({name} == ({expression}))"
                for name, expression in normalized_arguments.items()
            ),
            *(f"({name} == ({expression}))" for name, expression in normalized.items()),
        ]
    )
    if not constraints:
        if spec_body == candidate.body:
            return source
        specialized_comment = "/*@" + spec_body + "*/"
        return source[:start] + specialized_comment + source[end:]
    insertion = require_match.end()
    specialized_body = (
        spec_body[:insertion] + "\n      " + constraints + " &&" + spec_body[insertion:]
    )
    specialized_comment = "/*@" + specialized_body + "*/"
    return source[:start] + specialized_comment + source[end:]


def specialize_entry_source(
    source: str,
    function: str,
    bindings: dict[str, Any],
    spec_name: str | None = None,
    **kwargs: Any,
) -> tuple[str, str | None]:
    """Constrain the root entry without specializing contracts used by calls.

    QCP selects the named entry for initial execution; ordinary and explicitly
    named calls still see the original contracts in their original order.
    Declaration-only checks keep their single original goal interface.
    """
    specialized = specialize_source(source, function, bindings, spec_name, **kwargs)
    candidate = _find_function_spec(source, function, spec_name)
    suffix = re.match(r"\s*" + _C_COMMENT_TRIVIA + r"*([;{])", source[candidate.end :], re.S)
    if specialized == source or suffix is None or suffix.group(1) == ";":
        return specialized, spec_name
    entry = _find_function_spec(specialized, function, spec_name)
    start = re.search(r"\b(?:With|Require)\b", entry.body)
    assert start is not None
    names = set(re.findall(r"\b[A-Za-z_][A-Za-z0-9_]*\b", source))
    name = "__tespec_entry"
    while name in names:
        name += "_"
    comment = "\n/*@ " + name + " " + entry.body[start.start() :] + "*/"
    return source[: candidate.start] + comment + "\n" + source[candidate.start :], name


def _parse_qcp_config(job: dict[str, Any], base: Path, source_dir: Path) -> QcpConfig:
    raw = _require_object(job.get("qcp", {}), "qcp")
    qcip_root = (
        _resolve(base, raw["qcip_root"], "qcp.qcip_root")
        if "qcip_root" in raw
        else bundled_qcip_root().resolve()
    )
    binary = (
        _resolve(qcip_root, raw["binary"], "qcp.binary")
        if "binary" in raw
        else bundled_qcp_binary().resolve()
    )
    if not binary.is_file():
        raise JobError(f"QCP binary does not exist: {binary}")

    # Strategy and domain headers belong to the source/case that declares
    # them.  Keeping only the source directory implicit makes dependencies
    # relocatable and prevents an unrelated project-level provider from
    # silently changing a case's execution semantics.
    includes = [source_dir]
    for index, item in enumerate(raw.get("include_dirs", [])):
        includes.append(_resolve(qcip_root, item, f"qcp.include_dirs[{index}]"))

    timeout = raw.get("timeout_seconds", 30)
    if not isinstance(timeout, (int, float)) or timeout <= 0:
        raise JobError("qcp.timeout_seconds must be positive")
    try:
        execution_mode = normalize_execution_mode(raw.get("execution_mode", "entry-exit"))
        execution_strategy = normalize_execution_strategy(raw.get("execution_strategy", "inline"))
    except ValueError as error:
        raise JobError(f"qcp.{error}") from error
    modular_instantiation = raw.get("modular_instantiation", "on")
    if modular_instantiation not in ("on", "off"):
        raise JobError("qcp.modular_instantiation must be on or off")
    architecture_bits = raw.get("architecture_bits", 32)
    if type(architecture_bits) is not int or architecture_bits not in (32, 64):
        raise JobError("qcp.architecture_bits must be 32 or 64")
    spatial_smt = raw.get("spatial_smt", False)
    if type(spatial_smt) is not bool:
        raise JobError("qcp.spatial_smt must be a boolean")
    spatial_timeout = raw.get("spatial_smt_timeout_ms", 2000)
    if type(spatial_timeout) is not int or not 1 <= spatial_timeout <= 60000:
        raise JobError("qcp.spatial_smt_timeout_ms must be an integer from 1 to 60000")
    instance_trace = raw.get("instance_trace", False)
    if not isinstance(instance_trace, bool):
        raise JobError("qcp.instance_trace must be a boolean")
    annotation_policy = raw.get("annotation_policy")
    permitted = (
        (None, "qcp", "check-preserve")
        if execution_mode == "all-boundaries"
        else (None, "ignore", "check-preserve")
    )
    if annotation_policy not in permitted:
        raise JobError("annotation policy conflicts with execution mode")
    loop_unroll_limit = raw.get("loop_unroll_limit", 0)
    if (
        isinstance(loop_unroll_limit, bool)
        or not isinstance(loop_unroll_limit, int)
        or loop_unroll_limit < 0
        or loop_unroll_limit > 1_000_000
    ):
        raise JobError("qcp.loop_unroll_limit must be an integer from 0 to 1000000")
    call_depth_limit = raw.get("call_depth_limit", 64)
    if (
        isinstance(call_depth_limit, bool)
        or not isinstance(call_depth_limit, int)
        or call_depth_limit < 1
        or call_depth_limit > 1_000_000
    ):
        raise JobError("qcp.call_depth_limit must be an integer from 1 to 1000000")
    return QcpConfig(
        qcip_root=qcip_root,
        binary=binary,
        include_dirs=tuple(dict.fromkeys(includes)),
        timeout_seconds=float(timeout),
        execution_mode=execution_mode,
        execution_strategy=execution_strategy,
        modular_instantiation=modular_instantiation,
        annotation_policy=raw.get("annotation_policy"),
        instance_trace=instance_trace,
        loop_unroll_limit=loop_unroll_limit,
        call_depth_limit=call_depth_limit,
        architecture_bits=architecture_bits,
        spatial_smt=spatial_smt,
        spatial_smt_timeout_ms=spatial_timeout,
    )


def _qcp_command(
    config: QcpConfig,
    generated_source: Path,
    function: str,
    spec_name: str | None,
    vc_dir: Path,
) -> list[str]:
    command = [
        str(config.binary),
        f"--arch={config.architecture_bits}",
        f"--input-file={generated_source}",
        "--full-auto",
        "--Json-output",
        "--emit-residual-vc",
        "--no-strategy-gen",
        "--gen-and-backup",
        "--coq-output-dir",
        str(vc_dir),
        "--no-logic-path",
        "--disable-solver-info",
        "--no-exec-info",
        "--function",
        function,
    ]
    if config.execution_mode == "entry-exit":
        command.append("--concrete-bindings")
    else:
        command.append("--spec-test-no-expand")
    # Older binaries already default to inline. Only the opt-in strategy
    # requires the new native flag; its response is checked before accepting it.
    if config.execution_strategy != "inline":
        command.extend(("--execution-strategy", config.execution_strategy))
        if config.modular_instantiation == "off":
            command.extend(("--modular-instantiation", "off"))
    if config.instance_trace:
        command.append("--instance-trace")
    if config.annotation_policy is not None:
        command.extend(("--annotation-policy", config.annotation_policy))
    if spec_name is not None:
        command.extend(("--spec", spec_name))
    command.extend(f"-I{path}" for path in config.include_dirs)
    if config.loop_unroll_limit:
        command.extend(("--loop-unroll-limit", str(config.loop_unroll_limit)))
    command.extend(("--call-depth-limit", str(config.call_depth_limit)))
    return command


def _sha256(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as source:
        for chunk in iter(lambda: source.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def _run_measured(
    command: list[str], *, cwd: Path, timeout: float, metrics_path: Path
) -> tuple[subprocess.CompletedProcess[str], int | None, float | None]:
    """Measure executor and children with GNU time (RSS is max, not tree sum)."""

    time_binary = shutil.which("/usr/bin/time")
    metrics_path.unlink(missing_ok=True)
    measured_command = (
        [time_binary, "-q", "-f", "%M %U %S", "-o", str(metrics_path), "--", *command]
        if time_binary
        else command
    )
    process = subprocess.Popen(
        measured_command,
        cwd=cwd,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        text=True,
        start_new_session=True,
    )
    try:
        stdout, stderr = process.communicate(timeout=timeout)
    except subprocess.TimeoutExpired:
        # Kill the executor and all subprocesses, not only the time wrapper.
        try:
            os.killpg(process.pid, signal.SIGKILL)
        except ProcessLookupError:
            pass
        stdout, stderr = process.communicate()
        raise subprocess.TimeoutExpired(command, timeout, output=stdout, stderr=stderr)
    completed = subprocess.CompletedProcess(command, process.returncode, stdout, stderr)
    try:
        rss, user, system = metrics_path.read_text(encoding="utf-8").split()
        peak_rss_kb = int(rss)
        cpu_seconds = round(float(user) + float(system), 6)
    except (OSError, ValueError):
        peak_rss_kb = None
        cpu_seconds = None
    finally:
        metrics_path.unlink(missing_ok=True)
    return completed, peak_rss_kb, cpu_seconds


_SOURCE_COQ_IMPORT_RE = re.compile(
    r"/\*@\s*Import\s+Coq\s+"
    r"(?:(?:From\s+(?P<prefix>[A-Za-z_][A-Za-z0-9_.]*)\s+)?"
    r"Require\s+(?:(?:Import|Export)\s+)?)"
    r"(?P<modules>.*?)\*/",
    re.DOTALL,
)
_COQ_LOGICAL_NAME = r"[A-Za-z_][A-Za-z0-9_]*(?:\.[A-Za-z_][A-Za-z0-9_]*)*"
_COQ_REQUIRE_RE = re.compile(
    rf"\b(?:(?:From\s+(?P<prefix>{_COQ_LOGICAL_NAME})\s+)?"
    r"Require\s+(?:(?:Import|Export)\s+)?)"
    rf"(?P<modules>{_COQ_LOGICAL_NAME}"
    rf"(?:\s+{_COQ_LOGICAL_NAME})*)\s*\.",
)
_COQ_MODULE_RE = re.compile(rf"{_COQ_LOGICAL_NAME}\Z")


def _qualified_modules(prefix: str | None, body: str) -> list[str]:
    modules: list[str] = []
    for token in body.split():
        if _COQ_MODULE_RE.fullmatch(token) is None:
            continue
        modules.append(f"{prefix}.{token}" if prefix is not None else token)
    return modules


def _source_coq_imports(source: str) -> list[str]:
    """Extract direct and ``From`` Coq imports from QCP annotations."""

    modules: list[str] = []
    for match in _SOURCE_COQ_IMPORT_RE.finditer(source):
        modules.extend(
            _qualified_modules(match.group("prefix"), match.group("modules"))
        )
    return list(dict.fromkeys(modules))


def _coq_dependency_code(source: str) -> str:
    """Mask nested comments and strings before scanning vernacular imports."""
    chars = list(source)
    index, depth = 0, 0
    quoted = False
    while index < len(source):
        pair = source[index : index + 2]
        width = 1
        masked = depth > 0 or quoted
        if depth:
            if pair == "(*":
                depth += 1
                width = 2
            elif pair == "*)":
                depth -= 1
                width = 2
        elif quoted:
            if pair == '""':
                width = 2
            elif source[index] == '"':
                quoted = False
        elif pair == "(*":
            depth = 1
            width, masked = 2, True
        elif source[index] == '"':
            quoted, masked = True, True
        if masked:
            for pos in range(index, index + width):
                if chars[pos] != "\n":
                    chars[pos] = " "
        index += width
    if depth or quoted:
        raise JobError("unterminated Rocq comment or string in dependency source")
    return "".join(chars)


def _coq_required_modules(source: str) -> list[str]:
    """Extract Coq source dependencies for case-local recursive staging."""

    modules: list[str] = []
    for match in _COQ_REQUIRE_RE.finditer(_coq_dependency_code(source)):
        modules.extend(
            _qualified_modules(match.group("prefix"), match.group("modules"))
        )
    return list(dict.fromkeys(modules))


def _resolve_source_coq_module(
    module: str,
    original_source: Path,
    qcip_root: Path,
) -> Path | None:
    """Resolve a source-declared Coq module without case-name knowledge."""

    relative = Path(*module.split(".")).with_suffix(".v")

    # A case owns its domain modules.  Resolve the exact logical path before
    # consulting shared QCP libraries, so two cases may carry different
    # definitions without contaminating each other.
    ancestors = (original_source.parent, *original_source.parents[:5])
    for ancestor in dict.fromkeys(ancestors):
        for root in (ancestor / "dependencies" / "coq", ancestor / "coq"):
            candidate = root / relative
            if candidate.is_file():
                return candidate.resolve()

    basename = relative.name
    nearby = (
        original_source.parent / basename,
        original_source.parent.parent / "qciplib" / basename,
        original_source.parent.parent / "rocq" / basename,
    )
    for candidate in nearby:
        if candidate.is_file():
            return candidate.resolve()

    standard_roots = (("SimpleC.EE.", qcip_root / "SeparationLogic/examples"),)
    for prefix, physical_root in standard_roots:
        if module.startswith(prefix):
            candidate = physical_root / Path(
                *module[len(prefix) :].split(".")
            ).with_suffix(".v")
            if candidate.is_file():
                return candidate.resolve()

    return None


def _runtime_coq_module(module: str, qcip_root: Path) -> Path | None:
    """Resolve a runtime source by the same logical roots used by coqc."""
    runtime = qcip_root / "SeparationLogic"
    args = _coq_load_path_args(runtime, Path("."))
    for index, flag in enumerate(args):
        if flag not in {"-R", "-Q"}:
            continue
        physical, logical = args[index + 1 : index + 3]
        if logical and module.startswith(logical + "."):
            relative = module[len(logical) + 1 :]
            path = Path(physical) / Path(*relative.split(".")).with_suffix(".v")
            if path.is_file():
                return path.resolve()
    return None


def _stage_source_coq_dependencies(
    generated_source: Path,
    original_source: Path,
    qcip_root: Path,
    vc_dir: Path,
    dependency_source: str | None = None,
    runtime_dependencies: list[dict[str, Any]] | None = None,
) -> list[dict[str, str]]:
    """Copy explicit source-level Coq imports into an immutable VC-local tree.

    QCIP OUTPUT cases sometimes keep their library beside the C source rather
    than under SeparationLogic/examples, and those directories often contain
    only a .v file.  Staging the exact imported source lets the proof checker
    compile it under the logical module name without writing .vo files back
    into QCIP.
    """

    source = (
        dependency_source
        if dependency_source is not None
        else generated_source.read_text(encoding="utf-8", errors="replace")
    )
    modules = _source_coq_imports(source)
    dependencies: list[dict[str, str]] = []
    dependency_root = vc_dir / "dependencies"
    visiting: set[str] = set()
    staged_modules: set[str] = set()

    def stage(module: str) -> None:
        if module in staged_modules or module in visiting:
            return
        physical = _resolve_source_coq_module(module, original_source, qcip_root)
        runtime_source = _runtime_coq_module(module, qcip_root)
        if runtime_source is not None:
            if physical is not None and _sha256(physical) != _sha256(runtime_source):
                raise JobError(
                    "source dependency shadows pinned runtime module: " + module
                )
            if runtime_dependencies is not None:
                compiled = runtime_source.with_suffix(".vo")
                runtime_dependencies.append(
                    {
                        "module": module,
                        "source": str(runtime_source),
                        "sha256": _sha256(runtime_source),
                        "compiled": str(compiled) if compiled.is_file() else None,
                        "compiled_sha256": _sha256(compiled)
                        if compiled.is_file()
                        else None,
                        "origin": "pinned-runtime",
                    }
                )
            staged_modules.add(module)
            return
        if physical is None:
            return
        visiting.add(module)
        coq_source = physical.read_text(encoding="utf-8", errors="replace")
        for required in _coq_required_modules(coq_source):
            stage(required)
        visiting.remove(module)

        staged = dependency_root / Path(*module.split(".")).with_suffix(".v")
        staged.parent.mkdir(parents=True, exist_ok=True)
        shutil.copyfile(physical, staged)
        dependencies.append(
            {
                "module": module,
                "source": str(physical),
                "staged": str(staged),
                "sha256": _sha256(staged),
            }
        )
        staged_modules.add(module)

    for module in modules:
        stage(module)
    return dependencies


def _write_vc_manifest(
    vc_dir: Path,
    generated_source: Path,
    original_source: Path,
    qcip_root: Path,
    function: str,
    case_id: str,
    dependency_source: str | None = None,
    executor_output: str | None = None,
) -> dict[str, Any]:
    stem = generated_source.stem
    paths = {
        "goal": vc_dir / f"{stem}_goal.v",
        "proof_auto": vc_dir / f"{stem}_proof_auto.v",
        "proof_manual": vc_dir / f"{stem}_proof_manual.v",
        "goal_check": vc_dir / f"{stem}_goal_check.v",
    }
    missing = [name for name, path in paths.items() if not path.is_file()]
    residual_goals: list[str] = []
    if not missing:
        manual = paths["proof_manual"].read_text(encoding="utf-8", errors="replace")
        residual_goals = re.findall(
            r"(?m)^\s*Lemma\s+(proof_of_[A-Za-z_][A-Za-z0-9_]*)\s*:",
            manual,
        )
    counterexample_goals: list[str] = []
    runtime_dependencies: list[dict[str, Any]] = []
    coq_dependencies = _stage_source_coq_dependencies(
        generated_source,
        original_source,
        qcip_root,
        vc_dir,
        dependency_source,
        runtime_dependencies,
    )
    manifest = {
        "schema": "qcp-spectest-vc-manifest/v1",
        "case_id": case_id,
        "function": function,
        "source": str(generated_source),
        "qcip_root": str(qcip_root),
        "status": (
            "not_generated"
            if missing
            else "counterexample"
            if counterexample_goals
            else "residual"
            if residual_goals
            else "auto_proved"
        ),
        "residual_goals": residual_goals,
        "counterexample_goals": counterexample_goals,
        "files": {
            name: str(path) if path.is_file() else None for name, path in paths.items()
        },
        "missing_files": missing,
        "immutable_sha256": {
            name: _sha256(paths[name])
            for name in ("goal", "proof_auto", "goal_check")
            if paths[name].is_file()
        },
        "coq_dependencies": coq_dependencies,
        "runtime_dependencies": runtime_dependencies,
        # Embedded in the immutable certificate manifest during preparation.
        # This records the selected interpretation, not a proof of frontend
        # correctness or compatibility of legacy imported predicates.
        "target_layout": _executor_target_layout(executor_output),
    }
    vc_dir.mkdir(parents=True, exist_ok=True)
    manifest_path = vc_dir / "manifest.json"
    manifest_path.write_text(
        json.dumps(manifest, ensure_ascii=False, indent=2) + "\n",
        encoding="utf-8",
    )
    manifest["manifest"] = str(manifest_path)
    return manifest


def _safe_case_id(raw: Any, index: int) -> str:
    if raw is None:
        return f"case_{index + 1:03d}"
    if not isinstance(raw, str) or _NAME_RE.fullmatch(raw) is None:
        raise JobError(f"binds[{index}].id must be a C-identifier-like string")
    return raw


def _parse_bind_cases(raw_binds: list[Any], default_spec: Any) -> tuple[BindCase, ...]:
    cases: list[BindCase] = []
    seen_ids: set[str] = set()
    for index, raw_case in enumerate(raw_binds):
        case = _require_object(raw_case, f"binds[{index}]")
        case_id = _safe_case_id(case.get("id"), index)
        if case_id in seen_ids:
            raise JobError(f"duplicate bind case id: {case_id}")
        seen_ids.add(case_id)

        selected_spec = case.get("spec", default_spec)
        if selected_spec is not None and not isinstance(selected_spec, str):
            raise JobError(f"binds[{index}].spec must be a string")
        cases.append(
            BindCase(
                case_id=case_id,
                arguments=_require_object(case.get("args", {}), f"binds[{index}].args"),
                values=_require_object(case.get("values"), f"binds[{index}].values"),
                types=_require_object(case.get("types", {}), f"binds[{index}].types"),
                spec=selected_spec,
            )
        )
    return tuple(cases)


def _subprocess_text(value: str | bytes | None) -> str:
    if value is None:
        return ""
    if isinstance(value, bytes):
        return value.decode("utf-8", errors="replace")
    return value


@lru_cache(maxsize=8)
def _runtime_source_digest(root: Path) -> str:
    """Pin the source runtime at the start of this controller process."""
    digest = hashlib.sha256()
    for directory in (root / "SeparationLogic", root / "QCP_examples"):
        for path in sorted(directory.rglob("*")):
            if path.is_file() and (
                path.suffix in {".v", ".h", ".strategies"} or path.name == "_CoqProject"
            ):
                digest.update(str(path.relative_to(root)).encode())
                digest.update(b"\0")
                digest.update(hashlib.sha256(path.read_bytes()).digest())
    return digest.hexdigest()


def _report_provenance(
    source_path, job_path, binary, runtime, signature_source, spec_file=None
):
    """Use the same provenance vocabulary for ordinary and checked execution."""
    return {
        "source_sha256": _sha256(source_path),
        "job_sha256": _sha256(job_path),
        "binary_sha256": _sha256(binary),
        "runtime_source_sha256": _runtime_source_digest(runtime),
        "runtime_digest_scope": "SeparationLogic and QCP_examples: .v, .h, .strategies, _CoqProject",
        "included_source_sha256": hashlib.sha256(signature_source.encode()).hexdigest(),
        "spec_sha256": _sha256(spec_file) if spec_file else None,
    }


def run_job(
    job_path: Path, output_override: Path | None = None, *,
    spatial_smt: bool | None = None, spatial_smt_timeout_ms: int | None = None,
) -> dict[str, Any]:
    job_path = job_path.expanduser().resolve()
    try:
        job = json.loads(job_path.read_text(encoding="utf-8"))
    except (OSError, json.JSONDecodeError) as error:
        raise JobError(f"cannot read job file {job_path}: {error}") from error
    job = _require_object(job, "job")
    if spatial_smt is not None or spatial_smt_timeout_ms is not None:
        job["qcp"] = dict(_require_object(job.get("qcp", {}), "qcp"))
        if spatial_smt is not None:
            job["qcp"]["spatial_smt"] = spatial_smt
        if spatial_smt_timeout_ms is not None:
            job["qcp"]["spatial_smt_timeout_ms"] = spatial_smt_timeout_ms
    base = job_path.parent

    source_path = _resolve(base, job.get("source"), "source")
    source = read_source_text(source_path)
    function = job.get("function")
    if not isinstance(function, str):
        raise JobError("function must be a string")
    spec_file_value = job.get("spec_file")
    spec_file_path: Path | None = None
    if spec_file_value is not None:
        spec_file_path = _resolve(base, spec_file_value, "spec_file")
        source = attach_spec_to_source(
            source,
            read_source_text(spec_file_path),
            function,
        )

    raw_binds = job.get("binds")
    if not isinstance(raw_binds, list) or not raw_binds:
        raise JobError("binds must be a non-empty array")
    bind_cases = _parse_bind_cases(raw_binds, job.get("spec"))

    output_dir = (
        output_override.expanduser().resolve()
        if output_override is not None
        else _resolve(base, job.get("output_dir", ".spectest"), "output_dir")
    )
    output_dir.mkdir(parents=True, exist_ok=True)
    config = _parse_qcp_config(job, base, source_path.parent)
    signature_source = source_with_local_includes(
        source_path,
        config.include_dirs,
        primary_source=source,
    )

    results: list[dict[str, Any]] = []
    started = time.monotonic()
    for case in bind_cases:
        case_dir = output_dir / "artifacts" / case.case_id
        if case_dir.is_symlink() or (case_dir.exists() and not case_dir.is_dir()):
            raise JobError(f"case output path is not a directory: {case_dir}")
        if case_dir.exists():
            shutil.rmtree(case_dir)
        case_dir.mkdir(parents=True, exist_ok=True)
        generated_source = case_dir / "input.c"
        stdout_path = case_dir / "executor.json"
        stderr_path = case_dir / "stderr.log"
        vc_dir = case_dir / "vc"

        case_result: dict[str, Any] = {
            "id": case.case_id,
            "arguments": case.arguments,
            "bindings": case.values,
            "type_bindings": case.types,
            "spec": case.spec,
            "generated_source": str(generated_source),
        }
        try:
            specialized, entry_spec = specialize_entry_source(
                source,
                function,
                case.values,
                case.spec,
                type_bindings=case.types,
                signature_source=signature_source,
                argument_bindings=case.arguments,
            )
            specialized = _relocate_strategy_includes(specialized, source_path)
            generated_source.write_text(specialized, encoding="utf-8")
            command = _qcp_command(
                config,
                generated_source,
                function,
                entry_spec,
                vc_dir,
            )
            run_started = time.monotonic()
            completed, peak_rss_kb, cpu_seconds = _run_measured(
                command,
                cwd=config.binary.parent.parent,
                timeout=config.timeout_seconds,
                metrics_path=case_dir / ".qcp-rss-kb",
            )
            duration = time.monotonic() - run_started
            stdout_path.write_text(completed.stdout, encoding="utf-8")
            stderr_path.write_text(completed.stderr, encoding="utf-8")
            vc = _write_vc_manifest(
                vc_dir,
                generated_source,
                source_path,
                config.qcip_root,
                function,
                case.case_id,
                signature_source,
                executor_output=completed.stdout,
            )
            case_result.update(
                {
                    **_executor_result(
                        completed.stdout, completed.returncode, vc,
                        expected_strategy=config.execution_strategy,
                        expected_modular_instantiation=config.modular_instantiation,
                    ),
                    "returncode": completed.returncode,
                    "generated_source_sha256": _sha256(generated_source),
                    "duration_seconds": round(duration, 6),
                    "peak_rss_kb": peak_rss_kb,
                    "cpu_seconds": cpu_seconds,
                    "command": command,
                    "stdout": str(stdout_path),
                    "stderr": str(stderr_path),
                    "vc": vc,
                }
            )
        except JobError as error:
            case_result.update(
                {
                    "status": "ERROR",
                    "satisfied": None,
                    "reason": "invalid_bindings",
                    "error": str(error),
                }
            )
        except subprocess.TimeoutExpired as error:
            rss_path = case_dir / ".qcp-rss-kb"
            try:
                timeout_peak_rss_kb = int(
                    rss_path.read_text(encoding="utf-8").split()[0]
                )
            except (OSError, ValueError, IndexError):
                timeout_peak_rss_kb = None
            rss_path.unlink(missing_ok=True)
            stdout_path.write_text(_subprocess_text(error.stdout), encoding="utf-8")
            stderr_path.write_text(_subprocess_text(error.stderr), encoding="utf-8")
            case_result.update(
                {
                    "status": "UNKNOWN",
                    "satisfied": None,
                    "reason": "qcp_timeout",
                    "error": f"QCP exceeded {config.timeout_seconds:g} seconds",
                    "stdout": str(stdout_path),
                    "stderr": str(stderr_path),
                    "command": command,
                    "phases": {
                        name: "UNKNOWN"
                        for name in (
                            "precondition",
                            "safety",
                            "postcondition",
                            "annotations",
                        )
                    },
                    "vc": _write_vc_manifest(
                        vc_dir,
                        generated_source,
                        source_path,
                        config.qcip_root,
                        function,
                        case.case_id,
                        signature_source,
                    ),
                    "duration_seconds": round(time.monotonic() - run_started, 6),
                    "peak_rss_kb": timeout_peak_rss_kb,
                }
            )
        case_result.setdefault(
            "residual_vcs", case_result.get("vc", {}).get("residual_goals", [])
        )
        case_result.setdefault(
            "phases",
            {
                name: "NOT_CHECKED"
                for name in ("precondition", "safety", "postcondition", "annotations")
            },
        )
        case_result.setdefault("scope", "NOT_REPORTED")
        case_result.setdefault("abstraction_events", [])
        case_result.setdefault("overall", case_result["status"])
        entry = case_result["phases"].get("precondition")
        case_result.setdefault(
            "precondition_result", entry if entry in {"SAT", "UNSAT"} else "UNKNOWN"
        )
        case_result.setdefault(
            "test_result",
            case_result["status"]
            if case_result["status"] in {"PASS", "FAIL", "UNKNOWN"}
            else None,
        )
        case_result.setdefault("mode", config.execution_mode)
        case_result.setdefault("requested_execution_strategy", config.execution_strategy)
        case_result.setdefault(
            "evidence", {"decision_backend": "qcp-smt", "certificate": "NOT_CHECKED"}
        )
        case_result.setdefault(
            "resources",
            {
                "wall_seconds": case_result.get("duration_seconds"),
                "cpu_seconds": case_result.get("cpu_seconds"),
                "measurement": "GNU time; executor and children; maximum process RSS",
                "peak_rss_kib": case_result.get("peak_rss_kb"),
            },
        )
        if config.spatial_smt:
            from .spatial_smt import refine_case

            refine_case(case_result, stdout_path, case_dir / "spatial-smt",
                        timeout_ms=config.spatial_smt_timeout_ms)
        results.append(case_result)

    counts = {
        status: sum(result["status"] == status for result in results)
        for status in ("PASS", "FAIL", "UNKNOWN", "ERROR", "INVALID")
    }
    itp_vcs = [
        {
            "case_id": result["id"],
            "function": function,
            "manifest": result["vc"]["manifest"],
            "goals": result["vc"]["residual_goals"],
        }
        for result in results
        if isinstance(result.get("vc"), dict)
        and result["vc"].get("status") == "residual"
        and result["vc"].get("residual_goals")
        and result.get("spatial_smt", {}).get("itp_required", True)
    ]
    report = {
        "schema": "qcp-spectest-report/v1",
        "job": str(job_path),
        "source": str(source_path),
        "spec_file": str(spec_file_path) if spec_file_path is not None else None,
        "function": function,
        "qcp_binary": str(config.binary),
        "provenance": _report_provenance(
            source_path,
            job_path,
            config.binary,
            config.qcip_root,
            signature_source,
            spec_file_path,
        ),
        "vc_policy": {
            "mode": config.execution_mode,
            "execution_strategy": config.execution_strategy,
            "execution_semantics": execution_semantics(config.execution_strategy, config.modular_instantiation),
            "modular_instantiation": config.modular_instantiation,
            "loops": "execute_iterations" if config.execution_strategy == "inline" else ("retain_symbolic_invariant_boundaries" if config.modular_instantiation == "off" else "sample_or_retain_symbolic_invariant_boundaries"),
            "defined_function_calls": "execute_bodies" if config.execution_strategy == "inline" else ("retain_symbolic_contract_postconditions" if config.modular_instantiation == "off" else "sample_or_retain_symbolic_contract_postconditions"),
            "intermediate_boundaries": (
                config.annotation_policy not in (None, "ignore")
                or config.execution_mode == "all-boundaries"
            ),
            "declaration_calls": (
                "sample_contract_postconditions"
                if any(result.get("declaration_call_policy") == "contract-sample/v1"
                       for result in results)
                else ("retain_symbolic_contract_postconditions"
                      if any(result.get("declaration_call_policy") == "contract-symbolic/v1" for result in results)
                      else ("sample_or_retain_symbolic_contract_postconditions"
                            if any(result.get("declaration_call_policy") == "contract-sample-or-symbolic/v2" for result in results)
                            else "not_reported_by_executor"))
            ),
            "call_depth_limit": config.call_depth_limit,
            "loop_unroll_limit": config.loop_unroll_limit or 1024,
        },
        "results": results,
        "itp_vcs": itp_vcs,
        "summary": {
            "total": len(results),
            **counts,
            "specification_only": sum(
                result.get("scope") == "specification-only" for result in results
            ),
            "duration_seconds": round(time.monotonic() - started, 6),
            "executor_cpu_seconds": (
                round(sum(result["cpu_seconds"] for result in results), 6)
                if all(
                    isinstance(result.get("cpu_seconds"), (int, float))
                    for result in results
                )
                else None
            ),
            "peak_rss_kb": max(
                (
                    result["peak_rss_kb"]
                    for result in results
                    if isinstance(result.get("peak_rss_kb"), int)
                ),
                default=None,
            ),
        },
    }
    if config.spatial_smt:
        report["vc_policy"]["spatial_smt"] = {
            "enabled": True, "timeout_ms_per_query": config.spatial_smt_timeout_ms,
            "backend": "finite-spatial-smt/v1", "certificate": "NOT_CHECKED",
            "fallback": "original_itp_vcs", "stage": "after_executor",
        }
    report_path = output_dir / "report.json"
    report_path.write_text(
        json.dumps(report, ensure_ascii=False, indent=2) + "\n",
        encoding="utf-8",
    )
    report["report"] = str(report_path)
    return report


_FORBIDDEN_MANUAL_PROOF = re.compile(
    r"(?mi)^\s*(?:(?:Local|Global|Polymorphic|Monomorphic)\s+)*"
    r"(?:Axiom|Conjecture|Hypotheses?|Parameters?|Variables?|Context)\b"
    r"|\b(?:Admitted|admit|Abort)\b"
)


def _default_coqc_command() -> list[str]:
    coqc = shutil.which("coqc")
    if coqc is not None:
        return [coqc]
    opam = shutil.which("opam")
    if opam is not None:
        return [opam, "exec", "--switch=qcp-8.20", "--", "coqc"]
    raise JobError("neither opam nor coqc is available for proof checking")


def _coq_load_path_args(
    separation_logic: Path,
    vc_dir: Path,
    dependency_root: Path | None = None,
) -> list[str]:
    mappings = (
        ("-R", "flocq/src", "Flocq"),
        ("-R", "SeparationLogic", "SimpleC.SL"),
        ("-R", "unifysl", "Logic"),
        ("-R", "sets", "SetsClass"),
        ("-R", "compcert_lib", "compcert.lib"),
        ("-R", "auxlibs", "AUXLib"),
        ("-R", "examples", "SimpleC.EE"),
        ("-R", "stdlib", "SimpleC.StdLib"),
        ("-R", "StrategyLib", "SimpleC.StrategyLib"),
        ("-R", "Common", "SimpleC.Common"),
        ("-R", "fixedpoints", "FP"),
        ("-R", "MonadLib", "MonadLib"),
        ("-R", "listlib", "ListLib"),
        ("-R", "MaxMinLib", "MaxMinLib"),
        ("-R", "GraphLib", "GraphLib"),
        ("-R", "SumLib", "SumLib"),
        ("-R", "tracelib", "TraceLib"),
        ("-R", "coq-record-update/src", "RecordUpdate"),
        ("-Q", "algorithms", "Algorithms"),
    )
    args = ["-Q", str(vc_dir), ""]
    for flag, folder, logical in mappings:
        args.extend((flag, str(separation_logic / folder), logical))
    if dependency_root is not None:
        args.extend(("-Q", str(dependency_root), ""))
    return args


def check_vc_proof(
    manifest_path: Path,
    coqc_command: list[str] | None = None,
    timeout_seconds: float = 120,
) -> dict[str, Any]:
    """Compile a model- or human-filled residual proof without using an LLM."""

    manifest_path = manifest_path.expanduser().resolve()
    try:
        manifest = json.loads(manifest_path.read_text(encoding="utf-8"))
    except (OSError, json.JSONDecodeError) as error:
        raise JobError(f"cannot read VC manifest {manifest_path}: {error}") from error
    manifest = _require_object(manifest, "VC manifest")
    if manifest.get("schema") != "qcp-spectest-vc-manifest/v1":
        raise JobError("unsupported VC manifest schema")
    if timeout_seconds <= 0:
        raise JobError("proof timeout must be positive")

    raw_files = _require_object(manifest.get("files"), "VC manifest files")
    files: dict[str, Path] = {}
    for name in ("goal", "proof_auto", "proof_manual", "goal_check"):
        raw_path = raw_files.get(name)
        if not isinstance(raw_path, str):
            raise JobError(f"VC manifest has no generated {name} file")
        path = Path(raw_path).expanduser().resolve()
        if not path.is_file():
            raise JobError(f"VC file does not exist: {path}")
        files[name] = path
    vc_dir = manifest_path.parent
    if any(path.parent != vc_dir for path in files.values()):
        raise JobError("all VC files must be direct children of the manifest directory")

    immutable = _require_object(manifest.get("immutable_sha256"), "VC immutable_sha256")
    for name in ("goal", "proof_auto", "goal_check"):
        expected = immutable.get(name)
        if not isinstance(expected, str) or _sha256(files[name]) != expected:
            raise JobError(f"generated VC file was modified: {files[name]}")

    manual = files["proof_manual"].read_text(encoding="utf-8", errors="replace")
    forbidden = _FORBIDDEN_MANUAL_PROOF.search(manual)
    if forbidden is not None:
        token = forbidden.group(0).strip().split()[0]
        raise JobError(f"manual proof still contains a forbidden proof escape: {token}")
    automatic = files["proof_auto"].read_text(encoding="utf-8", errors="replace")
    if _FORBIDDEN_MANUAL_PROOF.search(automatic):
        raise JobError(
            "automatic proof contains unchecked placeholders; "
            "the VC group has no replayable certificate"
        )
    residual_goals = manifest.get("residual_goals")
    if not isinstance(residual_goals, list) or not all(
        isinstance(item, str) for item in residual_goals
    ):
        raise JobError("VC manifest residual_goals must be an array of names")
    proved = set(
        re.findall(
            r"(?m)^\s*Lemma\s+(proof_of_[A-Za-z_][A-Za-z0-9_]*)\s*:",
            manual,
        )
    )
    missing = sorted(set(residual_goals) - proved)
    if missing:
        raise JobError("manual proof is missing residual lemmas: " + ", ".join(missing))

    raw_root = manifest.get("qcip_root")
    if not isinstance(raw_root, str):
        raise JobError("VC manifest qcip_root must be a path")
    separation_logic = Path(raw_root).expanduser().resolve() / "SeparationLogic"
    if not (separation_logic / "_CoqProject").is_file():
        raise JobError(f"QCP SeparationLogic tree does not exist: {separation_logic}")

    dependency_root = (vc_dir / "dependencies").resolve()
    dependency_files: list[Path] = []
    raw_dependencies = manifest.get("coq_dependencies", [])
    if not isinstance(raw_dependencies, list):
        raise JobError("VC manifest coq_dependencies must be an array")
    for index, raw_dependency in enumerate(raw_dependencies):
        dependency = _require_object(
            raw_dependency, f"VC manifest coq_dependencies[{index}]"
        )
        module = dependency.get("module")
        staged_raw = dependency.get("staged")
        expected = dependency.get("sha256")
        if (
            not isinstance(module, str)
            or re.fullmatch(r"[A-Za-z_][A-Za-z0-9_.]*", module) is None
            or not isinstance(staged_raw, str)
            or not isinstance(expected, str)
        ):
            raise JobError(f"invalid VC manifest coq_dependencies[{index}]")
        staged = Path(staged_raw).expanduser().resolve()
        expected_path = (
            dependency_root / Path(*module.split(".")).with_suffix(".v")
        ).resolve()
        if staged != expected_path or not staged.is_file():
            raise JobError(f"invalid or missing staged Coq dependency: {staged}")
        if _sha256(staged) != expected:
            raise JobError(f"staged Coq dependency was modified: {staged}")
        dependency_files.append(staged)

    prefix = list(coqc_command or _default_coqc_command())
    version = subprocess.run(
        [*prefix, "-v"],
        cwd=separation_logic,
        capture_output=True,
        text=True,
        timeout=min(timeout_seconds, 15),
        check=False,
    )
    version_output = version.stdout + "\n" + version.stderr
    if version.returncode != 0 or "version 8.20" not in version_output:
        raise JobError(
            "proof checking requires Coq 8.20.x; got: "
            + version_output.strip().replace("\n", " ")[:300]
        )

    load_paths = _coq_load_path_args(
        separation_logic,
        vc_dir,
        dependency_root if dependency_files else None,
    )
    stdout_log = vc_dir / "proof_check.stdout.txt"
    stderr_log = vc_dir / "proof_check.stderr.txt"
    stdout_parts: list[str] = []
    stderr_parts: list[str] = []
    compiled: list[str] = []
    started = time.monotonic()
    compile_units = [
        *((f"dependency:{path.stem}", path) for path in dependency_files),
        *(
            (name, files[name])
            for name in ("goal", "proof_auto", "proof_manual", "goal_check")
        ),
    ]
    for name, compile_path in compile_units:
        command = [*prefix, *load_paths, str(compile_path)]
        try:
            completed = subprocess.run(
                command,
                cwd=separation_logic,
                capture_output=True,
                text=True,
                timeout=timeout_seconds,
                check=False,
            )
        except subprocess.TimeoutExpired as error:
            stdout_parts.append(_subprocess_text(error.stdout))
            stderr_parts.append(_subprocess_text(error.stderr))
            stdout_log.write_text("\n".join(stdout_parts), encoding="utf-8")
            stderr_log.write_text("\n".join(stderr_parts), encoding="utf-8")
            return {
                "schema": "qcp-spectest-proof-report/v1",
                "status": "UNKNOWN",
                "satisfied": None,
                "reason": "coq_proof_timeout",
                "failed_file": str(compile_path),
                "compiled": compiled,
                "stdout": str(stdout_log),
                "stderr": str(stderr_log),
            }
        stdout_parts.append(f"$ {' '.join(command)}\n{completed.stdout}")
        stderr_parts.append(f"$ {' '.join(command)}\n{completed.stderr}")
        if completed.returncode != 0:
            stdout_log.write_text("\n".join(stdout_parts), encoding="utf-8")
            stderr_log.write_text("\n".join(stderr_parts), encoding="utf-8")
            return {
                "schema": "qcp-spectest-proof-report/v1",
                "status": "UNKNOWN",
                "satisfied": None,
                "reason": "coq_proof_failed",
                "returncode": completed.returncode,
                "failed_file": str(compile_path),
                "compiled": compiled,
                "stdout": str(stdout_log),
                "stderr": str(stderr_log),
            }
        compiled.append(str(compile_path))

    stdout_log.write_text("\n".join(stdout_parts), encoding="utf-8")
    stderr_log.write_text("\n".join(stderr_parts), encoding="utf-8")
    report = {
        "schema": "qcp-spectest-proof-report/v1",
        "status": "PASS",
        "satisfied": True,
        "reason": "residual_vc_proved_by_coq",
        "case_id": manifest.get("case_id"),
        "function": manifest.get("function"),
        "residual_goals": residual_goals,
        "compiled": compiled,
        "coq_version": version_output.strip().splitlines()[0],
        "duration_seconds": round(time.monotonic() - started, 6),
        "stdout": str(stdout_log),
        "stderr": str(stderr_log),
    }
    proof_report = vc_dir / "proof_report.json"
    proof_report.write_text(
        json.dumps(report, ensure_ascii=False, indent=2) + "\n",
        encoding="utf-8",
    )
    report["report"] = str(proof_report)
    return report
