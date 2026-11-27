#!/usr/bin/env python3
"""Bind an independently checked negative proof to an identical frozen execution."""

import argparse
from functools import lru_cache
import json
from pathlib import Path
import sys
import tempfile

from collect_current_itp import gather
from replay_legacy_refutations import checked_outcome, match, require, sources
from organize_tespec_routes import ROOT, RESULTS, fingerprint, read, save
from spectest.certificates import prepare_certificate
from spectest.proof_reuse import proof_key
from spectest.routes import measure


def case_key(group, row):
    return group, row["variant"], row["case"], row["strategy"]


@lru_cache(maxsize=1)
def original_rows():
    return {
        case_key(f.parents[1].name, r): r
        for f in RESULTS.glob("*/tespec/current-executions.json")
        for r in read(f)["executions"]
    }


def identity(bundle, scratch):
    _, report, case, target, _, _ = bundle
    chosen = "proof_of_" + target
    with tempfile.TemporaryDirectory(dir=scratch) as temp:
        prepared = prepare_certificate(
            Path(case["vc"]["manifest"]),
            Path(temp) / "proof",
            refute=chosen,
            only={chosen},
        )
        return proof_key(read(Path(prepared["manifest"])), report, case)


def old_round(row, source_root):
    folder = source_root / row["native_report_sha256"]
    for p in sorted(folder.glob("legacy-negative-replay-*/routes.json")):
        if (p.parent / "dispatcher-paused.json").is_file():
            continue
        info = read(p)
        if info["native_report_sha256"] != row["native_report_sha256"]:
            continue
        checked = read(p.parent / "itp/proof/case_0000/certificate-report.json")
        if (
            checked.get("proof_status") == "VALID"
            and checked.get("polarity") == "negative"
        ):
            return p
    return None


def compare(queue, scratch, source_root, digest):
    rows = [r for r in read(queue)["executions"] if r["native_report_sha256"] == digest]
    require(len(rows) == 1, digest)
    row = rows[0]
    g = row["group"]
    old = original_rows()[case_key(g, row)]
    origin = old_round(old, source_root)
    require(origin is not None, (digest, "missing verified original run"))
    old_hash = old["native_report_sha256"]
    for field in (
        "input_sha256",
        "source_sha256",
        "executed_source_sha256",
        "goal_sha256",
        "executor_case_id",
    ):
        require(old[field] == row[field], (digest, field))
    legacy = match(g, old, source_root / old_hash)
    latest = match(g, row, scratch / digest)
    require(legacy and latest and legacy[3:] == latest[3:], digest)
    prior, current = legacy[2], latest[2]
    # Only the location of otherwise hash-verified artifacts, CLI, and measurement
    # fields may vary. Every semantic field (including native status, decision
    # phases, path/target ownership, entry, branches, all residuals) must agree.
    locations = {
        "generated_source",
        "duration_seconds",
        "peak_rss_kb",
        "command",
        "stdout",
        "stderr",
        "vc",
        "resources",
    }
    require(
        {k: v for k, v in prior.items() if k not in locations}
        == {k: v for k, v in current.items() if k not in locations},
        (digest, "native semantic record differs"),
    )
    for field in ("residual_goals", "counterexample_goals", "target_layout", "status"):
        require(prior["vc"].get(field) == current["vc"].get(field), (digest, field))
    k1 = identity(legacy, scratch)
    k2 = identity(latest, scratch)
    require(k1 and k1 == k2, (digest, "original proof identity differs"))
    receipt = read(origin)
    archive = receipt["replayed_archive"]
    target = latest[3]
    outcome = checked_outcome(
        origin.parent, old, target, archive["bridge_candidate_sha256"]
    )
    require(
        outcome["original_vc_judgement"] == "VC_REFUTED"
        and outcome["execution_counterexample"] == "NOT_ESTABLISHED"
        and current["status"] == "UNKNOWN",
        digest,
    )
    check_path = origin.parent / "itp/proof/case_0000/certificate-report.json"
    check = read(check_path)
    complete = receipt["routes"]["itp"]
    require(
        complete["model_calls"] == 0
        and complete["max_process_rss_kib"] > 0
        and complete["wall_seconds"] > 0
        and check.get("kernel_replay_mode") == "full",
        origin,
    )
    check_ref = fingerprint(check_path)
    return {
        "schema": "tespec-identical-execution-kernel-reuse/v1",
        "group": g,
        "variant": row["variant"],
        "case": row["case"],
        "strategy": row["strategy"],
        "source_sha256": row["source_sha256"],
        "executed_source_sha256": row["executed_source_sha256"],
        "input_sha256": row["input_sha256"],
        "goal_sha256": row["goal_sha256"],
        "shared_check_id": check_ref,
        "old_native_report_sha256": old_hash,
        "native_report_sha256": digest,
        "batch_native_report_sha256": row["batch_native_report_sha256"],
        "old_proof_key": k1,
        "new_proof_key": k2,
        "old_receipt": {
            "routes_sha256": fingerprint(origin),
            "certificate_sha256": check_ref,
            "group_itp_path": str(
                (RESULTS / g / "tespec/current-itp.json").relative_to(ROOT)
            ),
            "execution_key": old_hash,
            "candidate_sha256": check["candidate_sha256"],
        },
        "checked_roots": [archive["selected_original_vc"]],
        "requested_polarity": "negative",
        "polarity": check["polarity"],
        "proof_status": check["proof_status"],
        "kernel_replay_mode": check["kernel_replay_mode"],
        "assumptions": check["assumptions"],
        "unexpected_assumptions": check["unexpected_assumptions"],
        "assumptions_audited_goals": check["assumptions_audited_goals"],
        "final_status": current["status"],
        **outcome,
        "archived_source": {
            **latest[5],
            "bridge_candidate_sha256": check["candidate_sha256"],
        },
        "cold_check": {
            "wall_seconds": complete["wall_seconds"],
            "max_process_rss_kib": complete["max_process_rss_kib"],
            "tokens": 0,
            "model_calls": 0,
            "checker_stages": complete["checker_stages"],
        },
        "scope": "One measured ITP checker invocation per input/strategy, shared across two equivalent native reports. The binding process independently reconstructs both certificate identities. Count shared_check_id once across campaigns. The checked parent refutation does not establish an execution counterexample.",
    }


def publish_history(queue, source_root):
    """Persist old, hash-bound stages and proof objects which the new records cite."""
    updated = 0
    for group in sorted({row["group"] for row in read(queue)["executions"]}):
        if not sources(group):
            continue
        base = RESULTS / group
        path = base / "tespec/current-itp.json"
        previous = read(path)
        changes = {}
        for row in read(base / "tespec/current-executions.json")["executions"]:
            digest = row["native_report_sha256"]
            folder = source_root / digest
            routes = list(folder.glob("legacy-negative-replay-*/routes.json"))
            if not routes:
                continue
            item = gather(folder, row, base)
            if item is None:
                continue
            for route in routes:
                report = read(route)
                cert_file = route.parent / "itp/proof/case_0000/certificate-report.json"
                certificate = read(cert_file)
                matches = [
                    c
                    for c in item["checks"]
                    if c["candidate_sha256"] == certificate["candidate_sha256"]
                    and [(z["stage"], z["wall_seconds"]) for z in c["stages"]]
                    == [(z["stage"], z["wall_seconds"]) for z in certificate["stages"]]
                ]
                require(len(matches) == 1, cert_file)
                shared = fingerprint(cert_file)
                matches[0]["certificate_sha256"] = shared
                (attempt,) = [
                    a
                    for a in item["attempts"]
                    if a["report_sha256"] == fingerprint(route)
                ]
                attempt["certificate_sha256"] = shared
                old_candidate = report["replayed_archive"]["original_candidate"][
                    "sha256"
                ]
                origin = next(
                    (v for v in sources(group) if fingerprint(v[2]) == old_candidate),
                    None,
                )
                require(origin is not None, old_candidate)
                attempt["replayed_archive"].update(
                    historical_model=origin[-2],
                    historical_reasoning_effort=origin[-1],
                    model_calls=0,
                )
            if previous["executions"].get(digest) != item:
                changes[digest] = item
        if changes:
            latest = read(path)
            latest["executions"].update(changes)
            save(path, latest)
            updated += len(changes)
    return updated


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument("--queue", type=Path, required=True)
    p.add_argument("--scratch", type=Path, required=True)
    p.add_argument("--from-scratch", type=Path, required=True)
    p.add_argument("--one")
    p.add_argument(
        "--publish-history",
        action="store_true",
        help="Persist the old compact stage receipts, content-addressed proof sources and shared check IDs",
    )
    a = p.parse_args()
    if a.one:
        print(
            json.dumps(
                compare(a.queue, a.scratch, a.from_scratch, a.one),
                separators=(",", ":"),
            )
        )
        return
    # A new cross-campaign reference must already resolve to durable proof
    # source and a per-attempt receipt, even while the outer run is in progress.
    updated = publish_history(a.queue, a.from_scratch)
    if updated or a.publish_history:
        print("updated durable source executions", updated)
    total = added = 0
    durable = {}
    for row in read(a.queue)["executions"]:
        g = row["group"]
        digest = row["native_report_sha256"]
        if not sources(g):
            continue
        old = original_rows().get(case_key(g, row))
        origin = old_round(old, a.from_scratch) if old else None
        if not origin:
            continue
        if g not in durable:
            durable[g] = read(RESULTS / g / "tespec/current-itp.json")["executions"]
        source = durable[g].get(old["native_report_sha256"], {})
        shared = fingerprint(
            origin.parent / "itp/proof/case_0000/certificate-report.json"
        )
        if not any(
            c.get("certificate_sha256") == shared for c in source.get("checks", [])
        ):
            continue
        total += 1
        out = a.scratch / digest / "legacy-verified-binding.json"
        if out.exists():
            require(read(out)["native_report_sha256"] == digest, out)
            continue
        with tempfile.TemporaryDirectory(dir=a.scratch / digest) as tmp:
            work = Path(tmp)
            measurement = measure(
                [
                    sys.executable,
                    "-B",
                    str(Path(__file__).resolve()),
                    "--queue",
                    str(a.queue.resolve()),
                    "--scratch",
                    str(a.scratch.resolve()),
                    "--from-scratch",
                    str(a.from_scratch.resolve()),
                    "--one",
                    digest,
                ],
                work,
            )
            require(
                measurement["exit_code"] == 0,
                (digest, (work / "stderr.log").read_text()[-800:]),
            )
            record = read(work / "stdout.log")
            record["binding_cost"] = {**measurement, "tokens": 0, "model_calls": 0}
            save(out, record)
            added += 1
    print("eligible measured proofs", total, "new bindings", added)


if __name__ == "__main__":
    main()
