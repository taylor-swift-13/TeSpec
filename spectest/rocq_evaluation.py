"""Experimental, proof-producing evaluation of closed Rocq integer terms.

Results are equalities, not specification-test verdicts. Execution must only
consume them through a separately checked/pinned normalization interface.
"""

import hashlib
import json
from pathlib import Path
import re
import subprocess
import time

from .core import JobError, _run_measured

_IDENTIFIER = r"[A-Za-z_][A-Za-z0-9_']*(?:\.[A-Za-z_][A-Za-z0-9_']*)*"
_TOKEN = re.compile(rf"{_IDENTIFIER}|[0-9]+|[()+*\-]")


def validate_term(term):
    """Accept a small term language, excluding vernacular and tactic injection."""
    if not isinstance(term, str) or not term.strip() or len(term) > 65536:
        raise JobError("expected a nonempty Rocq term of at most 65536 characters")
    if "(*" in term or "*)" in term:
        raise JobError("comments are not accepted in evaluation terms")
    position, depth = 0, 0
    for token in _TOKEN.finditer(term):
        if term[position : token.start()].strip():
            raise JobError("unsupported syntax in Rocq evaluation term")
        if token[0] == "(":
            depth += 1
        if token[0] == ")":
            depth -= 1
            if depth < 0:
                raise JobError("unbalanced Rocq term")
        position = token.end()
    if term[position:].strip() or depth:
        raise JobError("unsupported or unbalanced Rocq term")


def evaluate_z_terms(terms, modules, output, *, load_path_args=(), timeout_seconds=30):
    terms, modules = list(terms), list(modules)
    if not terms or len(terms) > 1024:
        raise JobError("evaluation needs between 1 and 1024 terms")
    for term in terms:
        validate_term(term)
    for module in modules:
        if not re.fullmatch(_IDENTIFIER, module):
            raise JobError("invalid Rocq import module")
    output = Path(output).resolve()
    if output.exists():
        raise JobError("evaluation output directory already exists")
    output.mkdir(parents=True)
    imports = "Require Import Coq.ZArith.ZArith.\n"
    imports += "".join(f"Require Import {m}.\n" for m in modules)
    imports += "Local Open Scope Z_scope.\n"
    driver = imports
    for i, term in enumerate(terms):
        driver += f'Goal True. idtac "TESPEC_EVAL_{i}". exact I. Qed.\n'
        driver += f"Eval vm_compute in ({term} : Z).\n"
    (output / "Evaluate.v").write_text(driver)
    rows = [{"term": term, "value": None, "status": "UNKNOWN"} for term in terms]
    commands = []

    def run(command, log_name):
        started = time.monotonic()
        try:
            proc, peak_rss, cpu_seconds = _run_measured(
                command,
                cwd=Path.cwd(),
                timeout=timeout_seconds,
                metrics_path=output / (log_name + ".time"),
            )
            log = proc.stdout + proc.stderr
            code = proc.returncode
        except subprocess.TimeoutExpired as error:

            def decode(value):
                return (
                    value.decode(errors="replace")
                    if isinstance(value, bytes)
                    else value or ""
                )

            log = decode(error.stdout) + decode(error.stderr)
            code = None
            peak_rss = cpu_seconds = None
        (output / log_name).write_text(log)
        commands.append(
            {
                "command": command,
                "returncode": code,
                "wall_seconds": time.monotonic() - started,
                "log": log_name,
                "peak_rss_kib": peak_rss,
                "cpu_seconds": cpu_seconds,
            }
        )
        return code, log

    code, log = run(
        [
            "coqtop",
            "-quiet",
            "-batch",
            *load_path_args,
            "-l",
            str(output / "Evaluate.v"),
        ],
        "evaluation.log",
    )
    certificates = imports
    proposed = []
    if code == 0:
        for i, row in enumerate(rows):
            part = re.search(
                rf"TESPEC_EVAL_{i}\n(.*?)(?=TESPEC_EVAL_\d+\n|\Z)", log, re.S
            )
            match = (
                re.fullmatch(r"\s*=\s*(-?\s*[0-9]+)\s*:\s*Z\s*", part[1])
                if part
                else None
            )
            if match is None:
                continue
            try:
                value = int(match[1].replace(" ", ""))
            except ValueError:
                continue
            proposed.append((i, value))
            certificates += (
                f"Lemma tespec_eval_{i} : ({row['term']} : Z) = ({value} : Z).\n"
                "Proof. vm_compute. reflexivity. Qed.\n"
                f"Print Assumptions tespec_eval_{i}.\n"
            )
    (output / "Equalities.v").write_text(certificates)
    if proposed:
        code, proof_log = run(
            ["coqc", *load_path_args, str(output / "Equalities.v")], "proof.log"
        )
        closed = proof_log.count("Closed under the global context") == len(proposed)
        if code == 0 and closed and "Axioms:" not in proof_log:
            for i, value in proposed:
                rows[i].update(
                    value=value, status="COQC_CHECKED", lemma=f"tespec_eval_{i}"
                )
    report = {
        "schema": "tespec-rocq-integer-evaluation/v1",
        "terms": rows,
        "commands": commands,
        "scope": "ground-equalities-not-test-verdicts",
        "files": {
            p.name: hashlib.sha256(p.read_bytes()).hexdigest()
            for p in output.iterdir()
            if p.is_file()
        },
    }
    (output / "report.json").write_text(json.dumps(report, indent=2) + "\n")
    return report
