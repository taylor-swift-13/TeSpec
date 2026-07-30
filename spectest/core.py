from __future__ import annotations

import ast
import json
import hashlib
import re
import shutil
import subprocess
import time
from dataclasses import dataclass
from itertools import product
from pathlib import Path
from typing import Any


class JobError(ValueError):
    """The job cannot be executed safely or unambiguously."""


_C_SOURCE_ENCODINGS = ("utf-8-sig", "gb18030")


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


def attach_spec_to_source(source: str, spec: str, function: str) -> str:
    """Attach a separate full QCP spec to one C function definition.

    Public four-class questions keep implementation and specification as two
    inputs. QCP consumes one annotated translation unit, so this deterministic
    adapter performs the mechanical assembly before analysis or execution.
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
        r"(?P<comments>(?:/\*@.*?\*/\s*)*)"
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
        re.search(r"\bRequire\b", item.group("body"))
        for item in re.finditer(
            r"/\*@(?P<body>.*?)\*/",
            match.group("comments"),
            re.DOTALL,
        )
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
    loop_unroll_limit: int
    call_depth_limit: int


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

    return Path(__file__).resolve().parents[1] / "bin" / "qcp-symexec"


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
        r"(?P<comments>(?:/\*@.*?\*/\s*)+)"
        r"(?P<terminator>[;{])",
        re.DOTALL,
    )
    candidates: list[SpecCandidate] = []
    for function_match in pattern.finditer(source):
        if _inside_block_comment(source, function_match.start()):
            continue
        comments_start = function_match.start("comments")
        for comment in re.finditer(
            r"/\*@(?P<body>.*?)\*/",
            function_match.group("comments"),
            re.DOTALL,
        ):
            body = comment.group("body")
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


def _closed_qcp_list_length(expression: str) -> int | None:
    """Return the length of a closed ``nil``/``cons`` QCP list term."""

    term = _strip_outer_parentheses(expression.strip())
    if term in {"nil", "@nil Z", "(@nil Z)"}:
        return 0
    matched = re.fullmatch(r"cons\s*\((?P<args>.*)\)", term, re.DOTALL)
    if matched is None:
        return None
    arguments = _split_top_level(matched.group("args"), ",")
    if len(arguments) != 2:
        return None
    tail_length = _closed_qcp_list_length(arguments[1])
    return None if tail_length is None else tail_length + 1


def _materialize_derived_bindings(
    analysis: WithAnalysis,
    normalized: dict[str, str],
) -> dict[str, str]:
    """Evaluate derived With variables when their inputs are closed.

    Keeping the original Require equality is useful to QCP, but a concrete
    loop controller or heap extent must also be injected as a literal so
    concrete execution does not depend on a solver rewriting the equality at
    exactly the right time.  This evaluator is intentionally small and
    syntax-driven: integer constants, aliases, and lengths of closed QCP list
    constructor terms.
    """

    materialized = dict(normalized)
    pending = dict(analysis.derived)
    while pending:
        progressed = False
        for name, expression in tuple(pending.items()):
            if name in materialized:
                del pending[name]
                progressed = True
                continue
            value: str | None = None
            if re.fullmatch(r"[-+]?[0-9]+", expression):
                value = str(int(expression))
            elif expression in materialized:
                value = materialized[expression]
            else:
                length = re.fullmatch(
                    r"Zlength\s*\(\s*([A-Za-z_][A-Za-z0-9_]*)\s*\)",
                    expression,
                )
                if length is not None:
                    dependency = materialized.get(length.group(1))
                    if dependency is not None:
                        closed_length = _closed_qcp_list_length(dependency)
                        if closed_length is not None:
                            value = str(closed_length)
            if value is None:
                continue
            materialized[name] = value
            del pending[name]
            progressed = True
        if not progressed:
            break
    return materialized


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
    next_address = 4096
    argument_bindings: list[dict[str, Any]] = []
    for parameter in parameters:
        example = next_address if parameter.pointer_like else 0
        if parameter.pointer_like:
            next_address += 4096
        example_arguments[parameter.name] = example
        argument_bindings.append(
            {
                "name": parameter.name,
                "declaration": parameter.declaration,
                "required": True,
                "input": (
                    "concrete numeric address or raw QCP expression"
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
    """Constrain Require with complete C arguments and logical bind values."""

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
        missing_arguments = sorted(declared_arguments - provided_arguments)
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
                None,
                f"C argument {parameter.name}",
            )
            for parameter in parameters
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
    missing = sorted(declared - set(analysis.derived) - provided)
    if unknown:
        raise JobError(f"bindings not declared by With: {', '.join(unknown)}")
    if missing:
        raise JobError(f"missing With bindings: {', '.join(missing)}")
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
    normalized = _materialize_derived_bindings(analysis, normalized)
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
        loop_unroll_limit=loop_unroll_limit,
        call_depth_limit=call_depth_limit,
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
        f"--input-file={generated_source}",
        "--full-auto",
        "--emit-residual-vc",
        "--concrete-bindings",
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


_SOURCE_COQ_IMPORT_RE = re.compile(
    r"/\*@\s*Import\s+Coq\s+"
    r"(?:(?:From\s+(?P<prefix>[A-Za-z_][A-Za-z0-9_.]*)\s+)?"
    r"Require\s+Import\s+)"
    r"(?P<modules>.*?)\*/",
    re.DOTALL,
)
_COQ_LOGICAL_NAME = r"[A-Za-z_][A-Za-z0-9_]*(?:\.[A-Za-z_][A-Za-z0-9_]*)*"
_COQ_REQUIRE_RE = re.compile(
    rf"(?:(?:From\s+(?P<prefix>{_COQ_LOGICAL_NAME})\s+)?"
    r"Require\s+Import\s+)"
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


def _coq_required_modules(source: str) -> list[str]:
    """Extract Coq source dependencies for case-local recursive staging."""

    modules: list[str] = []
    for match in _COQ_REQUIRE_RE.finditer(source):
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


def _stage_source_coq_dependencies(
    generated_source: Path,
    original_source: Path,
    qcip_root: Path,
    vc_dir: Path,
    dependency_source: str | None = None,
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
    if residual_goals and paths["goal"].is_file():
        goal_source = paths["goal"].read_text(encoding="utf-8", errors="replace")
        counterexample_goals = [
            lemma
            for lemma in residual_goals
            if _closed_generated_goal_value(
                goal_source, lemma.removeprefix("proof_of_")
            )
            is False
        ]
    coq_dependencies = _stage_source_coq_dependencies(
        generated_source,
        original_source,
        qcip_root,
        vc_dir,
        dependency_source,
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
    }
    vc_dir.mkdir(parents=True, exist_ok=True)
    manifest_path = vc_dir / "manifest.json"
    manifest_path.write_text(
        json.dumps(manifest, ensure_ascii=False, indent=2) + "\n",
        encoding="utf-8",
    )
    manifest["manifest"] = str(manifest_path)
    return manifest


def _classify(returncode: int, output: str) -> tuple[str, bool | None, str]:
    if "Concrete bindings violate selected Require clause" in output:
        return "ERROR", None, "bindings_violate_require"
    conclusive_failures = (
        "inconsistent after solve",
        "SMT find a False Prop",
    )
    if any(marker in output for marker in conclusive_failures):
        return "FAIL", False, "qcp_found_inconsistent_obligation"

    unresolved = (
        "Entailment Check Failed",
        "Return Check Failed",
        "Witness cannot be solved",
    )
    if "Loop unroll limit exceeded" in output:
        return "UNKNOWN", None, "loop_unroll_limit_exceeded"
    if "Concrete call depth limit exceeded" in output:
        return "UNKNOWN", None, "call_depth_limit_exceeded"
    if "Concrete predicate unfold limit exceeded" in output:
        return "UNKNOWN", None, "predicate_unfold_limit_exceeded"
    if any(marker in output for marker in unresolved):
        return "UNKNOWN", None, "qcp_could_not_discharge_obligation"

    # Older QCIP binaries print explicit success markers.  Current QCP uses
    # LogLine for those markers, so --no-exec-info intentionally suppresses
    # them.  Both implementations report a completed full-auto check with
    # exit status zero; all parser, execution, and proof failures are nonzero.
    if returncode == 0:
        return "PASS", True, "qcp_full_auto_passed"

    return "ERROR", None, "qcp_execution_error"


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
                arguments=_require_object(case.get("args"), f"binds[{index}].args"),
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


def _coq_definition_body(source: str, name: str) -> str | None:
    """Return one generated Coq definition body.

    QCP emits both ``body\\n.`` and parenthesized ``body).`` endings.  Scan to
    the first top-level command terminator so qualified names such as
    ``UCharArray.full`` and periods inside comments/strings are not mistaken
    for the end of the definition.
    """

    match = re.search(
        rf"^Definition\s+{re.escape(name)}\s*:=\s*",
        source,
        re.MULTILINE,
    )
    if match is None:
        return None
    start = match.end()
    depths = {"(": 0, "[": 0, "{": 0}
    closing = {")": "(", "]": "[", "}": "{"}
    index = start
    comment_depth = 0
    in_string = False
    while index < len(source):
        pair = source[index : index + 2]
        character = source[index]
        if comment_depth:
            if pair == "(*":
                comment_depth += 1
                index += 2
                continue
            if pair == "*)":
                comment_depth -= 1
                index += 2
                continue
            index += 1
            continue
        if in_string:
            if character == '"':
                if index + 1 < len(source) and source[index + 1] == '"':
                    index += 2
                    continue
                in_string = False
            index += 1
            continue
        if pair == "(*":
            comment_depth = 1
            index += 2
            continue
        if character == '"':
            in_string = True
            index += 1
            continue
        if character in depths:
            depths[character] += 1
        elif character in closing:
            opener = closing[character]
            if depths[opener] > 0:
                depths[opener] -= 1
        elif character == "." and not any(depths.values()):
            return source[start:index]
        index += 1
    return None


def _closed_coq_proposition_value(expression: str) -> bool | None:
    """Evaluate a deliberately small, closed fragment of Coq propositions.

    This is used only to recognize concrete counterexamples, never to prove a
    residual VC.  Free variables, calls, quantifiers, heap entailments, and
    unsupported operators conservatively return ``None``.
    """

    compact = re.sub(r"\s+", " ", expression).strip()
    if not compact or len(compact) > 4096:
        return None
    compact = compact.strip("“”").strip()
    if any(
        marker in compact
        for marker in ("|--", "EX ", "exists ", "forall ", "->", "#", "&(")
    ):
        return None
    python_expression = compact
    python_expression = python_expression.replace("/\\", " and ")
    python_expression = python_expression.replace("\\/", " or ")
    python_expression = python_expression.replace("<>", "!=")
    python_expression = re.sub(r"(?<![<>=!])=(?!=)", "==", python_expression)
    python_expression = re.sub(r"(?<![A-Za-z0-9_])~\s*", " not ", python_expression)
    try:
        parsed = ast.parse(python_expression, mode="eval")
    except SyntaxError:
        return None

    def evaluate(node: ast.AST) -> int | bool | None:
        if isinstance(node, ast.Expression):
            return evaluate(node.body)
        if isinstance(node, ast.Constant):
            if isinstance(node.value, bool):
                return node.value
            if isinstance(node.value, int):
                return node.value
            return None
        if isinstance(node, ast.UnaryOp):
            operand = evaluate(node.operand)
            if operand is None:
                return None
            if isinstance(node.op, ast.Not) and isinstance(operand, bool):
                return not operand
            if isinstance(operand, bool) or not isinstance(operand, int):
                return None
            if isinstance(node.op, ast.USub):
                return -operand
            if isinstance(node.op, ast.UAdd):
                return operand
            return None
        if isinstance(node, ast.BinOp):
            left = evaluate(node.left)
            right = evaluate(node.right)
            if (
                left is None
                or right is None
                or isinstance(left, bool)
                or isinstance(right, bool)
                or not isinstance(left, int)
                or not isinstance(right, int)
            ):
                return None
            if isinstance(node.op, ast.Add):
                return left + right
            if isinstance(node.op, ast.Sub):
                return left - right
            if isinstance(node.op, ast.Mult):
                return left * right
            return None
        if isinstance(node, ast.BoolOp):
            values = [evaluate(item) for item in node.values]
            if not all(isinstance(item, bool) for item in values):
                return None
            if isinstance(node.op, ast.And):
                return all(values)
            if isinstance(node.op, ast.Or):
                return any(values)
            return None
        if isinstance(node, ast.Compare):
            left = evaluate(node.left)
            if left is None or isinstance(left, bool):
                return None
            for operator, comparator in zip(node.ops, node.comparators):
                right = evaluate(comparator)
                if right is None or isinstance(right, bool):
                    return None
                if isinstance(operator, ast.Eq):
                    result = left == right
                elif isinstance(operator, ast.NotEq):
                    result = left != right
                elif isinstance(operator, ast.Lt):
                    result = left < right
                elif isinstance(operator, ast.LtE):
                    result = left <= right
                elif isinstance(operator, ast.Gt):
                    result = left > right
                elif isinstance(operator, ast.GtE):
                    result = left >= right
                else:
                    return None
                if not result:
                    return False
                left = right
            return True
        return None

    value = evaluate(parsed)
    return value if isinstance(value, bool) else None


def _closed_generated_goal_value(goal_source: str, goal_name: str) -> bool | None:
    """Decide a generated goal with only closed proof-hypothesis binders."""

    body = _coq_definition_body(goal_source, goal_name)
    if body is None or "|--" in body:
        return None
    remaining = re.sub(r"\s+", " ", body).strip()
    while remaining.startswith("forall"):
        cursor = len("forall")
        binder_types: list[str] = []
        found = False
        while True:
            while cursor < len(remaining) and remaining[cursor].isspace():
                cursor += 1
            if cursor >= len(remaining) or remaining[cursor] != "(":
                break
            found = True
            start = cursor + 1
            depth = 1
            cursor += 1
            while cursor < len(remaining) and depth:
                if remaining[cursor] == "(":
                    depth += 1
                elif remaining[cursor] == ")":
                    depth -= 1
                cursor += 1
            if depth:
                return None
            declaration = remaining[start : cursor - 1]
            colon = _top_level_colon(declaration)
            if colon is None:
                return None
            binder_types.append(declaration[colon + 1 :].strip())
        while cursor < len(remaining) and remaining[cursor].isspace():
            cursor += 1
        if not found or cursor >= len(remaining) or remaining[cursor] != ",":
            return None
        for binder_type in binder_types:
            value = _closed_coq_proposition_value(binder_type)
            if value is None:
                return None
            if value is False:
                return True
        remaining = remaining[cursor + 1 :].strip()
    return _closed_coq_proposition_value(remaining)


def _finite_z_interval(body: str) -> tuple[str, int, int] | None:
    """Recognize a concrete, bounded outer ``forall (x : Z)`` guard.

    QCP deliberately leaves pointwise array postconditions quantified even
    after all test inputs are concrete.  Enumerating a small closed interval
    is complete for that concrete guard and is independent of the predicate,
    program, and array element expression inside the implication.
    """

    compact = re.sub(r"\s+", " ", body).strip()
    integer = r"(?P<{name}>-?\s*[0-9]+)"
    intervals: list[tuple[str, int, int]] = []
    remaining = compact
    while re.match(r"^forall\b", remaining):
        cursor = len("forall")
        binders: list[tuple[list[str], str]] = []
        while True:
            while cursor < len(remaining) and remaining[cursor].isspace():
                cursor += 1
            if cursor >= len(remaining) or remaining[cursor] != "(":
                break
            start = cursor + 1
            depth = 1
            cursor += 1
            while cursor < len(remaining) and depth:
                if remaining[cursor] == "(":
                    depth += 1
                elif remaining[cursor] == ")":
                    depth -= 1
                cursor += 1
            if depth:
                return None
            content = remaining[start : cursor - 1]
            nested = 0
            colon = None
            for position, character in enumerate(content):
                if character == "(":
                    nested += 1
                elif character == ")":
                    nested -= 1
                elif character == ":" and nested == 0:
                    colon = position
                    break
            if colon is None:
                return None
            names = content[:colon].strip().split()
            binder_type = content[colon + 1 :].strip()
            binders.append((names, binder_type))
        while cursor < len(remaining) and remaining[cursor].isspace():
            cursor += 1
        if cursor >= len(remaining) or remaining[cursor] != ",":
            return None
        tail = remaining[cursor + 1 :].lstrip()
        z_names = [
            name
            for names, binder_type in binders
            if binder_type == "Z"
            for name in names
            if re.fullmatch(r"[A-Za-z_][A-Za-z0-9_]*", name)
        ]
        for var in z_names:
            patterns = (
                (
                    rf"^\s*\(*\s*{integer.format(name='lo')}\s*<=\s*"
                    rf"{re.escape(var)}\s*\)*\s*/\\\s*\(*\s*"
                    rf"{re.escape(var)}\s*<\s*"
                    rf"{integer.format(name='hi')}",
                    0,
                    0,
                ),
                (
                    rf"^\s*\(*\s*{integer.format(name='lo')}\s*<=\s*"
                    rf"{re.escape(var)}\s*\)*\s*/\\\s*\(*\s*"
                    rf"{re.escape(var)}\s*<=\s*"
                    rf"{integer.format(name='hi')}",
                    0,
                    1,
                ),
                (
                    rf"^\s*\(*\s*{integer.format(name='lo')}\s*<\s*"
                    rf"{re.escape(var)}\s*\)*\s*/\\\s*\(*\s*"
                    rf"{re.escape(var)}\s*<\s*"
                    rf"{integer.format(name='hi')}",
                    1,
                    0,
                ),
                (
                    rf"^\s*\(*\s*{integer.format(name='lo')}\s*<\s*"
                    rf"{re.escape(var)}\s*\)*\s*/\\\s*\(*\s*"
                    rf"{re.escape(var)}\s*<=\s*"
                    rf"{integer.format(name='hi')}",
                    1,
                    1,
                ),
                (
                    rf"^\s*\(*\s*{re.escape(var)}\s*>=\s*"
                    rf"{integer.format(name='lo')}\s*\)*\s*/\\\s*\(*\s*"
                    rf"{re.escape(var)}\s*<\s*"
                    rf"{integer.format(name='hi')}",
                    0,
                    0,
                ),
                (
                    rf"^\s*\(*\s*{re.escape(var)}\s*>=\s*"
                    rf"{integer.format(name='lo')}\s*\)*\s*/\\\s*\(*\s*"
                    rf"{re.escape(var)}\s*<=\s*"
                    rf"{integer.format(name='hi')}",
                    0,
                    1,
                ),
            )
            for pattern, low_adjustment, high_adjustment in patterns:
                bounds = re.search(pattern, tail)
                if bounds is None:
                    continue
                low = int(bounds.group("lo").replace(" ", "")) + low_adjustment
                high = int(bounds.group("hi").replace(" ", "")) + high_adjustment
                # Keep generated proof size linear and bounded.  Larger
                # concrete domains remain sound residual VCs.
                if 0 <= high - low <= 256:
                    intervals.append((var, low, high))
                break
        remaining = tail
    # The last matching outer binder is the pointwise conclusion QCP split.
    return intervals[-1] if intervals else None


def _finite_z_interval_proof(goal_name: str, goal_source: str) -> str | None:
    body = _coq_definition_body(goal_source, goal_name)
    interval = _finite_z_interval(body) if body is not None else None
    if interval is None:
        return None
    var, low, high = interval
    lines = [
        "Proof.",
        f"  unfold {goal_name}.",
        f"  intros until {var}.",
        "  intros Hrange.",
    ]
    for offset, value in enumerate(range(low, high)):
        neq_name = f"Hneq_{offset}"
        lines.extend(
            [
                f"  destruct (Z.eq_dec {var} ({value})) as [-> | {neq_name}];",
                "    [vm_compute; intuition congruence | idtac].",
            ]
        )
    lines.extend(["  exfalso; lia.", "Qed."])
    return "\n".join(lines)


def _leading_forall_z_binders(body: str) -> list[str]:
    """Collect top-level ``Z`` binders from a generated proposition."""

    remaining = re.sub(r"\s+", " ", body).strip()
    result: list[str] = []
    while re.match(r"^forall\b", remaining):
        cursor = len("forall")
        found_group = False
        while True:
            while cursor < len(remaining) and remaining[cursor].isspace():
                cursor += 1
            if cursor >= len(remaining) or remaining[cursor] != "(":
                break
            found_group = True
            start = cursor + 1
            depth = 1
            cursor += 1
            while cursor < len(remaining) and depth:
                if remaining[cursor] == "(":
                    depth += 1
                elif remaining[cursor] == ")":
                    depth -= 1
                cursor += 1
            if depth:
                return []
            declaration = remaining[start : cursor - 1]
            colon = _top_level_colon(declaration)
            if colon is None:
                continue
            names = declaration[:colon].strip().split()
            binder_type = declaration[colon + 1 :].strip()
            if binder_type == "Z":
                result.extend(
                    name
                    for name in names
                    if re.fullmatch(r"[A-Za-z_][A-Za-z0-9_]*", name)
                )
        while cursor < len(remaining) and remaining[cursor].isspace():
            cursor += 1
        if not found_group or cursor >= len(remaining) or remaining[cursor] != ",":
            break
        remaining = remaining[cursor + 1 :].lstrip()
    return result


def _small_closed_z_domain(body: str) -> tuple[int, ...]:
    """Infer one finite integer domain shared by closed index quantifiers."""

    compact = re.sub(r"\s+", " ", body)
    integer = r"-?\s*[0-9]+"
    name = r"[A-Za-z_][A-Za-z0-9_]*"
    lows: list[int] = []
    highs: list[int] = []
    for matched in re.finditer(
        rf"(?P<value>{integer})\s*(?P<op><=|<)\s*(?P<var>{name})",
        compact,
    ):
        value = int(matched.group("value").replace(" ", ""))
        lows.append(value + (1 if matched.group("op") == "<" else 0))
    for matched in re.finditer(
        rf"(?P<var>{name})\s*(?P<op><=|<)\s*(?P<value>{integer})",
        compact,
    ):
        value = int(matched.group("value").replace(" ", ""))
        highs.append(value + (1 if matched.group("op") == "<=" else 0))
    if not highs:
        return ()
    low = min(lows) if lows else 0
    high = max(highs)
    if low > high or high - low > 32:
        return ()
    return tuple(range(low, high))


def _z_case_proposition(variable: str, values: tuple[int, ...]) -> str:
    return r" \/ ".join(f"{variable} = ({value})" for value in values)


def _z_case_pattern(values: tuple[int, ...]) -> str:
    if len(values) == 1:
        return "Hsingle"
    pattern = "->"
    for _value in values[:-1]:
        pattern = f"[-> | {pattern}]"
    return pattern


def _finite_closed_quantifier_proof(goal_name: str, goal_source: str) -> str | None:
    """Close concrete bounded quantifier combinations by finite enumeration."""

    body = _coq_definition_body(goal_source, goal_name)
    if body is None or "|--" in body:
        return None
    values = _small_closed_z_domain(body)
    if not values:
        return None
    interval = _finite_z_interval(body)
    outer_variables = (
        [interval[0]] if interval is not None else _leading_forall_z_binders(body)
    )
    if not outer_variables:
        return None
    if len(values) ** len(outer_variables) > 4096:
        return None

    existential = re.search(
        r"exists\s+\((?P<var>[A-Za-z_][A-Za-z0-9_]*)\s*:\s*Z\)\s*,",
        body,
    )
    nested_variables: list[str] = []
    if existential is not None:
        nested_variables = list(
            dict.fromkeys(
                re.findall(
                    r"forall\s+\(([A-Za-z_][A-Za-z0-9_]*)\s*:\s*Z\)",
                    body[existential.end() :],
                )
            )
        )

    lines = ["Proof.", f"  unfold {goal_name}.", "  intros."]
    for index, variable in enumerate(outer_variables):
        proposition = _z_case_proposition(variable, values)
        if len(values) == 1:
            prefix = "  " if index == 0 else "  all: "
            lines.append(
                f"{prefix}assert ({variable} = ({values[0]})) by lia; subst {variable}."
            )
            continue
        prefix = "  " if index == 0 else "  all: "
        lines.append(f"{prefix}assert ({proposition}) as Hcases_{index} by lia.")
        destruct = _z_case_pattern(values)
        lines.append(
            f"{'  ' if index == 0 else '  all: '}destruct Hcases_{index} as {destruct}."
        )

    if existential is None:
        lines.extend(
            [
                "  all: try lia.",
                "  all: vm_compute; intuition congruence.",
                "Qed.",
            ]
        )
        return "\n".join(lines)

    attempts: list[str] = []
    for witness in values:
        tactics = [
            f"exists ({witness})",
            "repeat split",
            "try lia",
            "try reflexivity",
            "try solve [vm_compute; intuition congruence]",
        ]
        if nested_variables:
            tactics.append("intros")
            for index, variable in enumerate(nested_variables):
                proposition = _z_case_proposition(variable, values)
                if len(values) == 1:
                    tactics.extend(
                        [
                            f"assert ({variable} = ({values[0]})) by lia",
                            f"subst {variable}",
                        ]
                    )
                else:
                    tactics.extend(
                        [
                            f"assert ({proposition}) as Hinner_{index} by lia",
                            f"destruct Hinner_{index} as {_z_case_pattern(values)}",
                        ]
                    )
        tactics.extend(["try lia", "vm_compute", "intuition congruence"])
        attempts.append("solve [" + "; ".join(tactics) + "]")
    lines.extend(
        [
            "  all: first [",
            "    " + "\n  | ".join(attempts),
            "  ].",
            "Qed.",
        ]
    )
    return "\n".join(lines)


def _concrete_permutation_proof(goal_name: str, goal_source: str) -> str | None:
    """Decide a closed ``Permutation (list Z) (list Z)`` proposition."""

    body = _coq_definition_body(goal_source, goal_name)
    if body is None or "|--" in body or "Permutation" not in body:
        return None
    values = sorted(
        {
            int(value.replace(" ", ""))
            for value in re.findall(r"\bcons\s+\(+\s*(-?\s*[0-9]+)\s*\)+", body)
        }
    )
    lines = [
        "Proof.",
        f"  unfold {goal_name}.",
    ]
    if not values:
        lines.extend(["  apply Permutation_refl.", "Qed."])
        return "\n".join(lines)
    lines.extend(
        [
            "  apply (proj2 (@Permutation_count_occ Z Z.eq_dec _ _)).",
            "  intro x.",
            "  cbn [List.count_occ].",
        ]
    )
    for value in values:
        lines.append(f"  destruct (Z.eq_dec ({value}) x);")
    lines.extend(["  simpl; lia.", "Qed."])
    return "\n".join(lines)


def _concrete_z_list_witness(body: str | None) -> str | None:
    """Recover a closed ``list Z`` witness from concrete ``Znth`` facts.

    Concrete execution records each final array/list cell in the residual
    return VC.  When those facts cover exactly ``0 .. Zlength - 1``, they
    determine the existential list without knowing the function, predicate,
    struct, or field names involved.
    """

    if body is None:
        return None
    declarations = re.finditer(
        r"EX\s+\((?P<var>[A-Za-z_][A-Za-z0-9_]*)\s*:\s*"
        r"\(@list\s+Z\)\)\s*,",
        body,
    )
    propositions = re.findall(r"“(?P<body>.*?)”", body, re.DOTALL)
    for declaration in declarations:
        variable = declaration.group("var")
        length: int | None = None
        values: dict[int, int] = {}
        conflict = False
        for proposition in propositions:
            length_match = re.search(
                rf"Zlength\s*\(\s*{re.escape(variable)}\s*\)"
                r"\s*\)*\s*=\s*\(*\s*(?P<length>[0-9]+)",
                proposition,
            )
            if length_match is not None:
                candidate_length = int(length_match.group("length"))
                if length is not None and length != candidate_length:
                    conflict = True
                length = candidate_length

            cell_match = re.search(
                r"(?P<value>.*?)=\s*"
                r"\(Znth\s*\(\s*(?P<index>[0-9]+)\s*\)\s*"
                rf"\(\s*{re.escape(variable)}\s*\)\s*"
                r"\([^)]*\)\)",
                proposition,
                re.DOTALL,
            )
            if cell_match is None:
                continue
            integer_match = re.fullmatch(
                r"\s*\(*\s*(?P<value>-?\s*[0-9]+)\s*\)*\s*",
                cell_match.group("value"),
            )
            if integer_match is None:
                continue
            index = int(cell_match.group("index"))
            value = int(integer_match.group("value").replace(" ", ""))
            if index in values and values[index] != value:
                conflict = True
            values[index] = value

        # Some concrete array postconditions constrain only the witness
        # length and its final IntArray::full heap, without spelling out
        # pointwise Znth equalities.  Recover those cells from the closed
        # low-level stores left by concrete execution.  This is based only on
        # the generic IntArray heap shape, not on a function or predicate
        # name.
        target = re.search(
            r"IntArray\.full\s+\(*\s*(?P<base>-?\s*[0-9]+)\s*\)*\s+"
            r"\(*\s*(?P<length>[0-9]+)\s*\)*\s+"
            rf"\(*\s*{re.escape(variable)}\s*\)*",
            body,
        )
        if target is not None:
            target_base = int(target.group("base").replace(" ", ""))
            target_length = int(target.group("length"))
            if length is None:
                length = target_length
            elif length != target_length:
                conflict = True
            for line in body.splitlines():
                cell = re.search(
                    r"(?P<base>-?\s*[0-9]+)\s*\+\s*"
                    r"\(\s*(?P<index>[0-9]+)\s*\*\s*sizeof\(INT\)\s*\)"
                    r".*?#\s*Int\s*\|->\s*\(*\s*"
                    r"(?P<value>-?\s*[0-9]+)\s*\)*",
                    line,
                )
                if cell is None:
                    continue
                base = int(cell.group("base").replace(" ", ""))
                if base != target_base:
                    continue
                index = int(cell.group("index"))
                value = int(cell.group("value").replace(" ", ""))
                if index in values and values[index] != value:
                    conflict = True
                values[index] = value
        if (
            conflict
            or length is None
            or length > 256
            or set(values) != set(range(length))
        ):
            continue
        witness = "(@nil Z)"
        for index in reversed(range(length)):
            witness = f"(cons ({values[index]}) ({witness}))"
        return witness
    return None


def _parse_closed_coq_z_list(
    source: str, start: int
) -> tuple[tuple[int, ...], int] | None:
    """Parse QCP's parenthesized ``list Z`` constructor syntax.

    The generated Coq printer freely adds redundant parentheses, including
    forms such as ``cons ((-1)) ((@nil Z))``.  Parsing the constructor spine
    keeps witness discovery independent of the array predicate and of any
    case-local list transformer used by the specification.
    """

    def skip_space(position: int) -> int:
        while position < len(source) and source[position].isspace():
            position += 1
        return position

    def parse_integer(position: int) -> tuple[int, int] | None:
        position = skip_space(position)
        wrappers = 0
        while position < len(source) and source[position] == "(":
            wrappers += 1
            position = skip_space(position + 1)
        matched = re.match(r"-?\s*[0-9]+", source[position:])
        if matched is None:
            return None
        value = int(matched.group(0).replace(" ", ""))
        position = skip_space(position + matched.end())
        for _ in range(wrappers):
            if position >= len(source) or source[position] != ")":
                return None
            position = skip_space(position + 1)
        return value, position

    def parse_list(position: int) -> tuple[tuple[int, ...], int] | None:
        position = skip_space(position)
        wrappers = 0
        while position < len(source) and source[position] == "(":
            wrappers += 1
            position = skip_space(position + 1)
        if source.startswith("@nil", position):
            position = skip_space(position + len("@nil"))
            if not source.startswith("Z", position):
                return None
            values: tuple[int, ...] = ()
            position = skip_space(position + 1)
        elif re.match(r"cons\b", source[position:]):
            position = skip_space(position + len("cons"))
            head = parse_integer(position)
            if head is None:
                return None
            value, position = head
            tail = parse_list(position)
            if tail is None:
                return None
            tail_values, position = tail
            values = (value, *tail_values)
        else:
            return None
        for _ in range(wrappers):
            if position >= len(source) or source[position] != ")":
                return None
            position = skip_space(position + 1)
        return values, position

    return parse_list(start)


def _coq_z_list_term(values: tuple[int, ...]) -> str:
    result = "(@nil Z)"
    for value in reversed(values):
        result = f"(cons ({value}) ({result}))"
    return result


def _closed_z_list_witnesses(body: str | None) -> list[str]:
    """Return bounded closed list terms already present in a concrete VC.

    Every nested constructor is also a valid suffix candidate.  This covers
    common ``exists tail, final = app prefix tail`` postconditions without
    evaluating a case-specific filter/map function in Python; Coq checks the
    candidate after unfolding the case-local transparent definitions.
    """

    if body is None:
        return []
    values: set[tuple[int, ...]] = {()}
    for matched in re.finditer(r"@nil\b|\bcons\b", body):
        parsed = _parse_closed_coq_z_list(body, matched.start())
        if parsed is None:
            continue
        items, _end = parsed
        if len(items) <= 256:
            values.add(items)
            values.update(items[index:] for index in range(len(items) + 1))
    ordered = sorted(values, key=lambda items: (len(items), items))
    return [_coq_z_list_term(items) for items in ordered]


def _concrete_bounded_z_witnesses(body: str | None) -> list[int]:
    """Enumerate closed bounded ``EX (x : Z)`` witnesses in a return VC.

    Concrete early-return specifications commonly express success as
    ``exists k, 0 <= k < n /\ ...``.  Once ``n`` and the heap are concrete,
    trying the finite interval is complete for that existential and avoids
    asking a model to guess an index.
    """

    if body is None:
        return []
    witnesses: set[int] = set()
    for declaration in re.finditer(
        r"EX\s+\((?P<var>[A-Za-z_][A-Za-z0-9_]*)\s*:\s*Z\)\s*,",
        body,
    ):
        variable = declaration.group("var")
        lower = re.search(
            rf"\(?\s*(?P<low>-?\s*[0-9]+)\s*<=\s*"
            rf"{re.escape(variable)}\s*\)?",
            body[declaration.end() :],
        )
        upper = re.search(
            rf"\(?\s*{re.escape(variable)}\s*<\s*"
            r"(?P<high>-?\s*[0-9]+)\s*\)?",
            body[declaration.end() :],
        )
        if lower is None or upper is None:
            continue
        low = int(lower.group("low").replace(" ", ""))
        high = int(upper.group("high").replace(" ", ""))
        if 0 <= high - low <= 256:
            witnesses.update(range(low, high))
    return sorted(witnesses)


def _concrete_bounded_z_witness_tuples(
    body: str | None,
) -> list[tuple[int, ...]]:
    """Enumerate grouped QCP ``EX (x : Z) (y : Z),`` witnesses."""

    if body is None:
        return []
    tuples: set[tuple[int, ...]] = set()
    for declaration in re.finditer(
        r"EX\s+(?P<binders>(?:"
        r"\([A-Za-z_][A-Za-z0-9_]*\s*:\s*Z\)\s*)+),",
        body,
    ):
        names = re.findall(
            r"\(([A-Za-z_][A-Za-z0-9_]*)\s*:\s*Z\)",
            declaration.group("binders"),
        )
        if not names:
            continue
        tail = body[declaration.end() :]
        if len(names) == 1:
            variable = names[0]
            lower = re.search(
                rf"\(?\s*(?P<low>-?\s*[0-9]+)\s*<=\s*"
                rf"{re.escape(variable)}\s*\)?",
                tail,
            )
            upper = re.search(
                rf"\(?\s*{re.escape(variable)}\s*<\s*"
                r"(?P<high>-?\s*[0-9]+)\s*\)?",
                tail,
            )
            if lower is not None and upper is not None:
                low = int(lower.group("low").replace(" ", ""))
                high = int(upper.group("high").replace(" ", ""))
                if 0 <= high - low <= 256:
                    tuples.update((value,) for value in range(low, high))
            continue
        domain = _small_closed_z_domain(tail)
        if not domain or len(domain) ** len(names) > 4096:
            continue
        tuples.update(product(domain, repeat=len(names)))
    return sorted(tuples)


def _concrete_int_array_witness(
    body: str | None,
) -> tuple[int, tuple[int, ...], str] | None:
    """Recover a closed existential ``list Z`` and its flat IntArray cells."""

    if body is None:
        return None
    propositions = re.findall(r"“(?P<body>.*?)”", body, re.DOTALL)
    for declaration in re.finditer(
        r"EX\s+\((?P<var>[A-Za-z_][A-Za-z0-9_]*)\s*:\s*"
        r"\(@list\s+Z\)\)\s*,",
        body,
    ):
        variable = declaration.group("var")
        length: int | None = None
        for proposition in propositions:
            matched_length = re.search(
                rf"Zlength\s*\(\s*{re.escape(variable)}\s*\)"
                r"\s*\)*\s*=\s*\(*\s*(?P<length>[0-9]+)",
                proposition,
            )
            if matched_length is not None:
                length = int(matched_length.group("length"))
                break
        target = re.search(
            r"IntArray\.full\s+\(*\s*(?P<base>-?\s*[0-9]+)\s*\)*\s+"
            r"\(*\s*(?P<length>[0-9]+)\s*\)*\s+"
            rf"\(*\s*{re.escape(variable)}\s*\)*",
            body,
        )
        if target is None:
            continue
        target_length = int(target.group("length"))
        if length is None:
            length = target_length
        if length != target_length or length > 256:
            continue
        base = int(target.group("base").replace(" ", ""))
        values: dict[int, int] = {}
        conflict = False
        for line in body.splitlines():
            cell = re.search(
                r"(?P<base>-?\s*[0-9]+)\s*\+\s*"
                r"\(\s*(?P<index>[0-9]+)\s*\*\s*sizeof\(INT\)\s*\)"
                r".*?#\s*Int\s*\|->\s*\(*\s*"
                r"(?P<value>-?\s*[0-9]+)\s*\)*",
                line,
            )
            if cell is None:
                continue
            if int(cell.group("base").replace(" ", "")) != base:
                continue
            index = int(cell.group("index"))
            value = int(cell.group("value").replace(" ", ""))
            if index in values and values[index] != value:
                conflict = True
            values[index] = value
        if conflict or set(values) != set(range(length)):
            continue
        ordered = tuple(values[index] for index in range(length))
        witness = "(@nil Z)"
        for value in reversed(ordered):
            witness = f"(cons ({value}) ({witness}))"
        return base, ordered, witness
    return None


def _int_array_return_attempt(
    side: str, base: int, values: tuple[int, ...], witness: str
) -> str:
    tactics = [side, "try intros", f"Exists {witness}"]

    def list_term(items: tuple[int, ...]) -> str:
        result = "(@nil Z)"
        for item in reversed(items):
            result = f"(cons ({item}) ({result}))"
        return result

    for index, value in enumerate(values):
        tactics.append(f"sep_apply (IntArray.seg_single {base} {index} ({value}))")
    for index in range(len(values)):
        tactics.append(f"replace ({index} + 1) with {index + 1} by lia")
    if len(values) > 1:
        prefix = list_term(values[:1])
        for index in range(1, len(values)):
            cell = list_term(values[index : index + 1])
            tactics.append(
                "sep_apply "
                "(derivable1_sepcon_comm "
                f"(IntArray.seg {base} {index} {index + 1} {cell}) "
                f"(IntArray.seg {base} 0 {index} {prefix}))"
            )
            tactics.append(
                "sep_apply "
                f"(IntArray.seg_merge_to_seg {base} 0 {index} "
                f"{index + 1} {prefix} {cell})"
            )
            tactics.append("try lia")
            prefix = list_term(values[: index + 1])
    if values:
        tactics.append(
            f"sep_apply (IntArray.seg_to_full {base} 0 {len(values)} {witness})"
        )
        tactics.append(f"replace ({base} + 0 * sizeof (INT)) with {base} by lia")
        tactics.append(f"replace ({len(values)} - 0) with {len(values)} by lia")
    tactics.append("entailer!")
    return "solve [" + "; ".join(tactics) + "]"


def _closed_return_disjunction_proof(
    goal_name: str, return_body: str, dependency_source: str = ""
) -> str | None:
    """Build a conservative proof search for QCP's two return alternatives."""

    if r"\/" not in return_body and "||" not in return_body:
        return None
    attempts: list[str] = []
    list_witness = _concrete_z_list_witness(return_body)
    suffix_witnesses = _closed_z_list_witnesses(return_body)
    int_array_witness = _concrete_int_array_witness(return_body)
    z_witnesses = _concrete_bounded_z_witness_tuples(return_body)
    definitions, _lemmas = _local_coq_declarations(dependency_source)
    body_symbols = set(re.findall(r"[A-Za-z_][A-Za-z0-9_']*", return_body))
    used_definitions = [name for name in definitions if name in body_symbols][:64]
    reduce_local = (
        "cbn [" + ", ".join(used_definitions) + "] in *; " if used_definitions else ""
    )
    sides = ("right", "left") if r"\/" in return_body else ("Left", "Right")
    for side in sides:
        if int_array_witness is not None:
            base, values, array_witness = int_array_witness
            attempts.append(
                _int_array_return_attempt(side, base, values, array_witness)
            )
        if list_witness is not None:
            attempts.append(
                f"solve [{side}; try intros; Exists {list_witness}; "
                f"{reduce_local}entailer!]"
            )
            attempts.append(
                f"solve [{side}; try intros; Exists {list_witness}; "
                f"{reduce_local}entailer!; vm_compute; "
                "intuition congruence]"
            )
        for suffix_witness in suffix_witnesses:
            if suffix_witness == list_witness:
                continue
            attempts.append(
                f"solve [{side}; try intros; Exists {suffix_witness}; "
                f"{reduce_local}entailer!; vm_compute; "
                "intuition congruence]"
            )
        for witnesses in z_witnesses:
            terms = " ".join(f"({witness})" for witness in witnesses)
            attempts.append(
                f"solve [{side}; try intros; Exists {terms}; {reduce_local}entailer!]"
            )
        attempts.append(f"solve [{side}; try intros; {reduce_local}entailer!]")
    return (
        "Proof.\n"
        f"  unfold {goal_name}.\n"
        "  first [\n    " + "\n  | ".join(attempts) + "\n  ].\n"
        "Qed."
    )


def _local_coq_declarations(
    dependency_source: str,
) -> tuple[list[str], list[str]]:
    """Collect case-local transparent definitions and reusable proof lemmas."""

    definitions = re.findall(
        r"(?m)^\s*(?:Local\s+)?"
        r"(?:Definition|Fixpoint|CoFixpoint)\s+"
        r"([A-Za-z_][A-Za-z0-9_']*)\b",
        dependency_source,
    )
    lemmas = re.findall(
        r"(?m)^\s*(?:Local\s+)?"
        r"(?:Lemma|Theorem|Fact|Corollary|Proposition)\s+"
        r"([A-Za-z_][A-Za-z0-9_']*)\b",
        dependency_source,
    )
    return list(dict.fromkeys(definitions)), list(dict.fromkeys(lemmas))


def _local_definition_split_proof(
    goal_name: str,
    goal_source: str,
    dependency_source: str,
) -> str | None:
    """Build a name-independent proof from definitions owned by the case.

    Concrete execution deliberately retains true branch propositions.  Once
    an opaque Ensure predicate is unfolded, its fields are therefore usually
    assumptions, reflexive facts, or consequences of helper lemmas shipped in
    the same case library.
    """

    body = _coq_definition_body(goal_source, goal_name)
    if body is None or not dependency_source:
        return None
    definitions, lemmas = _local_coq_declarations(dependency_source)
    body_symbols = set(re.findall(r"[A-Za-z_][A-Za-z0-9_']*", body))
    used_definitions = [name for name in definitions if name in body_symbols]
    if not used_definitions:
        return None

    # Prefer helpers from the same logical vocabulary as the concrete goal.
    # A small case library may safely offer all of its lemmas; for a larger
    # library, prefix filtering avoids an unbounded eauto search.
    if len(lemmas) <= 64:
        used_lemmas = lemmas
    else:
        prefixes = {symbol.split("_", 1)[0] for symbol in body_symbols if "_" in symbol}
        used_lemmas = [name for name in lemmas if name.split("_", 1)[0] in prefixes][
            :64
        ]

    unfold = ", ".join(used_definitions)
    eauto = (
        "intuition eauto using " + ", ".join(used_lemmas)
        if used_lemmas
        else "intuition eauto"
    )
    return (
        "Proof.\n"
        f"  unfold {goal_name}.\n"
        "  intros.\n"
        f"  unfold {unfold} in *.\n"
        "  first [\n"
        f"    solve [{eauto}]\n"
        "  | vm_compute; intuition congruence\n"
        "  ].\n"
        "Qed."
    )


def run_job(job_path: Path, output_override: Path | None = None) -> dict[str, Any]:
    job_path = job_path.expanduser().resolve()
    try:
        job = json.loads(job_path.read_text(encoding="utf-8"))
    except (OSError, json.JSONDecodeError) as error:
        raise JobError(f"cannot read job file {job_path}: {error}") from error
    job = _require_object(job, "job")
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
    started = time.time()
    for case in bind_cases:
        case_dir = output_dir / case.case_id
        if case_dir.is_symlink() or (case_dir.exists() and not case_dir.is_dir()):
            raise JobError(f"case output path is not a directory: {case_dir}")
        if case_dir.exists():
            shutil.rmtree(case_dir)
        case_dir.mkdir(parents=True, exist_ok=True)
        generated_source = case_dir / f"{source_path.stem}__{case.case_id}.c"
        stdout_path = case_dir / "qcp.stdout.txt"
        stderr_path = case_dir / "qcp.stderr.txt"
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
            specialized = specialize_source(
                source,
                function,
                case.values,
                case.spec,
                type_bindings=case.types,
                signature_source=signature_source,
                argument_bindings=case.arguments,
            )
            generated_source.write_text(specialized, encoding="utf-8")
            command = _qcp_command(
                config,
                generated_source,
                function,
                case.spec,
                vc_dir,
            )
            run_started = time.time()
            completed = subprocess.run(
                command,
                cwd=config.binary.parent.parent,
                capture_output=True,
                text=True,
                timeout=config.timeout_seconds,
                check=False,
            )
            duration = time.time() - run_started
            stdout_path.write_text(completed.stdout, encoding="utf-8")
            stderr_path.write_text(completed.stderr, encoding="utf-8")
            combined = completed.stdout + "\n" + completed.stderr
            status, satisfied, reason = _classify(completed.returncode, combined)
            vc = _write_vc_manifest(
                vc_dir,
                generated_source,
                source_path,
                config.qcip_root,
                function,
                case.case_id,
                signature_source,
            )
            if status == "PASS" and vc["status"] == "counterexample":
                status = "FAIL"
                satisfied = False
                reason = "closed_concrete_vc_is_false"
            elif status == "PASS" and vc["status"] == "residual":
                status = "UNKNOWN"
                satisfied = None
                reason = "residual_vc_requires_proof"
            elif status == "PASS" and vc["status"] == "not_generated":
                status = "ERROR"
                satisfied = None
                reason = "qcp_vc_generation_error"
            case_result.update(
                {
                    "status": status,
                    "satisfied": satisfied,
                    "reason": reason,
                    "returncode": completed.returncode,
                    "duration_seconds": round(duration, 6),
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
            stdout_path.write_text(_subprocess_text(error.stdout), encoding="utf-8")
            stderr_path.write_text(_subprocess_text(error.stderr), encoding="utf-8")
            case_result.update(
                {
                    "status": "ERROR",
                    "satisfied": None,
                    "reason": "qcp_timeout",
                    "error": f"QCP exceeded {config.timeout_seconds:g} seconds",
                }
            )
        results.append(case_result)

    counts = {
        status: sum(result["status"] == status for result in results)
        for status in ("PASS", "FAIL", "UNKNOWN", "ERROR")
    }
    report = {
        "schema": "qcp-spectest-report/v1",
        "job": str(job_path),
        "source": str(source_path),
        "spec_file": str(spec_file_path) if spec_file_path is not None else None,
        "function": function,
        "qcp_binary": str(config.binary),
        "results": results,
        "summary": {
            "total": len(results),
            **counts,
            "duration_seconds": round(time.time() - started, 6),
        },
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
    started = time.time()
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
        "duration_seconds": round(time.time() - started, 6),
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
