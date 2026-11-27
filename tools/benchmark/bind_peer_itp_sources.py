#!/usr/bin/env python3
"""Bind zero-model peer replays to traceable source receipts without recharging the donor."""
import argparse
from collections import Counter, defaultdict
from pathlib import Path

from organize_tespec_routes import RESULTS, fingerprint, read, save
from run_frozen_itp_queue import candidates, certificate_identity


def model_donors(folder, proposal):
    matches = []
    for receipt in sorted((folder / "model-receipts").glob("*.json")):
        model = read(receipt)
        if model["candidate_sha256"] == proposal["sha"] and model["exit_code"] == 0:
            matches.append((receipt.stat().st_mtime_ns, {"receipt_sha256": fingerprint(receipt),
                            "event_log_sha256": model["raw_event_log_sha256"]}))
    return matches


def replay_sources(scratch):
    rows = read(scratch / "queue.json")["executions"]
    authored = defaultdict(list)
    peers = []
    for row in rows:
        folder = scratch / row["native_report_sha256"]
        _, signature = certificate_identity(folder, row)
        for p in candidates(folder, row):
            stage = p["source"].relative_to(folder).parts[0]
            if stage.startswith(("peer-positive-replay-", "peer-negative-replay-")):
                peers.append((row, signature, folder / stage, p))
            elif stage in ("generated-itp", "repair-itp"):
                receipts = model_donors(folder, p)
                if receipts:
                    stage_dir = folder / stage
                    audit = p["source"].with_name("certificate-report.json")
                    authored[(row["group"], signature, p["sha"], p["target"])].append((
                        row["native_report_sha256"], p, receipts, max(audit.stat().st_mtime_ns,
                        (stage_dir / "routes.json").stat().st_mtime_ns)))
    return authored, peers


def historical_source(row, p, cache):
    # The historical cache is indexed by the exact recipient proof key.
    source = cache / (p["key"] + ".v")
    if not source.is_file() or fingerprint(source) != p["sha"]:
        return []
    archive = RESULTS / row["group"] / "tespec/current-itp.json"
    if not archive.is_file():
        return []
    matches = []
    for native, old in read(archive)["executions"].items():
        if any(old.get(k) != row[k] for k in ("case", "variant", "strategy", "goal_sha256",
                                              "executed_source_sha256", "input_sha256")):
            continue
        events = sorted({v["event_log_sha256"] for v in old["model_attempts"] if v["candidate_sha256"] == p["sha"]})
        if events:
            matches.append({"campaign": "archived_current_itp", "native_report_sha256": native,
                            "strict_proof_key": p["key"], "event_log_sha256": events})
    return matches


def bind(scratch):
    authored, peers = replay_sources(scratch)
    outcomes = Counter()
    for row, signature, out, p in peers:
        route = out / "routes.json"
        selected = out / "peer-selection.json"
        selection = read(selected) if selected.is_file() else None
        inspected = p["source"].with_name("manifest.json")
        target_stamp = inspected.stat().st_mtime_ns
        charged = {}
        source_receipt = None
        if selection:
            origin = Path(selection["source"])
            if (fingerprint(origin) != p["sha"] or selection["candidate_sha256"] != p["sha"]
                    or selection["recipient_proof_key"] != p["key"]):
                raise ValueError("Recorded source failed verification")
            archive_file = origin.with_name("manifest.json")
            source_receipt = {"candidate_sha256": p["sha"],
                              "manifest_sha256": fingerprint(archive_file) if archive_file.is_file() else None}
            if origin.is_relative_to(scratch) and len(origin.relative_to(scratch).parts[0]) == 64:
                source_receipt["native_report_sha256"] = origin.relative_to(scratch).parts[0]
        for native, donor, receipts, ready_stamp in authored[(row["group"], signature, p["sha"], p["target"])]:
            if native == row["native_report_sha256"] or ready_stamp > target_stamp:
                continue
            if donor["key"] != p["key"] and (p["target"] is not None or donor["audit"].get("proof_status") != "VALID"):
                continue
            if selection and source_receipt.get("native_report_sha256") and (
                Path(selection["source"]).relative_to(scratch).parts[1] in ("generated-itp", "repair-itp")
                and donor["source"] != Path(selection["source"])
            ):
                continue
            receipts = [evidence for stamp, evidence in receipts if stamp <= target_stamp]
            if not receipts:
                continue
            key = (native, donor["key"])
            charged[key] = {"campaign": "latest_itp", "native_report_sha256": native,
                            "strict_proof_key": donor["key"], "matching_model_receipts": receipts}
        donors = sorted(charged.values(), key=lambda v: v["native_report_sha256"])
        if not donors:
            donors = historical_source(row, p, scratch / "historical-positive-sources")
        status = ("unique_matching_donor" if len(donors) == 1 else
                  "multiple_indistinguishable_model_donors" if donors else "generation_donor_unresolved")
        provenance = {"route_receipt_sha256": fingerprint(route), "recipient_native_report_sha256": row["native_report_sha256"],
                      "recipient_strict_proof_key": p["key"], "candidate_sha256": p["sha"],
                      "polarity": "negative" if p["target"] else "positive", "refuted_goal": p["target"],
                      "recipient_model_calls": 0, "donor_resolution": status, "model_charged_to": donors,
                      **({"recorded_source": source_receipt} if source_receipt else {})}
        path = out / "peer-source.json"
        if not path.exists() or read(path) != provenance:
            save(path, provenance)
        outcomes[status] += 1
    return outcomes


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--scratch", type=Path, required=True)
    print(dict(bind(parser.parse_args().scratch)), flush=True)
