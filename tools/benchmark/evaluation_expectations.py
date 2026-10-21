"""Independent expected statuses, including narrowly guarded execution errors."""
import json
from test_read_variants import ROOT

def expected(row,tool,execution_strategy=None):
    case=row.get('plan_case',row)
    default = case.get('expected_by_tool',{}).get(tool,case.get('expected',row.get('expected_result')))
    if tool.startswith('tespec'):
        strategy = execution_strategy or row.get('execution_strategy', 'inline')
        override = case.get('expected_by_execution_strategy', {}).get(strategy, default)
        if override not in {'PASS', 'FAIL', 'ERROR'}:
            raise ValueError('Invalid execution strategy expectation: ' + repr(override))
        return override
    return default

def matches(row,tool,status=None,measurement=None):
    m=measurement if measurement is not None else row[tool]
    status=status or m.get('final_status') or m.get('status')
    if status!=expected(row,tool):return False
    guard=row.get('plan_case',row).get('expected_executor_error_contains')
    if status=='ERROR' and tool.startswith('tespec') and guard:
        if not m.get('report') or not(ROOT/m['report']).exists():return False
        report=json.loads((ROOT/m['report']).read_text());rs=report.get('results',[])
        if len(rs)!=1 or rs[0].get('reason')!='qcp_execution_error':return False
        return guard in json.dumps(rs[0].get('executor_error',{})) and rs[0].get('precondition_result')=='SAT'
    return True


def summary(rows,plan):
    from collections import Counter
    result={'configurations':len(plan['pairings']),'case_pairs':len(rows),'expected':dict(Counter(r['expected'] for r in rows)),'policy':'statuses preserves native classifications; final_statuses and expected_matches include independently checked ITP. native_expected_matches excludes ITP. Per-tool expected status mapping is explicit in the frozen case plan.'}
    result['variant_records']=len({r[k] for r in rows for k in ['variant','paired_qcp_variant']});result['variant_language_records']=result['variant_records'];result['language_files']=len({(lang,r[k]) for r in rows for lang,k in [('cn','variant'),('qcp','paired_qcp_variant')]})
    for tool in ['fulminate_test','tespec_off','tespec_on']:
        result[tool]={'statuses':dict(Counter(r[tool]['status'] for r in rows)),'final_statuses':dict(Counter(r[tool].get('final_status',r[tool]['status']) for r in rows)),'expected_statuses':dict(Counter(expected(r,tool) for r in rows)),'native_expected_matches':sum(matches(r,tool,status=r[tool]['status']) for r in rows),'expected_matches':sum(matches(r,tool) for r in rows)}
    return result
