"""Prepare an ordinary teSpec job whose selected Coq imports use the C target layout."""

import argparse
import hashlib
import json
import os
from pathlib import Path
import re
import shutil
import subprocess
import sys
import tempfile

from .core import (
    JobError,
    _COQ_LOGICAL_NAME,
    _COQ_REQUIRE_RE,
    _QUOTED_INCLUDE_RE,
    _coq_dependency_code,
    _coq_load_path_args,
    _coq_required_modules,
    _stage_source_coq_dependencies,
    _default_coqc_command,
    _parse_bind_cases,
    _parse_qcp_config,
    _relocate_strategy_includes,
    _require_object,
    _resolve,
    _sha256,
    qcp_annotations,
    read_source_text,
    source_with_local_includes,
)
from .errors import FieldLayoutMismatch
from .layout import generate_layout_source, target_layout_digest
from .layout_libraries import elaborate_library
from .layout_guards import candidates, prepare_guards, check_guard_header
from .preflight import export_program_preflight


def rewrite_imports(source, names, *, coq=False):
    """Change exact module tokens in Require commands, including From imports."""
    if coq:
        # Scan masked text, apply spans to the original to preserve all other bytes.
        pattern = _COQ_REQUIRE_RE
        scanned = _coq_dependency_code(source)
    else:
        pattern = re.compile(
            rf"(?P<open>/\*@\s*Import\s+Coq\s+)(?:From\s+(?P<prefix>{_COQ_LOGICAL_NAME})\s+)?"
            rf"Require\s+(?P<mode>(?:Import|Export)\s+)?"
            rf"(?P<modules>{_COQ_LOGICAL_NAME}(?:\s+{_COQ_LOGICAL_NAME})*)\s*\*/"
        )
        matches = (
            pattern.fullmatch(source, token.start(), token.end())
            for token in qcp_annotations(source)
        )
    chunks, pos = [], 0
    for m in pattern.finditer(scanned) if coq else matches:
        if m is None:
            continue
        modules = [
            (m["prefix"] + "." if m["prefix"] else "") + n for n in m["modules"].split()
        ]
        if not any(k in names for k in modules):
            continue
        renamed = " ".join(names.get(n, n) for n in modules)
        if coq:
            mode = re.search(r"\bRequire\s+(?:(Import|Export)\s+)?", m[0]).group(1)
            replacement = "Require " + (mode + " " if mode else "") + renamed + "."
        else:
            replacement = m["open"] + "Require " + (m["mode"] or "") + renamed + " */"
        chunks.extend([source[pos : m.start()], replacement])
        pos = m.end()
    return "".join([*chunks, source[pos:]])


def reject_old_qualifiers(source, names):
    # Coq allows shortened module qualifiers. A reference that still names an
    # old module could resolve through a transitive import of the original.
    qualifiers = {
        ".".join(parts[index:])
        for name in names
        for parts in [name.split(".")]
        for index in range(len(parts))
    }
    alternatives = "|".join(re.escape(name) for name in sorted(qualifiers))
    if re.search(
        rf"(?<![\w.'])(?:{alternatives})\.[^\W\d]",
        _coq_dependency_code(source),
    ):
        raise FieldLayoutMismatch(
            "qualified reference to an original field layout module"
        )


def stage_frontend(source, roots, output, names):
    """Copy the include chain leading to a changed annotation; reuse other headers."""
    source = source.resolve()
    files, includes, changed = {}, {}, {source}
    pending = [source]
    while pending:
        path = pending.pop()
        if path in files:
            continue
        if len(files) >= 512:
            raise JobError("layout job exceeds the frontend include limit")
        original = read_source_text(path)
        files[path] = rewrite_imports(original, names)
        if files[path] != original:
            changed.add(path)
        includes[path] = {}
        for match in _QUOTED_INCLUDE_RE.finditer(original):
            relative = Path(match["path"])
            target = next(
                (
                    d / relative
                    for d in (path.parent, *roots)
                    if (d / relative).is_file()
                ),
                None,
            )
            if target:
                includes[path][match["path"]] = target.resolve()
                pending.append(target.resolve())

    # Propagate changes to includers, including cycles with header guards.
    while True:
        parents = {
            p for p, edges in includes.items() if changed.intersection(edges.values())
        }
        if parents <= changed:
            break
        changed.update(parents)
    locations = {
        p: output / hashlib.sha256(str(p).encode()).hexdigest()[:20] / p.name
        for p in changed
    }
    for path, dest in locations.items():

        def include(m):
            target = includes[path].get(m["path"])
            if target is None:
                return m[0]
            return (
                m[0][: m.start("path") - m.start()]
                + str(locations.get(target, target))
                + '"'
            )

        text = _QUOTED_INCLUDE_RE.sub(include, files[path])
        if re.search(
            r"\b(?:__FILE__|__BASE_FILE__|__FILE_NAME__)\b|^\s*#\s*include_next\b",
            text,
            re.M,
        ):
            raise JobError(
                "layout staging cannot preserve a path-sensitive source: " + str(path)
            )
        dest.parent.mkdir(parents=True, exist_ok=True)
        dest.write_text(_relocate_strategy_includes(text, path))
    return locations[source]


def _prepare_libraries(inventory, modules, layout, depdir, build, runtime, compiler):
    sources = {}
    imports = {}
    for name, dep in inventory.items():
        raw = Path(dep["source"]).read_bytes()
        if hashlib.sha256(raw).hexdigest() != dep["sha256"]:
            raise JobError("Coq source changed during preparation: " + name)
        sources[name] = raw.decode("utf-8")
        imports[name] = set(_coq_required_modules(sources[name]))
    affected = set(modules)
    while True:
        users = {name for name, required in imports.items() if affected & required}
        if users <= affected:
            break
        affected.update(users)
    names = {
        name: "TeSpecLayout_"
        + hashlib.sha256(
            (
                name
                + ":"
                + inventory[name]["sha256"]
                + ":"
                + target_layout_digest(layout)
            ).encode()
        ).hexdigest()[:24]
        for name in affected
    }
    depdir.mkdir(parents=True)
    records = []
    (depdir / "GeneratedLayout.v").write_text(generate_layout_source(layout))
    shutil.copyfile(
        Path(__file__).resolve().parents[1] / "runtime/tespec/LayoutAddress.v",
        depdir / "LayoutAddress.v",
    )
    pending = {}
    for name, dep in inventory.items():
        text = sources[name]
        if name in names:
            text = rewrite_imports(text, names, coq=True)
            reject_old_qualifiers(text, names)
            if name in modules:
                rules = set(
                    re.findall(
                        r"(?m)^\s*Import\s+(naive_C_Rules(?:64)?)\s*\.",
                        _coq_dependency_code(text),
                    )
                )
                if rules - {layout.get("memory_rules")}:
                    raise JobError(
                        "predicate library and target use different memory rules: "
                        + name
                    )
                text = elaborate_library(text, check_address_aliases=True)
        elif "staged" not in dep:
            continue
        module = names.get(name, name)
        dest = depdir / Path(*module.split(".")).with_suffix(".v")
        if dest.exists():
            raise JobError("layout dependency name collision: " + module)
        dest.parent.mkdir(parents=True, exist_ok=True)
        dest.write_text(text)
        pending[module] = dest
        records.append(
            {
                "module": name,
                "active_module": module,
                "source_sha256": dep["sha256"],
                "active_sha256": _sha256(dest),
            }
        )
    # Compile complete modules, including their original auxiliary lemmas.
    # Keep build products private and publish only source and the receipt.
    shutil.copytree(depdir, build)
    args = _coq_load_path_args(runtime, build)
    order = ["LayoutAddress", "GeneratedLayout"]
    while pending:
        ready = [
            n
            for n, p in pending.items()
            if not set(_coq_required_modules(p.read_text())) & pending.keys()
        ]
        if not ready:
            raise JobError("cyclic layout library dependency")
        for n in ready:
            order.append(n)
            del pending[n]
    for n in order:
        unit = build / Path(*n.split(".")).with_suffix(".v")
        result = subprocess.run(
            [*compiler, "-q", *args, str(unit)],
            cwd=build,
            capture_output=True,
            text=True,
            timeout=120,
        )
        if result.returncode:
            raise JobError(
                f"layout library compilation failed for {n}: " + result.stderr[-1800:]
            )

    from .opaque_imports import compiled_interface

    interfaces = {}
    for item in records:
        module = item["active_module"]
        if module != item["module"]:
            continue
        interface = compiled_interface(
            module, sources[module], build, [*compiler, "-q", *args]
        )
        if interface:
            interfaces[module] = interface
    return names, records, order, interfaces


def _uses_field_addresses(source):
    """Select field notation in declarations, excluding comments, strings and proofs."""
    code = _coq_dependency_code(source)
    bound = False
    for command in re.split(r"\.(?=\s|$)", code):
        if command.strip() == "Import GeneratedLayout.AddressNotations":
            bound = True
        if not bound and re.match(r"\s*(?:(?:Local|Global|Program)\s+)*(?:Definition|Fixpoint)\s+", command):
            if re.search(r"&\s*\([^;]*?(?:->ₛ|\.ₛ)", command, re.S):
                return True
    return False


def auto_layout_modules(job_path):
    job_path = Path(job_path).resolve()
    job = _require_object(json.loads(job_path.read_text()), "job")
    if "field_layout_context" in job:
        return []
    base = job_path.parent
    source = _resolve(base, job.get("source"), "source")
    config = _parse_qcp_config(job, base, source.parent)
    text = read_source_text(source)
    if job.get("spec_file"):
        from .core import attach_spec_to_source
        text = attach_spec_to_source(text, read_source_text(_resolve(base, job["spec_file"], "spec_file")), job["function"])
    text = source_with_local_includes(source, config.include_dirs, primary_source=text)
    runtime = []
    with tempfile.TemporaryDirectory(prefix="tespec-layout-discovery-") as tmp:
        staged = _stage_source_coq_dependencies(source, source, config.qcip_root, Path(tmp), text, runtime,
                                                include_dirs=config.include_dirs)
        return sorted({d["module"] for d in [*staged, *runtime]
                       if _uses_field_addresses(Path(d["source"]).read_text())})


def prepare_auto_layout(job_path, output):
    job = json.loads(Path(job_path).read_text())
    modules = auto_layout_modules(job_path)
    if not modules:
        return {"status": "prebound" if "field_layout_context" in job else "not_required"}
    compiler = os.environ.get("COQC")
    if compiler:
        command = [compiler]
    elif shutil.which("opam"):
        command = ["opam", "exec", "--switch=qcp-8.20", "--", "coqc"]
    else:
        command = _default_coqc_command()
    receipt = prepare_layout_job(job_path, modules, output, coqc_command=command, project_guards=False)
    return {"status": "bound", "modules": modules, "job": receipt["job"],
            "original_job_sha256": receipt["original_job_sha256"],
            "layout_sha256": receipt["target_layout_sha256"],
            "original_source_sha256": _sha256(_resolve(Path(job_path).resolve().parent, job["source"], "source")),
            "libraries": receipt["libraries"]}


def prepare_layout_job(job_path, modules, output, *, coqc_command=None, project_guards=True):
    job_path, output = Path(job_path).resolve(), Path(output).resolve()
    job = _require_object(json.loads(job_path.read_text()), "job")
    binds = job.get("binds")
    if not isinstance(binds, list) or not binds:
        raise JobError("binds must be a non-empty array")
    first = _parse_bind_cases(binds, job.get("spec"))[0]
    if (
        not modules
        or len(set(modules)) != len(modules)
        or any(not re.fullmatch(_COQ_LOGICAL_NAME, name) for name in modules)
    ):
        raise JobError("select distinct Coq module names")
    if output.exists():
        raise JobError("layout job requires a fresh output directory")
    source = _resolve(job_path.parent, job.get("source"), "source")
    config = _parse_qcp_config(job, job_path.parent, source.parent)
    output.mkdir(parents=True)
    try:
        with tempfile.TemporaryDirectory(prefix="tespec-layout-job-") as tmp:
            base = Path(tmp)
            pre = export_program_preflight(
                job_path, base / "preflight", case_id=first.case_id
            )
            layout = pre["target_layout"]
            inventory = {
                d["module"]: d
                for d in (*pre["coq_dependencies"], *pre["runtime_dependencies"])
            }
            if not set(modules) <= inventory.keys():
                raise JobError(
                    "unresolved selected module: "
                    + ", ".join(sorted(set(modules) - inventory.keys()))
                )
            depdir = output / "dependencies" / "coq"
            compiler = coqc_command or _default_coqc_command()
            names, records, order, interfaces = _prepare_libraries(
                inventory,
                modules,
                layout,
                depdir,
                base / "coq",
                config.qcip_root / "SeparationLogic",
                compiler,
            )

            staged_source = stage_frontend(
                source, config.include_dirs, output / "frontend", names
            )
            new_job = dict(
                job, source=str(staged_source), output_dir=str(output / "run")
            )
            if "spec_file" in job:
                spec = (job_path.parent / job["spec_file"]).resolve()
                new_job["spec_file"] = str(
                    stage_frontend(
                        spec, config.include_dirs, output / "frontend", names
                    )
                )
            new_job["qcp"] = dict(
                job.get("qcp", {}),
                binary=str(config.binary),
                qcip_root=str(config.qcip_root),
                include_dirs=[str(depdir), *map(str, config.include_dirs)],
            )
            new_job["field_layout_context"] = {
                "modules": names,
                "runtime_source_sha256": pre["provenance"]["runtime_source_sha256"],
                "target_layout_sha256": target_layout_digest(layout),
                "dependencies": {
                    n: _sha256(depdir / Path(*n.split(".")).with_suffix(".v"))
                    for n in order
                },
            }
            if interfaces:
                new_job["field_layout_context"]["opaque_imports"] = interfaces
            job_file = output / "job.json"
            proposals = list(
                candidates(
                    source_with_local_includes(staged_source, config.include_dirs),
                    [names[m] for m in modules],
                    base / "coq",
                    layout,
                )
            ) if project_guards else []
            guard_receipt = {"proved": [], "skipped": {}}
            if not project_guards:
                guard_receipt["activation"] = "NOT_REQUESTED"
            if proposals:
                job_file.write_text(json.dumps(new_job))
                active = export_program_preflight(
                    job_file, base / "active-preflight", case_id=first.case_id
                )
                context = new_job["field_layout_context"]
                actual = {d["module"]: d["sha256"] for d in active["coq_dependencies"]}
                if (
                    actual != context["dependencies"]
                    or active["target_layout"] != layout
                    or active["provenance"]["runtime_source_sha256"]
                    != context["runtime_source_sha256"]
                ):
                    raise JobError("prepared projection and execution contexts differ")
                guards, guard_receipt = prepare_guards(
                    proposals, active, base / "coq", output / "guards", compiler
                )
                if guards:
                    context["guard_projection"] = guards
                    job_file.write_text(json.dumps(new_job))
                    try:
                        export_program_preflight(
                            job_file, base / "guard-preflight", case_id=first.case_id
                        )
                    except JobError as error:
                        # Some declared definitions are unavailable in the native
                        # frontend. Keep the ordinary prepared job in that case.
                        del context["guard_projection"]
                        guard_receipt["activation"] = "SKIPPED"
                        guard_receipt["reason"] = str(error)
                    else:
                        guard_receipt["activation"] = "CHECKED"
            receipt = {
                "guard_projection": guard_receipt,
                "interpretation": "target-layout",
                "original_job_sha256": pre["provenance"]["job_sha256"],
                "target_layout_sha256": target_layout_digest(layout),
                "libraries": records,
                "compiled": order,
                "job": str(output / "job.json"),
            }
            if any(
                _sha256(Path(item["path"])) != item["sha256"]
                for item in (
                    *pre["original_inputs"],
                    *pre["frontend_snapshot"]["files"],
                )
            ):
                raise JobError("frontend inputs changed during layout preparation")
            (output / "layout-job.json").write_text(
                json.dumps(receipt, indent=2) + "\n"
            )
            (output / "job.json").write_text(json.dumps(new_job, indent=2) + "\n")
            return receipt
    except BaseException:
        shutil.rmtree(output)
        raise


def validate_layout_context(expected, manifest, runtime_digest, *, incomplete_without_goal=False):
    active = {dep["module"]: dep["sha256"] for dep in manifest["coq_dependencies"]}
    if (
        not isinstance(expected, dict)
        or runtime_digest != expected.get("runtime_source_sha256")
        or target_layout_digest(manifest.get("target_layout"))
        != expected.get("target_layout_sha256")
        or not isinstance(expected.get("dependencies"), dict)
        or not {"LayoutAddress", "GeneratedLayout"} <= expected["dependencies"].keys()
        or not expected["dependencies"].keys() <= active.keys()
        or any(active[n] != sha for n, sha in expected["dependencies"].items())
    ):
        raise FieldLayoutMismatch("execution and prepared field layout context differ")
    selected = expected.get("modules")
    goal = manifest["files"].get("goal")
    if (
        not isinstance(selected, dict)
        or not selected
        or any(
            not isinstance(n, str) or not re.fullmatch(_COQ_LOGICAL_NAME, n)
            for n in selected
        )
        or any(not isinstance(n, str) or n not in active for n in selected.values())
    ):
        raise FieldLayoutMismatch(
            "missing prepared field layout module bindings or goal"
        )
    if not goal:
        if (incomplete_without_goal and "guard_projection" not in expected
                and manifest.get("status") == "not_generated" and manifest.get("residual_goals") == []
                and manifest.get("counterexample_goals") == []):
            return
        raise FieldLayoutMismatch("missing original goal for layout validation")
    sources = {
        d["module"]: Path(d["staged"])
        for d in (
            *manifest["coq_dependencies"],
            *manifest.get("generated_coq_dependencies", []),
        )
    }
    goal_source = Path(goal).read_text()
    if "guard_projection" in expected:
        generated = {
            d["module"]: d["sha256"]
            for d in manifest.get("generated_coq_dependencies", [])
        }
        if generated != expected["guard_projection"].get("generated_modules"):
            raise FieldLayoutMismatch(
                "goal dependencies differ from the checked guard bindings"
            )
        check_guard_header(expected["guard_projection"], goal_source)
    reject_old_qualifiers(goal_source, selected)
    pending = _coq_required_modules(goal_source)
    reachable = set()
    while pending:
        module = pending.pop()
        if module not in reachable:
            reachable.add(module)
            if module in sources:
                source = sources[module].read_text()
                reject_old_qualifiers(source, selected)
                pending.extend(_coq_required_modules(source))
    if not set(selected.values()) <= reachable or selected.keys() & reachable:
        raise FieldLayoutMismatch(
            "generated goal imports a different field layout interpretation"
        )


def layout_job_cli(args):
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("job", type=Path)
    parser.add_argument("--module", dest="modules", action="append", required=True)
    parser.add_argument("--output", type=Path, required=True)
    parser.add_argument("--coqc", help="Coq compiler compatible with the QCP runtime")
    opts = parser.parse_args(args)
    try:
        receipt = prepare_layout_job(
            opts.job,
            opts.modules,
            opts.output,
            coqc_command=[opts.coqc] if opts.coqc else None,
        )
    except (OSError, ValueError, JobError, subprocess.TimeoutExpired) as exc:
        print(str(exc), file=sys.stderr)
        return 2
    print(json.dumps(receipt, indent=2))
    return 0
