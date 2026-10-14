#!/usr/bin/env python3
"""Consolidate complete frozen-input replay receipts without altering suites."""
from collections import Counter
import hashlib
import json
from pathlib import Path
import shutil
HERE=Path(__file__).resolve().parent
ROOT=HERE.parents[1]
def read(p):return json.loads(p.read_text())
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def save(p,x):p.write_text(json.dumps(x,indent=2,ensure_ascii=False)+'\n')
def main():
    out=HERE/'review-20261014';out.mkdir(exist_ok=True)
    inputs={'original79':HERE/'expansion80/evidence/20261014-full-v2','memory3':HERE/'memory-controls/evidence/full'}
    combined={'schema':'tespec-benchmark-review/v1','date':'2026-10-14','original_target':80,'industrial_translation_pending':['fulminate_pkvm_buddy'],'full_80_complete':False,'tool_admission_and_independent_contract_review_complete':False,'groups':{},'coverage_gaps':read(HERE/'package-audit.json')['memory_coverage_gaps'],'diagnostics':{}}
    for name,directory in inputs.items():
        report=read(directory/'report.json')
        assert 'summary' in report and not report['errors'],name+' still pending'
        assert report['summary']['fully_replayed_subjects']==(79 if name=='original79' else 3)
        assert sha(directory/'driver-snapshot.py')==report['driver_sha256']
        for case in report['cases']:
            selection=read(directory/case['id']/'selection.json')
            suite_path=ROOT/selection['suite_path']/'suite.json';suite=read(suite_path)
            assert sha(suite_path)==selection['suite_sha256']
            assert selection['inputs']==suite['inputs']
            expected_ids={r['id'] for r in suite['inputs']}
            for group in case['groups']:
                assert {r['id'] for r in group['results']}==expected_ids
                assert len(group['results'])==len(expected_ids)
        tool_variants={}
        reasons=Counter();execution_completed=Counter();preconditions=Counter()
        for case in report['cases']:
            for group in case['groups']:
                key=group['tool']+'/'+group['variant']
                dest=tool_variants.setdefault(key,Counter())
                dest.update(r['status'] for r in group['results'])
                if group['tool']=='qcp' and group['variant']=='reference':
                    reasons.update(r.get('reason') for r in group['results'])
                    for row in read(directory/case['id']/'reference/qcp/report.json')['results']:
                        preconditions.update([row.get('precondition_result')])
                        execution_completed.update([row.get('phases',{}).get('execution','NOT_REPORTED')])
        combined['groups'][name]={'summary':report['summary'],'tool_variants':{k:dict(v) for k,v in tool_variants.items()},'reference_qcp_reasons':dict(reasons),'reference_preconditions':dict(preconditions),'reference_execution_phase':dict(execution_completed),'source_report_sha256':sha(directory/'report.json'),'driver_sha256':report['driver_sha256'],'binary_sha256':report['binary_sha256'],'cn_binary_sha256':report['cn_binary_sha256'],'timeout_seconds_per_input':report['timeout'],'loop_and_call_limit':report['loop_and_call_limit']}
        shutil.copyfile(directory/'report.json',out/(name+'-replay.json'))
        shutil.copyfile(directory/'driver-snapshot.py',out/(name+'-driver.py'))
    ablation=HERE/'instantiation/evidence/20261014-v3/summary.json'
    shutil.copyfile(ablation,out/'address-ablation.json')
    combined['diagnostics']['address_ablation_sha256']=sha(ablation)
    combined['diagnostics']['knapsack']='With lists determine both input arrays. Only weights/values/dp bases change. Symbolic bases time out at entry; numeric bases complete execution, safety PASS, postcondition UNKNOWN.'
    combined['diagnostics']['interior_pointer']='Numeric 4104 loses base-plus-index structure needed by MemOracle IndexFromAddress; symbolic base and cursor=a+k pass. This is executor address recovery, not a wrongly bound logical list or nontermination.'
    combined['diagnostics']['loop_budget']='The original reference loop_unroll_limit cases are sum_to_n inputs n>128 (first n=153, largest n=65535). They need more than the fixed iteration budget; no solver failure to see a reached exit has been demonstrated.'
    combined['diagnostics']['house_robber']='For l=[2,7,9,3,1], n=5, both symbolic and numeric nums finish with entry SAT and safety PASS; HouseRobberAnswer(l,12) remains a residual postcondition. Native32/native64 return 12, independently checked against exhaustive nonadjacent subsets.'
    shutil.copyfile(HERE/'instantiation/evidence/house-robber-native/report.json',out/'house-robber-native.json')
    shutil.copyfile(HERE/'instantiation/evidence/house-robber-native/oracle.c',out/'house-robber-native.c')
    combined['diagnostics']['matrix']='All supplemental matrix executions finish; list-repeat postcondition remains a residual obligation, including mutation survivors and violations.'
    combined['instantiation_policy']={'semantic_input':'Freeze scalar arguments and observable logical contents/shapes; preserve aliases, offsets, sharing and ownership. Bind pointer-valued logical fields where the predicate exposes them. Uninitialized output buffers need storage extent, not invented values.','address_profile':'Store fixed numeric fixtures for reproducibility, but keep address-sensitive and relocation-invariant experiments distinct. Use enough roots to resolve disjointness; current executor needs a numeric-offset recovery fix before a universal numeric-address policy.','native_relation':'Native stack addresses differ from QCP virtual addresses. Correspondence is via typed regions and pointer relations; native32/native64 success alone does not certify imported QCP predicate layout.','evaluation':'No LLM and no regeneration during replay. Never switch profiles silently after a failure.'}
    combined['validation']={'package_audit':'PASS','historical_artifact_validation':'see validation.json','parser_and_mode_unit_tests':53,'mode_regression_expectations_met':40,'interpretation':'No observed false PASS/FAIL on these fixtures is not a proof of soundness, completeness, or CN/QCP equivalence.'}
    save(out/'summary.json',combined)
    print(json.dumps({k:v['summary'] for k,v in combined['groups'].items()}))
if __name__=='__main__':main()
