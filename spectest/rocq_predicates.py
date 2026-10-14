"""Lower a checked subset of Rocq constructor clauses to QCP rewrite rules.

The output is a proposal. Its branch equations must compile in the original
library interpretation before the rules are admitted to an execution.
"""

from dataclasses import dataclass
import re

from .core import JobError, _coq_dependency_code
from .layout import resolve_field_path

_REORDER_TACTIC = r"""Ltac expose_logical_hypothesis :=
  match goal with
  | H : _ |- _ =>
    lazymatch type of H with
    | sepcon _ _ _ => fail
    | _ /\ _ => destruct H
    | ex _ => destruct H
    end
  end.
Ltac rebuild_logical_goal :=
  first [ eassumption
  | lazymatch goal with
    | |- sepcon _ _ _ => fail "spatial atom mismatch"
    | |- _ /\ _ => split; rebuild_logical_goal
    | |- ex _ => eexists; rebuild_logical_goal
    end ].
Ltac pure_exists_reorder :=
  unshelve (split; intro; repeat expose_logical_hypothesis; rebuild_logical_goal); eassumption.
"""

_ID = r"[A-Za-z_][A-Za-z0-9_']*"
_ATOM = rf"(?:{_ID}|-?[0-9]+)"
_MEMORY_TYPES = {
    "Char": "I8",
    "UChar": "U8",
    "Short": "I16",
    "UShort": "U16",
    "Int": "I32",
    "UInt": "U32",
    "Int64": "I64",
    "UInt64": "U64",
    "Ptr": "PTR(void)",
}

# These polymorphic schemas are frontend language builtins, not sample rules.
# Their identities are proved before a generated rule can be activated.
_LIST_FUNCTIONS = {
    "app": (2, "Coq.Lists.List.app"),
    "rev": (1, "Coq.Lists.List.rev"),
}
_LIST_CONSTRUCTORS = {
    "cons": "Coq.Init.Datatypes.cons",
    "nil": "Coq.Init.Datatypes.nil",
}
_UNSCHEMATIZED_BUILTINS = frozenset(
    {
        "nil",
        "cons",
        "repeat_Z",
        "replace_Znth",
        "Znth",
        "Zlength",
        "Zpow",
        "signed_last_nbits",
        "unsigned_last_nbits",
        "StringLength",
        "string_length",
        "sum",
        "AsciiToZ",
        "StringToList",
        "c_string",
        "INT_MAX",
        "INT_MIN",
        "INT64_MAX",
        "INT64_MIN",
        "UINT64_MAX",
        "SIZE_MAX",
        "PTR_MAX",
        "ADDR_MAX",
    }
)


@dataclass(frozen=True)
class Term:
    qcp: str
    coq: str
    typ: str | None
    symbols: frozenset[str] = frozenset()
    uses_layout: bool = False


@dataclass(frozen=True)
class Clause:
    pattern: str
    parameters: tuple[str, ...]
    existentials: tuple[str, ...]
    # Each atom records both the emitted strategy syntax and its Rocq meaning.
    atoms: tuple[tuple[str, str, bool], ...]
    predicate: str
    formal_parameters: tuple[str, ...]
    scrutinee: str
    constructor: str
    constructor_parameters: tuple[str, ...]
    existential_types: tuple[str, ...]
    uses_layout: bool
    term_symbols: tuple[str, ...] = ()
    constructor_expression: str = ""
    pattern_coq: str = ""
    pattern_symbols: tuple[str, ...] = ()
    coq_predicate: str = ""
    type_parameters: tuple[str, ...] = ()


def _atom(text, names):
    if not re.fullmatch(_ATOM, text):
        raise JobError("unsupported term in predicate clause: " + text)
    if text not in names and not re.fullmatch(r"-?[0-9]+", text):
        if text not in {"NULL", "INT_MIN", "INT_MAX"}:
            raise JobError("unbound clause term: " + text)
    return text


def _lower_atom(text):
    """Give both sides of the certificate the executor's literal meaning."""
    return {"NULL": "0", "INT_MIN": "(-2147483648)", "INT_MAX": "2147483647"}.get(
        text, text
    )


def referenced_symbols(clauses):
    """Global constructor/callee identities used by these generated rules."""
    symbols = set()
    for _, _, clause in clauses:
        symbols.add(clause.predicate)
        symbols.update(clause.term_symbols)
        symbols.update(clause.pattern_symbols)
        for typ in clause.existential_types:
            symbols.update(
                identifier
                for identifier in re.findall(_ID, typ)
                if identifier not in {"Z", "addr", "list"}
            )
        if clause.constructor:
            symbols.add(clause.constructor.split("{", 1)[0])
        bound = set(clause.parameters) | set(clause.existentials)
        for _, coq, pure in clause.atoms:
            if not pure and (coq == "emp" or re.match(rf"{_ID}\s", coq)):
                head = coq.split()[0]
                if head not in bound:
                    symbols.add(head)
    if symbols & _LIST_FUNCTIONS.keys():
        symbols.update(_LIST_CONSTRUCTORS)
    return sorted(symbols)


def semantic_probes(clauses):
    """Capture the actual notation interpretation used by emitted formulas."""
    probes = {
        "emp": "emp",
        "pure": "(fun (P : Prop) => “ P ”)",
        "and": "(fun (P Q : Assertion) => P && Q)",
        "sep": "(fun (P Q : Assertion) => P ** Q)",
    }
    for _, _, clause in clauses:
        for typ in clause.existential_types:
            key = "exists_" + typ.replace(" ", "_")
            probes[key] = f"(fun (P : {typ} -> Assertion) => EX x : {typ}, P x)"
        for _, coq, pure in clause.atoms:
            if not pure:
                cell = re.search(r"#\s*(\w+)\s*\|->", coq)
                if cell:
                    typ = cell[1]
                    probes["store_" + typ] = f"(fun (a v : Z) => a # {typ} |-> v)"
    return dict(sorted(probes.items()))


def _pure(text, names, types, target_layout):
    text = _strip_outer_parens(text.strip())
    # A quoted Rocq conjunction is logical conjunction, not a term-level
    # function application. Split only at depth zero, outside field strings.
    conjuncts, start, depth, quoted, index = [], 0, 0, False, 0
    while index < len(text):
        char = text[index]
        if char == '"':
            quoted = not quoted
        elif not quoted:
            depth += (char == "(") - (char == ")")
            if depth < 0:
                raise JobError("unbalanced pure conjunction")
            if depth == 0 and text.startswith("/\\", index):
                conjuncts.append(text[start:index].strip())
                index += 2
                start = index
                continue
        index += 1
    if depth or quoted:
        raise JobError("unbalanced pure conjunction")
    if conjuncts:
        conjuncts.append(text[start:].strip())
        if any(not part for part in conjuncts):
            raise JobError("empty pure conjunct")
        atoms, terms = [], []
        for part in conjuncts:
            more_atoms, more_terms = _pure(part, names, types, target_layout)
            atoms.extend(more_atoms)
            terms.extend(more_terms)
        return atoms, terms
    parts, start, depth, quoted, index = [], 0, 0, False, 0
    while index < len(text):
        char = text[index]
        if char == '"':
            quoted = not quoted
        elif not quoted:
            depth += (char == "(") - (char == ")")
            if depth < 0:
                raise JobError("unbalanced pure clause")
            if depth == 0:
                operator = re.match(r"<=|>=|<>|=|<|>", text[index:])
                if operator is not None:
                    parts.extend((text[start:index].strip(), operator[0]))
                    index += len(operator[0])
                    start = index
                    continue
        index += 1
    if depth or quoted:
        raise JobError("unbalanced pure clause")
    parts.append(text[start:].strip())
    if len(parts) == 1:
        term = _term(text, names, types, target_layout)
        if term.typ not in {None, "Prop"} or not term.symbols:
            raise JobError("pure application requires a logical proposition")
        return [(term.qcp, f"“ {term.coq} ”", True)], [term]
    if len(parts) not in (3, 5):
        raise JobError("unsupported pure clause: " + text)
    terms = [_term(term, names, types, target_layout) for term in parts[::2]]
    pairs = []
    for i in range(0, len(parts) - 2, 2):
        a, b, op = terms[i // 2], terms[i // 2 + 1], parts[i + 1]
        if op not in {"=", "<>"} and any(t.typ == "list Z" for t in (a, b)):
            raise JobError("ordered comparison requires scalar terms")
        qcp = f"{a.qcp} { {'=': '==', '<>': '!='}.get(op, op) } {b.qcp}"
        pairs.append((qcp, f"“ {a.coq} {op} {b.coq} ”", True))
    return pairs, terms


def _strip_outer_parens(text):
    while text.startswith("(") and text.endswith(")"):
        depth = 0
        for index, char in enumerate(text):
            depth += (char == "(") - (char == ")")
            if depth == 0:
                break
        if index != len(text) - 1:
            break
        text = text[1:-1].strip()
    return text


def _application_parts(text):
    """Split Rocq application arguments only at unparenthesized whitespace."""
    parts, start, depth, quoted = [], 0, 0, False
    for index, char in enumerate(text):
        if char == '"':
            quoted = not quoted
        elif not quoted:
            if char == "(":
                depth += 1
            elif char == ")":
                depth -= 1
                if depth < 0:
                    raise JobError("unbalanced predicate argument parentheses")
            elif char.isspace() and depth == 0:
                if text[start:index].strip():
                    parts.append(text[start:index].strip())
                start = index + 1
    if depth or quoted:
        raise JobError("unterminated predicate argument")
    if text[start:].strip():
        parts.append(text[start:].strip())
    return parts


def _address_term(text, names, target_layout):
    """Lower admitted address syntax identically in cells and predicate calls."""
    text = _strip_outer_parens(text.strip())
    field = re.fullmatch(
        rf'&\(\s*([()\s]*{_ID}[()\s]*)\s*#\s*"({_ID})"\s*->ₛ\s*"({_ID})"((?:\s*\.ₛ\s*"{_ID}")*)\s*\)',
        text,
    )
    if field is None:
        atom = _lower_atom(_atom(text, names))
        return atom, atom, False
    base, tag, first, tail = field.groups()
    base = _lower_atom(_atom(_strip_outer_parens(base.strip()), names))
    qaddr = f"field_addr({base}, {tag}, {first})"
    coq_addr = f'&({base} # "{tag}" ->ₛ "{first}")'
    if not tail:
        return qaddr, coq_addr, False
    if target_layout is None:
        raise JobError("nested field requires a target layout")
    path = [first, *re.findall(rf'"({_ID})"', tail)]
    try:
        offsets = resolve_field_path(target_layout, tag, path)
    except ValueError as error:
        raise JobError(str(error)) from error
    qaddr = base
    for offset in offsets:
        qaddr = f"({qaddr} + {offset})"
    return qaddr, qaddr, True


def _term(text, names, types, target_layout):
    """Retain typed function applications; only registered schemas are builtin."""
    text = _strip_outer_parens(text.strip())
    # List append is right associative and binds less tightly than application.
    depth, quoted = 0, False
    for index, char in enumerate(text):
        if char == '"':
            quoted = not quoted
        elif not quoted:
            if char == "(":
                depth += 1
            elif char == ")":
                depth -= 1
            elif depth == 0 and text[index : index + 2] == "++":
                left = _term(text[:index], names, types, target_layout)
                right = _term(text[index + 2 :], names, types, target_layout)
                return _list_application("app", [left, right])
    if text.startswith("&(") or re.fullmatch(_ATOM, text):
        qcp, coq, uses_layout = _address_term(text, names, target_layout)
        typ = (
            "Z"
            if text.startswith("&(")
            or re.fullmatch(r"-?[0-9]+", text)
            or text in {"NULL", "INT_MIN", "INT_MAX"}
            else types.get(text)
        )
        if typ == "addr":
            typ = "Z"
        return Term(qcp, coq, typ, uses_layout=uses_layout)
    parts = _application_parts(text)
    if len(parts) < 2 or not re.fullmatch(_ID, parts[0]):
        raise JobError("unsupported term in predicate clause: " + text)
    head = parts[0]
    if head in names:
        raise JobError("higher-order parameter application requires a typed schema")
    if head in _UNSCHEMATIZED_BUILTINS:
        raise JobError(
            "builtin application requires a registered semantic schema: " + head
        )
    args = [_term(part, names, types, target_layout) for part in parts[1:]]
    if head in _LIST_FUNCTIONS:
        return _list_application(head, args)
    return Term(
        head + "(" + ", ".join(t.qcp for t in args) + ")",
        "(" + head + " " + " ".join(t.coq for t in args) + ")",
        None,
        frozenset({head}).union(*(t.symbols for t in args)),
        any(t.uses_layout for t in args),
    )


def _list_application(head, args):
    if len(args) != _LIST_FUNCTIONS[head][0] or any(t.typ != "list Z" for t in args):
        raise JobError("list builtin needs its declared list Z arguments: " + head)
    return Term(
        head + "{Z}(" + ", ".join(t.qcp for t in args) + ")",
        "(@" + head + " Z " + " ".join(t.coq for t in args) + ")",
        "list Z",
        frozenset({head}).union(*(t.symbols for t in args)),
        any(t.uses_layout for t in args),
    )


def _pattern_type(source, typ, seen=()):
    """Resolve simple type aliases, retaining nominal inductive identities."""
    typ = _strip_outer_parens(" ".join(typ.split()))
    if typ.startswith("list "):
        return "list " + _pattern_type(source, typ[5:], seen)
    if not re.fullmatch(_ID, typ):
        raise JobError("unsupported constructor pattern type: " + typ)
    aliases = re.findall(
        rf"\bDefinition\s+{re.escape(typ)}\s*(?::\s*Type\s*)?:=\s*([^.]*)\.",
        source,
    )
    if not aliases:
        return typ
    if len(aliases) != 1 or typ in seen or len(seen) >= 32:
        raise JobError("ambiguous or cyclic pattern type alias: " + typ)
    return _pattern_type(source, aliases[0], (*seen, typ))


def _qcp_logic_type(typ):
    typ = _strip_outer_parens(" ".join(typ.split()))
    if typ.startswith("list "):
        return "list{" + _qcp_logic_type(typ[5:]) + "}"
    if typ == "addr":
        return "Z"
    if not re.fullmatch(_ID, typ):
        raise JobError("unsupported existential type: " + typ)
    return typ


def _definition_namespace(source, position):
    """Track explicit module/section boundaries before a unique declaration."""
    stack = []
    for match in re.finditer(
        rf"\b(Module(?:\s+Type)?|Section|End)\s+({_ID})([^.]*)\.", source[:position]
    ):
        kind, identifier, body = match.groups()
        if kind == "End":
            if not stack or stack[-1][1] != identifier:
                raise JobError("unsupported definition scope boundaries")
            stack.pop()
        elif ":=" not in body:
            stack.append((kind, identifier))
    return tuple(identifier for kind, identifier in stack if kind.startswith("Module"))


def _argument_witness_types(source, branch, identifier):
    """Infer only direct arguments of uniquely declared typed applications."""
    candidates = set()
    body = re.sub(r"\bEX\s+[^,]+,", "", branch)
    for token in re.split(r"\s*(?:\*\*|&&)\s*", body):
        token = _strip_outer_parens(token.strip())
        if token.startswith("“") and token.endswith("”"):
            token = token[1:-1].strip()
        parts = _application_parts(token)
        if len(parts) < 2 or not re.fullmatch(_ID, parts[0]):
            continue
        headers = re.findall(
            rf"\b(?:Definition|Fixpoint)\s+{re.escape(parts[0])}(?![\w'])\s*((?:\([^)]*\)\s*)+)\s*:",
            source,
        )
        if len(headers) != 1:
            continue
        arguments = []
        for group in re.findall(r"\(([^)]*)\)", headers[0]):
            names, separator, typ = group.partition(":")
            if not separator:
                break
            arguments.extend([typ.strip()] * len(names.split()))
        else:
            if len(arguments) != len(parts) - 1:
                continue
            for term, typ in zip(parts[1:], arguments):
                if _strip_outer_parens(term) == identifier:
                    resolved = _pattern_type(source, typ)
                    candidates.add("Z" if resolved == "addr" else resolved)
    return candidates


def _typed_list_pattern(source, pattern, typ, parameters):
    """Build a typed constructor tree for list patterns, without name dispatch."""
    resolved = _pattern_type(source, typ)
    if not resolved.startswith("list "):
        raise JobError("list constructor pattern requires a list type")
    binders, symbols = {}, {"cons", "nil"}

    def list_element(element):
        def qcp_type(typ):
            if typ.startswith("list "):
                return "list{" + qcp_type(typ[5:]) + "}"
            if typ != "Z":
                symbols.add(typ)
            return typ

        return qcp_type(element), "(" + element + ")" if " " in element else element

    def constructor_arguments(head, expected):
        signatures = []
        for block in re.findall(
            r"\bInductive\s+" + _ID + r"\s*:\s*Type\s*:=\s*([^.]*)\.", source
        ):
            signatures.extend(
                re.findall(rf"(?:^|\|)\s*{re.escape(head)}\s*:\s*([^|]+)", block)
            )
        if len(signatures) != 1:
            raise JobError("nested pattern requires one constructor signature: " + head)
        signature = [
            _pattern_type(source, item) for item in signatures[0].strip().split("->")
        ]
        if signature[-1] != expected:
            raise JobError("constructor pattern has a different result type: " + head)
        return signature[:-1]

    def parse(text, expected):
        text = _strip_outer_parens(text.strip())
        # Cons patterns associate to the right; split only at the current depth.
        depth = 0
        for index, char in enumerate(text):
            depth += (char == "(") - (char == ")")
            if depth == 0 and text[index : index + 2] == "::":
                if not expected.startswith("list "):
                    raise JobError("cons pattern requires a list type")
                element = expected[5:]
                qhead, chead = parse(text[:index], element)
                qtail, ctail = parse(text[index + 2 :], expected)
                qtype, ctype = list_element(element)
                return (
                    f"cons{{{qtype}}}({qhead}, {qtail})",
                    f"(@cons {ctype} {chead} {ctail})",
                )
        if text == "nil" and expected.startswith("list "):
            element = expected[5:]
            qtype, ctype = list_element(element)
            return f"nil{{{qtype}}}()", f"(@nil {ctype})"
        parts = _application_parts(text)
        if not parts or not re.fullmatch(_ID, parts[0]) or parts[0] == "_":
            raise JobError("unsupported typed constructor pattern")
        head = parts[0]
        if len(parts) == 1:
            # Recognize declared nullary constructors before treating a name as
            # a binder. A binder's type comes from its enclosing constructor.
            declaration = re.search(
                rf"(?:\||:=)\s*{re.escape(head)}\s*:\s*{re.escape(expected)}\s*(?=[|.])",
                source,
            )
            if declaration is None:
                if head in binders or head in parameters:
                    raise JobError("constructor binders must be fresh and distinct")
                binders[head] = expected
                return "?" + head, head
        argument_types = constructor_arguments(head, expected)
        if len(argument_types) != len(parts) - 1:
            raise JobError("constructor pattern arity mismatch: " + head)
        symbols.add(head)
        arguments = [
            parse(arg, arg_type) for arg, arg_type in zip(parts[1:], argument_types)
        ]
        return head + "(" + ", ".join(q for q, _ in arguments) + ")", "(" + head + (
            " " if arguments else ""
        ) + " ".join(c for _, c in arguments) + ")"

    qcp, coq = parse(pattern, resolved)
    if not qcp.startswith(("cons{", "nil{")):
        raise JobError("list branch requires an explicit constructor")
    return qcp, coq, binders, tuple(sorted(symbols))


def _assertion_definition_header(source, name):
    """Parse balanced typed binders; admit implicit Type parameters only."""
    starts = list(
        re.finditer(rf"\b(Fixpoint|Definition)\s+{re.escape(name)}(?![\w'])", source)
    )
    if len(starts) != 1:
        raise JobError("expected one explicitly typed Assertion definition")
    start = starts[0]
    pos = start.end()
    groups = []
    while True:
        while pos < len(source) and source[pos].isspace():
            pos += 1
        if pos >= len(source) or source[pos] not in "({":
            break
        opening = source[pos]
        begin = pos + 1
        stack = [")" if opening == "(" else "}"]
        pos += 1
        while pos < len(source) and stack:
            char = source[pos]
            if char in "({":
                stack.append(")" if char == "(" else "}")
            elif char in ")}":
                if char != stack.pop():
                    raise JobError("unbalanced predicate parameter")
            pos += 1
        if stack:
            raise JobError("unterminated predicate parameter")
        names, separator, typ = source[begin : pos - 1].partition(":")
        if not separator or not typ.strip() or not names.split():
            raise JobError("predicate parameters need explicit types")
        typ = " ".join(typ.split())
        if opening == "{" and typ != "Type":
            raise JobError("only implicit Type parameters are supported")
        groups.append((names.split(), typ, opening == "{"))
    ending = re.match(r"\s*:\s*Assertion\s*:=\s*", source[pos:])
    if ending is None:
        raise JobError("expected one explicitly typed Assertion definition")
    return start[1], start.start(), pos + ending.end(), groups


def parse_predicate(source: str, name: str, *, target_layout=None):
    if name == "_" or not re.fullmatch(_ID, name):
        raise JobError("invalid predicate identifier")
    masked = _coq_dependency_code(source)
    kind, position, body_start, groups = _assertion_definition_header(masked, name)
    namespace = _definition_namespace(masked, position)
    qcp_name = "::".join((*namespace, name))
    coq_name = ".".join((*namespace, name))
    params, type_params, types = [], [], {}
    for names, typ, implicit in groups:
        for identifier in names:
            if (
                identifier == "_"
                or not re.fullmatch(_ID, identifier)
                or identifier in types
            ):
                raise JobError("invalid or duplicate predicate parameter")
            (type_params if implicit else params).append(identifier)
            types[identifier] = typ
    inspected = re.match(rf"match\s+({_ID})\s+with\b", masked[body_start:])
    scrutinee = inspected[1] if inspected else ""
    if inspected:
        if scrutinee not in params:
            raise JobError("match must inspect a predicate parameter")
        start = body_start + inspected.end()
        end = re.search(r"\bend\s*\.", masked[start:])
        if end is None:
            raise JobError("unterminated predicate match")
        body = source[start : start + end.start()]
        if re.search(r"\bmatch\b", _coq_dependency_code(body)):
            raise JobError("nested match requires additional normalization")
        pieces = re.split(r"\|\s*([^|]*?)\s*=>", body)
        if pieces[0].strip() or len(pieces) < 3 or len(pieces) % 2 != 1:
            raise JobError("unsupported constructor clauses")
        branches = zip(pieces[1::2], pieces[2::2])
    else:
        if kind != "Definition":
            raise JobError("Fixpoint must match a parameter constructor")
        end = re.search(r"\.(?![\w'])", masked[body_start:])
        if end is None:
            raise JobError("unterminated predicate definition")
        branches = [("", source[body_start : body_start + end.start()])]
    clauses = []
    for pattern, branch in branches:
        pattern = pattern.strip()
        pattern_expression, pattern_qcp, pattern_coq, pattern_symbols = "", "", "", ()
        pattern_types = {}
        if not scrutinee:
            constructor, args, coq_pattern = "", [], ""
        elif "::" in pattern or (
            pattern == "nil"
            and _pattern_type(masked, types[scrutinee]).startswith("list ")
        ):
            pattern_qcp, pattern_coq, pattern_types, pattern_symbols = (
                _typed_list_pattern(masked, pattern, types[scrutinee], params)
            )
            pattern_expression = pattern_qcp.replace("?", "")
            args = list(pattern_types)
            constructor = pattern_expression.split("(", 1)[0]
            coq_pattern = pattern_coq
        else:
            words = pattern.split()
            if not words or not all(re.fullmatch(_ID, w) for w in words):
                raise JobError("unsupported constructor pattern")
            constructor, args = words[0], words[1:]
            coq_pattern = pattern
            if constructor in {"nil", "cons"} and types[scrutinee] == "list Z":
                constructor += "{Z}"
        if (
            "_" in args
            or len(set(args)) != len(args)
            or set(args) & (set(params) | set(type_params))
        ):
            raise JobError("constructor binders must be fresh and distinct")
        names = set(params) | set(type_params) | set(args)
        branch_types = dict(types)
        for identifier, typ in types.items():
            try:
                branch_types[identifier] = _pattern_type(masked, typ)
            except JobError as error:
                if not str(error).startswith("unsupported constructor pattern type:"):
                    raise
        branch_types.update(pattern_types)
        existentials = []
        existential_types = []

        def add_existential(identifiers, typ):
            typ = _pattern_type(masked, typ)
            _qcp_logic_type(typ)
            for identifier in identifiers.split():
                if (
                    identifier == "_"
                    or not re.fullmatch(_ID, identifier)
                    or identifier in names
                ):
                    raise JobError("existential binder must be fresh")
                names.add(identifier)
                branch_types[identifier] = typ
                existentials.append(identifier)
                existential_types.append(typ)

        def grouped_existential(m):
            for group in re.findall(r"\(([^()]*)\)", m[1]):
                identifiers, sep, typ = group.partition(":")
                if not sep:
                    raise JobError("existential binders need explicit types")
                add_existential(identifiers, typ)
            return ""

        branch = re.sub(r"\bEX\s+((?:\([^()]*\)\s*)+)\s*,", grouped_existential, branch)

        def existential(m):
            add_existential(m[1], m[2])
            return ""

        branch = re.sub(
            r"\bEX\s+([A-Za-z_][A-Za-z0-9_'\s]*):\s*([^,]+)\s*,", existential, branch
        )

        def inferred_existential(match):
            # Address and scalar-cell occurrences determine a Z witness in the
            # admitted memory model. Other implicit types remain barriers.
            for identifier in match[1].split():
                escaped = re.escape(identifier)
                address = re.search(
                    rf"\b{escaped}\s*#\s*(?:\"|{'|'.join(_MEMORY_TYPES)})", branch
                )
                value = re.search(
                    rf"#\s*(?:{'|'.join(_MEMORY_TYPES)})\s*\|->\s*{escaped}(?![\w'])",
                    branch,
                )
                if address is None and value is None:
                    candidates = _argument_witness_types(masked, branch, identifier)
                    if len(candidates) != 1:
                        raise JobError(
                            "implicit existential needs one determined type: "
                            + identifier
                        )
                    typ = next(iter(candidates))
                else:
                    typ = "Z"
                    candidates = _argument_witness_types(masked, branch, identifier)
                    if candidates - {"Z"}:
                        raise JobError(
                            "conflicting existential type occurrences: " + identifier
                        )
                add_existential(identifier, typ)
            return ""

        branch = re.sub(
            r"\bEX\s+([A-Za-z_][A-Za-z0-9_'\s]*)\s*,", inferred_existential, branch
        )
        atoms = []
        term_symbols = set()
        uses_layout = False
        # Pure quotation protects the only comparison syntax we accept.
        tokens = re.split(r"\s*(?:\*\*|&&)\s*", branch.strip())
        for token in tokens:
            token = _strip_outer_parens(token.strip())
            if token == "emp":
                atoms.append(("", "emp", False))
                continue
            if token.startswith("“") and token.endswith("”"):
                pure, terms = _pure(token[1:-1], names, branch_types, target_layout)
                atoms.extend(pure)
                for term in terms:
                    term_symbols.update(term.symbols)
                    uses_layout |= term.uses_layout
                continue
            direct_cell = re.fullmatch(
                rf"(.+?)\s*#\s*({'|'.join(_MEMORY_TYPES)})\s*\|->\s*(.+)",
                token,
            )
            if direct_cell:
                base, typ, value = direct_cell.groups()
                qaddr, coq_addr, resolved_layout = _address_term(
                    base, names, target_layout
                )
                uses_layout |= resolved_layout
                value = _term(value, names, branch_types, target_layout)
                if value.typ is not None and value.typ != "Z":
                    raise JobError("scalar storage needs a scalar term")
                term_symbols.update(value.symbols)
                uses_layout |= value.uses_layout
                atoms.append(
                    (
                        f"store({qaddr}, {_MEMORY_TYPES[typ]}, {value.qcp})",
                        f"{coq_addr} # {typ} |-> {value.coq}",
                        False,
                    )
                )
                continue
            application = _application_parts(token)
            if len(application) >= 2 and re.fullmatch(_ID, application[0]):
                terms = [
                    _term(value, names, branch_types, target_layout)
                    for value in application[1:]
                ]
                uses_layout |= any(term.uses_layout for term in terms)
                for term in terms:
                    term_symbols.update(term.symbols)
                atoms.append(
                    (
                        (qcp_name if application[0] == name else application[0])
                        + "("
                        + ", ".join(term.qcp for term in terms)
                        + ")",
                        (coq_name if application[0] == name else application[0])
                        + " "
                        + " ".join(
                            "(" + term.coq + ")"
                            if term.qcp.startswith("field_addr(") or term.uses_layout
                            else term.coq
                            for term in terms
                        ),
                        False,
                    )
                )
                continue
            raise JobError("unsupported spatial clause: " + token)
        qpattern = constructor + (
            "(" + ", ".join("?" + x for x in args) + ")" if args else "()"
        )
        if pattern_expression:
            qpattern = pattern_qcp
        qargs = [qpattern if p == scrutinee else "?" + p for p in params]
        lhs = (
            qcp_name
            + (
                "{" + ", ".join("?" + p for p in type_params) + "}"
                if type_params
                else ""
            )
            + "("
            + ", ".join(qargs)
            + ")"
        )
        coq_args = ["(" + coq_pattern + ")" if p == scrutinee else p for p in params]
        coq_lhs = " ".join(
            [coq_name, *(f"({p} := {p})" for p in type_params), *coq_args]
        )
        clauses.append(
            (
                lhs,
                coq_lhs,
                Clause(
                    pattern,
                    tuple(type_params)
                    + tuple(p for p in params if p != scrutinee)
                    + tuple(args),
                    tuple(existentials),
                    tuple(atoms),
                    qcp_name,
                    tuple(params),
                    scrutinee,
                    constructor,
                    tuple(args),
                    tuple(existential_types),
                    uses_layout,
                    tuple(sorted(term_symbols)),
                    pattern_expression,
                    pattern_coq,
                    pattern_symbols,
                    coq_name,
                    tuple(type_params),
                ),
            )
        )
    return clauses


def emit_rules(clauses, *, first_id=10000, infer_models=False, scope="core"):
    if not re.fullmatch(_ID, scope):
        raise JobError("invalid normalization strategy scope")
    if infer_models and any(clause.type_parameters for _, _, clause in clauses):
        raise JobError("polymorphic constructor inference is not supported")
    rules = []
    for index, (lhs, _, clause) in enumerate(clauses):
        for side_index, side in enumerate(["left", "right"]):
            actions = [f"{side}_erase(0)"]
            actions += [
                f"{side}_exist_add({name} : {_qcp_logic_type(typ)})"
                for name, typ in zip(clause.existentials, clause.existential_types)
            ]
            actions += [f"{side}_add({qcp})" for qcp, _, _ in clause.atoms if qcp]
            rules.append(
                f"id : {first_id + 2 * index + side_index}\npriority : {scope}(3)\n{side} : {lhs} at 0\naction : "
                + ";\n         ".join(actions)
                + ";\n"
            )
    if infer_models:
        for index, (_, _, clause) in enumerate(clauses):
            rules.extend(
                _model_inference_rules(clause, first_id + 2 * len(clauses) + 2 * index)
            )
    return "\n".join(rules)


def pure_projection_atoms(clause):
    """Facts observable without choosing an existential or interpreting layout.

    This is a conservative syntactic selection, followed by kernel-checked
    consequences of the original definition. It never infers facts from cell
    ownership or replaces the predicate by a weaker spatial body.
    """
    return tuple(
        (qcp, coq)
        for qcp, coq, pure in clause.atoms
        if pure
        # Nested addresses have already become integer offsets. Until per-atom
        # provenance is available, retain every layout-dependent clause.
        and not clause.uses_layout
        and not set(re.findall(_ID, qcp)).intersection(clause.existentials)
        and "field_addr(" not in qcp
    )


def emit_pure_projection_rules(clauses, *, first_id=10000, scope="core"):
    if not re.fullmatch(_ID, scope):
        raise JobError("invalid normalization strategy scope")
    rules = []
    for lhs, _, clause in clauses:
        for qcp, _ in pure_projection_atoms(clause):
            rules.append(
                f"id : {first_id + len(rules)}\npriority : {scope}(3)\n"
                f"left : {lhs} at 0\ncheck : absense({qcp});\n"
                f"action : left_add({qcp});\n"
            )
    if not rules:
        raise JobError("definition has no eligible witness-independent pure facts")
    return "\n".join(rules)


def emit_pure_projection_equations(clauses, module, name, **kwargs):
    """Certify H = H && fact, retaining all original resources and witnesses."""
    full = emit_equations(clauses, module, name, **kwargs)
    lines = [full.split(f"Lemma {name}_branch_0 :", 1)[0]]
    predicate = clauses[0][2].coq_predicate or name
    reference = module + "." + predicate
    count = 0
    for index, (_, lhs, clause) in enumerate(clauses):
        lhs = reference + lhs[len(predicate) :]
        quantified = (
            "forall " + " ".join(clause.parameters) + "," if clause.parameters else ""
        )
        for atom_index, (_, coq) in enumerate(pure_projection_atoms(clause)):
            coq = _qualified_selected_term(coq, predicate, reference, clause.parameters)
            lines += [
                f"Lemma {name}_pure_{index}_{atom_index} : {quantified}",
                f"  {lhs} = ({lhs} && {coq}).",
                "Proof. intros; apply functional_extensionality; intro h;",
                "  apply propositional_extensionality; split; intro H.",
                "  - split; [exact H |].",
                f"    unfold {reference} at 1 in H.",
                "    cbv beta iota zeta delta [andp exp coq_prop] in H |- *.",
                "    repeat match goal with",
                "    | K : _ /\\ _ |- _ => destruct K",
                "    | K : exists _, _ |- _ => destruct K",
                "    end; assumption.",
                "  - exact (proj1 H).",
                "Qed.",
            ]
            count += 1
    if not count:
        raise JobError("definition has no eligible witness-independent pure facts")
    return "\n".join(lines) + "\n"


def _model_inference_rules(clause, rule_id, specialize_literals=True):
    """Propose constructor witnesses on the goal side, never as assumptions.

    Only guards independent of constructor/existential witnesses can guide
    selection. All original branch resources and guards remain subgoals via
    the ordinary constructor rule. Selection can be incomplete.
    """
    if not clause.scrutinee:
        return []
    known = set(clause.formal_parameters) - {clause.scrutinee}
    guards = [
        qcp
        for qcp, _, pure in clause.atoms
        if pure and set(re.findall(_ID, qcp)) <= known
    ]
    if not guards:
        return []
    model = clause.scrutinee
    bound = set()

    def bind_guard(match):
        variable = match[0]
        prefix = "" if variable in bound else "?"
        bound.add(variable)
        return prefix + variable

    guard_patterns = [re.sub(_ID, bind_guard, guard) for guard in guards]
    arguments = [p if p in bound else "?" + p for p in clause.formal_parameters]
    # Normalization removes tautologies such as 0 == 0. Match a literal
    # boundary directly on the goal so the base case remains selectable.
    literal_guard = re.fullmatch(rf"({_ID}) == (-?[0-9]+)", guards[0])
    if specialize_literals and len(guards) == 1 and literal_guard:
        variable, literal = literal_guard.groups()
        arguments = [
            literal if p == variable else "?" + p for p in clause.formal_parameters
        ]
        guard_patterns = []
    pattern = clause.predicate + "(" + ", ".join(arguments) + ")"
    constructor = clause.constructor_expression or (
        clause.constructor + "(" + ", ".join(clause.constructor_parameters) + ")"
    )
    instantiated = [constructor if p == model else p for p in clause.formal_parameters]
    if not guard_patterns and literal_guard:
        instantiated = [literal if p == variable else p for p in instantiated]
    actions = ["right_erase(0)"]
    actions += [f"right_exist_add({p})" for p in clause.constructor_parameters]
    actions += [
        f"right_add({model} == {constructor})",
        "right_add(" + clause.predicate + "(" + ", ".join(instantiated) + "))",
    ]
    rules = [
        f"id : {rule_id}\npriority : core(4)\n"
        + (
            "left : "
            + "\n       ".join(
                f"({g}) at {i + 1}" for i, g in enumerate(guard_patterns)
            )
            if guard_patterns
            else ""
        )
        + f"\nright : {pattern} at 0\naction : "
        + ";\n         ".join(actions)
        + ";\n"
    ]
    if specialize_literals and len(guards) == 1 and literal_guard:
        rules.extend(_model_inference_rules(clause, rule_id + 1, False))
    return rules


def _qualified_selected_term(text, name, reference, bound=()):
    """Qualify free selected identifiers, preserving strings and other paths."""
    tokens = re.compile(rf'"(?:""|[^"])*"|{_ID}(?:\.{_ID})*')
    return tokens.sub(
        lambda match: reference if match[0] == name and name not in bound else match[0],
        text,
    )


def emit_equations(
    clauses,
    module,
    name,
    *,
    notation_imports=(),
    context_modules=(),
    memory_rules="naive_C_Rules",
):
    if not re.fullmatch(rf"{_ID}(?:\.{_ID})*", module):
        raise JobError("invalid Rocq module")
    if not re.fullmatch(rf"{_ID}(?:\.{_ID})*", memory_rules):
        raise JobError("invalid normalization memory rules module")
    for imported in (*notation_imports, *context_modules):
        if not re.fullmatch(rf"{_ID}(?:\.{_ID})*", imported):
            raise JobError("invalid Rocq notation import")
    coq_predicate = clauses[0][2].coq_predicate or name
    selected_symbol = clauses[0][2].predicate
    namespace = coq_predicate.rpartition(".")[0]
    reference = module + "." + coq_predicate
    lines = [
        "Require Import Coq.ZArith.ZArith Coq.Strings.String Coq.Lists.List.",
        "Require Import Coq.Logic.FunctionalExtensionality Coq.Logic.PropExtensionality.",
        "Require Import SimpleC.SL.Mem SimpleC.SL.SeparationLogic.",
        "Require Import Logic.LogicGenerator.demo932.Interface.",
        *(
            f"Require Import {imported}."
            for imported in context_modules
            if imported != module
        ),
        f"Require Import {module}.",
        *([f"Import {module}.{namespace}."] if namespace else []),
        "Local Open Scope Z_scope.",
        "Local Open Scope string.",
        f"Import {memory_rules}.",
        "Local Open Scope sac.",
        *(f"Import {imported}." for imported in notation_imports),
        _REORDER_TACTIC,
    ]
    lines += [
        f"Definition normalization_binding_{index} := @{reference if symbol == selected_symbol else symbol.replace('::', '.')}."
        for index, symbol in enumerate(referenced_symbols(clauses))
    ]
    lines += [
        f"Definition normalization_semantics_{key} := {expression}."
        for key, expression in semantic_probes(clauses).items()
    ]
    builtins = set().union(*(clause.term_symbols for _, _, clause in clauses))
    identities = {
        builtin: _LIST_FUNCTIONS[builtin][1]
        for builtin in builtins & _LIST_FUNCTIONS.keys()
    }
    if identities or any(clause.pattern_symbols for _, _, clause in clauses):
        identities.update(_LIST_CONSTRUCTORS)
    for builtin, identity in sorted(identities.items()):
        # The QCP evaluator uses this standard function's computational meaning.
        # A same-named user function must not be silently interpreted as it.
        lines += [
            f"Lemma {name}_builtin_{builtin} : @{builtin} = @{identity}.",
            "Proof. reflexivity. Qed.",
        ]
    for index, (_, lhs, clause) in enumerate(clauses):
        lhs = reference + lhs[len(coq_predicate) :]
        bound = (*clause.parameters, *clause.existentials)
        pure = [
            _qualified_selected_term(coq, coq_predicate, reference, bound)
            for _, coq, is_pure in clause.atoms
            if is_pure
        ]
        spatial = [
            _qualified_selected_term(coq, coq_predicate, reference, bound)
            for _, coq, is_pure in clause.atoms
            if not is_pure
        ]
        rhs = " ** ".join(spatial) if spatial else "emp"
        rhs = " && ".join([*pure, "(" + rhs + ")"])
        if clause.existentials:
            rhs = (
                "EX "
                + " ".join(
                    f"({identifier}: {typ})"
                    for identifier, typ in zip(
                        clause.existentials, clause.existential_types
                    )
                )
                + ", "
                + rhs
            )
        quantified = (
            "forall " + " ".join(clause.parameters) + "," if clause.parameters else ""
        )
        lines += [
            f"Lemma {name}_branch_{index} : {quantified}",
            f"  {lhs} = ({rhs}).",
            "Proof. intros; unfold "
            + reference
            + " at 1; fold "
            + ("(@" + reference + ")" if clause.type_parameters else reference)
            + ".",
            "  apply functional_extensionality; intro h; apply propositional_extensionality.",
            "  cbv beta iota zeta delta [andp exp coq_prop].",
            "  pure_exists_reorder.",
            "Qed.",
        ]
    return "\n".join(lines) + "\n"


def emit_model_refinements(clauses, *, module=None):
    """Check the goal-side constructor choice independently of search policy."""
    lines = []
    for index, (_, lhs, clause) in enumerate(clauses):
        if not clause.scrutinee:
            continue
        constructor = clause.pattern_coq or clause.pattern
        if not clause.pattern_coq and "::" in constructor:
            constructor = "cons " + " ".join(constructor.split("::"))
        predicate = clause.coq_predicate or clause.predicate
        reference = (module + "." if module is not None else "") + predicate
        lhs = reference + lhs[len(predicate) :]
        original = reference + " " + " ".join(clause.formal_parameters)
        binders = " ".join((*clause.parameters, clause.scrutinee))
        lines += [
            f"Lemma {clause.predicate.replace('::', '_')}_choose_{index} : forall {binders},",
            f"  {clause.scrutinee} = ({constructor}) -> {lhs} = {original}.",
            "Proof. intros; subst; reflexivity. Qed.",
        ]
    return "\n".join(lines) + "\n"
