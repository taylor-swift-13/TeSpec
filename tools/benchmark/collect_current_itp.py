#!/usr/bin/env python3
"""Collect compact ITP receipts for the exact measured native reports."""
import argparse
import fcntl
import os
from pathlib import Path
import shutil
from tempfile import NamedTemporaryFile

from organize_tespec_routes import RESULTS, ROOT, fingerprint, read, reference, save


def proof_sources(folder, base):
    files = {}
    for path in sorted(folder.rglob("*.v")):
        sha = fingerprint(path)
        target = base / "tespec/proof-objects" / sha / path.name
        if not target.exists():
            target.parent.mkdir(parents=True, exist_ok=True)
            with NamedTemporaryFile(dir=target.parent, prefix=".proof-", delete=False) as tmp:
                staged = Path(tmp.name)
            try:
                shutil.copyfile(path, staged)
                if fingerprint(staged) != sha:
                    raise ValueError("ITP proof source changed during collection")
                try:
                    os.link(staged, target)
                except FileExistsError:
                    pass
            finally:
                staged.unlink(missing_ok=True)
        if fingerprint(target) != sha:
            raise ValueError("Changed proof source")
        files[str(path.relative_to(folder))] = reference(target)
    return files


def gather(folder, row, base):
    rounds = [folder / n for n in ("current-itp", "generated-itp", "repair-itp")]
    for prefix in ("runtime-source-replay-", "legacy-negative-replay-", "peer-positive-replay-", "peer-negative-replay-"):
        rounds.extend(sorted(folder.glob(prefix + "*")))
    if any(p.is_dir() and not (p / "routes.json").exists() for p in rounds):
        return None
    receipts = [p / "routes.json" for p in rounds if (p / "routes.json").is_file()]
    if not receipts:
        return None
    attempts = []
    checks = []
    model_steps = []
    sources = {}
    reported_calls = 0
    for path in receipts:
        d = read(path)
        case, = d["cases"]
        if (d["native_report_sha256"] != row["native_report_sha256"] or
                case["case_id"] != row["executor_case_id"] or not case["eligible"]):
            raise ValueError("ITP result bound to a different execution")
        itp = d["routes"]["itp"]
        reported_calls += itp.get("model_calls", 0) or 0
        agent_file = path.parent / "itp/agent-report.json"
        agent = read(agent_file) if agent_file.exists() else {"attempts": [read(f) for f in sorted((path.parent/"itp").glob("**/attempt-*/attempt.json"))]}
        bundles = {fingerprint(p): read(p) for p in path.parent.glob("itp/*proof/case_*/manifest.json")}
        for attempt in agent.get("attempts", []):
            audit = attempt["check"]
            if audit.get("original_goal_sha256") != row["goal_sha256"]:
                raise ValueError("Wrong ITP parent goal")
            requested = bundles.get(audit["manifest_sha256"])
            if requested is None or requested["original_goal_sha256"] != row["goal_sha256"]:
                raise ValueError("Missing original certificate request for checked attempt")
            target = requested.get("refuted_goal")
            requested_proofs = [goal["proof"] for goal in requested["goals"]]
            if target is not None and target not in requested_proofs:
                raise ValueError("Refutation target is outside the requested original obligations")
            steps = []
            for step in audit["stages"]:
                steps.append({"stage": step["stage"], "exit_code": step["exit_code"], "wall_seconds": step["wall_seconds"],
                              "max_process_rss_kib": (step.get("resources") or {}).get("max_process_rss_kib"),
                              "log_sha256": fingerprint(step["log"]),
                              **({"candidate_resource_policy": "explicit_rlimit_as" if step.get("address_space_limit_bytes")
                                  else "no_address_space_limit_set_by_checker",
                                  "address_space_limit_bytes": step.get("address_space_limit_bytes")}
                                 if step["stage"] == "compile_Candidate.v" else {}),
                              **{k:step[k] for k in ("resource_failure", "measured_command") if k in step},
                              **({"queue_seconds": step["queue_seconds"]} if step.get("queue_seconds") else {})})
            checks.append({**{k: audit.get(k) for k in ("candidate_sha256", "proof_status", "polarity", "vc_status",
                                                         "execution_counterexample", "reason",
                                                         "assumptions", "unexpected_assumptions", "assumptions_audited_goals",
                                                         "kernel_replay_mode")}, **({"compiled_runtime_sources": audit["compiled_runtime_sources"]}
                               if audit.get("compiled_runtime_sources") else {}),
                           **({"generated_alignment": audit["generated_alignment"]} if audit.get("generated_alignment") else {}),
                           "requested_polarity": "negative" if target else "positive",
                           "refuted_goal": target, "requested_goals": requested_proofs,
                           "manifest_sha256": audit["manifest_sha256"], "stages": steps})
        for bundle in path.parent.glob("itp/*proof/case_*/manifest.json"):
            sources[str(bundle.parent.relative_to(folder))] = proof_sources(bundle.parent, base)
        attempts.append({"report_sha256": fingerprint(path), "wall_seconds": itp["wall_seconds"],
                         "max_process_rss_kib": itp["max_process_rss_kib"], "status": case["itp_status"],
                         "missing_candidates": itp.get("missing_candidates", []),
                         **({"replayed_archive": d["replayed_archive"]} if d.get("replayed_archive") else {}),
                         **({"dispatcher_pause": read(path.with_name("dispatcher-paused.json"))}
                            if path.with_name("dispatcher-paused.json").is_file() else {})})
    for path in sorted(folder.glob("model-receipts/*.json")):
        m = read(path)
        cmd = m["command"]
        if (m["requested_model"] != "gpt-6.1-sol" or m["requested_reasoning_effort"] != "medium"
                or "--model" not in cmd or cmd[cmd.index("--model") + 1:cmd.index("--model") + 2] != ["gpt-6.1-sol"]
                or not any(cmd[i] in ("-c", "--config") and v == 'model_reasoning_effort="medium"'
                           for i, v in enumerate(cmd[1:]))):
            raise ValueError("Nonconforming ITP model CLI settings")
        usage = m["token_usage"]
        model_steps.append({"requested_model": m["requested_model"], "requested_reasoning_effort": m["requested_reasoning_effort"],
                            "exit_code": m["exit_code"], "wall_seconds": m["wall_seconds"],
                            "max_process_rss_kib": m["resources"]["max_process_peak_working_set_bytes"] / 1024 or None,
                            "usage_events": usage, "candidate_sha256": m["candidate_sha256"],
                            "locked_inputs": m["locked_goal_and_helper_sha256"], "prompt_sha256": m["prompt_sha256"],
                            "event_log_sha256": m["raw_event_log_sha256"],
                            **({"historical_proof_sha256": m["historical_proof_sha256"]}
                               if m.get("historical_proof_sha256") else {})})
    def cost(steps):
        peaks = [s["max_process_rss_kib"] for s in steps]
        return {"invoked": bool(steps), "wall_seconds": sum(s["wall_seconds"] for s in steps),
                "max_process_rss_kib": max(peaks) if peaks and None not in peaks else None, "tokens": 0}
    if len(model_steps) < reported_calls:
        raise ValueError("Missing model attempt receipt")
    stages = [s for c in checks for s in c["stages"]]
    model = cost(model_steps)
    for key in ("input_tokens", "output_tokens"):
        model[key] = (sum(e[key] for s in model_steps for e in s["usage_events"])
                      if all(s["usage_events"] and all(isinstance(e.get(key), int) for e in s["usage_events"]) for s in model_steps) else None)
    model["tokens"] = None if None in (model["input_tokens"],model["output_tokens"]) else model["input_tokens"] + model["output_tokens"]
    resource_failure_file = folder / "resource-failures.json"
    metering = {"resource_failures": read(resource_failure_file)["events"]} if resource_failure_file.exists() else {}
    protected = [read(p) for p in sorted(folder.glob("memory-limit-replay-*/receipt.json"))]
    if protected:
        for replay in protected:
            if (replay["native_report_sha256"] != row["native_report_sha256"]
                    or replay["original_goal_sha256"] != row["goal_sha256"] or replay["model_calls"] != 0
                    or not any(c["manifest_sha256"] == replay["manifest_sha256"]
                               and c["candidate_sha256"] == replay["candidate_sha256"] for c in checks)):
                raise ValueError("Unbound protected ITP memory replay")
            stages.extend(replay["stages"])
        metering["resource_protection_replays"] = protected
    resource_replays = [read(p) for p in sorted(folder.glob("resource-replay-*/receipt.json"))]
    if resource_replays:
        measurements = []
        used = set()
        for chk in checks:
            original = [step for step in chk["stages"] if not step["stage"].startswith("kernel_replay")]
            if all(step["max_process_rss_kib"] is not None for step in original):
                measurements.extend(original)
                continue
            matched = next((i for i, r in enumerate(resource_replays) if i not in used
                            and r["manifest_sha256"] == chk["manifest_sha256"]
                            and r["candidate_sha256"] == chk["candidate_sha256"]
                            and r["original_goal_sha256"] == row["goal_sha256"]
                            and r["native_report_sha256"] == row["native_report_sha256"]), None)
            if matched is None:
                measurements.extend(original)
            else:
                used.add(matched)
                measurements.extend(s for s in resource_replays[matched]["stages"] if not s["stage"].startswith("kernel_replay"))
        if len(used) != len(resource_replays):
            raise ValueError("Unmatched ITP resource replay")
        metering = {**metering, "resource_replays": resource_replays,
                    "itp_coq_comparable": cost(measurements),
                    "itp_coq_comparable_scope": "One complete measurement per original certificate attempt, using an identical-input replay if its original RSS was lost",
                    "itp_coq_total_observed_wall_seconds": sum(s["wall_seconds"] for s in stages if not s["stage"].startswith("kernel_replay")) +
                        sum(s["wall_seconds"] for r in resource_replays for s in r["stages"] if not s["stage"].startswith("kernel_replay"))}
    terminal = {a["status"] for a in attempts if a["status"] in {"PASS", "FAIL", "CRASH"}}
    if len(terminal) > 1:
        raise ValueError("Conflicting checked verdicts for a single native report")
    final = next(iter(terminal), attempts[-1]["status"])
    interrupted = [read(p) for p in sorted(folder.glob("interrupted-*/interruption.json"))]
    return {**metering, **({"interrupted_attempts": interrupted, "cumulative_costs_complete": False,
                "cost_scope": "completed rounds only"} if interrupted else {}),
            "variant": row["variant"], "case": row["case"], "strategy": row["strategy"],
            "input_sha256": row["input_sha256"], "executed_source_sha256": row["executed_source_sha256"],
            "goal_sha256": row["goal_sha256"], "final_status": final,
            "needs_model": bool(attempts[-1]["missing_candidates"]) and not model_steps,
            "attempts": attempts, "checks": checks, "proof_sources": sources, "model_attempts": model_steps,
            "itp_model": model, "itp_coq": cost([s for s in stages if not s["stage"].startswith("kernel_replay")]),
            "itp_kernel": cost([s for s in stages if s["stage"].startswith("kernel_replay")])}



def checkpoint(scratch, current, row):
    base = current.parents[1]
    item = gather(scratch / row["native_report_sha256"], row, base)
    if not item:
        raise ValueError("No checked receipt for " + row["native_report_sha256"])
    path = current.with_name("current-itp.json")
    with (scratch / ("itp-results-" + base.name + ".lock")).open("a") as guard:
        fcntl.flock(guard, fcntl.LOCK_EX)
        index = read(path)
        index["executions"][row["native_report_sha256"]] = item
        save(path, index)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--scratch", type=Path, required=True)
    args = parser.parse_args()
    for path in sorted(RESULTS.glob("*/tespec/current-executions.json")):
        base = path.parent.parent
        output = path.with_name("current-itp.json")
        records = read(output)["executions"] if output.exists() else {}
        rows = read(path)["executions"]
        for row in rows:
            if row["auto_status"] == "NOT_RUN":
                continue
            native = row["native_report_sha256"]
            item = gather(args.scratch / native, row, base)
            if item:
                records[native] = item
        valid = {r["native_report_sha256"] for r in rows}
        save(output, {"schema": "tespec-measured-itp/v1", "executions": {k:v for k,v in records.items() if k in valid}})


if __name__ == "__main__":
    main()
