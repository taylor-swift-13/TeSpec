"""Independent full-VC replay without trusting generated automatic placeholders.

The automatic executor and its auto/manual classification stay unchanged. This
optional stage asks for proofs of the original VC_Correct module interface.
Its manifest digest must be held by the calling controller, outside proof edits.
"""

from __future__ import annotations

from contextlib import contextmanager
import hashlib
import json
import os
from pathlib import Path
import re
import signal
import sys
import subprocess
from tempfile import TemporaryDirectory
import time

from .core import JobError, _coq_load_path_args, _runtime_coq_module, _coq_required_modules
from .kernel_replay import KernelReplayCache

IDENT = r"[A-Za-z_][A-Za-z0-9_]*"
QUALIFIED = IDENT + r"(?:\." + IDENT + r")*"

# Logical foundations already used by the bundled QCP library. No generated
# proof, domain axiom or arbitrary runtime namespace is implicitly trusted.
TRUSTED_ASSUMPTIONS = {
    "Classical_Prop.classic",
    "FunctionalExtensionality.functional_extensionality_dep",
    "PropExtensionality.propositional_extensionality",
    "CNotation.eval_addr_expr",
    "CNotation.sizeof_struct_type",
    "CNotation.sizeof_union_type",
    "CNotation.sizeof_enum_type",
    "CNotation.sizeof_alias_type",
    "SeparationLogic.field_address",
}

ASSUMPTION_IDENTITIES = {
    name: (
        "SimpleC.SL." + name
        if name.startswith(("CNotation.", "SeparationLogic."))
        else "Coq.Logic." + name
    )
    for name in TRUSTED_ASSUMPTIONS
}


def check_dependency_namespace(module: str, runtime: Path) -> None:
    # A task library may not impersonate a pinned runtime or standard library.
    args = _coq_load_path_args(runtime, Path("."))
    reserved = {"Coq", "Corelib", "Stdlib"}
    reserved.update(
        {"Goal", "Candidate", "Coverage", "Assumptions", "AssumptionIdentities"}
    )
    reserved.update(
        args[i + 2].split(".")[0]
        for i, arg in enumerate(args)
        if arg in {"-R", "-Q"} and args[i + 2]
    )
    if module.split(".")[0] in reserved:
        raise JobError("dependency shadows a trusted library namespace: " + module)


def digest(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def strip_comments(text: str) -> str:
    """Remove nested Coq comments while retaining strings and line positions."""
    result = []
    index = depth = 0
    quoted = False
    while index < len(text):
        if depth:
            if text.startswith("(*", index):
                depth += 1
                index += 2
            elif text.startswith("*)", index):
                depth -= 1
                index += 2
            else:
                result.append("\n" if text[index] == "\n" else " ")
                index += 1
        elif text[index] == '"':
            result.append(text[index])
            index += 1
            if quoted and index < len(text) and text[index] == '"':
                result.append(text[index])
                index += 1
            else:
                quoted = not quoted
        elif not quoted and text.startswith("(*", index):
            result.append(" ")
            depth = 1
            index += 2
        else:
            result.append(text[index])
            index += 1
    if depth or quoted:
        raise JobError("unterminated Coq comment or string")
    return "".join(result)


def goal_interface(source: str) -> list[tuple[str, str]]:
    source = strip_comments(source)
    module = re.search(
        r"\bModule\s+Type\s+VC_Correct\s*\.(.*?)\bEnd\s+VC_Correct\s*\.", source, re.S
    )
    if module is None:
        raise JobError("generated goal lacks VC_Correct")
    pattern = rf"\s*Axiom\s+(proof_of_{IDENT})\s*:\s*({IDENT})\s*\."
    body = module.group(1)
    entries = re.findall(pattern, body)
    if not entries or re.sub(pattern, "", body).strip():
        raise JobError("unsupported or empty VC_Correct interface")
    if len({name for name, _ in entries}) != len(entries):
        raise JobError("duplicate proof name in VC_Correct")
    return entries


def tree_digest(root: Path) -> str:
    """Pin compiled libraries as well as sources: Coq consumes .vo files."""
    result = hashlib.sha256()
    for path in sorted(root.rglob("*")):
        if path.is_file() and (
            path.suffix in {".v", ".vo"} or path.name == "_CoqProject"
        ):
            result.update(str(path.relative_to(root)).encode() + b"\0")
            result.update(bytes.fromhex(digest(path)))
    return result.hexdigest()


def coverage_source(entries, refute=None, *, partial=False):
    if refute is None and not partial:
        return "Require Import Goal Candidate.\nModule Checked : Goal.VC_Correct.\nInclude Candidate.Proofs.\nEnd Checked.\n"
    if refute is not None and refute not in {name for name, _ in entries}:
        raise JobError("refutation target is not an original VC")
    interface = "Require Import Goal Candidate.\nModule Type Refutation_Correct.\n"
    for name, statement in entries:
        polarity = "~ " if name == refute else ""
        interface += f"Axiom {name} : {polarity}Goal.{statement}.\n"
    return (
        interface
        + "End Refutation_Correct.\nModule Checked : Refutation_Correct.\nInclude Candidate.Proofs.\nEnd Checked.\n"
    )


def prepare_certificate(
    original_manifest: Path, output: Path, *, refute: str | None = None,
    only: set[str] | None = None,
) -> dict:
    original_manifest = original_manifest.resolve()
    manifest = json.loads(original_manifest.read_text())
    if manifest.get("schema") != "qcp-spectest-vc-manifest/v1":
        raise JobError("expected an original QCP VC manifest")
    goal = Path(manifest["files"]["goal"]).resolve()
    if digest(goal) != manifest["immutable_sha256"]["goal"]:
        raise JobError("original generated goal was modified")
    entries = goal_interface(goal.read_text())
    if only is not None:
        if not only or only - {name for name, _ in entries}:
            raise JobError("selected proof target is not an original VC")
        entries = [(name, statement) for name, statement in entries if name in only]
    coverage = coverage_source(entries, refute, partial=only is not None)
    runtime = Path(manifest["qcip_root"]).resolve() / "SeparationLogic"
    output = output.resolve()
    if output.exists() and any(output.iterdir()):
        raise JobError("certificate output must be empty")
    output.mkdir(parents=True, exist_ok=True)
    target = output / "Goal.v"
    target.write_bytes(goal.read_bytes())
    dependencies = []
    generated = manifest.get("generated_coq_dependencies", [])
    module_names = set()
    for item in [*manifest.get("coq_dependencies", []), *generated]:
        module = item["module"]
        if re.fullmatch(QUALIFIED, module) is None:
            raise JobError("invalid dependency module")
        check_dependency_namespace(module, runtime)
        if module in module_names:
            raise JobError("duplicate certificate dependency: " + module)
        module_names.add(module)
        source = Path(item["staged"])
        if digest(source) != item["sha256"]:
            raise JobError("original dependency was modified")
        dest = output / "dependencies" / Path(*module.split(".")).with_suffix(".v")
        dest.parent.mkdir(parents=True, exist_ok=True)
        dest.write_bytes(source.read_bytes())
        dependencies.append(
            {
                "module": module,
                "file": str(dest.relative_to(output)),
                "sha256": digest(dest),
                **({"generated": True} if item in generated else {}),
            }
        )
    proof = "Require Import Goal.\nModule Proofs.\n\n"
    for name, statement in entries:
        polarity = "~ " if name == refute else ""
        proof += f"Lemma {name} : {polarity}Goal.{statement}.\nProof. Abort.\n\n"
    proof += "End Proofs.\n"
    (output / "Candidate.v").write_text(proof)
    (output / "Coverage.v").write_text(coverage)
    audit = "Require Import Coverage.\nSet Printing Width 1000000.\n"
    for name, _ in entries:
        audit += f"Print Assumptions Coverage.Checked.{name}.\n"
    (output / "Assumptions.v").write_text(audit)
    runtime = Path(manifest["qcip_root"]).resolve() / "SeparationLogic"
    if not (runtime / "_CoqProject").is_file():
        raise JobError("missing Coq runtime")
    bundle = {
        "schema": "qcp-spectest-certificate/v1",
        "scope": "selected-original-vcs" if only is not None else "original-vc-group-with-one-refutation"
        if refute
        else "complete-original-vc-group",
        "refuted_goal": refute,
        "selected_goals": sorted(only) if only is not None else None,
        "case_id": manifest.get("case_id"),
        "function": manifest.get("function"),
        "target_layout": manifest.get("target_layout"),
        "original_manifest": str(original_manifest),
        "original_manifest_sha256": digest(original_manifest),
        "source_only_runtime_dependencies": [dep for dep in manifest.get("runtime_dependencies", [])
                                             if dep.get("compiled") is None],
        "original_goal_sha256": digest(goal),
        "goals": [
            {"proof": name, "statement": statement} for name, statement in entries
        ],
        "immutable_sha256": {
            name: digest(output / name)
            for name in ["Goal.v", "Coverage.v", "Assumptions.v"]
        },
        "dependencies": dependencies,
        "runtime": str(runtime),
        "runtime_sha256": tree_digest(runtime),
        "allowed_assumptions": sorted(TRUSTED_ASSUMPTIONS),
        "editable": "Candidate.v",
    }
    path = output / "manifest.json"
    path.write_text(json.dumps(bundle, indent=2) + "\n")
    return {
        "manifest": str(path),
        "manifest_sha256": digest(path),
        "goals": len(entries),
        "editable": str(output / "Candidate.v"),
    }


def assumption_audit_from_output(text: str) -> tuple[set[str], list[str]]:
    """Read every Coq 8.20 assumption entry, including non-type kernel flags.

    printer.ml emits ordinary constants as name : type, but disabled checks as
    guarded/positive/unsafe-hierarchy records and additional Theory lines. Such
    records cannot disappear merely because another entry is an allowed axiom.
    Names are retained verbatim: Coq identifiers also permit Unicode and primes.
    """
    observed, unsupported = set(), []
    section = None
    headings = {"Axioms:", "Theory:", "Section Variables:",
                "Opaque constants:", "Transparent constants:"}
    lines = text.splitlines()
    for index, line in enumerate(lines):
        value = line.strip()
        if value == "Closed under the global context":
            section = None
        elif value in headings:
            section = value
        elif section is not None and value:
            if section != "Axioms:":
                unsupported.append(section + " " + value)
                continue
            if line[0].isspace():
                # Pretty-printed type continuations are indented. Audit callers
                # set a wide line width; also accept a name followed by newline :.
                continue
            entry = re.match(r"^([^\s:]+)\s*:", line)
            if entry:
                observed.add(entry.group(1))
                continue
            if (re.fullmatch(r"[^\s:]+", value)
                    and index + 1 < len(lines)
                    and lines[index + 1].lstrip().startswith(":")):
                observed.add(value)
                continue
            # Includes Coq's guardedness, positivity, TypeInType and UIP flags,
            # and any unrecognized non-type entry. Fail closed at the caller.
            unsupported.append(value)
    return observed, unsupported


def assumptions_from_output(text: str) -> set[str]:
    return assumption_audit_from_output(text)[0]


def check_candidate_commands(source: str) -> None:
    candidate = strip_comments(source)
    # Module names can coincide with vernacular keywords (AUXLib.Axioms is
    # shipped by QCP). Remove only grammatically restricted Require commands;
    # imported assumptions are still audited transitively after compilation.
    candidate = re.sub(
        rf"(?<![\w.])(?:From\s+{QUALIFIED}\s+)?Require\s+"
        rf"(?:(?:Import|Export)\s+)?{QUALIFIED}(?:\s+{QUALIFIED})*\s*\.(?!\w)",
        " ",
        candidate,
    )
    forbidden = re.search(
        r"\b(?:Admitted|admit|Axiom|Axioms|Conjecture|Parameters?|Hypotheses?|Variables?|Context)\b|\bUnset\s+(?:Guard|Positivity|Universe)\s+Checking\b|\bDeclare\s+ML\s+Module\b",
        candidate,
    )
    if forbidden:
        raise JobError("candidate contains forbidden command: " + forbidden.group())


def _uncompiled_runtime_modules(manifest, runtime, directory):
    """Stage only original, hash-checked runtime sources lacking a compiled unit."""
    original = Path(manifest["original_manifest"])
    declared = manifest.get("source_only_runtime_dependencies")
    if original.is_file():
        if digest(original) != manifest["original_manifest_sha256"]:
            raise JobError("original VC manifest changed")
        pinned = json.loads(original.read_bytes())
        selected = [dep for dep in pinned.get("runtime_dependencies", []) if dep.get("compiled") is None]
        if declared is not None and declared != selected:
            raise JobError("runtime source list differs from original VC manifest")
    else:
        # Older portable bundles used only the compiled runtime. New bundles
        # also pin source-only imports when the generation workspace is archived.
        selected = declared or []
    pending = {}
    for dep in selected:
        name = dep["module"]
        if not re.fullmatch(QUALIFIED, name) or "." not in name or name in pending:
            raise JobError("invalid runtime dependency name")
        path = _runtime_coq_module(name, runtime.parent)
        if path is None or path != Path(dep["source"]).resolve() or not path.is_relative_to(runtime):
            raise JobError("wrong runtime module source for " + name)
        text = path.read_bytes()
        if hashlib.sha256(text).hexdigest() != dep["sha256"]:
            raise JobError("runtime dependency hash mismatch: " + name)
        target = directory.joinpath(*name.split(".")).with_suffix(".v")
        target.parent.mkdir(parents=True, exist_ok=True)
        target.write_bytes(text)
        pending[name] = (target, set(_coq_required_modules(text.decode())))
    units = {}
    while pending:
        ready = [name for name, (_, imports) in pending.items() if not imports.intersection(pending)]
        if not ready:
            raise JobError("cyclic or unresolved runtime dependencies")
        for name in ready:
            units[name] = pending.pop(name)[0]
    return units


def _reserved_job_memory_kib(root):
    """Count resident anonymous pages already consuming the kernel and compiler reserves."""
    proc = Path("/proc")
    budget = {}
    for name, command, limit in (("kernel", "coqchk", 3 * 1024**2),
                                 ("compiler", "coqc", 1536 * 1024)):
        try:
            st = (root / (name + "-0.lock")).stat()
            budget[(os.major(st.st_dev), os.minor(st.st_dev), st.st_ino)] = (command, limit)
        except OSError:
            continue
    used = 0
    for record in (proc / "locks").read_text().splitlines():
        fields = record.split()
        if len(fields) < 7 or fields[1:4] != ["FLOCK", "ADVISORY", "WRITE"]:
            continue
        major, minor, inode = fields[5].split(":")
        key = (int(major, 16), int(minor, 16), int(inode))
        if key not in budget:
            continue
        command, limit = budget.pop(key)
        pids = [int(fields[4])]
        anonymous = 0
        for pid in pids:
            task = proc / str(pid)
            try:
                pids.extend(int(c) for c in (task / "task" / str(pid) / "children").read_text().split())
                if (task / "comm").read_text().strip() == command:
                    pages = int(next(v.split()[1] for v in (task / "status").read_text().splitlines()
                                     if v.startswith("RssAnon:")))
                    # Forked workers can temporarily share anonymous pages.
                    anonymous = max(anonymous, pages)
            except (OSError, ValueError, StopIteration):
                continue
        used += min(anonymous, limit)
    return used


def _second_candidate_has_headroom(root, candidate_bytes, *, kernel_reserved=True):
    """Reserve two capped candidates, a kernel, a compiler and explicit host headroom."""
    try:
        meminfo = {line.partition(":")[0]: int(line.partition(":")[2].split()[0])
                   for line in Path("/proc/meminfo").read_text().splitlines()}
        if meminfo["SwapFree"] < 2 * 1024**2:
            return False
        first = int((root / "candidate-0.lock").read_text())
        children = [first]
        first_rss = 0
        for pid in children:
            proc = Path("/proc") / str(pid)
            children.extend(int(v) for v in (proc / "task" / str(pid) / "children").read_text().split())
            if (proc / "comm").read_text().strip() != "coqc":
                continue
            cmd = (proc / "cmdline").read_bytes().split(b"\0")
            if not any(arg.endswith(b"/Candidate.v") for arg in cmd):
                continue
            bound = next(line.split()[3] for line in (proc / "limits").read_text().splitlines()
                         if line.startswith("Max address space"))
            if bound == "unlimited" or int(bound) > candidate_bytes:
                return False
            first_rss = int(next(line.split()[1] for line in (proc / "status").read_text().splitlines()
                                 if line.startswith("RssAnon:")))
        # KiB. Reserve 3 GiB for one kernel, 1.5 GiB for other compilation,
        # and another 1.5 GiB for the OS and background work.
        required = 2 * (candidate_bytes // 1024) + (6 if kernel_reserved else 3) * 1024**2
        if first_rss <= 0:
            return False
        available = meminfo["MemAvailable"] + first_rss
        # Only live FLOCK owners can consume these reserves. Foreign jobs, page
        # cache and shared mappings do not contribute to the added headroom.
        return available >= required or available + _reserved_job_memory_kib(root) >= required
    except (OSError, ValueError, KeyError, StopIteration):
        return False


def _idle_kernel_lease(root):
    """Temporarily reserve the idle kernel lane without overtaking its queue."""
    import fcntl

    lease = []
    with (root / "kernel-admission.lock").open("a") as admission:
        try:
            fcntl.flock(admission, fcntl.LOCK_EX | fcntl.LOCK_NB)
            # Older controllers used two kernel lanes. Lock both for the lease.
            for name in ("kernel-0.lock", "kernel-1.lock"):
                handle = (root / name).open("a")
                lease.append(handle)
                fcntl.flock(handle, fcntl.LOCK_EX | fcntl.LOCK_NB)
        except BaseException as exc:
            for handle in lease:
                handle.close()
            if isinstance(exc, BlockingIOError):
                return []
            raise
    return lease


@contextmanager
def _benchmark_resource_slot(stage, allocation=None, job_fds=None):
    """Bound ITP subprocesses across workers while measuring each invocation separately."""
    directory = os.environ.get("TESPEC_ITP_RESOURCE_DIR")
    if stage == "model_generation":
        kind = "model"
    elif stage.startswith("kernel_replay"):
        kind = "kernel"
    elif stage == "compile_Candidate.v":
        kind = "candidate"
    else:
        kind = "compiler" if stage.startswith("compile_") else None
    if not directory or not kind:
        yield 0.0
        return
    import fcntl

    root = Path(directory)
    if not root.is_dir():
        raise JobError("ITP resource-slot directory is unavailable")
    defaults = {"model": "8", "kernel": "1", "candidate": "2", "compiler": "1"}
    count = int(os.environ.get("TESPEC_ITP_" + kind.upper() + "_SLOTS", defaults[kind]))
    if not 1 <= count <= int(defaults[kind]):
        raise JobError("invalid ITP resource-slot count")
    started = time.monotonic()
    handles = []
    lease = []
    try:
        for index in range(count):
            handles.append((root / (kind + "-" + str(index) + ".lock")).open("a"))
        # Only the oldest admitted waiter polls the slots. New arrivals wait on
        # a blocking flock and cannot repeatedly overtake a queued kernel replay.
        with (root / (kind + "-admission.lock")).open("a") as admission:
            fcntl.flock(admission, fcntl.LOCK_EX)
            acquired = False
            while not acquired:
                for index, handle in enumerate(handles):
                    if kind == "candidate" and index:
                        bound = int(os.environ.get("TESPEC_ITP_CANDIDATE_ADDRESS_SPACE_BYTES", 4 * 1024**3))
                        if not _second_candidate_has_headroom(root, bound):
                            if not _second_candidate_has_headroom(root, bound, kernel_reserved=False):
                                continue
                            lease = _idle_kernel_lease(root)
                            if not lease:
                                continue
                            if not _second_candidate_has_headroom(root, bound, kernel_reserved=False):
                                for reserved in lease:
                                    reserved.close()
                                lease.clear()
                                continue
                    try:
                        fcntl.flock(handle, fcntl.LOCK_EX | fcntl.LOCK_NB)
                    except BlockingIOError:
                        for reserved in lease:
                            reserved.close()
                        lease.clear()
                        continue
                    if kind == "candidate":
                        handle.seek(0)
                        handle.truncate()
                        handle.write(str(os.getpid()))
                        handle.flush()
                    acquired = True
                    break
                if not acquired:
                    time.sleep(0.1)
        if kind == "candidate" and allocation is not None:
            allocation["borrowed_idle_kernel_slot"] = bool(lease)
        if job_fds is not None:
            # A surviving GNU time wrapper retains the flock on the same open
            # file description until its bounded job exits, even if this checker dies.
            job_fds.extend(item.fileno() for item in [handle, *lease])
        yield time.monotonic() - started
    finally:
        for handle in handles + lease:
            handle.close()


def check_certificate(
    path: Path,
    expected_digest: str,
    *,
    switch: str = "qcp-8.20",
    timeout: float = 120,
    kernel_cache: KernelReplayCache | None = None,
    measure_candidate_precheck: bool = False,
) -> dict:
    path = path.resolve()
    # An earlier PASS must not survive a rejected or failed new attempt.
    (path.parent / "certificate-report.json").unlink(missing_ok=True)
    if digest(path) != expected_digest:
        raise JobError("certificate manifest differs from controller digest")
    if timeout <= 0:
        raise JobError("timeout must be positive")
    manifest = json.loads(path.read_text())
    if manifest.get("schema") != "qcp-spectest-certificate/v1":
        raise JobError("unsupported certificate manifest")
    out = path.parent
    for name, expected in manifest["immutable_sha256"].items():
        if Path(name).name != name or digest(out / name) != expected:
            raise JobError("immutable certificate input changed: " + name)
    runtime = Path(manifest["runtime"])
    if tree_digest(runtime) != manifest["runtime_sha256"]:
        raise JobError("compiled/source runtime changed since preparation")
    dep_paths = []
    for dep in manifest["dependencies"]:
        check_dependency_namespace(dep["module"], runtime)
        target = (out / dep["file"]).resolve()
        if (
            not target.is_relative_to(out / "dependencies")
            or digest(target) != dep["sha256"]
        ):
            raise JobError("certificate dependency changed")
        dep_paths.append(target)
    if not measure_candidate_precheck:
        check_candidate_commands((out / "Candidate.v").read_text())
    entries = goal_interface((out / "Goal.v").read_text())
    refute = manifest.get("refuted_goal")
    selected = manifest.get("selected_goals")
    if selected is not None:
        if not isinstance(selected, list) or not selected or any(
            not isinstance(name, str) for name in selected
        ) or set(selected) - {name for name, _ in entries}:
            raise JobError("invalid selected original VC inventory")
        entries = [(name, statement) for name, statement in entries if name in selected]
    if (out / "Coverage.v").read_text() != coverage_source(
        entries, refute, partial=selected is not None
    ):
        raise JobError(
            "coverage interface does not match requested original VC polarities"
        )
    if entries != [(item["proof"], item["statement"]) for item in manifest["goals"]]:
        raise JobError("certificate inventory differs from original interface")
    load_paths = _coq_load_path_args(
        runtime, out, out / "dependencies" if dep_paths else None
    )
    prefix = ["opam", "exec", "--switch=" + switch, "--"]
    stages = []
    started = time.monotonic()
    report = {
        "schema": "qcp-spectest-certificate-report/v1",
        "status": "UNKNOWN",
        "scope": manifest["scope"],
        "manifest_sha256": expected_digest,
        "candidate_sha256": digest(out / "Candidate.v"),
        "original_goal_sha256": manifest["original_goal_sha256"],
        "target_layout": manifest.get("target_layout"),
        "case_id": manifest.get("case_id"),
        "function": manifest.get("function"),
        "stages": stages,
    }

    def finish(reason):
        runtime_work.cleanup()
        report["reason"] = reason
        report["duration_seconds"] = round(time.monotonic() - started, 6)
        (out / "certificate-report.json").write_text(
            json.dumps(report, indent=2) + "\n"
        )
        return report

    def execute(label, command):
        log = out / (label + ".log")
        resource = out / (label + ".resources.json")
        limit = None
        checked_command = command
        if label == "compile_Candidate.v" and os.environ.get("TESPEC_ITP_RESOURCE_DIR"):
            limit = int(os.environ.get("TESPEC_ITP_CANDIDATE_ADDRESS_SPACE_BYTES", 4 * 1024**3))
            if limit <= 0:
                raise JobError("invalid ITP candidate process address-space limit")
            checked_command = ["/usr/bin/prlimit", "--as=" + str(limit), "--", *command]
        measured = [
            "/usr/bin/time",
            "--quiet",
            "-f",
            '{"user_seconds":%U,"system_seconds":%S,"max_process_rss_kib":%M}',
            "-o",
            str(resource),
            # GNU time stays outside the timeout process group, so it can reap
            # the command and write maximum RSS when the compiler times out.
            "/usr/bin/timeout", "--kill-after=3s", f"{timeout}s", *checked_command,
        ]
        allocation = {}
        job_fds = []
        with _benchmark_resource_slot(label, allocation, job_fds) as queue_seconds:
            start = time.monotonic()
            with log.open("w") as stream:
                process = subprocess.Popen(
                    measured,
                    cwd=out,
                    stdout=stream,
                    stderr=subprocess.STDOUT,
                    start_new_session=True,
                    **({"pass_fds": tuple(job_fds)} if job_fds else {}),
                )
                try:
                    code = process.wait(timeout=timeout + 10)
                    if code in (124, 137) and time.monotonic() - start >= timeout:
                        code = "TIMEOUT"
                except subprocess.TimeoutExpired:
                    os.killpg(process.pid, signal.SIGKILL)
                    process.wait()
                    code = "TIMEOUT"
        resources = None
        if resource.exists():
            try:
                resources = json.loads(resource.read_text())
            except json.JSONDecodeError:
                pass
        stages.append(
            {
                "stage": label,
                "command": command,
                **({"address_space_limit_bytes": limit, "measured_command": measured,
                    **allocation, "resource_slot_policy": "two capped candidates; reserve 3 GiB kernel unless its idle lane is locked, 1.5 GiB compiler and 1.5 GiB host; credit reserved jobs anonymous RSS; min 2 GiB swap free"} if limit else {}),
                **({"resource_failure": "candidate_allocation_failed"} if limit and code != 0 and
                   re.search(r"out of memory|cannot allocate memory|memory allocation failed",
                             log.read_text(errors="replace"), re.IGNORECASE) else {}),
                "exit_code": code,
                "wall_seconds": time.monotonic() - start,
                **({"queue_seconds": queue_seconds} if queue_seconds else {}),
                "resources": resources,
                "log": str(log),
            }
        )
        return code == 0

    # Keep derived objects outside both the pinned runtime and model-editable files.
    # A private directory also prevents reused .vo files from shadowing other modules.
    runtime_work = TemporaryDirectory(prefix="tespec-itp-runtime-")
    runtime_units = _uncompiled_runtime_modules(manifest, runtime, Path(runtime_work.name))
    for module_dir, logical in sorted({(unit.parent, name.rsplit(".", 1)[0])
                                       for name, unit in runtime_units.items()}):
        load_paths.extend(["-Q", str(module_dir), logical])
    if measure_candidate_precheck:
        # Use a separate measured process so a rejected source has real time
        # and per-attempt RSS, even when no Coq compiler is ever launched.
        precheck = [
            sys.executable, "-I", "-c",
            "import sys; from pathlib import Path; sys.path.insert(0, sys.argv[1]); "
            "from spectest.certificates import check_candidate_commands; "
            "check_candidate_commands(Path('Candidate.v').read_text())",
            str(Path(__file__).resolve().parents[1]),
        ]
        if not execute("candidate_precheck", precheck):
            return finish("candidate_source_precheck_failed_or_timeout")
    if not execute("version", prefix + ["coqc", "--version"]):
        return finish("coq_unavailable")
    if "version 8.20" not in (out / "version.log").read_text():
        return finish("unsupported_coq_version")
    for name, unit in runtime_units.items():
        if not execute("compile_runtime_" + name.replace(".", "_"), prefix + ["coqc", *load_paths, str(unit)]):
            return finish("uncompiled_runtime_dependency")
        report.setdefault("compiled_runtime_sources", {})[name] = {
            "source_sha256": digest(unit), "compiled_sha256": digest(unit.with_suffix(".vo"))}
    # Never accept a stale compiled candidate from a previous attempt.
    for unit in [
        *dep_paths,
        *(
            out / name
            for name in ["Goal.v", "Candidate.v", "Coverage.v", "Assumptions.v"]
        ),
    ]:
        unit.with_suffix(".vo").unlink(missing_ok=True)
        if not execute(
            "compile_" + str(unit.relative_to(out)).replace("/", "_"),
            prefix + ["coqc", *load_paths, str(unit)],
        ):
            # The generator can emit an invalid opaque alignment proof body.
            # Check the original first. Only the pinned generated input_def may
            # use a layout-derived proof for the identical original declarations.
            generated_unit = next((dep for dep in manifest["dependencies"]
                                   if dep.get("generated") and dep["module"] == "input_def"
                                   and (out / dep["file"]).resolve() == unit), None)
            if generated_unit is None or not manifest.get("target_layout"):
                return finish("coq_compile_failed_or_timeout")
            from .auto_guard_recheck import alignment_proof_source
            original = unit.read_bytes()
            replacement = alignment_proof_source(original.decode(), manifest["target_layout"]).encode()
            if replacement == original:
                return finish("coq_compile_failed_or_timeout")
            unit.write_bytes(replacement)
            try:
                if not execute("compile_generated_alignment", prefix + ["coqc", *load_paths, str(unit)]):
                    return finish("coq_compile_failed_or_timeout")
            finally:
                unit.write_bytes(original)
            report["generated_alignment"] = {
                "module": "input_def", "original_sha256": generated_unit["sha256"],
                "compiled_source_sha256": hashlib.sha256(replacement).hexdigest(),
                "compiled_sha256": digest(unit.with_suffix(".vo"))}
    audit = (out / "compile_Assumptions.v.log").read_text()
    observed, unsupported = assumption_audit_from_output(audit)
    blocks = audit.count("Axioms:") + audit.count("Closed under the global context")
    report["assumptions"] = sorted(observed)
    report["assumptions_audited_goals"] = blocks
    report["unsupported_assumption_records"] = unsupported
    if unsupported:
        return finish("unsupported_assumption_records")
    if blocks != len(entries) or ("Axioms:" in audit and not observed):
        return finish("assumption_audit_incomplete")
    # The built-in ceiling prevents a manifest from silently trusting arbitrary axioms.
    allowed = set(manifest["allowed_assumptions"]) & TRUSTED_ASSUMPTIONS
    report["unexpected_assumptions"] = sorted(observed - allowed)
    if observed - allowed:
        return finish("unapproved_transitive_assumptions")
    if observed:
        # Print Assumptions abbreviates names. Resolve their actual identities
        # so a task-local CNotation.eval_addr_expr cannot pass as QCP's one.
        identity_file = out / "AssumptionIdentities.v"
        identity_file.write_text(
            "Require Import Coverage.\n"
            + "".join(f"Locate {name}.\n" for name in sorted(observed))
        )
        if not execute(
            "assumption_identities", prefix + ["coqc", *load_paths, str(identity_file)]
        ):
            return finish("assumption_identity_check_failed")
        identities = re.findall(
            rf"(?m)^Constant ({QUALIFIED})\s*$",
            (out / "assumption_identities.log").read_text(),
        )
        report["assumption_identities"] = identities
        if identities != [ASSUMPTION_IDENTITIES[name] for name in sorted(observed)]:
            return finish("assumption_identity_mismatch")
    identity = (switch, (out / "version.log").read_text())
    checker = None
    checker_digest = None
    if kernel_cache is not None:
        if execute("kernel_checker_path", prefix + ["which", "coqchk"]):
            checker = Path((out / "kernel_checker_path.log").read_text().strip())
            if checker.is_file():
                checker_digest = digest(checker)
                identity = (*identity, checker_digest)
            else:
                kernel_cache = None
        else:
            kernel_cache = None
    fresh_modules = {
        (out / (module + ".vo")).resolve(): module
        for module in ("Goal", "Candidate", "Coverage")
    }
    fresh_modules.update(
        {
            (out / dep["file"]).with_suffix(".vo").resolve(): dep["module"]
            for dep in manifest["dependencies"]
        }
    )
    fresh_modules.update({unit.with_suffix(".vo").resolve(): name for name, unit in runtime_units.items()})
    partial = kernel_cache is not None and kernel_cache.ready(identity)
    command = prefix + ["coqchk", *load_paths]
    if partial:
        for module in fresh_modules.values():
            command.extend(("-norec", module))
    else:
        command.append("Coverage")
    if not execute("kernel_replay", command):
        return finish("independent_kernel_replay_failed_or_timeout")
    kernel_log = (out / "kernel_replay.log").read_text()
    report["kernel_replay_mode"] = "full"
    if partial:
        coverage = kernel_cache.accepts_partial(kernel_log, identity, fresh_modules)
        if coverage is None:
            # A newly imported dependency is never accepted on cache authority.
            # Replay the full closure in this case and retain both stage logs.
            if not execute(
                "kernel_replay_full_fallback",
                prefix + ["coqchk", *load_paths, "Coverage"],
            ):
                return finish("independent_kernel_replay_failed_or_timeout")
            kernel_log = (out / "kernel_replay_full_fallback.log").read_text()
            partial = False
        else:
            report["kernel_replay_mode"] = "checked-dependency-reuse"
            report["kernel_dependency_reuse"] = coverage
    try:
        if digest(out / "Candidate.v") != report["candidate_sha256"]:
            return finish("candidate_changed_during_check")
        if digest(path) != expected_digest:
            return finish("manifest_changed_during_check")
        for name, expected in manifest["immutable_sha256"].items():
            if digest(out / name) != expected:
                return finish("immutable_input_changed_during_check")
        if any(
            digest(out / item["file"]) != item["sha256"]
            for item in manifest["dependencies"]
        ):
            return finish("dependency_changed_during_check")
        if tree_digest(runtime) != manifest["runtime_sha256"]:
            return finish("runtime_changed_during_check")
        if kernel_cache is not None:
            if digest(checker) != checker_digest:
                return finish("kernel_checker_changed_during_check")
            if partial:
                if not kernel_cache.ready(identity):
                    return finish("checked_dependency_changed_during_check")
            else:
                kernel_cache._record_checked_closure(
                    kernel_log,
                    identity,
                    fresh_modules,
                    origin={
                        "manifest_sha256": expected_digest,
                        "goal_sha256": report["original_goal_sha256"],
                        "candidate_sha256": report["candidate_sha256"],
                        "kernel_log_sha256": hashlib.sha256(
                            kernel_log.encode()
                        ).hexdigest(),
                        "checker_sha256": checker_digest,
                    },
                )
    except OSError as error:
        report["unavailable_evidence"] = str(error.filename) if error.filename else str(error)
        return finish("evidence_unavailable_during_check")
    if refute:
        report["status"] = "UNKNOWN"
        report["vc_status"] = "INVALID"
        report["proof_status"] = "VALID"
        report["polarity"] = "negative"
        report["refuted_goal"] = refute
        report["execution_counterexample"] = "NOT_ESTABLISHED"
        return finish("original_vc_refuted_and_replayed")
    report["status"] = "PASS"
    report["vc_status"] = "VALID"
    report["proof_status"] = "VALID"
    report["polarity"] = "positive"
    return finish("original_vc_group_proved_and_replayed")
