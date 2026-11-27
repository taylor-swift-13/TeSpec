#!/usr/bin/env python3
"""Collect original native process measurements once per batch of the latest finite matrix."""
import argparse
from collections import Counter, defaultdict
from pathlib import Path

from organize_tespec_routes import ROOT, RESULTS, branch_counts, digest, fingerprint, inputs, read, save
from prepare_latest_itp_queue import jobs
from current_test_plan import matches_crash
from replay_guarded_auto import inventory as guarded_inventory

BRANCH_FIELDS = ("pure_queries", "evaluated_true", "evaluated_false", "smt_fallback")


def phase_summary(states):
    measured = [r for r in states if r and r.get("wall_seconds") is not None]
    unknown = sum(bool(r) and r.get("wall_seconds") is None for r in states)
    return {"status":"PARTIAL" if unknown else "MEASURED" if measured else "NOT_INVOKED",
            "invoked_batches":sum(bool(r) for r in states),"measured_batches":len(measured),
            "not_invoked_batches":sum(r is None for r in states),"unmeasured_invocations":unknown,
            "states":dict(Counter(r.get("status") for r in states if r)),
            "wall_seconds":sum(r["wall_seconds"] for r in measured) if measured and not unknown else None,
            "max_process_rss_kib":max((r["max_process_rss_kib"] for r in measured),default=None) if not unknown else None,
            "tokens":sum(r["tokens"] for r in measured) if not unknown else None,"model_calls":0}


def stage_measure(route_path, route, name):
    if name=="layout_prepare":
        m=route.get("auto_layout")
        stage="layout"
    else:
        m=route["routes"].get("auto")
        stage="auto"
        if (m is None)!=(route["eligible_executions"]==0):
            raise ValueError("missing or unsolicited Auto invocation")
    if m is None:
        return None
    rss=route_path.parent/"measurements"/stage/"rss.txt"
    if (int(rss.read_text().strip())!=m["max_process_rss_kib"] or m["wall_seconds"]<=0
            or m["tokens"]!=0 or m["model_calls"]!=0):
        raise ValueError(f"incorrect {name} measurement: {route_path}")
    if name=="batch_auto" and m["native_report_sha256"]!=route["native_report_sha256"]:
        raise ValueError("Auto measured on different raw batch")
    return {"status":m["status"],"wall_seconds":m["wall_seconds"],"max_process_rss_kib":m["max_process_rss_kib"],
            "tokens":m["tokens"],"model_calls":m["model_calls"],"rss_sha256":fingerprint(rss),
            "route_sha256":fingerprint(route_path)}


def aggregate(batch_rows):
    inputs = [row for b in batch_rows for row in b["inputs"]]
    branch = [r["branches"] for r in inputs if r["branches"] is not None]
    unavailable = [{"group": r["group"], "variant": r["variant"], "case": r["case"], "strategy":r["strategy"],
                    "native_status": r["native_status"], "reason":r["reason"],"input_sha256":r["input_sha256"]}
                   for r in inputs if r["branches"] is None]
    return {"layout_prepare":phase_summary([b["layout_prepare"] for b in batch_rows]),
            "batch_auto":phase_summary([b["batch_auto"] for b in batch_rows]),
            "final_auto_outcomes":dict(Counter(r["final_auto"] for r in inputs)),
            "expected_matches":sum(r["expected_match"] for r in inputs),
            "native_batches":len(batch_rows),"native_invocations":sum(b["native_invocations"] for b in batch_rows),
            "guard_fallback_batches":sum(b["native_invocations"]>1 for b in batch_rows),"executions":len(inputs),"wall_seconds":sum(b["wall_seconds"] for b in batch_rows),
            "max_process_rss_kib":max((b["max_process_rss_kib"] for b in batch_rows),default=None),
            "tokens":sum(b["tokens"] for b in batch_rows),"model_calls":0,
            "source_cohorts":dict(Counter(b["scope"] for b in batch_rows)),"native_outcomes":dict(Counter(x["native_status"] for x in inputs)),
            "branch_records":len(branch),"branch_missing":len(unavailable),
            **{k:sum(stat[k] for stat in branch) for k in BRANCH_FIELDS},
            "missing_branch_cases":unavailable,
            "batch_evidence_sha256":digest(sorted(b["receipt_sha256"] for b in batch_rows)),
            "input_evidence_sha256":digest(sorted(digest(r) for r in inputs))}


def verify_meter(route, cost):
    fallback=cost.get("guard_fallback")
    meters=[("native",cost)] if not fallback else [("native",fallback["previous"]),("unguarded-native",fallback["unguarded"])]
    if (abs(sum(m["wall_seconds"] for _,m in meters)-cost["wall_seconds"])>1e-8
            or max(m["max_process_rss_kib"] for _,m in meters)!=cost["max_process_rss_kib"]):
        raise ValueError(f"incorrect combined native cost: {route}")
    receipts=[]
    for name,m in meters:
        rss=route.parent/"measurements"/name/"rss.txt"
        if (int(rss.read_text().strip())!=m["max_process_rss_kib"] or not m["measured_this_run"]
                or m["wall_seconds"]<=0 or m["tokens"]!=0):
            raise ValueError(f"native process evidence differs: {route}")
        receipts.append({"phase":name,"rss_sha256":fingerprint(rss),"wall_seconds":m["wall_seconds"],
                         "max_process_rss_kib":m["max_process_rss_kib"],"tokens":m["tokens"]})
    return receipts


def measure(args):
    groups=defaultdict(lambda:defaultdict(list))
    plans={}
    seen_batches=set()
    coordinates=set()
    all_batches=[]
    extra_batches=[]
    extra_phases=defaultdict(list)
    engine=fingerprint(ROOT/"bin/tespec-symexec")
    certified={(g,batch): raw for g,batch,_,_,raw,_ in guarded_inventory(args.guard)}
    for group,scope,replay,items in jobs(args.guard,args.final,args.remainder):
        if group not in plans:plans[group]=inputs(group)[0]
        final=read(replay)
        extras=[]
        if scope=="original_roots":
            refresh=args.final/"certificate-refresh"/group/replay.parent.name/"routes.json"
            if refresh.exists():
                superseded=stage_measure(replay,final,"batch_auto")
                if superseded:extra_phases[group,items[0][0][2],"superseded_certificates","batch_auto"].append(superseded)
                refreshed=read(refresh)
                if any(refreshed[k]!=final[k] for k in ("native_report_sha256","cases","spatial_smt_timeout_ms")):
                    raise ValueError("refreshed Auto certificate changed the original execution")
                replay,final=refresh,refreshed
            folder=args.guard/group/replay.parent.name
            if (folder/"timeout-retry/measurement.json").is_file():
                extras.append(("superseded_native",folder/"out/routes.json",None))
                folder=folder/"timeout-retry"
            route=folder/"out/routes.json"
            prior_hash=certified[group,replay.parent.name]
        else:
            route=replay
            archived=items[0][1]
            prior_hash=archived["native_report_sha256"]
            diagnostic=archived.get("additional_timeout_diagnostic")
            if diagnostic:
                extras.append((f"timeout_diagnostic_{diagnostic['budget_seconds']}s",
                               replay.parents[1]/"timeout-120/routes/routes.json",diagnostic["native_report_sha256"]))
        raw=read(route)
        if scope=="original_roots":
            before_auto=stage_measure(route,raw,"batch_auto")
            if before_auto:extra_phases[group,items[0][0][2],"superseded_guard_auto","batch_auto"].append(before_auto)
        layout_measure=stage_measure(route,raw,"layout_prepare")
        auto_measure=stage_measure(replay,final,"batch_auto")
        cost=raw["native_cost"]
        report_path=Path(raw["native_report"])
        native_sha=fingerprint(report_path)
        if (native_sha!=raw["native_report_sha256"] or native_sha!=final["native_report_sha256"]
                or native_sha!=prior_hash or native_sha in seen_batches or not cost["measured_this_run"]):
            raise ValueError(f"unmeasured, changed or repeated native report: {route}")
        seen_batches.add(native_sha)
        meters=verify_meter(route,cost)
        native=read(report_path)
        prov=native["provenance"]
        if (prov["binary_sha256"]!=engine or prov["job_sha256"]!=fingerprint(Path(native["job"]))
                or prov["source_sha256"]!=fingerprint(Path(native["source"]))):
            raise ValueError(f"native job or source mismatch: {route}")
        cases={r["id"]:r for r in native["results"]}
        states={r["case_id"]:r for r in final["cases"]}
        strategies={key[2] for key,_ in items}
        if len(strategies)!=1 or cases.keys()!=states.keys() or len(cases)!=len(items):
            raise ValueError("batch boundaries differ")
        strategy,=strategies
        rows=[]
        final_cases={c["id"]:c for c in read(Path(final["routes"]["auto"]["report"]))["results"]} if auto_measure else {}
        for key,archived in items:
            coordinate=(group,*key)
            if coordinate in coordinates:
                raise ValueError(f"duplicate planned execution {coordinate}")
            coordinates.add(coordinate)
            (func,source,bind,expected),_,fault=plans[group][key]
            case_id=archived["executor_case_id"]
            c=cases[case_id]
            if (source["sha256"]!=archived["source_sha256"] or digest(bind)!=archived["input_sha256"]
                    or expected!=archived["expected"] or fault!=archived["expected_fault_code"]
                    or c["arguments"]!=bind.get("args",{}) or c["bindings"]!=bind.get("values",{})
                    or native["function"]!=func or c["status"]!=states[case_id]["native_status"]):
                raise ValueError(f"incorrect execution in {route}: {key}")
            if c.get("execution_strategy",native["vc_policy"]["execution_strategy"])!=strategy:
                raise ValueError("different execution strategy")
            generated=Path(c["generated_source"])
            actual=fingerprint(generated)
            if (c.get("generated_source_sha256",actual)!=actual or
                    [a for a in c["command"] if a.startswith("--input-file=")]!=["--input-file="+str(generated)]):
                raise ValueError(f"actual execution source differs: {generated}")
            final_status=states[case_id]["auto_status"] if states[case_id]["eligible"] else c["status"]
            final_case=final_cases.get(case_id,c)
            ok=final_status==expected and (expected!="CRASH" or matches_crash(final_case,fault))
            rows.append({"expected":expected,"final_auto":final_status,"expected_match":ok,"group":group,"variant":key[0],"case":key[1],"strategy":strategy,"executor_case_id":case_id,
                         "input_sha256":digest(bind),"source_sha256":source["sha256"],"executed_source_sha256":actual,
                         "native_status":c["status"],"reason":c.get("reason"),"branches":branch_counts(c)})
        record={"scope":scope,"layout_prepare":layout_measure,"batch_auto":auto_measure,"native_report_sha256":native_sha,"native_provenance":prov,"route_sha256":fingerprint(route),
                "native_invocations":len(meters),"meters":meters,"wall_seconds":cost["wall_seconds"],
                "max_process_rss_kib":cost["max_process_rss_kib"],"tokens":cost["tokens"],"inputs":rows}
        record["receipt_sha256"]=digest(record)
        groups[group][strategy].append(record); all_batches.append(record)
        for kind, extra_path, expected_sha in extras:
            extra=read(extra_path)
            extra_sha=extra["native_report_sha256"]
            if extra_sha==native_sha or (expected_sha is not None and expected_sha!=extra_sha):
                raise ValueError(f"incorrect diagnostic identity: {extra_path}")
            extra_native_path=Path(extra["native_report"])
            if fingerprint(extra_native_path)!=extra_sha:
                raise ValueError(f"changed diagnostic report: {extra_path}")
            extra_native=read(extra_native_path)
            extra_cases={c["id"]:c for c in extra_native["results"]}
            if extra_cases.keys()!=cases.keys() or extra_native["provenance"]["binary_sha256"]!=engine:
                raise ValueError(f"different diagnostic case inventory: {extra_path}")
            for case_id, c in extra_cases.items():
                original=cases[case_id]
                if (c["arguments"],c["bindings"],c.get("type_bindings")) != (
                       original["arguments"],original["bindings"],original.get("type_bindings")):
                    raise ValueError(f"different diagnostic input: {extra_path}")
            for name in ("layout_prepare","batch_auto"):
                phase=stage_measure(extra_path,extra,name)
                if phase:extra_phases[group,strategy,kind,name].append(phase)
            extra_cost=extra["native_cost"]
            extra_meters=verify_meter(extra_path,extra_cost)
            extra_batches.append({"kind":kind,"group":group,"strategy":strategy,
                                  "coordinates":[[r["variant"],r["case"]] for r in rows],
                                  "route_sha256":fingerprint(extra_path),"native_report_sha256":extra_sha,
                                  "primary_native_report_sha256":native_sha,"native_invocations":len(extra_meters),
                                  "wall_seconds":extra_cost["wall_seconds"],"max_process_rss_kib":extra_cost["max_process_rss_kib"],
                                  "tokens":extra_cost["tokens"]})
    totals=aggregate(all_batches)
    paired=read(RESULTS/"paired-tool-comparison.json")
    if (len(coordinates)!=paired["unique_auto"]["executions"]
            or totals["expected_matches"]!=paired["unique_auto"]["matches"] or totals["final_auto_outcomes"]!=paired["outcomes"]):
        raise ValueError("incomplete finite matrix")
    compact={g:{strategy:aggregate(bs) for strategy,bs in sorted(modes.items())} for g,modes in sorted(groups.items())}
    root={"schema":"latest-native-costs/v1","engine_sha256":engine,
          "scope":"Original native phase only. Batch wall time is charged once; maximum single-process RSS includes descendants. Per-input branch counters are summed only when emitted.",
          "identity":"SHA-256 over sorted per-input and per-batch evidence digests; optionally materialize all contributing records with --audit-output.",
          "totals":totals,"by_strategy":{s:aggregate([b for g in groups.values() for b in g.get(s,[])]) for s in ("inline","modular")},
          "groups":compact}
    extra_shas={b["native_report_sha256"] for b in extra_batches}
    if seen_batches & extra_shas or len(extra_shas)!=len(extra_batches):
        raise ValueError("duplicate supplementary native charge")
    root["additional_native_attempts"]={"included_in_primary_totals":False,"rows":extra_batches}
    root["additional_stage_costs"]=[{"group":g,"strategy":s,"kind":reason,"stage":stage,
                                  "receipt_set_sha256":digest(sorted(digest(m) for m in ms)),**phase_summary(ms)}
                                 for (g,s,reason,stage),ms in sorted(extra_phases.items())]
    root["measurement_profile"]="Primary phases refer to the final finite Auto matrix. Diagnostic, preceding guard, and replaced certificate measurements are separate. Per-input replay on frozen ITP roots is a distinct experiment."
    if args.audit_output:save(args.audit_output,all_batches)
    return root


if __name__=="__main__":
    p=argparse.ArgumentParser(description=__doc__)
    for key in ("guard","final","remainder"):
        p.add_argument("--"+key,type=Path,required=True)
    p.add_argument("--audit-output",type=Path)
    p.add_argument("--output",type=Path,default=RESULTS/"latest-native-costs.json")
    args=p.parse_args()
    out=measure(args);save(args.output,out)
    print({k:out["totals"][k] for k in ("native_batches","executions","wall_seconds","max_process_rss_kib","branch_records","branch_missing")})
