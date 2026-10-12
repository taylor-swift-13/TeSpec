#!/usr/bin/env python3
"""Run one optional proof process, then independently check its candidates."""

import argparse
import json
import os
from pathlib import Path
import signal
import subprocess
import sys
import tempfile
import time

ROOT = Path(__file__).resolve().parents[3]
sys.path.insert(0, str(ROOT))
from spectest.run_certificates import prepare_run_certificates, check_run_certificates  # noqa: E402


def token_usage(events):
    records = []
    for line in events.splitlines():
        try:
            event = json.loads(line)
        except json.JSONDecodeError:
            continue
        if (
            isinstance(event, dict)
            and event.get("type") == "turn.completed"
            and isinstance(event.get("usage"), dict)
        ):
            records.append(event["usage"])
    # Preserve raw per-turn telemetry. Do not infer totals from arbitrary nested
    # payloads, tool text or the agent's own final-message claims.
    return records or None


def run_agent(command, prompt, out, timeout):
    started = time.monotonic()
    resource_path = out / "agent.resources.json"
    measured = [
        "/usr/bin/time",
        "--quiet",
        "-f",
        '{"user_seconds":%U,"system_seconds":%S,"max_process_rss_kib":%M}',
        "-o",
        str(resource_path),
        *command,
    ]
    (out / "agent-prompt.txt").write_text(prompt)
    with (
        (out / "agent.stdout.jsonl").open("w") as stdout,
        (out / "agent.stderr.log").open("w") as stderr,
    ):
        process = subprocess.Popen(
            measured,
            cwd=ROOT,
            stdin=subprocess.PIPE,
            stdout=stdout,
            stderr=stderr,
            text=True,
            start_new_session=True,
        )
        try:
            process.communicate(prompt, timeout=timeout)
            exit_code = process.returncode
        except subprocess.TimeoutExpired:
            os.killpg(process.pid, signal.SIGKILL)
            process.wait()
            exit_code = "TIMEOUT"
    resources = None
    try:
        resources = json.loads(resource_path.read_text())
    except (OSError, ValueError):
        pass
    usage = token_usage((out / "agent.stdout.jsonl").read_text(errors="replace"))
    return {
        "status": "COMPLETED" if exit_code == 0 else "INCOMPLETE",
        "exit_code": exit_code,
        "wall_seconds": time.monotonic() - started,
        "resources": resources,
        "token_usage": usage,
        "token_usage_note": "raw turn.completed usage records"
        if usage
        else "not reported by agent telemetry",
        "model": None,
        "model_note": "inherited caller configuration; identity not independently reported",
        "command": command,
    }


def read_refutation_plan(path, report):
    """Untrusted judgement can select a proof obligation, never its verdict."""
    plan = json.loads(path.read_text())
    if not isinstance(plan, dict) or set(plan) - {"refute_vcs", "refute_preconditions"}:
        raise ValueError("invalid proof routing plan")
    vcs = plan.get("refute_vcs", {})
    entries = plan.get("refute_preconditions", [])
    if (not isinstance(vcs, dict) or not all(isinstance(k, str) and isinstance(v, str)
                                           for k, v in vcs.items())
            or not isinstance(entries, list) or not all(isinstance(v, str) for v in entries)):
        raise ValueError("invalid proof routing targets")
    cases = {case["id"]: case for case in report["results"]}
    selected = set(vcs) | set(entries)
    if selected - cases.keys() or set(vcs) & set(entries):
        raise ValueError("unknown or conflicting proof routing case")
    # A successful positive proof overrides a stale negative judgement.
    return ({key: value for key, value in vcs.items() if cases[key]["status"] == "UNKNOWN"},
            {key for key in entries if cases[key]["status"] == "UNKNOWN"})


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("report", type=Path)
    parser.add_argument("--output", type=Path)
    parser.add_argument("--agent-timeout", type=float, default=900)
    parser.add_argument("--check-timeout", type=float, default=600)
    parser.add_argument("--switch", default="qcp-8.20")
    parser.add_argument(
        "--refute-precondition", action="append", default=[], metavar="CASE_ID"
    )
    parser.add_argument("--refute-vc", action="append", default=[], metavar="CASE_ID=PROOF_NAME")
    parser.add_argument("--agent-command", nargs=argparse.REMAINDER)
    args = parser.parse_args()
    if args.agent_timeout <= 0 or args.check_timeout <= 0:
        parser.error("timeouts must be positive")
    if args.output is None:
        parent = ROOT / ".spectest"
        parent.mkdir(exist_ok=True)
        out = Path(tempfile.mkdtemp(prefix="agent.", dir=parent))
    else:
        out = args.output.resolve()
        if out.exists() and any(out.iterdir()):
            parser.error("output must be empty")
        out.mkdir(parents=True, exist_ok=True)
    refute_vcs = {}
    for value in args.refute_vc:
        case, separator, goal = value.partition("=")
        if not separator or not case or not goal or case in refute_vcs:
            parser.error("--refute-vc requires unique CASE_ID=PROOF_NAME values")
        refute_vcs[case] = goal
    prepared = prepare_run_certificates(
        args.report.resolve(),
        out / "proof",
        refute_preconditions=set(args.refute_precondition),
        refute_vcs=refute_vcs,
    )
    # This digest remains in the external controller's memory during proof work.
    (out / "controller-request.json").write_text(json.dumps(prepared, indent=2) + "\n")
    agent = {
        "status": "SKIPPED",
        "wall_seconds": 0,
        "token_usage": None,
        "resources": None,
        "model": None,
        "token_usage_note": "no agent launched",
    }
    if prepared["proof_required"]:
        command = args.agent_command or [
            os.environ.get("CODEX_BIN", "codex"),
            "exec",
            "--json",
            "--skip-git-repo-check",
            "--sandbox",
            "workspace-write",
            "--ephemeral",
            "-C",
            str(ROOT),
            "--add-dir",
            str(out),
            "-o",
            str(out / "agent.last.txt"),
            "-",
        ]
        prompt = (
            "First assess whether each original VC holds. Prove the supplied statement if it holds. "
            "If a positive VC appears false, request a proof of its negation using the routing plan below. "
            "Your judgement and the routing plan never establish a verdict; only kernel-checked proofs do. "
            "Construct proofs for all listed TeSpec Candidate.v files. You are the sole proof Agent. "
            "Read each sibling Goal.v and staged dependencies as immutable program/proof data. "
            "Fill every original interface obligation, including initial satisfiability. "
            "Controller-selected goals may request a negation; preserve each supplied lemma statement exactly. "
            "Edit only Candidate.v files and the optional proof-plan.json; place compilation scratch under the output directory. "
            "Do not change source, binds, goals, manifests, dependencies or runtime libraries. "
            "Do not introduce axioms, admits or proof escapes. You may compile drafts for feedback. "
            "Do not run final certificate acceptance, write verdict reports, launch other Agents, "
            "or invoke run-agent.sh. The external controller performs final checking. "
            "Leave unresolved proofs unresolved and report their blockers.\n"
            + "Output: "
            + str(out)
            + "\nOptional routing plan: " + str(out / "proof-plan.json")
            + ' with JSON {"refute_vcs": {"CASE_ID": "proof_of_original_goal"}, "refute_preconditions": ["CASE_ID"]}. '
            + "Use only case IDs and original interface proof names from the controller request. "
            + "A second controller round will supply immutable negative statements for checking.\n"
            + "\nCandidates: "
            + json.dumps(prepared["editable"])
            + "\n"
            + "Proof guidance: "
            + str(ROOT / "skills/qcp-spec-test/references/residual-vc.md")
            + "\n"
        )
        agent = run_agent(command, prompt, out, args.agent_timeout)
    (out / "agent-report.json").write_text(json.dumps(agent, indent=2) + "\n")
    report = check_run_certificates(
        Path(prepared["manifest"]),
        prepared["manifest_sha256"],
        switch=args.switch,
        timeout=args.check_timeout,
    )
    plan_path = out / "proof-plan.json"
    if plan_path.is_file() and not (args.refute_precondition or refute_vcs):
        negative_vcs, negative_entries = read_refutation_plan(plan_path, report)
        if negative_vcs or negative_entries:
            negative = prepare_run_certificates(
                Path(report["report"]), out / "negative-proof",
                refute_preconditions=negative_entries, refute_vcs=negative_vcs,
            )
            second_out = out / "negative-agent"
            second_out.mkdir()
            second_prompt = (
                "Prove the controller-supplied negative VC statements. Preserve every lemma statement exactly. "
                "Only a checked proof of the original VC's negation establishes INVALID. "
                "Edit only the listed Candidate.v files. Goals, manifests, dependencies and reports are immutable. "
                "Do not introduce axioms, admits or proof escapes, launch other Agents, or run final acceptance. "
                "If the negation cannot be proved, leave it unresolved.\nCandidates: "
                + json.dumps(negative["editable"]) + "\n"
            )
            second_agent = run_agent(command, second_prompt, second_out, args.agent_timeout)
            checked = check_run_certificates(
                Path(negative["manifest"]), negative["manifest_sha256"],
                switch=args.switch, timeout=args.check_timeout,
            )
            agent = {"status": second_agent["status"], "attempts": [agent, second_agent],
                     "wall_seconds": agent["wall_seconds"] + second_agent["wall_seconds"],
                     "token_usage_note": "raw telemetry recorded separately for both attempts"}
            report = checked
    (out / "agent-report.json").write_text(json.dumps(agent, indent=2) + "\n")
    report["proof_completion"]["agent"] = agent
    Path(report["report"]).write_text(json.dumps(report, indent=2) + "\n")
    print(
        json.dumps(
            {
                "report": report["report"],
                "agent_report": str(out / "agent-report.json"),
                "summary": report["summary"],
            },
            indent=2,
        )
    )
    return 0 if all(case["status"] == "PASS" for case in report["results"]) else 1


if __name__ == "__main__":
    raise SystemExit(main())
