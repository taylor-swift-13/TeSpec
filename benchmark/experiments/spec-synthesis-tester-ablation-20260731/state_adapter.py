"""Translate concrete C states into candidate-specific QCP bindings."""

from __future__ import annotations

import re
from typing import Any


class StateBindingError(ValueError):
    """A candidate spec cannot be bound from the hidden C-state schema."""


def _call_arguments(text: str, name: str) -> list[tuple[str, str]]:
    calls = []
    pattern = re.compile(rf"\b{re.escape(name)}\s*\(")
    for match in pattern.finditer(text):
        start = match.end()
        depth = 1
        comma = None
        index = start
        while index < len(text) and depth:
            char = text[index]
            if char == "(":
                depth += 1
            elif char == ")":
                depth -= 1
            elif char == "," and depth == 1 and comma is None:
                comma = index
            index += 1
        if depth != 0 or comma is None:
            raise StateBindingError(f"malformed {name}(address, value) term")
        calls.append((text[start:comma].strip(), text[comma + 1 : index - 1].strip()))
    return calls


def _field_address(address: str) -> tuple[str, str | None, str]:
    compact = re.sub(r"\s+", "", address)
    cast = re.fullmatch(
        r"&\(\(\((?P<type>[A-Za-z_]\w*)\*\)(?P<root>[A-Za-z_]\w*)\)"
        r"->(?P<field>[A-Za-z_]\w*)\)",
        compact,
    )
    if cast is not None:
        return cast.group("root"), cast.group("type"), cast.group("field")
    direct = re.fullmatch(
        r"&\((?P<root>[A-Za-z_]\w*)->(?P<field>[A-Za-z_]\w*)\)",
        compact,
    )
    if direct is not None:
        return direct.group("root"), None, direct.group("field")
    raise StateBindingError(
        "Require store address must be &(root->field) or &(((Type *)root)->field)"
    )


def candidate_field_binders(spec: str) -> dict[str, tuple[str, str | None, str]]:
    """Map each candidate-defined binder to its C input field."""

    clauses = re.search(
        r"\bWith\b(?P<with>.*?)\bRequire\b(?P<require>.*?)\bEnsure\b",
        spec,
        re.DOTALL,
    )
    if clauses is None:
        raise StateBindingError("candidate must contain With, Require, and Ensure")
    declarations = re.findall(r"\(\s*(?P<name>[A-Za-z_]\w*)\s*:", clauses.group("with"))
    if not declarations:
        raise StateBindingError("With must declare at least one typed logical variable")
    if len(declarations) != len(set(declarations)):
        raise StateBindingError("With contains duplicate logical variables")
    declared = set(declarations)
    mapping: dict[str, tuple[str, str | None, str]] = {}
    locations: set[tuple[str, str | None, str]] = set()
    stores = _call_arguments(clauses.group("require"), "store")
    if not stores:
        raise StateBindingError("Require must describe input fields with store terms")
    for address, value in stores:
        binder = value.strip()
        if binder not in declared:
            continue
        location = _field_address(address)
        if binder in mapping:
            raise StateBindingError(f"With variable {binder!r} maps more than once")
        if location in locations:
            raise StateBindingError(
                f"C field {location[0]}.{location[2]} maps more than once"
            )
        mapping[binder] = location
        locations.add(location)
    missing = sorted(declared - mapping.keys())
    if missing:
        raise StateBindingError(
            "With variables not directly mapped by Require store: " + ", ".join(missing)
        )
    return mapping


def bind_states_for_spec(
    spec: str,
    states: list[dict[str, Any]],
) -> list[dict[str, Any]]:
    """Create ephemeral QCP binds using field identity, never binder spelling."""

    mapping = candidate_field_binders(spec)
    binds = []
    for state in states:
        objects = state.get("objects")
        if not isinstance(objects, list):
            raise StateBindingError(f"state {state.get('id')!r} has invalid objects")
        values = {}
        for binder, (root, type_name, field) in mapping.items():
            matches = [
                item
                for item in objects
                if item.get("root") == root
                and (type_name is None or item.get("type") == type_name)
            ]
            if len(matches) != 1:
                raise StateBindingError(
                    f"state {state.get('id')!r} has no unique object for {root!r}"
                )
            obj = matches[0]
            if state.get("args", {}).get(root) != obj.get("address"):
                raise StateBindingError(
                    f"state {state.get('id')!r} has inconsistent address for {root!r}"
                )
            fields = obj.get("fields")
            if not isinstance(fields, dict) or field not in fields:
                raise StateBindingError(
                    f"state {state.get('id')!r} has no field {root}.{field}"
                )
            values[binder] = fields[field]
        binds.append(
            {
                "id": state["id"],
                "args": state["args"],
                "values": values,
            }
        )
    return binds
