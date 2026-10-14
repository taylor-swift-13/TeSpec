#!/usr/bin/env python3
"""Extract reviewed CN functions and translate their contracts to QCP.

Executable tokens are copied from the locked upstream files. Member renaming
maps the CN list layout onto QCP's existing, defined sll predicate. C99's
implicit return 0 in main is made explicit for the native QCP frontend.
Trusted allocation wrappers become declarations; they are not implementations.
"""

from __future__ import annotations

import argparse
import hashlib
import json
from pathlib import Path
import re

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[2]
SOURCE = HERE.parent / "sources/fulminate-cn/src/examples"
QCP = ROOT / "runtime/qcip/QCP_examples/QCP_demos_human"
MOD = "4294967296"


def sha(data):
    return hashlib.sha256(data).hexdigest()


def strip_comments(source):
    return re.sub(r"/\*.*?\*/|//[^\n]*", "", source, flags=re.S)


def extract(source, name):
    clean = strip_comments(source)
    matches = list(
        re.finditer(
            r"(?m)^([^\n;{}]*\b" + re.escape(name) + r"\s*\([^;{}]*?\))\s*\{", clean
        )
    )
    if len(matches) != 1:
        raise ValueError(f"Expected one function body: {name}")
    match = matches[0]
    start = match.end() - 1
    depth, end = 1, start + 1
    while depth:
        depth += (clean[end] == "{") - (clean[end] == "}")
        end += 1
    # Removing comments/blank lines changes neither tokens nor execution.
    body = "\n".join(
        line.rstrip() for line in clean[start:end].splitlines() if line.strip()
    )
    return match.group(1).strip(), body


def rename(text, mapping):
    if not mapping:
        return text
    text = re.sub(
        r"\bstruct\s+(int_list|int_queueCell)\b",
        lambda m: "struct " + mapping.get(m[1], m[1]),
        text,
    )
    # Member names only: renaming the local `head` in stack.pop would capture
    # the existing local pointer `data` and change the executable semantics.
    return re.sub(
        r"(->|\.)\s*(head|tail|first)\b", lambda m: m[1] + mapping.get(m[2], m[2]), text
    )


ALLOC = """unsigned int *mallocUnsignedInt()
/*@ Require emp Ensure __return != 0 && undef_data_at(__return, unsigned int) */;
void freeUnsignedInt(unsigned int *p)
/*@ Require undef_data_at(p, unsigned int) Ensure emp */;
"""
REF = "With v0 Require v == v0 && emp Ensure data_at(__return, unsigned int, v0)"
INCR = (
    "With n0 Require data_at(p, unsigned int, n0) Ensure "
    f"data_at(p, unsigned int, (n0 + 1) % {MOD})"
)
LIST_ALLOC = """struct list *mallocIntList()
/*@ Require emp Ensure __return != 0 &&
    undef_data_at(&(__return->data), int) *
    undef_data_at(&(__return->next), struct list *) */;
void freeIntList(struct list *p)
/*@ Require undef_data_at(&(p->data), int) *
            undef_data_at(&(p->next), struct list *) Ensure emp */;
"""
NIL = "Require emp Ensure sll(__return, nil)"
CONS = "With h0 (l: list Z) Require h == h0 && sll(t,l) Ensure sll(__return,cons(h0,l))"
COPY = "With (l: list Z) Require sll(xs,l) Ensure sll(xs,l) * sll(__return,l)"
LENGTH = (
    "With (l: list Z) Require sll(xs,l) "
    f"Ensure __return == Zlength(l) % {MOD} && sll(xs,l)"
)
MAPPING = {"int_list": "list", "head": "data", "tail": "next"}
QUEUE_SHAPE = """(
  (data_at(field_addr(Q,int_queue,front),struct list *,0) *
   data_at(field_addr(Q,int_queue,back),struct list *,0) && L == (nil: list Z)) ||
  (exists f b last (pre: list Z),
   f != 0 && b != 0 && L == app(pre,cons(last,nil)) &&
   data_at(field_addr(Q,int_queue,front),struct list *,f) *
   data_at(field_addr(Q,int_queue,back),struct list *,b) *
   sllseg(f,b,pre) * data_at(field_addr(b,list,data),int,last) *
   data_at(field_addr(b,list,next),struct list *,0)))"""
QUEUE_NONEMPTY = """(
  (exists h, l == (nil: list Z) && h != 0 &&
   data_at(&(q->front),struct list *,h) * data_at(&(q->back),struct list *,h) *
   data_at(field_addr(h,list,data),int,x0) * data_at(field_addr(h,list,next),struct list *,0)) ||
  (exists h t b last (pre: list Z), h != 0 && t != 0 && b != 0 && l == app(pre,cons(last,nil)) &&
   data_at(&(q->front),struct list *,h) * data_at(&(q->back),struct list *,b) *
   data_at(field_addr(h,list,data),int,x0) * data_at(field_addr(h,list,next),struct list *,t) *
   sllseg(t,b,pre) * data_at(field_addr(b,list,data),int,last) *
   data_at(field_addr(b,list,next),struct list *,0)))"""


def expand_queue(contract):
    # Expose the first cell for pop. This is one unfolding of the nonempty
    # CN predicate, not a length bound or an extra input restriction.
    contract = contract.replace("cn_queue(q,cons(x0,l))", QUEUE_NONEMPTY)
    while "cn_queue(" in contract:
        start = contract.index("cn_queue(")
        end, depth = start + len("cn_queue("), 1
        while depth:
            depth += (contract[end] == "(") - (contract[end] == ")")
            end += 1
        q, seq = contract[start + len("cn_queue(") : end - 1].split(",", 1)
        formula = re.sub(
            r"\b(Q|L)\b", lambda m: q if m[1] == "Q" else "(" + seq + ")", QUEUE_SHAPE
        )
        contract = contract[:start] + formula + contract[end:]
    return contract


def recipes():
    groups = []

    def add(
        name,
        upstream,
        declarations,
        functions,
        targets,
        mapping=None,
        notes=None,
        list_library=False,
    ):
        groups.append(
            dict(
                id=name,
                upstream=upstream,
                declarations=declarations,
                functions=functions,
                targets=targets,
                identifier_mapping=mapping or {},
                notes=notes or [],
                list_library=list_library,
            )
        )

    def target(name, binds):
        rows = []
        for i, given in enumerate(binds):
            v, args = dict(given), {}
            if name in {"refUnsignedInt", "triple_ref_with_frame"}:
                args["v"] = v["v0"]
            if name == "triple_ref_with_frame":
                args["p_"] = 4096
            if name == "ref_greater" or name == "get_and_free":
                args["p"] = 4096
            if name == "succ_using_incr":
                args["n"] = v["n0"]
            if name == "val_rand":
                args["n"] = v["n0"]
            if name == "IntList_cons":
                args.update(h=v["h0"], t=4096 if v["l"] else 0)
            if name in {
                "IntList_copy",
                "IntList_free_list",
                "IntList_length",
                "IntList_rev",
            }:
                args["xs"] = 4096 if v["l"] else 0
            if name in {"IntList_append", "IntList_append2"}:
                args.update(xs=4096 if v["a"] else 0, ys=8192 if v["b"] else 0)
            if name in {"sizeOf", "push", "top", "pop"}:
                args["p"] = 4096
                v["d"] = 8192 if v["l"] or name in {"top", "pop"} else 0
            if name == "push":
                args["x"] = v["x0"]
            if name in {"IntQueue_pop", "IntQueue_push"}:
                args["q"] = 4096
            if name == "IntQueue_push":
                args["x"] = v["x0"]
            rows.append(dict(id="input_" + str(i), args=args, values=v))
        return dict(function=name, binds=rows)

    values = [0, 1, 5, 2147483647, 4294967294, 4294967295]
    add(
        "ref",
        "slf10_basic_ref.c",
        ALLOC,
        {"refUnsignedInt": REF},
        [target("refUnsignedInt", [{"v0": v} for v in values])],
    )
    for name, upstream, abstract in [
        ("ref-greater", "slf11_basic_ref_greater.c", False),
        ("ref-greater-abstract", "slf12_basic_ref_greater_abstract.c", True),
    ]:
        relation = "m > n0" if abstract else f"m == (n0+1) % {MOD}"
        pre = "n0 < 4294967295 && " if abstract else ""
        contract = (
            f"With n0 Require {pre}data_at(p,unsigned int,n0) "
            f"Ensure exists m, {relation} && "
            "data_at(p,unsigned int,n0) * data_at(__return,unsigned int,m)"
        )
        add(
            name,
            upstream,
            ALLOC,
            {"refUnsignedInt": REF, "ref_greater": contract},
            [
                target(
                    "ref_greater",
                    [{"n0": v} for v in values if not abstract or v < 4294967295],
                )
            ],
            notes=[
                "CN u32 addition becomes modulo 2^32; the abstract version excludes wraparound."
            ],
        )
    add(
        "ref-frame",
        "slf13_basic_ref_with_frame.c",
        ALLOC,
        {
            "refUnsignedInt": REF,
            "triple_ref_with_frame": "With old v0 Require v == v0 && data_at(p_,unsigned int,old) "
            "Ensure data_at(p_,unsigned int,old) * data_at(__return,unsigned int,v0)",
        },
        [target("triple_ref_with_frame", [{"old": 6, "v0": v} for v in values])],
    )
    add(
        "succ-alloc-free",
        "slf16_basic_succ_using_incr.c",
        ALLOC,
        {
            "refUnsignedInt": REF,
            "incr": INCR,
            "succ_using_incr": f"With n0 Require n == n0 && emp Ensure __return == (n0+1) % {MOD} && emp",
        },
        [target("succ_using_incr", [{"n0": v} for v in values])],
    )
    add(
        "get-free",
        "slf17_get_and_free.c",
        ALLOC,
        {
            "get_and_free": "With v0 Require data_at(p,unsigned int,v0) Ensure __return == v0 && emp"
        },
        [target("get_and_free", [{"v0": v} for v in values])],
        notes=[
            "freeUnsignedInt is an external adapter contract, matching the CN free interface."
        ],
    )

    lists = [[], [1], [2, 1], [-1, 0, 3]]
    add(
        "list-all",
        "list_all.c",
        LIST_ALLOC,
        {
            "IntList_nil": NIL,
            "IntList_cons": CONS,
            "IntList_copy": COPY,
            "IntList_free_list": "With (l: list Z) Require sll(xs,l) Ensure emp",
            "IntList_length": LENGTH,
            "IntList_rev_aux": "With (a b: list Z) Require sll(xs,a) * sll(ys,b) Ensure sll(__return,app(rev(b),a))",
            "IntList_rev": "With (l: list Z) Require sll(xs,l) Ensure sll(__return,rev(l))",
            "IntList_append": "With (a b: list Z) Require sll(xs,a) * sll(ys,b) Ensure sll(__return,app(a,b))",
            "IntList_append2": "With (a b: list Z) Require sll(xs,a) * sll(ys,b) Ensure sll(xs,a) * sll(ys,b) * sll(__return,app(a,b))",
        },
        [
            target("IntList_cons", [{"h0": 7, "l": seq} for seq in lists]),
            *[
                target(n, [{"l": seq} for seq in lists])
                for n in [
                    "IntList_copy",
                    "IntList_free_list",
                    "IntList_length",
                    "IntList_rev",
                ]
            ],
            *[
                target(n, [{"a": a, "b": b} for a, b in zip(lists, reversed(lists))])
                for n in ["IntList_append", "IntList_append2"]
            ],
        ],
        mapping=MAPPING,
        list_library=True,
        notes=[
            "Function subset; sorting, iterative reverse and the original main remain separate obligations.",
            "Bijective layout rename: int_list/head/tail to QCP list/data/next.",
            "CN IntList is QCP sll; CN sequence constructors are Coq list constructors.",
        ],
    )

    queue_decl = """struct int_queue { struct list *front; struct list *back; };
struct int_queue *mallocIntQueue()
/*@ Require emp Ensure __return != 0 &&
    undef_data_at(&(__return->front),struct list *) *
    undef_data_at(&(__return->back),struct list *) */;
struct list *mallocIntQueueCell()
/*@ Require emp Ensure __return != 0 &&
    undef_data_at(&(__return->data),int) *
    undef_data_at(&(__return->next),struct list *) */;
void freeIntQueueCell(struct list *p)
/*@ Require undef_data_at(&(p->data),int) *
            undef_data_at(&(p->next),struct list *) Ensure emp */;
void push_lemma(struct list *front, struct list *p)
/*@ With x n (l: list Z)
    Require sllseg(front,p,l) * data_at(&(p->data),int,x) *
            data_at(&(p->next),struct list *,n)
    Ensure sllseg(front,n,app(l,cons(x,nil))) */;
"""
    add(
        "queue",
        "queue_all.c",
        queue_decl,
        {
            "IntQueue_empty": "Require emp Ensure cn_queue(__return,nil)",
            "IntQueue_pop": "With x0 (l: list Z) Require cn_queue(q,cons(x0,l)) Ensure __return == x0 && cn_queue(q,l)",
            "IntQueue_push": "With x0 (l: list Z) Require x == x0 && cn_queue(q,l) Ensure cn_queue(q,app(l,cons(x0,nil)))",
        },
        [
            target("IntQueue_empty", [{}]),
            target("IntQueue_pop", [{"x0": 7, "l": seq} for seq in lists]),
            target("IntQueue_push", [{"x0": 7, "l": seq} for seq in lists]),
        ],
        mapping={"int_queueCell": "list", "first": "data"},
        list_library=True,
        notes=[
            "IntQueuePtr and IntQueueFB become an explicit empty/nonempty disjunction using sllseg.",
            "The original trusted push_lemma remains a declared trusted lemma; its proof is not claimed.",
            "The alternate push_induction and original main remain separate obligations.",
        ],
    )

    stack_decl = (
        LIST_ALLOC
        + """struct sized_stack { unsigned int size; struct list *data; };
struct sized_stack *malloc_sized_stack()
/*@ Require emp Ensure __return != 0 &&
    undef_data_at(&(__return->size),unsigned int) *
    undef_data_at(&(__return->data),struct list *) */;
"""
    )
    stack_pre = f"With d (l: list Z) Require p->size == Zlength(l) % {MOD} && p->data == d * sll(d,l) "
    add(
        "stack",
        "slf_sized_stack.c",
        stack_decl,
        {
            "IntList_cons": CONS,
            "create": "Require emp Ensure __return->size == 0 && __return->data == 0",
            "sizeOf": stack_pre
            + f"Ensure __return == Zlength(l) % {MOD} && p->size == Zlength(l) % {MOD} && p->data == d * sll(d,l)",
            "push": f"With d x0 (l: list Z) Require x == x0 && p->size == Zlength(l) % {MOD} && p->data == d * sll(d,l) Ensure exists d2, p->size == (Zlength(l)+1) % {MOD} && p->data == d2 * sll(d2,cons(x0,l))",
            "top": f"With d h (l: list Z) Require (Zlength(l)+1) % {MOD} > 0 && p->size == (Zlength(l)+1) % {MOD} && p->data == d * sll(d,cons(h,l)) Ensure __return == h && p->size == (Zlength(l)+1) % {MOD} && p->data == d * sll(d,cons(h,l))",
            "pop": f"With d h (l: list Z) Require (Zlength(l)+1) % {MOD} > 0 && p->size == (Zlength(l)+1) % {MOD} && p->data == d * sll(d,cons(h,l)) Ensure exists d2, p->size == Zlength(l) % {MOD} && p->data == d2 * sll(d2,l)",
        },
        [
            target("create", [{}]),
            target("sizeOf", [{"l": seq} for seq in lists]),
            target("push", [{"x0": 7, "l": seq} for seq in lists]),
            *[target(n, [{"h": 9, "l": seq} for seq in lists]) for n in ["top", "pop"]],
        ],
        mapping=MAPPING,
        list_library=True,
        notes=[
            "SizedStack is unfolded into size, data and sll with size = length modulo 2^32.",
            "The original pop postcondition specifies the remaining stack, not the returned value; retained.",
        ],
    )
    add(
        "two-dice",
        "slf18_two_dice.c",
        "int rand() /*@ Require emp Ensure 0 <= __return && __return <= 2147483647 && emp */;",
        {
            "val_rand": "With n0 Require n == n0 && n0 > 0 && emp Ensure 0 <= __return && __return < n0 && emp",
            "two_dice": "Require emp Ensure 2 <= __return && __return <= 12 && emp",
        },
        [
            target("val_rand", [{"n0": n} for n in [1, 2, 6, 4294967295]]),
            target("two_dice", [{}]),
        ],
        notes=[
            "rand is a nondeterministic external contract with the C nonnegative-int result range; no random trace replay is claimed."
        ],
    )

    raw_alloc = """void *cn_malloc(unsigned long size)
/*@ Require size == sizeof(unsigned int) && emp
    Ensure __return != 0 && undef_data_at(__return,unsigned int) */;
void cn_free_sized(void *p, unsigned long size)
/*@ Require size == sizeof(unsigned int) && undef_data_at(p,unsigned int)
    Ensure emp */;
"""
    for ident, upstream in [
        ("single-free", "runtime-extras/same_func_malloc_free.c"),
        ("double-free", "runtime-extras/double_free.broken.c"),
    ]:
        add(
            ident,
            upstream,
            raw_alloc,
            {
                "deref": "With v0 Require data_at(p,unsigned int,v0) Ensure __return == v0 && data_at(p,unsigned int,v0)",
                "main": "Require emp Ensure emp",
            },
            [target("main", [{}])],
            notes=[
                "Original trusted driver is checked here, with only unsigned-int-sized allocation admitted.",
                "Paired positive/negative lifetime control: the negative driver performs a second free.",
                "The C99 implicit return 0 at the end of main is made explicit for native QCP.",
            ],
        )
    return groups


def prepare(write=False):
    manifest = {
        "schema": "fulminate-qcp-migration/v1",
        "scope": "function migration; not whole-program coverage",
        "trusted_boundary": "typed allocation/free contracts; no executable allocator model",
        "cases": [],
    }
    expected = {}
    for group in recipes():
        upstream = SOURCE / group["upstream"]
        source = upstream.read_text()
        mapping = group["identifier_mapping"]
        preamble = '#include "verification_stdlib.h"\n'
        if group["list_library"]:
            preamble += '#include "sll_def.h"\n'
        chunks = [preamble, group["declarations"]]
        receipts = []
        for name, contract in group["functions"].items():
            signature, body = extract(source, name)
            contract = expand_queue(contract)
            # QCP's `*` has arithmetic precedence before points-to sugar.
            contract = re.sub(r"p->data == (d2|d) \*", r"(p->data == \1) *", contract)
            translated_body = rename(body, mapping)
            if name == "main":
                translated_body = translated_body[:-1] + "  return 0;\n}"
            output = (
                rename(signature, mapping)
                + "\n/*@ "
                + contract
                + " */\n"
                + translated_body
            )
            chunks.append(output)
            receipts.append(
                dict(
                    function=name,
                    original_body_sha256=sha(body.encode()),
                    translated_body_sha256=sha(translated_body.encode()),
                )
            )
        generated = ("\n\n".join(chunks) + "\n").encode()
        filename = "cases/" + group["id"] + ".c"
        expected[filename] = generated
        manifest["cases"].append(
            {k: v for k, v in group.items() if k not in {"declarations", "functions"}}
            | dict(
                source=filename,
                source_sha256=sha(generated),
                upstream_sha256=sha(upstream.read_bytes()),
                functions=list(group["functions"]),
                body_receipts=receipts,
            )
        )
    # Strategies are fixtures required beside the input by upstream QCP.
    for name in ["sll.strategies", "sll_def.h"]:
        expected["cases/" + name] = (QCP / name).read_bytes()
    manifest["library_sha256"] = {
        name: sha((QCP / name).read_bytes())
        for name in ["sll.strategies", "sll_def.h", "verification_stdlib.h"]
    }
    definition = (
        ROOT / "runtime/qcip/SeparationLogic/examples/QCP_demos_human/sll_lib.v"
    )
    manifest["list_predicate_definition"] = {
        "path": str(definition.relative_to(ROOT)),
        "sha256": sha(definition.read_bytes()),
    }
    expected["manifest.json"] = (
        json.dumps(manifest, indent=2, ensure_ascii=False) + "\n"
    ).encode()
    for name, content in expected.items():
        path = HERE / name
        if write:
            path.parent.mkdir(parents=True, exist_ok=True)
            path.write_bytes(content)
        elif not path.is_file() or path.read_bytes() != content:
            raise ValueError(f"Stale migration: {name}; run prepare.py --write")
    actual = {"cases/" + p.name for p in (HERE / "cases").iterdir() if p.is_file()}
    if actual != {name for name in expected if name.startswith("cases/")}:
        raise ValueError("Unexpected or missing generated case fixture")
    print(
        f"Validated {len(manifest['cases'])} source migrations, "
        f"{sum(len(c['targets']) for c in manifest['cases'])} target functions"
    )
    return manifest


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--write", action="store_true")
    prepare(parser.parse_args().write)
