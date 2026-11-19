"""Independent expected statuses, including narrowly guarded execution errors."""
import json
from functools import lru_cache
import re
from test_read_variants import ROOT
from current_test_plan import matches_crash, sha256

def expected(row,tool,execution_strategy=None):
    case=row.get('plan_case',row)
    default = case.get('expected_by_tool',{}).get(tool,case.get('expected',row.get('expected_result')))
    if tool.startswith('tespec'):
        strategy = execution_strategy or row.get('execution_strategy', 'inline')
        override = case.get('expected_by_execution_strategy', {}).get(strategy, default)
        if override not in {'PASS', 'FAIL', 'ERROR', 'CRASH'}:
            raise ValueError('Invalid execution strategy expectation: ' + repr(override))
        return override
    return default

@lru_cache(maxsize=8)
def archived_permission_decisions(group):
    # These groups have checked historical ERROR decisions predating CRASH.
    if group not in {"read", "incr", "zero", "slf3_basic_inplace_double"}:
        return set()
    base = ROOT / "benchmark/results" / group
    decisions = json.loads((base / "evidence/strategies.json").read_bytes())["decisions"]
    archived = {(r["variant"], r["case"], r["strategy"], r["mode"], r["report"]["sha256"])
                for r in decisions if r["expected"] == r["raw_status"] == "ERROR"}
    batch = base / ("20261015-variants" if group == "read" else "20261016-evaluation") / "results.json"
    for row in json.loads(batch.read_bytes())["runs"]:
        for mode in ("off","on"):
            value = row.get("tespec_" + mode, row.get("tespec", {}) if mode == "off" else {})
            if (value.get("status") == "ERROR" or value.get("statuses") == ["ERROR"]):
                digest = value.get("report_sha256") or value.get("report_omitted", {}).get("sha256")
                if digest:
                    archived.add((row["variant"], row["case"], "inline", mode, digest))
    return archived


def matches(row,tool,status=None,measurement=None):
    m=measurement if measurement is not None else row[tool]
    status=status or m.get('final_status') or m.get('status')
    if status!=expected(row,tool):return False
    if not tool.startswith('tespec') or status not in {'ERROR', 'CRASH'}:
        return True
    case = row.get('plan_case', row)
    guard = case.get('expected_executor_error_contains')
    if not m.get('report'):
        return False
    path = ROOT / m['report']
    if not path.is_file():
        return False
    if m.get('report_sha256') and sha256(path) != m['report_sha256']:
        return False
    results = json.loads(path.read_bytes()).get('results', [])
    if len(results) != 1:
        return False
    result = results[0]
    if result.get('status') != status:
        return False
    if status == 'CRASH':
        case_id = case.get('id', row.get('case'))
        if case_id is not None:
            bind_id = (case_id if re.fullmatch(r'[A-Za-z_]\w*', case_id) else
                       'case_' + re.sub(r'\W', '_', case_id))
            if result.get('id') != bind_id:
                return False
        return matches_crash(result, case.get('expected_crash_fault_code'))
    try:
        relative = path.resolve().relative_to(ROOT / 'benchmark/results')
    except ValueError:
        return False
    if len(relative.parts) < 2:
        return False
    key = (row.get('variant'), row.get('case'), row.get('execution_strategy','inline'),
           tool.removeprefix('tespec_'), sha256(path))
    if key not in archived_permission_decisions(relative.parts[0]):
        return False
    # Historical ERROR can only be credited with its documented diagnostic.
    # The original read plan predates the per-case guard field. Its approved
    # refusal was independently checked in complete_read_pipeline.py.
    if not guard and row.get('variant') == 'constructed:case_2ca8ba1f4ef270af':
        guard = 'cannot read memory through this pointer'
    return (bool(guard) and result.get('reason') == 'qcp_execution_error'
            and result.get('precondition_result') == 'SAT'
            and guard in json.dumps(result.get('executor_error', {})))


def summary(rows,plan):
    from collections import Counter
    result={'configurations':len(plan['pairings']),'case_pairs':len(rows),'expected':dict(Counter(r['expected'] for r in rows)),'policy':'statuses preserves native classifications; final_statuses and expected_matches include independently checked ITP. native_expected_matches excludes ITP. Per-tool expected status mapping is explicit in the frozen case plan.'}
    result['variant_records']=len({r[k] for r in rows for k in ['variant','paired_qcp_variant']});result['variant_language_records']=result['variant_records'];result['language_files']=len({(lang,r[k]) for r in rows for lang,k in [('cn','variant'),('qcp','paired_qcp_variant')]})
    for tool in ['fulminate_test','tespec_off','tespec_on']:
        result[tool]={'statuses':dict(Counter(r[tool]['status'] for r in rows)),'final_statuses':dict(Counter(r[tool].get('final_status',r[tool]['status']) for r in rows)),'expected_statuses':dict(Counter(expected(r,tool) for r in rows)),'native_expected_matches':sum(matches(r,tool,status=r[tool]['status']) for r in rows),'expected_matches':sum(matches(r,tool) for r in rows)}
    return result
