"""Elaborate exported target layouts into an explicit Rocq address environment.

This selects a computational interpretation; it does not prove equivalence to
legacy predicates compiled against QCP's abstract global address evaluator.
"""

import hashlib
import json
import re


BASIC_BYTES = {
    "bool": 1,
    "char": 1,
    "unsigned_char": 1,
    "short": 2,
    "unsigned_short": 2,
    "int": 4,
    "unsigned_int": 4,
    "int64": 8,
    "uint64": 8,
    "int128": 16,
    "uint128": 16,
    "float": 4,
    "double": 8,
}
IDENTIFIER = re.compile(r"[A-Za-z_][A-Za-z0-9_]*\Z")


def target_layout_digest(layout):
    return hashlib.sha256(
        json.dumps(layout, sort_keys=True, separators=(",", ":")).encode()
    ).hexdigest()


def resolve_field_path(layout, tag, path):
    """Return admitted offsets without crossing an implicit pointer dereference."""
    if not path or any(not isinstance(name, str) for name in path):
        raise ValueError("field path must be nonempty")
    generate_layout_source(layout)
    records = {record["id"]: record for record in layout["aggregates"]}
    candidates = {record["id"] for record in records.values() if record["name"] == tag}
    for alias in layout["aliases"]:
        typ = alias["type"]
        if alias["name"] == tag:
            if typ.get("kind") not in {"struct", "union"}:
                raise ValueError("unresolved or ambiguous aggregate tag: " + tag)
            candidates.add(typ["id"])
    if len(candidates) != 1:
        raise ValueError("unresolved or ambiguous aggregate tag: " + tag)
    current = records[candidates.pop()]
    offsets = []
    for index, name in enumerate(path):
        fields = [
            field
            for field in current["fields"]
            if field["name"] == name and field["computational"]
        ]
        if len(fields) != 1 or not current["defined"]:
            raise ValueError("unresolved or unsupported field: " + name)
        field = fields[0]
        offsets.append(field["offset"])
        if index + 1 < len(path):
            typ = field["type"]
            if typ["kind"] not in {"struct", "union"}:
                raise ValueError(
                    "nested field requires an aggregate, not an implicit dereference"
                )
            current = records[typ["id"]]
    return tuple(offsets)


def integer(value, label, minimum=0):
    if type(value) is not int or value < minimum:
        raise ValueError(f"invalid {label}")
    return value


def generate_layout_source(layout: dict) -> str:
    if not isinstance(layout, dict):
        raise ValueError("target layout must be an object")
    if layout.get("schema") != "sac-target-layout/v1":
        raise ValueError("expected sac-target-layout/v1")
    bits = integer(layout.get("architecture_bits"), "architecture_bits")
    pointer = integer(layout.get("pointer_size"), "pointer_size", 1)
    if bits not in (32, 64) or pointer * 8 != bits:
        raise ValueError("inconsistent target width")
    if not isinstance(layout.get("aggregates"), list) or not isinstance(
        layout.get("aliases"), list
    ):
        raise ValueError("aggregate and alias inventories are required")
    records = {}
    for record in layout["aggregates"]:
        if not isinstance(record, dict):
            raise ValueError("aggregate record must be an object")
        rid = integer(record.get("id"), "aggregate id")
        if rid in records:
            raise ValueError("duplicate aggregate identity")
        if (
            record.get("kind") not in ("struct", "union")
            or type(record.get("defined")) is not bool
        ):
            raise ValueError("invalid aggregate kind/definition flag")
        if record["defined"]:
            integer(record.get("size"), "aggregate size")
            integer(record.get("alignment"), "aggregate alignment", 1)
        if not isinstance(record.get("fields"), list):
            raise ValueError("invalid field inventory")
        records[rid] = record

    def typ(desc, depth=0):
        if not isinstance(desc, dict) or depth > 128:
            raise ValueError("invalid or excessively nested type descriptor")
        kind = desc.get("kind")
        if kind == "basic":
            size = BASIC_BYTES.get(desc.get("name"))
            return (f"(Lprimitive {size})", size) if size else (None, None)
        if kind == "pointer":
            return "Lpointer", pointer
        if kind in ("struct", "union"):
            rid = integer(desc.get("id"), "type reference")
            if rid not in records or records[rid]["kind"] != kind:
                raise ValueError("dangling or mismatched aggregate reference")
            record = records[rid]
            return f"(Laggregate {rid}%nat)", record["size"] if record[
                "defined"
            ] else None
        if kind == "array":
            count = integer(desc.get("length"), "array length")
            element, width = typ(desc.get("element"), depth + 1)
            return (
                (
                    f"(Larray {element} {count})",
                    count * width if width is not None else None,
                )
                if element
                else (None, None)
            )
        if kind in ("enum", "unresolved"):
            return None, None
        raise ValueError("unknown type descriptor kind")

    def usable_name(value):
        return isinstance(value, str) and IDENTIFIER.fullmatch(value)

    # A textual tag or alias is usable only when all declarations of that
    # name resolve to the same type identity. Never choose the first match.
    names = {"struct": {}, "union": {}, "alias": {}}
    for rid, record in records.items():
        name = record.get("name")
        if usable_name(name):
            term = f"(Laggregate {rid}%nat)"
            names[record["kind"]].setdefault(name, set()).add(term)
            names["alias"].setdefault(name, set()).add(term)
    for alias in layout["aliases"]:
        if not isinstance(alias, dict):
            raise ValueError("alias record must be an object")
        term, _ = typ(alias.get("type"))
        name = alias.get("name")
        if usable_name(name):
            names["alias"].setdefault(name, set()).add(term)

    fields = []
    seen_field_ids = set()
    for rid, record in sorted(records.items()):
        seen_names = set()
        for field in record["fields"]:
            if not isinstance(field, dict):
                raise ValueError("field record must be an object")
            fid = integer(field.get("id"), "field id")
            if fid in seen_field_ids:
                raise ValueError("duplicate field identity")
            seen_field_ids.add(fid)
            name = field.get("name")
            if name is not None and not isinstance(name, str):
                raise ValueError("field name must be a string or null")
            if name in seen_names:
                raise ValueError("duplicate field name within aggregate")
            seen_names.add(name)
            term, expected_size = typ(field.get("type"))
            if type(field.get("computational")) is not bool:
                raise ValueError("missing field admission flag")
            if not field["computational"]:
                continue
            offset = integer(field.get("offset"), "field offset")
            size = integer(field.get("size"), "field size", 1)
            align = integer(field.get("alignment"), "field alignment", 1)
            if (
                not record["defined"]
                or offset + size > record["size"]
                or offset % align
                or record["alignment"] % align
                or (record["kind"] == "union" and offset != 0)
            ):
                raise ValueError("inconsistent admitted field layout")
            if term is None or expected_size is None:
                continue
            if expected_size != size:
                raise ValueError("field size disagrees with its type")
            if usable_name(name):
                fields.append((rid, name, offset, term))

    digest = hashlib.sha256(
        json.dumps(layout, sort_keys=True, separators=(",", ":")).encode()
    ).hexdigest()
    lines = [
        f"(* target-layout canonical JSON SHA256: {digest} *)",
        "From Coq Require Import ZArith String List.",
        "From SimpleC.SL Require Import CNotation.",
        "Require Import LayoutAddress.",
        "Local Open Scope Z_scope.",
        "Local Open Scope string_scope.",
    ]
    for kind in ("struct", "union", "alias"):
        lines.append(
            f"Definition resolve_{kind} (name : string) : option layout_type :="
        )
        for name, options in sorted(names[kind].items()):
            if len(options) == 1 and None not in options:
                lines.append(
                    f'  if String.eqb name "{name}" then Some {next(iter(options))} else'
                )
        lines.append("  None.")
    lines.extend(
        [
            "Definition resolve_type (ty : front_end_type) : option layout_type :=",
            "  match ty with",
            "  | FET_struct name => resolve_struct name",
            "  | FET_union name => resolve_union name",
            "  | FET_alias name => resolve_alias name",
            "  | FET_ptr => Some Lpointer",
            "  | FET_char | FET_uchar => Some (Lprimitive 1)",
            "  | FET_short | FET_ushort => Some (Lprimitive 2)",
            "  | FET_int | FET_uint | FET_float => Some (Lprimitive 4)",
            "  | FET_int64 | FET_uint64 | FET_double => Some (Lprimitive 8)",
            "  | _ => None",
            "  end.",
            "Definition resolve_size (id : nat) : option Z :=",
        ]
    )
    for rid, record in sorted(records.items()):
        if record["defined"] and record["size"] > 0:
            lines.append(f"  if Nat.eqb id {rid}%nat then Some {record['size']} else")
    lines.extend(
        [
            "  None.",
            "Definition resolve_field (id : nat) (name : string) : option field_record :=",
        ]
    )
    for rid, name, offset, term in fields:
        lines.append(
            f'  if andb (Nat.eqb id {rid}%nat) (String.eqb name "{name}") then'
        )
        lines.append(f"    Some {{| fl_offset := {offset}; fl_type := {term} |}} else")
    lines.extend(
        [
            "  None.",
            "Definition target_layout : layout_env :=",
            "  {| lookup_type := resolve_type; lookup_size := resolve_size;",
            f"     lookup_field := resolve_field; pointer_bytes := {pointer} |}}.",
            "Module AddressNotations.",
            'Notation "&( x )" :=',
            "  (ltac:(let x' := get_lvalue_expr x in",
            "          let e := constr:(eval_l target_layout x') in",
            "          let v := (eval cbv -[Z.add Z.mul Z.sub Z.opp] in e) in",
            "          lazymatch v with",
            "          | Some (?a, ?t) => exact a",
            '          | _ => fail "unresolved target-layout address"',
            "          end))",
            "  (at level 0, x custom lvalue_expr_entry at level 99, only parsing).",
            "End AddressNotations.",
        ]
    )
    return "\n".join(lines) + "\n"
