"""Deterministic semantic cases; oracles are computed independently of teSpec.

The tests borrow fault *classes* from Fulminate/Darcy, not their code or counts.
Every descriptor is materialized as C, a binds JSON and a semantic expectation.
"""

from __future__ import annotations
from dataclasses import dataclass, field
from typing import Any


@dataclass
class Program:
    name: str
    category: str
    source: str
    inputs: list[dict[str, Any]]
    mutation: tuple[str, str] | None = None
    description: str = ""
    variants: list[str] = field(
        default_factory=lambda: ["reference", "wrong_post", "wrong_body"]
    )
    expectations: dict[str, dict[str, str]] | None = None


def scalar(
    name,
    body,
    oracle,
    ns=(-3, 0, 1, 4),
    *,
    helper="",
    mutation=None,
    category="scalar_control",
):
    inputs = []
    for n in ns:
        result = oracle(n)
        inputs.append(
            dict(
                id=f"n_{n}".replace("-", "minus_"),
                args={"n": n},
                values={"expected": result},
                native_setup="",
                native_args=str(n),
                native_observe=[],
                oracle=[result],
            )
        )
    return Program(
        name,
        category,
        helper + "\nint sample(int n)\n"
        "/*@ With expected Require -100<=n && n<=100 && emp "
        "Ensure __return==expected && emp */\n{ " + body + " }\n",
        inputs,
        mutation,
    )


def array(
    name,
    body,
    oracle,
    arrays,
    *,
    mutation=None,
    helper="",
    category="arrays",
    second=False,
    char=False,
):
    module, ctype = ("UCharArray", "unsigned char") if char else ("IntArray", "int")
    inputs = []
    for i, xs in enumerate(arrays):
        result, out = oracle(xs[:])
        vals = {"xs": xs, "out": out, "expected": result}
        setup = (
            f"{ctype} a[{max(1, len(xs))}]={{" + ",".join(map(str, xs or [0])) + "};"
        )
        arg = f"a,{len(xs)}"
        observe = [f"a[{k}]" for k in range(len(xs))]
        if second:
            vals["ys"] = [0] * len(xs)
            setup += f"{ctype} b[{max(1, len(xs))}]={{0}};"
            arg = f"a,b,{len(xs)}"
            observe = [f"b[{k}]" for k in range(len(xs))]
            # Native oracle checks source frame as well as destination writes.
            observe += [f"a[{k}]" for k in range(len(xs))]
        inputs.append(
            dict(
                id=f"input_{i}",
                args={"n": len(xs)},
                values=vals,
                native_setup=setup,
                native_args=arg,
                native_observe=observe,
                oracle=[result] + out + (xs if second else []),
            )
        )
    params = f"{ctype} *a, " + (f"{ctype} *b, " if second else "") + "int n"
    pre = f"{module}::full(a,n,xs)"
    post = f"{module}::full(a,n,out)"
    withs = "(xs: list Z) (out: list Z) (expected: Z)"
    if second:
        withs += " (ys: list Z)"
        pre += f" * {module}::full(b,n,ys)"
        post = f"{module}::full(a,n,xs) * {module}::full(b,n,out)"
    source = '#include "verification_list.h"\n' + helper + f"\nint sample({params})\n"
    source += f"/*@ With {withs} Require n==Zlength(xs) && 0<=n && n<=8 && {pre}\n"
    source += f"Ensure __return==expected && {post} */\n{{ {body} }}\n"
    return Program(name, category, source, inputs, mutation)


def heap(name, category, prefix, params, pre, post, body, inputs, mutation=None):
    return Program(
        name,
        category,
        prefix + f"\nint sample({params})\n"
        f"/*@ With (v: Z) (expected: Z) Require {pre}\nEnsure __return==expected && {post} */\n"
        "{ " + body + " }\n",
        inputs,
        mutation,
    )


def heap_inputs(setup, args, observe, oracle, vs=(0, 1, 3, 8)):
    return [
        dict(
            id=f"v_{v}",
            args={},
            values={"v": v, "expected": oracle(v)[0]},
            native_setup=setup.format(v=v),
            native_args=args,
            native_observe=observe,
            oracle=oracle(v),
        )
        for v in vs
    ]


def programs():
    ps = []
    ps += [
        scalar(
            "absolute",
            "if(n<0) return -n; return n;",
            abs,
            mutation=("return -n", "return n"),
        ),
        scalar(
            "clamp",
            "if(n<0) return 0; if(n>3) return 3; return n;",
            lambda n: max(0, min(3, n)),
            mutation=("return 3", "return 2"),
        ),
        scalar(
            "switch_value",
            "switch(n) { case 0:return 10; case 1:return 20; default:return 30; }",
            lambda n: 10 if n == 0 else 20 if n == 1 else 30,
            mutation=("return 20", "return 21"),
        ),
        scalar(
            "short_circuit",
            "if(n!=0 && 12/n>2) return 1; return 0;",
            lambda n: int(n != 0 and int(12 / n) > 2),
            mutation=("return 1", "return 2"),
        ),
        scalar(
            "triangular",
            "int s=0; for(int i=0;i<=n;i++) s+=i; return s;",
            lambda n: n * (n + 1) // 2,
            (0, 1, 3, 6),
            mutation=("i<=n", "i<n"),
            category="loops",
        ),
        scalar(
            "count_down",
            "int s=0; while(n>0) { n--; s++; } return s;",
            lambda n: n,
            (0, 1, 3, 6),
            mutation=("s++", "s+=2"),
            category="loops",
        ),
        scalar(
            "do_once",
            "int s=0; do { s++; } while(s<n); return s;",
            lambda n: max(1, n),
            (0, 1, 3, 6),
            mutation=("return s", "return s+1"),
            category="loops",
        ),
        scalar(
            "continue_sum",
            "int s=0; for(int i=0;i<n;i++) { if(i%2==0) continue; s+=i; } return s;",
            lambda n: sum(i for i in range(n) if i % 2),
            (0, 1, 4, 7),
            mutation=("i%2==0", "i%2!=0"),
            category="loops",
        ),
        scalar(
            "nested_loops",
            "int s=0; for(int i=0;i<n;i++) for(int j=0;j<i;j++) s++; return s;",
            lambda n: n * (n - 1) // 2,
            (0, 1, 3, 5),
            mutation=("j<i", "j<=i"),
            category="loops",
        ),
        scalar(
            "factorial",
            "return fact(n);",
            lambda n: __import__("math").factorial(n),
            (0, 1, 3, 5),
            helper="int fact(int n) { if(n<=1) return 1; int k=n; int r=fact(n-1); return k*r; }",
            mutation=("return k*r", "return k+r"),
            category="recursion",
        ),
        scalar(
            "fibonacci",
            "return fib(n);",
            lambda n: [0, 1, 1, 2, 3, 5, 8][n],
            (0, 1, 4, 6),
            helper="int fib(int n) { if(n<2) return n; return fib(n-1)+fib(n-2); }",
            mutation=("return n;", "return 1;"),
            category="recursion",
        ),
        scalar(
            "mutual_even",
            "return even(n);",
            lambda n: int(n % 2 == 0),
            (0, 1, 4, 5),
            helper="int odd(int n); int even(int n) { if(n==0) return 1; return odd(n-1); } int odd(int n) { if(n==0) return 0; return even(n-1); }",
            mutation=("if(n==0) return 0", "if(n==0) return 1"),
            category="recursion",
        ),
        scalar(
            "repeated_call",
            "int x=n; x=step(x); x=step(x); return x;",
            lambda n: n + 2,
            helper="int step(int x) { return x+1; }",
            mutation=("return x+1", "return x+2"),
            category="calls",
        ),
        scalar(
            "recursive_local_alias",
            "int x=0; return f(n,&x);",
            lambda n: 0 if n == 0 else (7 if n == 1 else n),
            (0, 1, 2, 4),
            helper="int f(int n,int *p) { int x=n; if(n==0) { *p=7; return 0; } f(n-1,&x); return x; }",
            mutation=("*p=7", "*p=8"),
            category="calls",
        ),
    ]
    arrays = [[], [3], [1, 2, 3], [4, -1, 4, 0]]
    ps += [
        scalar(
            "signed_division",
            "return n/3;",
            lambda n: int(n / 3),
            (-7, -1, 0, 7),
            mutation=("n/3", "n/2"),
            category="integer_semantics",
        ),
        scalar(
            "signed_remainder",
            "return n%3;",
            lambda n: n - int(n / 3) * 3,
            (-8, -2, 0, 8),
            mutation=("n%3", "n%2"),
            category="integer_semantics",
        ),
        scalar(
            "bit_mask",
            "return (n&7)^3;",
            lambda n: (n & 7) ^ 3,
            (0, 1, 7, 15),
            mutation=("^3", "^2"),
            category="integer_semantics",
        ),
        scalar(
            "left_shift",
            "return 1<<n;",
            lambda n: 1 << n,
            (0, 1, 4, 7),
            mutation=("1<<n", "2<<n"),
            category="integer_semantics",
        ),
        array(
            "array_sum",
            "int s=0; for(int i=0;i<n;i++) s+=a[i]; return s;",
            lambda a: (sum(a), a),
            arrays,
            mutation=("s+=a[i]", "s-=a[i]"),
        ),
        array(
            "array_increment",
            "for(int i=0;i<n;i++) a[i]++; return n;",
            lambda a: (len(a), [x + 1 for x in a]),
            arrays,
            mutation=("a[i]++", "a[i]+=2"),
        ),
        array(
            "array_reverse",
            "for(int i=0;i<n/2;i++) { int t=a[i]; a[i]=a[n-1-i]; a[n-1-i]=t; } return n;",
            lambda a: (len(a), list(reversed(a))),
            arrays,
            mutation=("a[n-1-i]=t", "a[n-1-i]=0"),
        ),
        array(
            "array_copy",
            "for(int i=0;i<n;i++) b[i]=a[i]; return n;",
            lambda a: (len(a), a),
            arrays,
            second=True,
            mutation=("b[i]=a[i]", "b[i]=0"),
        ),
        array(
            "array_prefix",
            "int s=0; for(int i=0;i<n;i++) { s+=a[i]; a[i]=s; } return s;",
            lambda a: (sum(a), [sum(a[: i + 1]) for i in range(len(a))]),
            arrays,
            mutation=("a[i]=s", "a[i]=s+1"),
        ),
        array(
            "array_find_zero",
            "for(int i=0;i<n;i++) if(a[i]==0) return i; return -1;",
            lambda a: (a.index(0) if 0 in a else -1, a),
            [[], [0], [1, 0, 3], [2, 3, 4]],
            mutation=("return -1", "return 0"),
        ),
        array(
            "bubble_sort",
            "for(int i=0;i<n;i++) for(int j=0;j+1<n-i;j++) if(a[j]>a[j+1]) { int t=a[j]; a[j]=a[j+1]; a[j+1]=t; } return n;",
            lambda a: (len(a), sorted(a)),
            arrays,
            mutation=("a[j]>a[j+1]", "a[j]<a[j+1]"),
        ),
        array(
            "array_map_call",
            "for(int i=0;i<n;i++) a[i]=twice(a[i]); return n;",
            lambda a: (len(a), [2 * x for x in a]),
            arrays,
            helper="int twice(int x) { return x*2; }",
            mutation=("return x*2", "return x*3"),
            category="calls",
        ),
        array(
            "string_length",
            "int i=0; while(i<n && a[i]!=0) i++; return i;",
            lambda a: (a.index(0) if 0 in a else len(a), a),
            [[0], [65, 0], [65, 66, 0], [65, 0, 66, 0]],
            char=True,
            category="strings",
            mutation=("a[i]!=0", "a[i]==0"),
        ),
        array(
            "string_replace",
            "int s=0; for(int i=0;i<n;i++) { if(a[i]==65) { a[i]=66; s++; } } return s;",
            lambda a: (a.count(65), [66 if x == 65 else x for x in a]),
            [[0], [65, 0], [65, 66, 65, 0], [67, 0]],
            char=True,
            category="strings",
            mutation=("a[i]=66", "a[i]=67"),
        ),
    ]
    ps += [
        heap(
            "cell_update",
            "pointer_alias",
            "",
            "int *p",
            "0<=v && v<=8 && data_at(p,int,v)",
            "data_at(p,int,v+1)",
            "(*p)++; return *p;",
            heap_inputs("int x={v};", "&x", ["x"], lambda v: [v + 1, v + 1]),
            ("(*p)++", "*p+=2"),
        ),
        heap(
            "alias_update",
            "pointer_alias",
            "",
            "int *p,int *q",
            "p==q && 0<=v && v<=8 && data_at(p,int,v)",
            "p==q && data_at(p,int,v+2)",
            "*p+=1; *q+=1; return *p;",
            heap_inputs("int x={v};", "&x,&x", ["x"], lambda v: [v + 2, v + 2]),
            ("*q+=1", "*q+=2"),
        ),
        heap(
            "swap_cells",
            "pointer_alias",
            "",
            "int *p,int *q",
            "data_at(p,int,v)*data_at(q,int,9)",
            "data_at(p,int,9)*data_at(q,int,v)",
            "int t=*p; *p=*q; *q=t; return *q;",
            heap_inputs(
                "int x={v}; int y=9;", "&x,&y", ["x", "y"], lambda v: [v, 9, v]
            ),
            ("*q=t", "*q=0"),
        ),
        heap(
            "pointer_slot",
            "pointer_alias",
            "void assign(int **p,int *q) { *p=q; *q=7; }",
            "int **p,int *q",
            "data_at(p,int*,0)*data_at(q,int,v)",
            "data_at(p,int*,q)*data_at(q,int,7)",
            "assign(p,q); return **p;",
            heap_inputs(
                "int x={v}; int *p=0;", "&p,&x", ["x", "p==&x"], lambda v: [7, 7, 1]
            ),
            ("*q=7", "*q=8"),
        ),
        heap(
            "argument_snapshot",
            "calls",
            "int update(int *p,int old) { *p=9; return old; }",
            "int *p",
            "data_at(p,int,v)",
            "data_at(p,int,9)",
            "return update(p,*p);",
            heap_inputs("int x={v};", "&x", ["x"], lambda v: [v, 9]),
            ("return old", "return *p"),
        ),
        heap(
            "struct_fields",
            "structs",
            "struct Pair { int x; int y; };",
            "struct Pair *p",
            "data_at(&(p->x),int,v)*data_at(&(p->y),int,5)",
            "data_at(&(p->x),int,7)*data_at(&(p->y),int,5)",
            "p->x=7; return p->x+p->y;",
            heap_inputs(
                "struct Pair x={{{v},5}};", "&x", ["x.x", "x.y"], lambda v: [12, 7, 5]
            ),
            ("p->x=7", "p->x=8"),
        ),
        heap(
            "nested_struct",
            "structs",
            "struct Inner { int x; }; struct Outer { struct Inner i; int y; };",
            "struct Outer *p",
            "data_at(&(p->i.x),int,v)*data_at(&(p->y),int,5)",
            "data_at(&(p->i.x),int,v+1)*data_at(&(p->y),int,5)",
            "p->i.x++; return p->i.x;",
            heap_inputs(
                "struct Outer x={{{{{v}}},5}};",
                "&x",
                ["x.i.x", "x.y"],
                lambda v: [v + 1, v + 1, 5],
            ),
            ("p->i.x++", "p->i.x+=2"),
        ),
    ]
    ps += [
        scalar(
            "struct_value_copy",
            "struct Pair p={n,3}; int x=f(p); return x+p.x;",
            lambda n: 12 + n,
            (0, 1, 3, 8),
            helper="struct Pair { int x; int y; }; int f(struct Pair p) { p.x=9; return p.x+p.y; }",
            mutation=("p.x=9", "p.x=8"),
            category="structs",
        ),
        scalar(
            "struct_return",
            "struct Pair p=f(n); return p.x+p.y;",
            lambda n: n + 3,
            (0, 1, 3, 8),
            helper="struct Pair { int x; int y; }; struct Pair f(int n) { struct Pair p={n,3}; return p; }",
            mutation=("p={n,3}", "p={n,4}"),
            category="structs",
        ),
    ]
    # Finite symbolic-address shapes: no numeric heap addresses in Require.
    node = "struct Node { int value; struct Node *next; };"
    shape = "data_at(&(p->value),int,v)*data_at(&(p->next),struct Node*,q)*data_at(&(q->value),int,2)*data_at(&(q->next),struct Node*,0)"
    linked = heap_inputs(
        "struct Node q={{2,0}}; struct Node p={{{v},&q}};",
        "&p,&q",
        ["p.value", "q.value", "p.next==&q", "q.next==0"],
        lambda v: [v + 2, v, 2, 1, 1],
    )
    ps += [
        heap(
            "list_iterate",
            "linked_structures",
            node,
            "struct Node *p,struct Node *q",
            shape,
            shape,
            "int s=0; struct Node *c=p; while(c) { s+=c->value; c=c->next; } return s;",
            linked,
            ("s+=c->value", "s-=c->value"),
        ),
        heap(
            "list_recurse",
            "linked_structures",
            node
            + " int total(struct Node *p) { if(!p) return 0; return p->value+total(p->next); }",
            "struct Node *p,struct Node *q",
            shape,
            shape,
            "return total(p);",
            linked,
            ("p->value+total", "p->value-total"),
        ),
    ]
    tree = "struct Tree { int v; struct Tree *l; struct Tree *r; };"
    tree_shape = " * ".join(
        [
            f"data_at(&({p}->v),int,{v}) * data_at(&({p}->l),struct Tree*,{l}) * data_at(&({p}->r),struct Tree*,{r})"
            for p, v, l, r in [
                ("p", "v", "a", "b"),
                ("a", "2", "0", "0"),
                ("b", "3", "0", "0"),
            ]
        ]
    )
    tree_helper = " int sum_tree(struct Tree *p) { if(!p) return 0; return p->v+sum_tree(p->l)+sum_tree(p->r); }"
    ps.append(
        heap(
            "binary_tree",
            "trees",
            tree + tree_helper,
            "struct Tree *p,struct Tree *a,struct Tree *b",
            tree_shape,
            tree_shape,
            "return sum_tree(p);",
            heap_inputs(
                "struct Tree a={{2,0,0}}, b={{3,0,0}}, p={{{v},&a,&b}};",
                "&p,&a,&b",
                ["p.v", "a.v", "b.v"],
                lambda v: [v + 5, v, 2, 3],
            ),
            ("p->v+sum_tree", "p->v-sum_tree"),
        )
    )
    # Pool-allocation arithmetic with owned arena: inspired by allocator boundary bugs.
    ps += [
        scalar(
            "aligned_size",
            "if(n==0) return 0; return ((n+7)/8)*8;",
            lambda n: 0 if n == 0 else ((n + 7) // 8) * 8,
            (0, 1, 8, 9),
            mutation=("if(n==0) return 0", "if(n==0) return 8"),
            category="allocator_patterns",
        ),
        array(
            "arena_zero",
            "for(int i=0;i<n;i++) a[i]=0; return n;",
            lambda a: (len(a), [0] * len(a)),
            arrays,
            mutation=("i<n;i++", "i+1<n;i++"),
            category="allocator_patterns",
        ),
    ]
    ps += [
        array(
            "insertion_sort",
            "for(int i=1;i<n;i++) { int t=a[i]; int j=i; while(j>0 && a[j-1]>t) { a[j]=a[j-1]; j--; } a[j]=t; } return n;",
            lambda a: (len(a), sorted(a)),
            arrays,
            mutation=("a[j-1]>t", "a[j-1]<t"),
        ),
        array(
            "array_max",
            "if(n==0) return 0; int m=a[0]; for(int i=1;i<n;i++) if(a[i]>m) m=a[i]; return m;",
            lambda a: (max(a) if a else 0, a),
            arrays,
            mutation=("a[i]>m", "a[i]<m"),
        ),
        array(
            "array_count_zero",
            "int c=0; for(int i=0;i<n;i++) if(a[i]==0) c++; return c;",
            lambda a: (a.count(0), a),
            [[], [0], [1, 0, 3], [0, 0, 4, 0]],
            mutation=("a[i]==0", "a[i]!=0"),
        ),
        heap(
            "defined_cell",
            "logical_predicates",
            "/*@ Let cell(p: Z, v: Z) = data_at(p,int,v) */",
            "int *p",
            "0<=v && v<=8 && cell(p,v)",
            "cell(p,v+1)",
            "(*p)++; return *p;",
            heap_inputs("int x={v};", "&x", ["x"], lambda v: [v + 1, v + 1]),
            ("(*p)++", "*p+=2"),
        ),
        heap(
            "guarded_predicate",
            "logical_predicates",
            "/*@ Let choice(p: Z, k: Z) = (k==0 && data_at(p,int,5)) || (k!=0 && data_at(p,int,6)) */",
            "int *p",
            "choice(p,v)",
            "data_at(p,int,expected)",
            "(*p)++; return *p;",
            heap_inputs(
                "int x=({v}==0 ? 5 : 6);",
                "&x",
                ["x"],
                lambda v: [6 if v == 0 else 7] * 2,
            ),
            ("(*p)++", "*p+=2"),
        ),
    ]
    ps.append(
        heap(
            "existential_cell",
            "logical_predicates",
            "/*@ Let cell(p: Z, v: Z) = exists x, x==v && data_at(p,int,x) */",
            "int *p",
            "0<=v && v<=8 && cell(p,v)",
            "cell(p,v+1)",
            "(*p)++; return *p;",
            heap_inputs("int x={v};", "&x", ["x"], lambda v: [v + 1, v + 1]),
            ("(*p)++", "*p+=2"),
        )
    )
    ps.append(
        heap(
            "nested_definition",
            "logical_predicates",
            "/*@ Let cell(p: Z, v: Z) = data_at(p,int,v) */\n/*@ Let pair(p: Z, q: Z, v: Z) = cell(p,v)*cell(q,v+1) */",
            "int *p,int *q",
            "0<=v && v<=8 && pair(p,q,v)",
            "cell(p,v+1)*cell(q,v+2)",
            "(*p)++; (*q)++; return *p+*q;",
            heap_inputs(
                "int x={v}, y={v}+1;",
                "&x,&y",
                ["x", "y"],
                lambda v: [2 * v + 3, v + 1, v + 2],
            ),
            ("(*q)++", "*q+=2"),
        )
    )
    tree_write = " int visit(struct Tree *p) { if(!p) return 0; p->v++; return p->v+visit(p->l)+visit(p->r); }"
    post_tree = (
        tree_shape.replace("p->v),int,v)", "p->v),int,v+1)")
        .replace("a->v),int,2)", "a->v),int,3)")
        .replace("b->v),int,3)", "b->v),int,4)")
    )
    ps.append(
        heap(
            "tree_update",
            "trees",
            tree + tree_write,
            "struct Tree *p,struct Tree *a,struct Tree *b",
            tree_shape,
            post_tree,
            "return visit(p);",
            heap_inputs(
                "struct Tree a={{2,0,0}}, b={{3,0,0}}, p={{{v},&a,&b}};",
                "&p,&a,&b",
                ["p.v", "a.v", "b.v"],
                lambda v: [v + 8, v + 1, 3, 4],
            ),
            ("p->v++", "p->v+=2"),
        )
    )
    dag_shape = "data_at(&(p->v),int,v)*data_at(&(p->l),struct Tree*,q)*data_at(&(p->r),struct Tree*,q)*data_at(&(q->v),int,2)*data_at(&(q->l),struct Tree*,0)*data_at(&(q->r),struct Tree*,0)"
    ps.append(
        heap(
            "shared_dag",
            "trees",
            tree + tree_helper,
            "struct Tree *p,struct Tree *q",
            dag_shape,
            dag_shape,
            "return sum_tree(p);",
            heap_inputs(
                "struct Tree q={{2,0,0}}, p={{{v},&q,&q}};",
                "&p,&q",
                ["p.v", "q.v", "p.l==p.r"],
                lambda v: [v + 4, v, 2, 1],
            ),
            ("p->v+sum_tree", "p->v-sum_tree"),
        )
    )
    dnode = "struct DNode { int value; struct DNode *next; struct DNode *prev; };"
    dshape = "data_at(&(p->value),int,v)*data_at(&(p->next),struct DNode*,q)*data_at(&(p->prev),struct DNode*,0)*data_at(&(q->value),int,2)*data_at(&(q->next),struct DNode*,0)*data_at(&(q->prev),struct DNode*,p)"
    dpost = "data_at(&(p->value),int,v)*data_at(&(p->next),struct DNode*,0)*data_at(&(p->prev),struct DNode*,q)*data_at(&(q->value),int,2)*data_at(&(q->next),struct DNode*,p)*data_at(&(q->prev),struct DNode*,0)"
    ps.append(
        heap(
            "doubly_reverse",
            "linked_structures",
            dnode,
            "struct DNode *p,struct DNode *q",
            dshape,
            dpost,
            "struct DNode *c=p; struct DNode *head=0; while(c) { struct DNode *n=c->next; c->next=c->prev; c->prev=n; head=c; c=n; } return head->value;",
            heap_inputs(
                "struct DNode q={{2,0,0}}, p={{{v},&q,0}}; q.prev=&p;",
                "&p,&q",
                [
                    "p.value",
                    "q.value",
                    "p.next==0",
                    "p.prev==&q",
                    "q.next==&p",
                    "q.prev==0",
                ],
                lambda v: [2, v, 2, 1, 1, 1, 1],
            ),
            ("c->next=c->prev", "c->next=0"),
        )
    )
    return ps


def scenarios():
    """Explicit expected outcomes; these are not derived from solver output."""
    checks = []

    def add(name, category, source, expand, checked=None, **options):
        checks.append(
            dict(
                name=name,
                category=category,
                source=source,
                binds=[{"id": "case", "args": options.pop("args", {}), "values": {}}],
                expected={
                    "expand": {"case": expand},
                    "no-expand": {"case": checked or expand},
                },
                options=options,
            )
        )

    passed = {
        "overall": "PASS",
        "precondition": "SAT",
        "execution": "PASS",
        "safety": "PASS",
        "postcondition": "PASS",
        "negative": False,
    }
    bad_boundary = {
        **passed,
        "overall": "UNKNOWN",
        "annotations": "UNKNOWN",
        "negative": True,
        "negative_kind": "entailment_checker_wit",
    }
    unknown = {
        "overall": "UNKNOWN",
        "precondition": "SAT",
        "execution": "UNKNOWN",
        "negative": True,
        "expect_artifacts": False,
    }
    invalid = {
        "overall": "INVALID",
        "precondition": "UNSAT",
        "execution": "NOT_RUN",
        "safety": "NOT_RUN",
        "postcondition": "NOT_RUN",
        "negative": True,
        "expect_artifacts": False,
    }
    error = {"overall": "ERROR", "negative": True, "expect_artifacts": False}
    add(
        "false_assert",
        "vc_boundaries",
        "int sample(void) /*@ Require emp Ensure __return==4 && emp */ { int x=3; /*@ Assert x==99 */ x++; return x; }",
        passed,
        bad_boundary,
    )
    add(
        "weak_assert",
        "vc_boundaries",
        "int sample(void) /*@ Require emp Ensure __return==4 && emp */ { int x=3; /*@ Assert x>=0 */ x++; return x; }",
        passed,
    )
    add(
        "false_invariant",
        "vc_boundaries",
        "int sample(void) /*@ Require emp Ensure __return==2 && emp */ { int i=0; /*@ Inv i==0 */ while(i<2) i++; return i; }",
        passed,
        bad_boundary,
    )
    add(
        "visited_invariant",
        "vc_boundaries",
        "int sample(void) /*@ Require emp Ensure __return==3 && emp */ { int i=0; /*@ Inv i>=0 && i<=3 */ while(i<3) i++; return i; }",
        passed,
    )
    add(
        "false_callee_ensure",
        "vc_boundaries",
        "int f(int x) /*@ Require x==2 && emp Ensure __return==99 && emp */ { return x+1; } int sample(void) /*@ Require emp Ensure __return==3 && emp */ { return f(2); }",
        passed,
        bad_boundary,
    )
    add(
        "false_callee_require",
        "vc_boundaries",
        "int f(int x) /*@ Require x==99 && emp Ensure __return==3 && emp */ { return x+1; } int sample(void) /*@ Require emp Ensure __return==3 && emp */ { return f(2); }",
        passed,
        {**bad_boundary, "negative_kind": None, "reason": "contract_binding_unknown"},
    )
    add(
        "weak_callee_ensure",
        "vc_boundaries",
        "int f(int x) /*@ Require x==2 && emp Ensure exists r, __return==r && emp */ { return x+1; } int sample(void) /*@ Require emp Ensure __return==3 && emp */ { return f(2); }",
        passed,
    )
    add(
        "body_without_contract",
        "vc_boundaries",
        "int f(int x) { return x+1; } int sample(void) /*@ Require emp Ensure __return==3 && emp */ { return f(2); }",
        passed,
    )
    add(
        "which_implies_false",
        "vc_boundaries",
        "int sample(int *p) /*@ Require data_at(p,int,3) Ensure data_at(p,int,3) && __return==3 */ { /*@ data_at(p,int,3) which implies data_at(p,int,99) */ return *p; }",
        passed,
        {**bad_boundary, "negative_kind": "which_implies_wit"},
    )
    add(
        "alias_separation_conflict",
        "precondition",
        "int sample(int *p,int *q) /*@ Require p==q && data_at(p,int,1)*data_at(q,int,2) Ensure emp */ { return 0; }",
        invalid,
    )
    add(
        "array_cell_overlap",
        "precondition",
        '#include "verification_list.h"\nint sample(int *p) /*@ Require IntArray::full(p,2,cons(1,cons(2,nil)))*data_at(p+1,int,2) Ensure emp */ { return 0; }',
        invalid,
    )
    for offset in (-1, 0, 2, 3):
        shape = f"IntArray::full(p,2,cons(1,cons(2,nil)))*data_at(p+({offset}),int,9)"
        add(
            f"array_offset_{offset}".replace("-", "minus_"),
            "precondition",
            '#include "verification_list.h"\nint sample(int *p) /*@ Require '
            + shape
            + " Ensure __return==0 && "
            + shape
            + " */ { return 0; }",
            invalid if offset == 0 else passed,
        )
    add(
        "known_int_range_conflict",
        "precondition",
        "int sample(int *p) /*@ Require data_at(p,int,2147483648) Ensure emp */ { return 0; }",
        invalid,
    )
    add(
        "pure_contradiction",
        "precondition",
        "int sample(int x) /*@ Require x>0 && x<0 && emp Ensure emp */ { return x; }",
        invalid,
        args={"x": 1},
    )
    add(
        "loop_exhaustion",
        "incomplete",
        "int sample(void) /*@ Require emp Ensure emp */ { while(1) {} return 0; }",
        {**unknown, "reason": "loop_unroll_limit"},
        loop_unroll_limit=2,
    )
    add(
        "recursion_exhaustion",
        "incomplete",
        "int f(void) { return f(); } int sample(void) /*@ Require emp Ensure emp */ { return f(); }",
        {**unknown, "reason": "call_depth_limit"},
        call_depth_limit=3,
    )
    add(
        "external_body_missing",
        "incomplete",
        "int f(void) /*@ Require emp Ensure __return==3 && emp */; int sample(void) /*@ Require emp Ensure __return==3 && emp */ { return f(); }",
        {**unknown, "reason": "missing_function_body"},
    )
    add(
        "external_contract_missing",
        "incomplete",
        "int f(void); int sample(void) /*@ Require emp Ensure emp */ { return f(); }",
        error,
    )
    add(
        "return_value_missing",
        "incomplete",
        "int f(void) { int x=0; } int sample(void) /*@ Require emp Ensure emp */ { return f(); }",
        {**unknown, "reason": "missing_return_value"},
    )
    add(
        "declaration_only",
        "declarations",
        "int sample(void) /*@ Require emp Ensure emp */;",
        {
            "overall": "PASS",
            "precondition": "SAT",
            "execution": "NOT_RUN",
            "safety": "NOT_RUN",
            "postcondition": "NOT_RUN",
            "scope": "specification-only",
            "negative": False,
        },
    )
    add(
        "opaque_require",
        "declarations",
        "/*@ Extern Coq (opaque : Z -> Assertion) */ int sample(void) /*@ Require opaque(0) Ensure emp */;",
        {
            "overall": "UNKNOWN",
            "precondition": "UNKNOWN",
            "execution": "NOT_RUN",
            "negative": False,
        },
    )
    add("declaration_spec_missing", "declarations", "int sample(void);", error)
    add(
        "unowned_read",
        "c_safety",
        "int sample(int *p) /*@ Require emp Ensure emp */ { return *p; }",
        error,
    )
    add(
        "unowned_write",
        "c_safety",
        "int sample(int *p) /*@ Require emp Ensure emp */ { *p=3; return 0; }",
        error,
    )
    add(
        "escaping_local_dereference",
        "c_safety",
        "int *f(void) { int x=7; return &x; } int sample(void) /*@ Require emp Ensure emp */ { int *p=f(); return *p; }",
        error,
    )
    add(
        "one_past_array_read",
        "c_safety",
        '#include "verification_list.h"\nint sample(int *p) /*@ Require IntArray::full(p,1,cons(3,nil)) Ensure emp */ { return p[1]; }',
        error,
    )
    bad_safety = {
        "overall": "UNKNOWN",
        "precondition": "SAT",
        "safety": "UNKNOWN",
        "negative": True,
        "negative_kind": "safety_checker_wit",
    }
    for name, body in [
        ("division_by_zero", "int x=1; int y=0; return x/y;"),
        ("remainder_by_zero", "int x=1; int y=0; return x%y;"),
        ("signed_add_overflow", "int x=2147483647; return x+1;"),
        ("signed_sub_overflow", "int x=-2147483647; x--; return x-1;"),
        ("signed_mul_overflow", "int x=1073741824; return x*2;"),
        ("signed_div_overflow", "int x=-2147483647; x--; return x/(-1);"),
        ("negative_shift", "int n=-1; return 1<<n;"),
        ("width_shift", "int n=32; return 1<<n;"),
    ]:
        add(
            name,
            "c_safety",
            "int sample(void) /*@ Require emp Ensure emp */ { " + body + " }",
            error if name == "negative_shift" else bad_safety,
        )
    return checks
