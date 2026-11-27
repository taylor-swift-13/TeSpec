#!/usr/bin/env python3
"""Replay hash-bound historical Coq refutations on an execution's original target."""

import argparse
from collections import Counter
from concurrent.futures import ThreadPoolExecutor
from functools import lru_cache
import hashlib
import os
from pathlib import Path
import re
import tempfile
from types import SimpleNamespace

from organize_tespec_routes import ROOT, RESULTS, fingerprint, read, reference, save
from spectest.certificates import (
    check_candidate_commands,
    prepare_certificate,
    goal_interface,
)
from spectest.itp_schedule import route_case_ids
from spectest.proof_reuse import proof_key
from spectest.routes import itp_command, measure, proof_costs

IDENT = r"[A-Za-z_]\w*"
THEOREM = re.compile(
    rf"\b(?:Theorem|Lemma)\s+({IDENT})\s*:\s*~\s*({IDENT})\.({IDENT})\s*\."
)
FORALL = re.compile(r"\bforall\s*((?:\(\s*[A-Za-z_]\w*\s*:\s*Z\s*\)\s*)+)")
Z_NAME = re.compile(r"\(\s*([A-Za-z_]\w*)\s*:\s*Z\s*\)")
BINDER = re.compile(r"\(\s*([A-Za-z_]\w*)\s*:")
SIGNATURE = re.compile(r"\bModule Type VC_Correct\s*\.[\s\S]*?\bEnd VC_Correct\s*\.")
LOCAL_IMPORT = re.compile(
    r"(?m)^Require Import ([A-Za-z_]\w*(?:\s+[A-Za-z_]\w*)*)\s*\."
)
SOURCE = RESULTS.parent / "programs"


def require(condition, message):
    if not condition:
        raise ValueError(str(message))


def statement(text, target):
    found = re.search(
        rf"\bDefinition\s+{re.escape(target)}\s*:=\s*([\s\S]*?)\.(?=\s|$)", text
    )
    return found[1] if found else None


def canonical(text):
    # This is a search key only. Final equality/implication is kernel checked.
    ordered = FORALL.sub(
        lambda m: "forall"
        + "".join("(" + n + ":Z)" for n in sorted(Z_NAME.findall(m[1]))),
        text,
    )
    return re.sub(r"\s+", "", ordered)


def bridge(old, new, target, theorem, namespace):
    if canonical(old) != canonical(new):
        return None
    lines = [
        "Require Import Goal.",
        "Module Proofs.",
        f"Theorem proof_of_{target} : ~ Goal.{target}.",
        "Proof.",
        "  intro current.",
        f"  apply LegacyProof.{theorem}.",
        f"  unfold {namespace}.{target}, Goal.{target} in *.",
    ]
    if re.sub(r"\s+", "", old) == re.sub(r"\s+", "", new):
        lines.append("  exact current.")
    else:
        old_arms, new_arms = old.split("\\/"), new.split("\\/")
        if len(old_arms) != len(new_arms):
            return None
        names = [f"arm{i}" for i in range(len(old_arms))]
        if len(names) > 1:
            pattern = names[-1]
            for n in reversed(names[:-1]):
                pattern = f"[{n} | {pattern}]"
            lines.append("  destruct current as " + pattern + ".")
        for i, (a, b) in enumerate(zip(old_arms, new_arms)):
            if "," not in a or "," not in b:
                return None
            old_vars, new_vars = (
                BINDER.findall(a.split(",", 1)[0]),
                BINDER.findall(b.split(",", 1)[0]),
            )
            if (
                not old_vars
                or len(set(old_vars)) != len(old_vars)
                or sorted(old_vars) != sorted(new_vars)
            ):
                return None
            choose = "right. " * i + ("left. " if i < len(names) - 1 else "")
            claim = names[i] if len(names) > 1 else "current"
            lines.append(
                "  "
                + ("- " if len(names) > 1 else "")
                + choose
                + "intros "
                + " ".join(old_vars)
                + "."
            )
            lines.append("    exact (" + claim + " " + " ".join(new_vars) + ").")
    return "\n".join([*lines, "Qed.", "End Proofs.", ""])


@lru_cache(maxsize=None)
def historical_native_runs(group):
    rows = {}
    for path in sorted((RESULTS / group).glob("*/results.json")):
        evidence = read(path)
        if not isinstance(evidence, dict):
            continue
        for row in evidence.get("runs", []):
            if not isinstance(row, dict) or not isinstance(row.get("tespec"), dict):
                continue
            report = row["tespec"].get("report_omitted")
            if report and row.get("qcp_source_sha256"):
                rows[report["sha256"]] = row
    return rows


@lru_cache(maxsize=None)
def sources(group):
    paths = sorted(
        (RESULTS / group).glob("*-itp-per-execution/execution-*/receipt.json")
    )
    paths += sorted(
        (RESULTS / group).glob(
            "*-itp-per-execution/execution-*/attempt-*/coq-receipt.json"
        )
    )
    records = []
    for path in paths:
        doc = read(path)
        if doc.get("status") == "REFUTED_KERNEL_CHECKED":
            bind = doc["case_binding"]
            check = next(
                (
                    a
                    for a in doc["attempts"]
                    if a["candidate_sha256"] == bind["proof_sha256"]
                    and a["status"] == "KERNEL_CHECKED"
                ),
                None,
            )
            if not check:
                continue
            candidate = ROOT / bind["proof"]
            goal = ROOT / bind["goal_copy"]
            goal_sha = bind["goal_copy_sha256"]
        elif (
            doc.get("status") == "KERNEL_CHECKED" and doc.get("final_status") == "FAIL"
        ):
            bind = doc["binding"]
            check = doc
            candidate = ROOT / doc["candidate"]
            copies = [
                p
                for p in candidate.parent.glob("*.v")
                if fingerprint(p) == bind["goal_sha256"]
            ]
            if len(copies) != 1:
                continue
            goal = copies[0]
            goal_sha = bind["goal_sha256"]
        else:
            continue
        require(
            fingerprint(candidate) == check["candidate_sha256"]
            and fingerprint(goal) == goal_sha
            and check["kernel_check"]["exit_code"] == 0,
            path,
        )
        if not bind.get("qcp_source_sha256"):
            historical = historical_native_runs(group).get(
                bind["original_test_report_omitted"]["sha256"]
            )
            require(
                historical
                and historical["variant"] == bind["variant"]
                and historical["case"] == bind["case"],
                path,
            )
            bind = {
                **bind,
                "qcp_source_sha256": historical["qcp_source_sha256"],
                "binds_sha256": historical.get("binds_sha256"),
            }
        mapped = {p.stem: p for p in candidate.parent.glob("*.v") if p != candidate}
        model = doc.get("model") or read(ROOT / check["model_receipt"])
        require(
            {f.name: fingerprint(f) for f in mapped.values()}
            == model["locked_goal_and_helper_sha256"],
            path,
        )
        for theorem, namespace, target in THEOREM.findall(candidate.read_text()):
            if namespace != goal.stem:
                continue
            old = statement(goal.read_text(), target)
            if old:
                records.append(
                    (
                        bind,
                        path,
                        candidate,
                        mapped,
                        theorem,
                        namespace,
                        target,
                        old,
                        model["requested_model"],
                        model.get("requested_reasoning_effort"),
                    )
                )
    return records


FINITE_CLOSING = "cbv beta iota zeta in *;\n  repeat match goal with |- context [if ?b then _ else _] => destruct b eqn:? end;\n  repeat match goal with\n  | H : Z.eqb _ _ = true |- _ => apply Z.eqb_eq in H\n  | H : Z.eqb _ _ = false |- _ => apply Z.eqb_neq in H\n  | H : Z.leb _ _ = true |- _ => apply Z.leb_le in H\n  | H : Z.leb _ _ = false |- _ => apply Z.leb_gt in H\n  | H : Z.ltb _ _ = true |- _ => apply Z.ltb_lt in H\n  | H : Z.ltb _ _ = false |- _ => apply Z.ltb_ge in H\n  end; first [lia | solve [intuition (try congruence; try lia)] | eauto 16]"


def embed(candidate, modules, namespace, finish_finite_goals=False):
    # A legacy module's VC_Correct signature declares axioms as interface fields.
    # Embed only definitions, never these signatures or any precompiled library.
    text = candidate.read_text()
    names = set(modules)
    blocks = []
    for key, path in sorted(modules.items()):
        src = path.read_text()
        if key == namespace:
            src = SIGNATURE.sub("", src)
        blocks.append(f"Module {key}.\n{src}\nEnd {key}.")

    def imports(m):
        words = m[1].split()
        if not (set(words) & names):
            return m[0]
        require(set(words) <= names, ("mixed embedded import", words))
        return "Import " + " ".join(words) + "."

    code = LOCAL_IMPORT.sub(imports, text)
    if finish_finite_goals:
        # A migrated tactic may leave finite Boolean goals. Never replace its
        # original statement or close an unchecked proof. Coq checks the result.
        code = re.sub(
            r"\bintuition\s+congruence\.",
            lambda _: "first [solve [intuition congruence] | solve ["
            + FINITE_CLOSING
            + "]].",
            code,
        )
        code = re.sub(
            r"\bQed\.", lambda _: "all: try solve [" + FINITE_CLOSING + "].\nQed.", code
        )

    blocks.append("Module LegacyProof.\n" + code + "\nEnd LegacyProof.")
    return "\n".join(blocks) + "\n"


@lru_cache(maxsize=None)
def plan_cases(group):
    result = {}
    for pair in read(SOURCE / group / "evaluation-plan.json")["pairings"]:
        for c in pair["cases"]:
            key = pair["qcp_variant"], c["id"]
            require(key not in result, key)
            result[key] = pair["cn_variant"], c
    return result


def match(group, row, folder, finish_finite_goals=False):
    cn_variant, planned = plan_cases(group)[row["variant"], row["case"]]
    if not any(
        bind["variant"] in (cn_variant, row["variant"]) and bind["case"] == row["case"]
        for bind, *_ in sources(group)
    ):
        return None
    native = folder / "out/native/report.json"
    require(fingerprint(native) == row["native_report_sha256"], native)
    report = read(native)
    (case,) = report["results"]
    require(
        case["id"] == row["executor_case_id"]
        and fingerprint(report["source"]) == row["source_sha256"],
        native,
    )
    if case["id"] not in route_case_ids(report):
        return None
    goal = Path(case["vc"]["files"]["goal"])
    require(fingerprint(goal) == row["goal_sha256"], goal)
    original_interface = goal_interface(goal.read_text())
    t = planned["binds"]
    require(
        t["args"] == case["arguments"] and t.get("values", {}) == case["bindings"],
        row["case"],
    )
    for (
        bind,
        path,
        candidate,
        modules,
        theorem,
        namespace,
        target,
        old,
        historical_model,
        historical_effort,
    ) in sources(group):
        if (
            bind["variant"] not in (cn_variant, row["variant"])
            or bind["case"] != row["case"]
        ):
            continue
        if (
            bind.get("qcp_source_sha256")
            and bind["qcp_source_sha256"] != row["source_sha256"]
        ):
            continue
        if (f"proof_of_{target}", target) not in original_interface:
            continue
        if f"proof_of_{target}" not in case["vc"]["residual_goals"]:
            continue
        if planned.get("original_binds_sha256") and bind.get("binds_sha256"):
            require(
                planned["original_binds_sha256"] == bind["binds_sha256"],
                (group, row["case"]),
            )
        new = statement(goal.read_text(), target)
        wrapper = bridge(old, new, target, theorem, namespace) if new else None
        if not wrapper:
            continue
        code = embed(candidate, modules, namespace, finish_finite_goals) + wrapper
        check_candidate_commands(code)
        return (
            native,
            report,
            case,
            target,
            code,
            {
                "archive_receipt": reference(path),
                "historical_model": historical_model,
                "historical_reasoning_effort": historical_effort,
                "model_calls": 0,
                "original_candidate": reference(candidate),
                "original_modules": {k: reference(v) for k, v in modules.items()},
                "theorem": theorem,
                **(
                    {
                        "source_adaptation": "After archived tactics, close remaining finite Boolean cases with Coq case analysis, linear arithmetic, propositional reasoning, and ordinary auto."
                    }
                    if finish_finite_goals
                    else {}
                ),
            },
        )
    return None


def checked_outcome(out, row, target, source_hash):
    report = read(out / "itp/proof/report.json")
    (case,) = report["results"]
    (audit,) = report["proof_completion"]["agent"]["attempts"]
    checked = audit["check"]
    require(
        case["id"] == row["executor_case_id"]
        and checked["candidate_sha256"] == source_hash
        and checked["original_goal_sha256"] == row["goal_sha256"],
        out,
    )
    if checked.get("proof_status") == "VALID":
        stages = {s["stage"]: s for s in checked["stages"]}
        require(
            checked.get("polarity") == "negative"
            and checked.get("refuted_goal") == "proof_of_" + target
            and checked["assumptions_audited_goals"] == 1
            and not checked.get("unexpected_assumptions")
            and all(
                stages[name]["exit_code"] == 0
                for name in (
                    "compile_Goal.v",
                    "compile_Candidate.v",
                    "compile_Coverage.v",
                    "compile_Assumptions.v",
                    "kernel_replay",
                )
            ),
            out,
        )
    return {
        "original_vc_judgement": case.get("evidence", {}).get("vc_judgement"),
        "execution_counterexample": case.get("evidence", {}).get(
            "execution_counterexample"
        ),
        "execution_reason": case.get("reason"),
    }


def replay(task):
    group, row, scratch, *options = task
    folder = scratch / row["native_report_sha256"]
    selected = match(
        group, row, folder, finish_finite_goals=bool(options and options[0])
    )
    if not selected:
        return None
    native, report, case, target, code, provenance = selected
    source_hash = hashlib.sha256(code.encode()).hexdigest()
    out = folder / ("legacy-negative-replay-" + source_hash)
    if (out / "routes.json").is_file():
        path = out / "routes.json"
        record = read(path)
        provenance.update(checked_outcome(out, row, target, source_hash))
        require(
            record["native_report_sha256"] == row["native_report_sha256"]
            and record["replayed_archive"]["bridge_candidate_sha256"] == source_hash,
            path,
        )
        # Preserve the raw receipt digest cited by cross-campaign bindings.
        require(
            all(
                record["replayed_archive"].get(k, v) == v for k, v in provenance.items()
            ),
            path,
        )
        return record["cases"][0]["itp_status"]
    out.mkdir(exist_ok=False)
    target_id = "proof_of_" + target
    cache = out / "cache"
    cache.mkdir()
    with tempfile.TemporaryDirectory(dir=out) as temp:
        meta = prepare_certificate(
            Path(case["vc"]["manifest"]),
            Path(temp) / "proof",
            refute=target_id,
            only={target_id},
        )
        bundle = read(Path(meta["manifest"]))
        identity = proof_key(bundle, report, case)
        require(identity, case["id"])
    (cache / (identity + ".v")).write_text(code)
    args = SimpleNamespace(
        itp_config={"agent_timeout": 600, "check_timeout": 600, "switch": "qcp-8.20"},
        itp_replay_only=True,
        proof_cache=cache,
    )
    cmd = itp_command(args, native, out / "itp", {case["id"]}) + [
        "--refute-vc",
        case["id"] + "=" + target_id,
    ]
    # Record elapsed time inside the worker as well as from the dispatcher.
    # This keeps a queued caller's scheduling latency separate from proof execution.
    clock = out / "controller-seconds.txt"
    stats = measure(
        ["/usr/bin/time", "-q", "-f", "%e", "-o", str(clock), *cmd],
        out / "measurements/itp",
    )
    stats["controller_wall_seconds"] = float(clock.read_text().strip())
    result_file = out / "itp/proof/report.json"
    require(stats["exit_code"] in (0, 1) and result_file.is_file(), (out, stats))
    result = read(result_file)
    (final,) = result["results"]
    agent = result["proof_completion"]["agent"]
    require(
        fingerprint(native) == row["native_report_sha256"]
        and final["id"] == case["id"]
        and agent["agent_invocations"] == 0
        and agent["tokens"] == 0,
        out,
    )
    attempts = agent["attempts"]
    require(
        len(attempts) == 1
        and attempts[0]["source"] == "cache"
        and attempts[0]["check"]["candidate_sha256"] == source_hash,
        (out, attempts),
    )
    provenance.update(checked_outcome(out, row, target, source_hash))
    stats.update(
        status="COMPLETED",
        report=str(result_file),
        candidate_policy="replay_only",
        tokens=0,
        model_calls=0,
        checker_stages=proof_costs(agent),
        missing_candidates=[],
        native_report_sha256=row["native_report_sha256"],
    )
    save(
        out / "routes.json",
        {
            "native_report_sha256": row["native_report_sha256"],
            "eligible_executions": 1,
            "routes": {"itp": stats},
            "cases": [
                {"case_id": case["id"], "eligible": True, "itp_status": final["status"]}
            ],
            "replayed_archive": {
                **provenance,
                "selected_original_vc": target_id,
                "bridge_candidate_sha256": source_hash,
            },
        },
    )
    print(group, row["case"], row["strategy"], final["status"], flush=True)
    return final["status"]


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument("--scratch", type=Path, required=True)
    p.add_argument("--workers", type=int, default=2)
    p.add_argument(
        "--queue", type=Path, help="A manifest of frozen native execution records"
    )
    p.add_argument(
        "--list-matches",
        action="store_true",
        help="Check eligibility, input/VC/source binding without scheduling Coq",
    )
    p.add_argument("--group", action="append")
    p.add_argument(
        "--finish-finite-goals",
        action="store_true",
        help="Repair incomplete archived tactic scripts with a checked finite Boolean closing tactic",
    )
    p.add_argument(
        "--native-report-sha",
        action="append",
        help="Limit replay to specified frozen native reports",
    )
    p.add_argument("--limit", type=int)
    args = p.parse_args()
    if args.queue and (args.scratch / "resource-slots").is_dir():
        os.environ.setdefault(
            "TESPEC_ITP_RESOURCE_DIR", str((args.scratch / "resource-slots").resolve())
        )
    tasks = []
    if args.queue:
        inventory = [(row["group"], row) for row in read(args.queue)["executions"]]
    else:
        inventory = [
            (file.parents[1].name, row)
            for file in sorted(RESULTS.glob("*/tespec/current-executions.json"))
            for row in read(file)["executions"]
            if row["native_status"] == "UNKNOWN"
        ]
    for group, row in inventory:
        if (
            args.native_report_sha
            and row["native_report_sha256"] not in args.native_report_sha
        ):
            continue
        if (args.group and group not in args.group) or not sources(group):
            continue
        tasks.append((group, row, args.scratch.resolve()))
    if args.list_matches:
        counts = Counter(
            group
            for group, row, scratch in tasks
            if match(group, row, scratch / row["native_report_sha256"])
        )
        print(dict(counts))
        return
    if args.limit:
        tasks = [
            t for t in tasks if match(t[0], t[1], t[2] / t[1]["native_report_sha256"])
        ][: args.limit]
    with ThreadPoolExecutor(args.workers) as pool:
        print(
            dict(
                Counter(
                    pool.map(replay, [(*t, args.finish_finite_goals) for t in tasks])
                )
            )
        )


if __name__ == "__main__":
    main()
