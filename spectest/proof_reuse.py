"""Strict lookup of reusable proof *sources* for the current execution.

All candidates, including published ones, go through the ordinary checker in a
fresh bundle. No archived verdict or compiled proof object is imported.
"""
import hashlib
import json
import os
from pathlib import Path
import re
import tempfile

from .certificates import IDENT, digest
from .errors import JobError


def proof_key(bundle, report, case):
    provenance = report.get("provenance", {})
    if not all(provenance.get(k) for k in ("binary_sha256", "source_sha256", "included_source_sha256")):
        return None
    original = Path(bundle["original_manifest"])
    if digest(original) != bundle["original_manifest_sha256"]:
        raise JobError("original proof manifest changed")
    manifest = json.loads(original.read_text())
    source = case.get("generated_source_sha256")
    if not source or source != digest(Path(manifest["source"])):
        return None
    identity = {
        "function": bundle["function"], "layout": bundle["target_layout"],
        "inputs": [case.get(k) for k in ("arguments", "bindings", "type_bindings", "spec")],
        "binary": provenance["binary_sha256"], "source": provenance["source_sha256"],
        "include": provenance["included_source_sha256"], "generated": source,
        "original": bundle["original_goal_sha256"], "scope": bundle["scope"],
        "goals": bundle["goals"], "refuted": bundle["refuted_goal"],
        "immutable": bundle["immutable_sha256"], "dependencies": bundle["dependencies"],
        "runtime": bundle["runtime_sha256"], "assumptions": bundle["allowed_assumptions"],
    }
    return hashlib.sha256(json.dumps(identity, sort_keys=True).encode()).hexdigest()


def publish_candidate(cache, key, candidate, audit):
    source = candidate.read_bytes()
    if hashlib.sha256(source).hexdigest() != audit["candidate_sha256"]:
        raise JobError("candidate changed after replay")
    cache.mkdir(parents=True, exist_ok=True)
    with tempfile.NamedTemporaryFile(dir=cache, delete=False) as stream:
        name = Path(stream.name)
        try:
            stream.write(source)
            stream.flush()
            os.replace(name, cache / (key + ".v"))
        finally:
            name.unlink(missing_ok=True)


def dependency_ids(items):
    return sorted((item["module"], item["sha256"], item.get("compiled_sha256")) for item in items)


def published_candidates(root, report, case, bundle):
    """Bridge the published direct-original-targets theorem names to Coverage."""
    if bundle["refuted_goal"]:
        return
    source = Path(report["source"]).resolve()
    programs = root / "benchmark/programs"
    if not source.is_relative_to(programs):
        return
    parts = source.relative_to(programs).parts
    if len(parts) < 3 or parts[1] != "variants":
        return
    group = root / "benchmark/results" / parts[0]
    original = json.loads(Path(bundle["original_manifest"]).read_text())
    expected = {g["proof"]: g["statement"] for g in bundle["goals"]}
    seen = set()

    def checked_file(record):
        path = (root / record["path"]).resolve()
        if not path.is_relative_to(root) or digest(path) != record["sha256"]:
            raise ValueError("published evidence identity mismatch")
        return path

    admitted_dependencies = {d["sha256"] for d in bundle["dependencies"]}
    for path in sorted((group / "evidence/proofs").glob("*.json")):
        try:
            proof = json.loads(path.read_text())
            if (proof.get("schema") != "tespec-current-proof/v1" or proof.get("kind") != "test"
                    or proof.get("status") != "PASS" or proof.get("coverage_style") != "direct-original-targets"
                    or proof["goal"]["sha256"] != bundle["original_goal_sha256"]
                    or proof["source"]["sha256"] != report["provenance"]["source_sha256"]
                    or checked_file(proof["source"]) != source
                    or set(proof["targets"]) != expected.keys()
                    or set(proof["target_theorems"]) != expected.keys()
                    or len(proof["input"]) != 1):
                continue
            binds = proof["input"][0]
            if (binds["args"] != case["arguments"] or binds["values"] != case["bindings"]
                    or binds.get("type_bindings", {}) != case.get("type_bindings", {})):
                continue
            context = json.loads(checked_file(proof["logical_context"]).read_text())
            if (context["target_layout"] != bundle["target_layout"]
                    or any(dependency_ids(context[k]) != dependency_ids(original[k])
                           for k in ("coq_dependencies", "runtime_dependencies"))):
                continue
            checked_file(proof["goal"])
            candidate = checked_file(proof["candidate"])
            if proof["candidate"]["sha256"] in seen:
                continue
            names = proof["target_theorems"]
            if any(not re.fullmatch(IDENT, n) for n in names.values()):
                continue
            # Additional standalone proof helpers need their own audit.
            if any(dep["sha256"] not in admitted_dependencies for dep in proof["dependencies"]):
                continue
            code = re.sub(r"\bExecutionGoal\b", "Goal", candidate.read_text())
            wrappers = [f"Definition {k} : Goal.{stmt} := {names[k]}."
                        for k, stmt in expected.items()]
            code += "\nModule Proofs.\n" + "\n".join(wrappers) + "\nEnd Proofs.\n"
            seen.add(proof["candidate"]["sha256"])
            yield str(path), code
        except (KeyError, OSError, ValueError, TypeError, IndexError):
            continue
