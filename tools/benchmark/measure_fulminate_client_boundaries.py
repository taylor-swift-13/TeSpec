"""Check internal contracts of the frozen array and allocation client comparisons."""

import argparse
import re
from collections import Counter
from pathlib import Path
import json

from cn_toolchain import CN, ROOT, installed_identity
from measure_fulminate_companions import (
    COMPILER,
    SHARED,
    UPSTREAM,
    RESULTS,
    diagnostic,
    executable,
    load,
    measured,
    relative,
    sha,
    short_metric,
    text_hash,
)


def functions(source):
    # All client fixture bodies are nonnested top-level straight-line C routines.
    pattern = r"(?m)^(?P<signature>(?:unsigned\s+)?(?:void|int)\s*[*\s]*?(?P<name>\w+)\s*\([^()]*\))\s*(?P<contract>/\*@[\s\S]*?\*/)\s*(?P<tail>[;{])"
    result = []
    for match in re.finditer(pattern, source):
        declaration = match["tail"] == ";"
        body = "" if declaration else source[match.end() : source.index("}", match.end())]
        result.append(
            {
                "name": match["name"],
                "signature": match["signature"],
                "contract": match["contract"],
                "body": body,
                "extern": declaration,
            }
        )
    return result


def assert_literal(formula):
    # Preserve variable and constant equalities, including a tautology when present in QCP.
    if not re.fullmatch(r"(?:\w+\s*==\s*(?:\w+|\d+))(?:\s*&&\s*(?:\w+\s*==\s*(?:\w+|\d+)))*", formula):
        raise ValueError(formula)
    return "/*@ assert (" + formula + "); @*/"


def translated_runtime(g, source):
    signed = g == "runtime-extras__bad_free"
    typ = "int" if signed else "unsigned int"
    preamble = (
        "#ifndef CN_UTILS\n#include <stdlib.h>\nvoid *cn_malloc(unsigned long);\n"
        "void cn_free_sized(void *,unsigned long);\n#endif\n"
    )
    parts = [preamble]
    probes = []
    inventory = []
    annotations = []
    for f in functions(source):
        n = f["name"]
        c = f["contract"]
        pattern = re.sub(r"\s+", " ", c.removeprefix("/*@").removesuffix("*/")).strip()
        inventory.append(
            {"function": n, "qcp_contract": pattern, "kind": "external" if f["extern"] else "body"}
        )
        if n == "cn_malloc":
            sz = "n" if " n)" in f["signature"] else "size"
            if "undef_data_at(__return," + typ + ")" not in c or "__return != 0" not in c:
                raise ValueError(pattern)
            parts.append(
                f"void *checked_alloc(unsigned long {sz})\n"
                f"/*@ requires {sz} == 4; ensures take b = Block<{typ}>(return); !is_null(return); @*/\n"
                f"{{ return cn_malloc({sz}); }}\n"
            )
            continue
        if n == "cn_free_sized":
            sz = "n" if " n)" in f["signature"] else "size"
            if "undef_data_at(p," + typ + ")" not in c or "Ensure emp" not in c:
                raise ValueError(pattern)
            parts.append(
                f"void checked_free(void *p,unsigned long {sz})\n"
                f"/*@ requires {sz} == 4; take b = Block<{typ}>(p); ensures true; @*/\n"
                f"{{ cn_free_sized(p,{sz}); }}\n"
            )
            continue
        if n == "malloc_int":
            if pattern != "Require emp Ensure undef_data_at(__return,int)":
                raise ValueError(pattern)
            contract = "requires true; ensures take b=Block<int>(return);"
        elif n == "bad_free":
            if pattern != "Require emp Ensure emp":
                raise ValueError(pattern)
            contract = "requires true; ensures true;"
        elif n in ("get", "deref", "read_and_free", "leaky_get"):
            value = re.fullmatch(
                r"With (\w+) Require data_at\(p,unsigned int,\1\) Ensure __return == \1 && (emp|data_at\(p,unsigned int,\1\))",
                pattern,
            )
            if not value:
                raise ValueError(pattern)
            contract = "requires take before=Owned<unsigned int>(p); ensures "
            if value[2] != "emp":
                contract += "take after=Owned<unsigned int>(p); after==before; "
            contract += "return==before;"
        elif n == "mkref":
            if (
                "0 <= v && v <= 4294967295 && x == v && emp Ensure data_at(__return,unsigned int,v)"
                not in pattern
            ):
                raise ValueError(pattern)
            contract = (
                "requires 0 <= x; x <= 4294967295; ensures take after=Owned<unsigned int>(return); after==x;"
            )
        elif n == "bad":
            if (
                pattern
                != "With v Require data_at(p,unsigned int,v) Ensure data_at(p,unsigned int,v) * data_at(__return,unsigned int*,p)"
            ):
                raise ValueError(pattern)
            contract = (
                "requires take before=Owned<unsigned int>(p); ensures take after=Owned<unsigned int>(p); "
                "take pointer_slot=Owned<unsigned int*>(return); after==before; ptr_eq(pointer_slot,p);"
            )
        elif n == "main":
            if pattern not in ("Require emp Ensure emp", "Require emp Ensure __return == 0 && emp"):
                raise ValueError(pattern)
            contract = "requires true; ensures " + ("return == 0;" if "__return" in c else "true;")
        else:
            raise ValueError(n)

        def assertion(match):
            formula = match[1].strip()
            if "data_at(&x,unsigned int*,x)" in formula:
                # These are additive && on distinct singleton heaps, not separating *. Mapping separately would be unsound.
                annotations.append({"qcp": formula, "kind": "additive_conjunction_on_distinct_stack_cells"})
                # Emit the explicitly labeled atom-level projection for diagnostics. Retain the exact resource conjunction as unmatched.
                probes.append(
                    "void check_stack_atoms(unsigned int **xp,unsigned int *rp,unsigned int *x,unsigned int res)\n"
                    "/*@ requires take x1=RW<unsigned int*>(xp); take r1=RW<unsigned int>(rp); "
                    "ptr_eq(x1,x); r1==res; res==5; ensures take x2=RW<unsigned int*>(xp); "
                    "take r2=RW<unsigned int>(rp); ptr_eq(x1,x2); r1==r2; @*/ {}\n"
                )
                return "check_stack_atoms(&x,&res,x,res);"
            if "data_at(" in formula:
                if formula not in ("x == 5 && data_at(p,unsigned int,5)", "data_at(p,unsigned int,5)"):
                    raise ValueError(formula)
                probes.append(
                    "void check_cell(unsigned int *p,unsigned int x)\n"
                    "/*@ requires take before=RW<unsigned int>(p); before==5; x==5; "
                    "ensures take after=RW<unsigned int>(p); after==before; @*/ {}\n"
                )
                annotations.append({"qcp": formula, "kind": "typed_cell_transfer"})
                return "check_cell(p," + ("x" if formula.startswith("x ==") else "5") + ");"
            annotations.append({"qcp": formula, "kind": "pure"})
            if " x == x" in formula:
                return "/*@ assert (" + formula.replace("x == x", "ptr_eq(x,x)") + "); @*/"
            return assert_literal(formula)

        body = re.sub(r"/\*@\s*Assert\s+([\s\S]*?)\s*\*/", assertion, f["body"])
        body = re.sub(r"\bcn_malloc\b", "checked_alloc", body)
        body = re.sub(r"\bcn_free_sized\b", "checked_free", body)
        sig = f["signature"].replace("main()", "boundary_client(void)")
        parts.append(sig + "\n/*@ " + contract + " @*/\n{" + body + "}\n")
    if not any(x["function"] == "main" for x in inventory):
        raise ValueError("missing main")
    return (
        "\n".join([parts[0], *probes, *parts[1:]]) + "int main(void) { return boundary_client(); }\n",
        inventory,
        annotations,
    )


CONSTANT_LIST = "cons(0,cons(1,cons(2,nil)))"
INT_LOCALS = ("zero", "one", "two")
PTR_LOCALS = ("first", "second", "third")


def array_boundary(k, formula):
    compact = re.sub(r"\s+", "", formula)
    compact = compact.replace(CONSTANT_LIST, "LIST")
    # Separate only the syntactic spatial star (not multiplication or pointer types).
    atoms = re.split(r"&&|(?<=\))\*(?=(?:data_at|IntArray))", compact)
    params = {"base": ("int *", "a")}
    pre = []
    post = []
    descriptions = []

    def local(name):
        if name in INT_LOCALS + PTR_LOCALS:
            params[name] = ("int *" if name in PTR_LOCALS else "int", name)
        return name

    def cell(name, ctype, address, value):
        pre.append(f"take before_{name}=RW<{ctype}>({address});")
        eq = f"ptr_eq(before_{name},{value})" if ctype.endswith("*") else f"before_{name}=={value}"
        pre.append(eq + ";")
        post.append(f"take after_{name}=RW<{ctype}>({address});")
        eq = f"ptr_eq(before_{name},after_{name})" if ctype.endswith("*") else f"before_{name}==after_{name}"
        post.append(eq + ";")

    for item in atoms:
        m = re.fullmatch(r"IntArray::full\(&?a,3,LIST\)", item)
        if m:
            for n in range(3):
                cell("cell" + str(n), "int", f"array_shift<int>(base,{n})", n)
            descriptions.append("full three-cell ownership and contents")
            continue
        m = re.fullmatch(r"IntArray::missing_i\(a,([012]),0,3,LIST\)", item)
        if m:
            hole = int(m[1])
            for n in range(3):
                if n != hole:
                    cell("cell" + str(n), "int", f"array_shift<int>(base,{n})", n)
            descriptions.append("separately owned two cells outside hole " + str(hole))
            continue
        m = re.fullmatch(r"data_at\((&?)(\w+),(int\*?),(\w+)\)", item)
        if m:
            amp, name, ty, value = m.groups()
            if amp:
                param = "address_" + name
                params[param] = (ty + " *", "&" + name)
            else:
                param = local(name)
            cell("local_" + name, ty, param, local(value))
            descriptions.append("typed ownership " + item)
            continue
        q = re.fullmatch(r"Znth\(([012]),LIST,0\)==([012])", item)
        if q:
            pre.append(f"{q[1]}=={q[2]};")
            descriptions.append("literal Znth on three fixed cells")
            continue
        m = re.fullmatch(r"(\w+)==(.*)", item)
        if not m:
            raise ValueError(item)
        left, r = m.groups()
        typ = left in PTR_LOCALS or left == "a"
        lhs = "base" if left == "a" else local(left)
        if not typ:
            if not (r.isdigit() or r in INT_LOCALS):
                raise ValueError(item)
            pre.append(lhs + "==" + local(r) + ";")
        else:
            if r in ("a", "a0", "(&a)", "(int*)&a"):
                rhs = "base"
            elif r == left:
                rhs = local(r)
            elif r.startswith("a0+") and r[3:] in ("4", "8"):
                rhs = f"array_shift<char>(base,{r[3:]})"
            else:
                offset = re.fullmatch(r"\(\(int\*\)&a\+([12])\)", r)
                if not offset:
                    raise ValueError(item)
                rhs = f"array_shift<int>(base,{offset[1]})"
            pre.append(f"ptr_eq({lhs},{rhs});")
        descriptions.append(item)
    name = "array_assert_" + str(k)
    # Pointer spelling can end with '*' but scalar C type needs a separating space.
    formals = ",".join(ty + " " + arg for arg, (ty, _) in params.items())
    calls = ",".join(expr for _, expr in params.values())
    fn = (
        "void "
        + name
        + "("
        + formals
        + ") /*@ requires "
        + " ".join(pre)
        + " ensures "
        + " ".join(post)
        + " @*/ {}\n"
    )
    return fn, name + "(" + calls + ");", descriptions


def translated_array(row, source):
    main = row["function"]
    pos = source.index("int " + main + "(")
    start = source.index("{", source.index("*/", pos))
    header = source[pos:start]
    body = source[start + 1 : source.rindex("}")]
    if main == "verify_main" and re.search(r"\ba\s*=(?!=)", re.sub(r"/\*.*?\*/", "", body, flags=re.S)):
        raise ValueError("entry pointer a0 cannot be replaced by a after assignment")
    weak = "Ensure exists l2" in source[:pos]
    req = (
        "/*@ requires take before=each(integer j; 0<=j && j<n) { RW<int>(array_shift<int>(p,j)) }; "
        "0<=i && i<n; ensures take after=each(integer j; 0<=j && j<n) { RW<int>(array_shift<int>(p,j)) }; "
    )
    if not weak:
        req += "before==after; return==before[i];"
    helper = "int array_read(int *p,int n,int i)\n" + req + " @*/ { return p[i]; }\n"
    if main == "verify_main":
        pre = (
            "requires take before=each(integer j; 0<=j && j<3){RW<int>(array_shift<int>(a,j))}; "
            "before[0]==0; before[1]==1; before[2]==2; ensures take after=each(integer j; 0<=j && j<3)"
            "{RW<int>(array_shift<int>(a,j))}; before==after; return==0;"
        )
        signature = "int boundary_client(int *a)"
        wrapper = "int main(void){int a[3]={0,1,2}; return boundary_client(a);}\n"
    else:
        pre = "requires true; ensures return==0;"
        signature = "int boundary_client(void)"
        wrapper = "int main(void){return boundary_client();}\n"
    probes = []
    inventory = []

    def statement(m):
        formula = m[1].strip()
        fn, call, components = array_boundary(len(probes), formula)
        probes.append(fn)
        inventory.append(
            {"qcp": formula, "kind": "spatial_atoms_checked_together", "translated_atoms": components}
        )
        return call

    body = re.sub(r"/\*@\s*Assert\s+([\s\S]*?)\s*\*/", statement, body)
    # An explicit QCP 'where l=...' binds the helper's input list. Check its actual three-cell contents before that call.
    where = re.compile(
        r"(?m)^([ \t]*)(int (?:zero|one|two)\s*=\s*read\([^\n;]+?\))\s*/\*@\s*where l\s*=\s*cons\(0,cons\(1,cons\(2,nil\)\)\)\s*\*/;"
    )
    if "where" in body:
        fn, call, _ = array_boundary(6, "IntArray::full(a,3," + CONSTANT_LIST + ")")
        probes.append(fn)
        body, n = where.subn(lambda m: m[1] + call + "\n" + m[1] + m[2] + ";", body)
        if n != 3:
            raise ValueError("unsupported explicit list witness")
    body = re.sub(r"\bread\s*\(", "array_read(", body)
    if "/*@" in body or len(inventory) != 6:
        raise ValueError("untranslated client annotation")
    return (
        helper + "".join(probes) + signature + " /*@ " + pre + " @*/ {" + body + "}\n" + wrapper,
        [
            {
                "function": "read",
                "contract": "weak existential output array" if weak else "same contents and indexed return",
            },
            {"function": main, "qcp_contract": header[header.index("/*@") :].strip()},
        ],
        inventory,
    )


def repair_development_costs(earlier_root, out):
    original = load(RESULTS / "fulminate-contract-companions.json")
    pending = [r for r in original["earlier_attempts"]["measurements"] if r["wall_seconds"] is None]
    rows = []
    for entry in pending:
        stage = entry["stage"]
        matches = []
        for path in earlier_root.glob("*/" + entry["group"] + "/" + entry["case"]):
            source = path / "subject.c"
            stdout = path / (stage + ".stdout")
            stderr = path / (stage + ".stderr")
            if (
                not (path / "receipt.json").exists()
                and source.is_file()
                and sha(source) == entry["source_sha256"]
                and stdout.is_file()
                and sha(stdout) == entry["stdout_sha256"]
                and sha(stderr) == entry["stderr_sha256"]
                and load(path / (stage + ".time.json"))["max_process_rss_kib"] == entry["max_process_rss_kib"]
            ):
                matches.append(path)
        if len(matches) != 1:
            raise ValueError(f"ambiguous or missing original command coordinates: {entry}")
        (path,) = matches
        new = out / str(len(rows))
        new.mkdir(parents=True)
        if stage == "test":
            exe = executable(path / "generated")
            command = [str(exe)]
            checked_object = {"binary_sha256": sha(exe), "same_binary": True}
        elif stage == "pipeline":
            source = new / "subject.c"
            source.write_bytes((path / "subject.c").read_bytes())
            gen = new / "generated"
            gen.mkdir()
            if entry["group"] in ("dll_add", "dll_remove"):
                cc = COMPILER if entry["group"] == "dll_remove" else SHARED / "gcc-with-runtime.sh"
                inc = [SHARED / "Dbl_Linked_List", UPSTREAM]
            else:
                cc = ROOT / "tools/benchmark/gcc-no-builtins.sh"
                inc = [ROOT / "arxiv/fulminate-cn/src/examples/runtime-extras"]
            command = [
                str(CN),
                "instrument",
                "--run",
                "--cc=" + str(cc),
                "--output-dir=" + str(gen),
                *("-I" + str(i) for i in inc),
                str(source),
            ]
            checked_object = {
                "subject_sha256": sha(source),
                "same_source": True,
                "argv_template": [
                    p.replace(str(new), "{work}").replace(str(ROOT) + "/", "{repo}/") for p in command
                ],
            }
        else:
            raise ValueError(stage)
        actual = measured(command, new, stage, prefix_id(entry))
        rows.append(
            {
                "original": {
                    k: entry[k]
                    for k in ("group", "case", "source_sha256", "stage", "stdout_sha256", "stderr_sha256")
                },
                "original_wall_seconds": None,
                "recheck": short_metric(actual),
                **checked_object,
            }
        )
    return rows


def prefix_id(row):
    return row["group"] + "/" + row["case"] + "/" + row["stage"]


def checked_functions(unit, names):
    code = unit.read_text()
    result = {}
    spans = []
    for name in sorted(names):
        pattern = (
            r"(?m)^(?:(?:unsigned\s+)?(?:int|void)\s*[*\s]*)"
            + re.escape(name)
            + r"\s*\([^;\n]*\)\s*(?:/\*@[\s\S]*?\*/\s*)?\{"
        )
        match = re.search(pattern, code)
        if not match:
            raise ValueError("missing generated function: " + name)
        spans.append((match.start(), name))
    spans.sort()
    for i, (start, name) in enumerate(spans):
        body = code[start : spans[i + 1][0] if i + 1 < len(spans) else len(code)]
        pre = "/* EXECUTABLE CN PRECONDITION */"
        post = "/* EXECUTABLE CN POSTCONDITION */"
        if pre not in body or post not in body:
            raise ValueError("missing generated check: " + name)
        if name != "main" and "cn_postcondition_leak_check();" not in body:
            raise ValueError("missing exit ownership check in " + name)
        result[name] = {
            "entry": True,
            "exit": True,
            "has_statement_check": "STATEMENT);" in body,
            "runtime_pre_assertions": len(re.findall(r"cn_assert\(.*?, PRE\);", body)),
        }
    return result


def measured_client(group, case_id, source, work, saved, inventory, saved_tests):
    g = work / group / case_id
    if group == "array_load":
        names = {"array_read", "boundary_client", "main", *("array_assert_" + str(i) for i in range(6))}
        if "void array_assert_6(" in source:
            names.add("array_assert_6")
    else:
        aliases = {"cn_malloc": "checked_alloc", "cn_free_sized": "checked_free", "main": "boundary_client"}
        names = {"main", *(aliases.get(f["function"], f["function"]) for f in inventory)}
        for name in ("check_stack_atoms", "check_cell"):
            if "void " + name + "(" in source:
                names.add(name)
    digest = text_hash(source)
    key = (group, case_id, digest)
    if key in saved:
        directory, stage = saved[key]
        gen = directory / "generated"
    else:
        if saved_tests:
            raise ValueError(f"missing exact saved pipeline for {key}; cannot validate saved tests")
        g.mkdir(parents=True, exist_ok=False)
        directory = g
        subject = g / "subject.c"
        subject.write_text(source)
        gen = g / "generated"
        gen.mkdir()
        command = [
            str(CN),
            "instrument",
            "--run",
            "--cc=" + str(ROOT / "tools/benchmark/gcc-no-builtins.sh"),
            "--output-dir=" + str(gen),
            str(subject),
        ]
        stage = measured(command, g, "pipeline", "pipeline")
        (g / "build.json").write_text(json.dumps(stage))
    g.mkdir(parents=True, exist_ok=True)
    (unit,) = gen.glob("*.exec.c")
    binary = executable(gen)
    checks = checked_functions(unit, names)
    tested_binary = binary
    tested_unit = unit
    tested_origin = directory
    if saved_tests:
        g = saved_tests / group / case_id
        run = load(g / "test-receipt.json")
        if len(run["command"]) != 1:
            raise ValueError("unexpected saved standalone command")
        tested_binary = Path(run["command"][0])
        tested_origin = tested_binary.parent.parent
        if sha(tested_origin / "subject.c") != digest:
            raise ValueError("standalone ELF was built from different C")
        (tested_unit,) = tested_binary.parent.glob("*.exec.c")
        if checked_functions(tested_unit, names) != checks:
            raise ValueError("standalone generated obligations differ")
        if (tested_origin.parent.name, tested_origin.name, digest) not in saved:
            raise ValueError("unidentified standalone build origin")
        for stream in ("stderr", "stdout"):
            if sha(g / ("test." + stream)) != run[stream + "_sha256"]:
                raise ValueError("changed standalone test diagnostics")
    else:
        run = measured([str(binary)], g, "test", "test")
        (g / "test-receipt.json").write_text(json.dumps(run))
    code = run["exit_code"]
    failure = diagnostic(g, "test") if code else None
    if code and not ("Failed at" in failure or "failed." in failure.lower()):
        raise ValueError("unattributed runtime exit on " + group + "/" + case_id + ": " + str(failure))
    record = {
        "source_sha256": digest,
        "pipeline_binding": {
            "group": group,
            "case": case_id,
            "subject_sha256": digest,
            "generated_sha256": sha(unit),
            "elf_sha256": sha(binary),
            "receipt_sha256": sha(directory / "build.json"),
        },
        "standalone_binding": {
            "built_group": tested_origin.parent.name,
            "built_case": tested_origin.name,
            "subject_sha256": digest,
            "generated_sha256": sha(tested_unit),
            "elf_sha256": sha(tested_binary),
            "receipt_sha256": sha(g / "test-receipt.json"),
        },
        "generated_sha256": sha(unit),
        "elf_sha256": sha(binary),
        "pipeline": short_metric(stage),
        "test": short_metric(run),
        "status": "FAIL" if code else "PASS",
        "diagnostic": failure,
        "instrumented_functions": checks,
        "branch_counters": None,
        "branch_scope": "Fulminate does not emit teSpec branch-query counters.",
    }

    if tested_origin.resolve() != directory.resolve():
        prior = load(tested_origin / "build.json")
        record["previous_source_only_pipeline_attribution"] = {
            "source_group": tested_origin.parent.name,
            "source_case": tested_origin.name,
            "previous_metric": short_metric(prior),
            "previous_receipt_sha256": sha(tested_origin / "build.json"),
            "correction": "The original source-only merge charged the other build on this row. The pipeline and standalone bindings identify their own original ELF and measurement.",
        }
    return record


def prior_cost_fingerprint(entry):
    return tuple(
        entry[k] for k in ("group", "case", "source_sha256", "stage", "stdout_sha256", "stderr_sha256")
    )


def main():
    from tempfile import TemporaryDirectory
    from organize_tespec_routes import inputs, make_test_job

    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--work", required=True, type=Path, help="empty directory for generated checks and execution costs"
    )
    parser.add_argument(
        "--saved-pipelines",
        action="append",
        type=Path,
        default=[],
        help="resume checked builds and run their binaries",
    )
    parser.add_argument(
        "--earlier-work", type=Path, help="source/ELF scratch for the original seven diagnostic stages"
    )
    parser.add_argument(
        "--prior-cost-receipt",
        type=Path,
        help="retain the matched repeated diagnostic timings already measured",
    )
    parser.add_argument(
        "--saved-tests", type=Path, help="revalidate real standalone receipts for the exact same executable"
    )
    parser.add_argument(
        "--early-validation",
        type=Path,
        action="append",
        default=[],
        help="earlier inspection rounds whose full stage observation was interrupted",
    )
    parser.add_argument("--output", type=Path, required=True)
    args = parser.parse_args()
    work = args.work.resolve()
    work.mkdir(parents=True, exist_ok=True)
    if any(work.iterdir()):
        parser.error("--work must be empty")
    if args.saved_tests and not args.saved_pipelines:
        parser.error("--saved-tests requires its original --saved-pipelines")
    if args.earlier_work and args.prior_cost_receipt:
        parser.error("choose one source of prior cost records")
    installed_identity()
    parent = RESULTS / "fulminate-contract-companions.json"
    source_index = load(parent)
    saved = {}
    for folder in args.saved_pipelines:
        for path in folder.glob("*/*/build.json"):
            stage = load(path)
            src = path.parent / "subject.c"
            if stage["command"][0] != str(CN) or Path(stage["command"][-1]).resolve() != src.resolve():
                raise ValueError("resumed command does not match fixed compiler/source")
            for stream in ("stdout", "stderr"):
                if sha(path.parent / ("pipeline." + stream)) != stage[stream + "_sha256"]:
                    raise ValueError("changed build log")
            key = (path.parent.parent.name, path.parent.name, sha(src))
            if key in saved:
                raise ValueError(f"ambiguous saved cold build for {key}")
            saved[key] = (path.parent, stage)
    cohort = [
        r
        for r in source_index["rows"]
        if r["profile"] in ("array_client_entry_exit", "lifted_array_client", "runtime_client_entry_exit")
    ]
    if len(cohort) != 22:
        raise ValueError("expected all 22 previously qualified client inputs")
    results = []
    plans = {}
    with TemporaryDirectory() as tmp:
        temp = Path(tmp)
        for r in cohort:
            group = r["group"]
            case = r["case"]
            variant = r["qcp_variant"]
            if group not in plans:
                plans[group] = inputs(group)[0]
            declared = source_index["groups"][group]["sources"][variant]["qcp"]
            source_path = ROOT / declared["path"]
            if sha(source_path) != declared["sha256"]:
                raise ValueError("different QCP source")
            policy = {}
            for mode in ("inline", "modular"):
                key = variant, case, mode
                job, _, executed, _ = make_test_job((key, plans[group][key]), temp)
                config = load(job)["qcp"]
                if (
                    sha(executed) != declared["sha256"]
                    or config["vc_scope"] != "all-boundaries"
                    or config["execution"] != mode
                ):
                    raise ValueError("unexpected source or VC scope")
                policy[mode] = {
                    "vc_scope": config["vc_scope"],
                    "strategy": config["execution"],
                    "native_report_sha256": r["strategies"][mode]["native_report_sha256"],
                    "auto": r["strategies"][mode]["auto"],
                    "expected": r["strategies"][mode]["expected"],
                }
            if group == "array_load":
                source, inventory, annotations = translated_array(r, source_path.read_text())
                scope = "concrete_spatial_atoms_and_separating_ownership"
                reason = (
                    "Every QCP assertion runs a read-only procedure requiring its listed cells jointly, indexed values and pure checks. "
                    "Callee resource transfer admits unrelated framed storage. This does not establish absence of all other cells in the symbolic stack heap."
                )
                if "weak" in inventory[0]["contract"]:
                    reason += " The concrete array read returns the actual element; the weak modular helper post also permits other output maps and return values."
            else:
                source, inventory, annotations = translated_runtime(group, source_path.read_text())
                kinds = {a["kind"] for a in annotations}
                if "additive_conjunction_on_distinct_stack_cells" in kinds:
                    scope = "stack_atoms_only"
                    reason = (
                        "The QCP source uses additive && on two distinct local data_at predicates. "
                        "The CN probe demonstrates simultaneous availability on two disjoint concrete cells. "
                        "The frozen inline residual requires TT && emp |-- (&res_spec_402) # UInt |-> 5; successful execution cannot discharge that entailment."
                    )
                elif "typed_cell_transfer" in kinds:
                    scope = "concrete_spatial_atoms_and_separating_ownership"
                    reason = (
                        "The typed initialized cell and required value are checked inside a restoring CN transfer. "
                        "Testing availability of that concrete cell permits unmentioned frame resources; full equality of the ambient logical heaps is not certified."
                    )
                else:
                    scope = "source_contracts_and_all_explicit_assertions"
                    reason = (
                        "The QCP C bodies, ordinary helper contracts and all explicit statement assertions are carried over. "
                        "Non-null allocation, four-byte size, uninitialized storage transfer and deallocation ownership are checked at the external API boundary. "
                        "Inputs use the repository ABI and concrete allocator. A single Fulminate run does not quantify over permitted modular callee results."
                    )
            original = source_index["groups"][group]["sources"][r["cn_variant"]]["cn"]
            cn_text = (ROOT / original["path"]).read_text()
            original_main = re.split(r"\bint\s+main\s*\(", cn_text, maxsplit=1)[-1]
            old_asserts = re.findall(r"/\*@\s*assert\s*(.*?)\s*;?\s*@?\*/", original_main, flags=re.S)
            receipt = measured_client(group, case, source, work, saved, inventory, args.saved_tests)
            results.append(
                {
                    "group": group,
                    "case": case,
                    "cn_variant": r["cn_variant"],
                    "qcp_variant": variant,
                    "qcp_sha256": declared["sha256"],
                    "developer_source_cn_sha256": original["sha256"],
                    "original_cn_main_assertions": old_asserts,
                    "strategies": policy,
                    "contracts": inventory,
                    "assertions": annotations,
                    "comparison_scope": scope,
                    "qualification": reason,
                    "fulminate": receipt,
                }
            )
    for row in results:
        if row["comparison_scope"] != "stack_atoms_only":
            continue
        current = load(RESULTS / row["group"] / "tespec/current-executions.json")
        (subject,) = [
            r
            for r in current["executions"]
            if r["variant"] == row["qcp_variant"] and r["case"] == row["case"] and r["strategy"] == "inline"
        ]
        goal = RESULTS / row["group"] / "tespec/proof-objects" / subject["goal_sha256"] / "Goal.v"
        obligation = "main_entail_wit_1_split_goal_spatial"
        definition = re.search(r"Definition " + obligation + r" :=[\s\S]*?\n\.", goal.read_text())
        if (
            not definition
            or sha(goal) != subject["goal_sha256"]
            or "TT && emp" not in definition[0]
            or "res_spec_402" not in definition[0]
        ):
            raise ValueError("the cited original assertion VC has changed")
        row["frozen_stack_vc"] = {
            "path": relative(goal),
            "sha256": sha(goal),
            "definition": obligation,
            "text": definition[0],
        }
    earlier = []
    if args.earlier_work:
        earlier = repair_development_costs(args.earlier_work.resolve(), work / "development-rechecks")
    if args.prior_cost_receipt:
        earlier = load(args.prior_cost_receipt)
    if earlier:
        pending = [r for r in source_index["earlier_attempts"]["measurements"] if r["wall_seconds"] is None]
        if Counter(prior_cost_fingerprint(r) for r in pending) != Counter(
            prior_cost_fingerprint(r["original"]) for r in earlier
        ):
            raise ValueError("development rechecks differ from the original missing stages")
        if any(
            r["original_wall_seconds"] is not None
            or r["recheck"]["exit_code"]
            or r["recheck"]["wall_seconds"] <= 0
            or r["recheck"]["max_process_rss_kib"] <= 0
            for r in earlier
        ):
            raise ValueError("invalid development recheck")
    used = {(r["group"], r["case"], r["fulminate"]["source_sha256"]) for r in results}
    superseded = [
        {"source_sha256": key[2], "group": p.parent.name, "case": p.name, "pipeline": short_metric(s)}
        for key, (p, s) in saved.items()
        if key not in used
    ]

    def total(rows):
        return {
            "measurements": len(rows),
            "wall_seconds": sum(q["wall_seconds"] for q in rows),
            "max_process_rss_kib": max((q["max_process_rss_kib"] for q in rows), default=None),
            "tokens": 0,
        }

    earlier_validation = []
    for directory in args.early_validation:
        for timing in sorted(directory.rglob("*.time.json")):
            key = timing.name.removesuffix(".time.json")
            folder = timing.parent
            native = load(timing)
            record = {
                "phase": key,
                "original_wall_seconds": None,
                "observed_cpu_seconds": native["user_seconds"] + native["system_seconds"],
                "original_rss_kib": native["max_process_rss_kib"],
                "tokens": 0,
                "stdout_sha256": sha(folder / (key + ".stdout")),
                "stderr_sha256": sha(folder / (key + ".stderr")),
            }
            if key == "test":
                (result,) = [
                    r for r in results if (r["group"], r["case"]) == (folder.parent.name, folder.name)
                ]
                record.update(
                    compared_group=result["group"],
                    compared_case=result["case"],
                    same_binary_sha256=result["fulminate"]["standalone_binding"]["elf_sha256"],
                    matched_phase="fulminate.test",
                )
            else:
                src_sha = sha(folder / "subject.c")
                possible = [
                    i
                    for i, r in enumerate(earlier)
                    if r["original"]["source_sha256"] == src_sha and r["original"]["stage"] == key
                ]
                if not possible:
                    raise ValueError("earlier validation has no matched measured phase")
                record.update(same_source_sha256=src_sha, matched_development_rechecks=possible)
            earlier_validation.append(record)
    payload = {
        "schema": "fulminate-concrete-client-boundaries/v1",
        "scope": "All 22 previously entry/exit-only client pairs. These are supplementary actual executions. Qualification distinguishes concrete matching of declared predicates from exact symbolic stack and externally chosen poststates.",
        "source_comparison": {"path": relative(parent), "sha256": sha(parent)},
        "generator": {"path": relative(Path(__file__).resolve()), "sha256": sha(Path(__file__).resolve())},
        "dependencies": {
            relative(p): sha(p)
            for p in (
                ROOT / "tools/benchmark/measure_fulminate_companions.py",
                ROOT / "tools/benchmark/cn-toolchain.json",
                ROOT / "tools/benchmark/gcc-no-builtins.sh",
                ROOT / "tools/benchmark/organize_tespec_routes.py",
                ROOT / "runtime/qcip/SeparationLogic/SeparationLogic/ArrayLib.v",
            )
        },
        "counts": {
            "scopes": dict(Counter(r["comparison_scope"] for r in results)),
            "fulminate": dict(Counter(r["fulminate"]["status"] for r in results)),
        },
        "costs": {
            **{k: total([r["fulminate"][k] for r in results]) for k in ("pipeline", "test")},
            "superseded_builds": total([r["pipeline"] for r in superseded]),
            "development_cost_rechecks": total([r["recheck"] for r in earlier]),
        },
        "rows": results,
        "superseded_builds": superseded,
        "earlier_receipt_assembly_checks": earlier_validation,
        "development_cost_rechecks": earlier,
    }
    args.output.write_text(json.dumps(payload, ensure_ascii=False, separators=(",", ":")) + "\n")
    print(payload["counts"], payload["costs"])


if __name__ == "__main__":
    main()
