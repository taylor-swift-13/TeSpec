"""Independent full-VC replay without trusting generated automatic placeholders.

The automatic executor and its auto/manual classification stay unchanged. This
optional stage asks for proofs of the original VC_Correct module interface.
Its manifest digest must be held by the calling controller, outside proof edits.
"""

from __future__ import annotations

import hashlib
import json
import os
from pathlib import Path
import re
import signal
import subprocess
import time

from .core import JobError, _coq_load_path_args
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
    for item in manifest.get("coq_dependencies", []):
        module = item["module"]
        if re.fullmatch(QUALIFIED, module) is None:
            raise JobError("invalid dependency module")
        check_dependency_namespace(module, runtime)
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


def assumptions_from_output(text: str) -> set[str]:
    observed = set()
    # Import diagnostics precede Print Assumptions and are not axiom entries.
    # Within an axiom block, retain every identifier (even one named Warning).
    for block in text.split("Axioms:\n")[1:]:
        block = block.split("Closed under the global context", 1)[0]
        observed.update(re.findall(rf"(?m)^({QUALIFIED})\s*:", block))
    return observed


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


def check_certificate(
    path: Path,
    expected_digest: str,
    *,
    switch: str = "qcp-8.20",
    timeout: float = 120,
    kernel_cache: KernelReplayCache | None = None,
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
        report["reason"] = reason
        report["duration_seconds"] = round(time.monotonic() - started, 6)
        (out / "certificate-report.json").write_text(
            json.dumps(report, indent=2) + "\n"
        )
        return report

    def execute(label, command):
        log = out / (label + ".log")
        resource = out / (label + ".resources.json")
        measured = [
            "/usr/bin/time",
            "--quiet",
            "-f",
            '{"user_seconds":%U,"system_seconds":%S,"max_process_rss_kib":%M}',
            "-o",
            str(resource),
            *command,
        ]
        start = time.monotonic()
        with log.open("w") as stream:
            process = subprocess.Popen(
                measured,
                cwd=out,
                stdout=stream,
                stderr=subprocess.STDOUT,
                start_new_session=True,
            )
            try:
                code = process.wait(timeout=timeout)
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
                "exit_code": code,
                "wall_seconds": time.monotonic() - start,
                "resources": resources,
                "log": str(log),
            }
        )
        return code == 0

    if not execute("version", prefix + ["coqc", "--version"]):
        return finish("coq_unavailable")
    if "version 8.20" not in (out / "version.log").read_text():
        return finish("unsupported_coq_version")
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
            return finish("coq_compile_failed_or_timeout")
    audit = (out / "compile_Assumptions.v.log").read_text()
    observed = assumptions_from_output(audit)
    blocks = audit.count("Axioms:") + audit.count("Closed under the global context")
    report["assumptions"] = sorted(observed)
    report["assumptions_audited_goals"] = blocks
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
