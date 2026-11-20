#!/usr/bin/env python3
"""Route one execution per proof task and independently check each attempt."""

import argparse
import json
import os
from pathlib import Path
import shutil
import signal
import subprocess
import sys
import tempfile
import time

ROOT = Path(__file__).resolve().parents[3]
sys.path.insert(0, str(ROOT))
from spectest.proof_reuse import proof_key, publish_candidate, published_candidates  # noqa: E402
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
        "model_note": "identity not independently reported by CLI telemetry",
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
    # A successful proof overrides a stale negative judgement. A provisional
    # functional FAIL may still carry an explicitly scheduled safety target.
    pending = {task["case_id"]: task.get("goals", []) for task in report.get("itp_vcs", [])}
    return ({key: value for key, value in vcs.items()
             if cases[key]["status"] == "UNKNOWN"
             or (cases[key]["status"] == "FAIL" and value in pending.get(key, []))},
            {key for key in entries if cases[key]["status"] == "UNKNOWN"})


def proof_attempts(command, out, cache, automatic, attempts, plans, args):
    """Yield proof candidates for exactly one execution, replaying locally first."""
    def for_case(entry):
        case = automatic["results"][entry["case_index"]]
        manifest = Path(entry["manifest"])
        bundle = json.loads(manifest.read_text())
        candidate = manifest.parent / "Candidate.v"
        template = candidate.read_bytes()
        key = proof_key(bundle, automatic, case)
        stage_root = out / ("case_%04d" % entry["case_index"])
        stage_root.mkdir(parents=True, exist_ok=True)

        def record(label, origin, number, agent=None):
            folder = stage_root / f"attempt-{number}"
            folder.mkdir(exist_ok=True)
            def finished(audit):
                info = {"case_id": case["id"], "source": label, "origin": origin,
                        "key": key, "check": dict(audit)}
                if agent is not None:
                    info["agent"] = agent
                if audit.get("proof_status") != "VALID" and label != "agent":
                    # Fresh checks write the same log names. Keep failed replay
                    # costs and evidence available after a subsequent attempt.
                    logs = folder / "checker"
                    logs.mkdir()
                    stages = []
                    for stage in audit["stages"]:
                        item = dict(stage)
                        log = Path(stage["log"])
                        stored = logs / log.name
                        shutil.copyfile(log, stored)
                        item["log"] = str(stored)
                        stages.append(item)
                    info["check"]["stages"] = stages
                if key and audit.get("proof_status") == "VALID" and label != "cache":
                    try:
                        publish_candidate(cache, key, candidate, audit)
                    except OSError as error:
                        info["cache_write_error"] = str(error)
                attempts.append(info)
                (folder / "attempt.json").write_text(json.dumps(info, indent=2) + "\n")
            return finished

        number = 0
        if key:
            cached = cache / (key + ".v")
            if cached.is_file():
                number += 1
                # The ordinary checker validates the exact staged bytes and
                # meters a rejected source like any other failed attempt.
                candidate.write_bytes(cached.read_bytes())
                yield record("cache", str(cached), number)
            for origin, text in published_candidates(ROOT, automatic, case, bundle):
                number += 1
                candidate.write_text(text)
                yield record("published", origin, number)

        candidate.write_bytes(template)
        number += 1
        folder = stage_root / f"attempt-{number}"
        folder.mkdir(exist_ok=True)
        plan = folder / "proof-plan.json"
        if bundle["refuted_goal"]:
            routing = "Prove the negative statement supplied by the controller."
        else:
            routing = (
                f"Optional routing plan: {plan} with JSON "
                '{"refute_vcs":{"CASE_ID":"proof_of_original_goal"}} '
                'or {"refute_preconditions":["CASE_ID"]}. '
                f"The only allowed case ID is {case['id']!r}."
            )
        prompt = (
            f"Prove exactly this execution's supplied original VC obligations in {candidate}. "
            "Keep the supplied statements and polarities unchanged. "
            "Read sibling Goal.v and dependencies as immutable inputs. "
            "Edit only Candidate.v and the optional routing plan. No admits, new axioms, "
            "proof escapes, delegated agents, or controller verdict edits. "
            "Leave any unresolved obligations unresolved. "
            + routing + "\nCandidates: " + json.dumps([str(candidate)])
            + "\nSee " + str(ROOT / "skills/qcp-spec-test/references/residual-vc.md")
        )
        proc_command = list(command)
        if not args.agent_command:
            proc_command.extend(["-o", str(folder / "agent.last.txt"), "-"])
        agent = run_agent(proc_command, prompt, folder, args.agent_timeout)
        agent["requested_model"] = None if args.agent_command else "gpt-6.1-sol"
        (folder / "agent-report.json").write_text(json.dumps(agent, indent=2) + "\n")
        if plan.is_file() and not bundle["refuted_goal"]:
            plans.append((case["id"], plan))
        yield record("agent", str(candidate), number, agent)
    return for_case


def agent_summary(attempts):
    runs = [row["agent"] for row in attempts if "agent" in row]
    usage = [event for run in runs for event in (run["token_usage"] or [])]
    usage_complete = all(run["token_usage"] is not None for run in runs)
    total = None
    if usage_complete and all(isinstance(e.get(k), int) and e[k] >= 0
                              for e in usage for k in ("input_tokens", "output_tokens")):
        total = sum(e["input_tokens"] + e["output_tokens"] for e in usage)
    peaks = [(run.get("resources") or {}).get("max_process_rss_kib") for run in runs]
    peak = max(peaks) if peaks and all(type(rss) is int for rss in peaks) else None
    status = "SKIPPED"
    if runs:
        status = "COMPLETED" if all(r["status"] == "COMPLETED" for r in runs) else "INCOMPLETE"
    return {
        "status": status, "agent_invocations": len(runs),
        "wall_seconds": sum(r["wall_seconds"] for r in runs),
        "token_usage": usage if usage_complete else None,
        "tokens": total,
        "resources": {"max_process_rss_kib": peak} if runs else None, "model": None,
        "token_usage_note": "actual turn.completed events; individual attempts retain partial telemetry",
        "attempts": attempts,
    }



def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("report", type=Path)
    parser.add_argument("--output", type=Path)
    parser.add_argument("--agent-timeout", type=float, default=900)
    parser.add_argument("--check-timeout", type=float, default=600)
    parser.add_argument("--proof-cache", type=Path, default=ROOT / ".spectest" / "proof-cache")
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

    command = args.agent_command or [
        os.environ.get("CODEX_BIN", "codex"), "exec", "--model", "gpt-6.1-sol", "--json", "--skip-git-repo-check",
        "--sandbox", "workspace-write", "--ephemeral", "-C", str(ROOT), "--add-dir", str(out),
    ]
    attempts, plans = [], []

    def check_round(report_path, proof_dir, requests, negative_vcs, negative_entries, only_case_ids=None):
        prepared = prepare_run_certificates(report_path, proof_dir,
                                            refute_preconditions=negative_entries,
                                            refute_vcs=negative_vcs, decision_only=True,
                                            only_case_ids=only_case_ids)
        requests.mkdir(exist_ok=True)
        (requests / "controller-request.json").write_text(json.dumps(prepared, indent=2) + "\n")
        frozen = json.loads((proof_dir / "automatic.json").read_text())
        return check_run_certificates(
            Path(prepared["manifest"]), prepared["manifest_sha256"],
            switch=args.switch, timeout=args.check_timeout,
            candidate_attempts=proof_attempts(command, requests, args.proof_cache.resolve(),
                                              frozen, attempts, plans, args),
        )

    report = check_round(args.report.resolve(), out / "proof", out, refute_vcs,
                    set(args.refute_precondition))
    if plans and not (args.refute_precondition or refute_vcs):
        negative_vcs, negative_entries = {}, set()
        for case_id, plan in plans:
            vcs, entries = read_refutation_plan(plan, report)
            if (vcs.keys() | entries) - {case_id}:
                raise ValueError("proof routing plan refers to another execution")
            negative_vcs.update(vcs)
            negative_entries.update(entries)
        if negative_vcs or negative_entries:
            report = check_round(Path(report["report"]), out / "negative-proof",
                            out / "negative-agent", negative_vcs, negative_entries,
                            only_case_ids=negative_vcs.keys() | negative_entries)

    agent = agent_summary(attempts)
    (out / "agent-report.json").write_text(json.dumps(agent, indent=2) + "\n")
    report["proof_completion"]["agent"] = agent
    # Include failed replays and any positive round before a negative route.
    check_seconds = sum(row["check"]["duration_seconds"] for row in attempts)
    report["proof_completion"]["wall_seconds"] = check_seconds
    report["summary"]["proof_wall_seconds"] = check_seconds
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
