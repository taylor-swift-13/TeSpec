#!/usr/bin/env python3
"""Collect compact ITP receipts for the exact measured native reports."""
import argparse
from pathlib import Path
import shutil

from organize_tespec_routes import RESULTS, ROOT, fingerprint, read, reference, save


def proof_sources(folder, base):
    files = {}
    for path in sorted(folder.rglob("*.v")):
        sha = fingerprint(path)
        target = base / "tespec/proof-objects" / sha / path.name
        if not target.exists():
            target.parent.mkdir(parents=True, exist_ok=True)
            shutil.copyfile(path, target)
        if fingerprint(target) != sha:
            raise ValueError("Changed proof source")
        files[str(path.relative_to(folder))] = reference(target)
    return files


def gather(folder, row, base):
    rounds = [folder / n for n in ("current-itp", "generated-itp", "repair-itp")]
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
        for attempt in agent.get("attempts", []):
            audit = attempt["check"]
            if audit.get("original_goal_sha256") != row["goal_sha256"]:
                raise ValueError("Wrong ITP parent goal")
            steps = []
            for step in audit["stages"]:
                steps.append({"stage": step["stage"], "exit_code": step["exit_code"], "wall_seconds": step["wall_seconds"],
                              "max_process_rss_kib": (step.get("resources") or {}).get("max_process_rss_kib"),
                              "log_sha256": fingerprint(step["log"])})
            checks.append({**{k: audit.get(k) for k in ("candidate_sha256", "proof_status", "polarity", "reason",
                                                         "assumptions", "unexpected_assumptions", "assumptions_audited_goals",
                                                         "kernel_replay_mode")}, "stages": steps})
        for bundle in path.parent.glob("itp/*proof/case_*/manifest.json"):
            sources[str(bundle.parent.relative_to(folder))] = proof_sources(bundle.parent, base)
        attempts.append({"report_sha256": fingerprint(path), "wall_seconds": itp["wall_seconds"],
                         "max_process_rss_kib": itp["max_process_rss_kib"], "status": case["itp_status"],
                         "missing_candidates": itp.get("missing_candidates", [])})
    for path in sorted(folder.glob("model-receipts/*.json")):
        m = read(path)
        if m["requested_model"] != "gpt-6.1-sol" or m["requested_reasoning_effort"] != "medium":
            raise ValueError("Nonconforming ITP model")
        usage = m["token_usage"]
        model_steps.append({"requested_model": m["requested_model"], "requested_reasoning_effort": m["requested_reasoning_effort"],
                            "exit_code": m["exit_code"], "wall_seconds": m["wall_seconds"],
                            "max_process_rss_kib": m["resources"]["max_process_peak_working_set_bytes"] / 1024 or None,
                            "usage_events": usage, "candidate_sha256": m["candidate_sha256"],
                            "locked_inputs": m["locked_goal_and_helper_sha256"], "prompt_sha256": m["prompt_sha256"],
                            "event_log_sha256": m["raw_event_log_sha256"]})
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
    return {"variant": row["variant"], "case": row["case"], "strategy": row["strategy"],
            "input_sha256": row["input_sha256"], "executed_source_sha256": row["executed_source_sha256"],
            "goal_sha256": row["goal_sha256"], "final_status": attempts[-1]["status"],
            "needs_model": bool(attempts[-1]["missing_candidates"]) and not model_steps,
            "attempts": attempts, "checks": checks, "proof_sources": sources, "model_attempts": model_steps,
            "itp_model": model, "itp_coq": cost([s for s in stages if s["stage"] != "kernel_replay"]),
            "itp_kernel": cost([s for s in stages if s["stage"] == "kernel_replay"])}


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
