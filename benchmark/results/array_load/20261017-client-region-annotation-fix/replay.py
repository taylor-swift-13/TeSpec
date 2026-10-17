#!/usr/bin/env python3
"""Measure only the corrected array client input; never overwrite an existing run."""
from pathlib import Path
import collections,datetime,json,sys
ROOT=Path(__file__).resolve().parents[4]
OUT=Path(__file__).resolve().parent
sys.path.insert(0,str(ROOT/'tools/benchmark'))
from test_read_variants import measure,sha,save
from evaluation_provenance import snapshot
CASE='original_client_translation5_only_entry'
VARIANT='qcp_existing:3f5666557099c82f3a7f'
SOURCE=ROOT/'benchmark/programs/array_load/variants/qcp_existing_3f5666557099c82f3a7f/qcp/array_client_region.qcp.c'
OLD=ROOT/'benchmark/results/array_load/20261016-evaluation/results.json'
PLAN=ROOT/'benchmark/programs/array_load/evaluation-plan.json'
assert not (OUT/'results.json').exists(),'Preserve this measured run; use a fresh output directory for another attempt'
assert sha(SOURCE)==sha(OUT/'source-after.qcp.c')
old_data=json.loads(OLD.read_text())
old=next(x for x in old_data['runs'] if x['case']==CASE)
assert old['paired_qcp_variant']==VARIANT
assert sha(OUT/'source-before.qcp.c')==old['qcp_source_sha256']
assert sha(ROOT/old['binds'])==old['binds_sha256']
assert sha(ROOT/'bin/tespec-symexec')==old_data['toolchain']['executor_sha256']
plan=json.loads(PLAN.read_text())
case=next(c for pair in plan['pairings'] if pair['qcp_variant']==VARIANT and pair.get('function')=='verify_main' for c in pair['cases'] if c['id']==CASE)
assert case['expected']=='PASS' and case['precondition_valid']
receipt={
 'schema':'tespec-single-case-source-revision/v1',
 'program_group':'array_load','case':CASE,'paired_qcp_variant':VARIANT,
 'function':'verify_main','expected':'PASS','input':case['binds'],
 'started_utc':datetime.datetime.now(datetime.timezone.utc).isoformat(),
 'source':str(SOURCE.relative_to(ROOT)),'source_before_sha256':old['qcp_source_sha256'],'source_after_sha256':sha(SOURCE),
 'source_before_snapshot':str((OUT/'source-before.qcp.c').relative_to(ROOT)),
 'source_after_snapshot':str((OUT/'source-after.qcp.c').relative_to(ROOT)),
 'historical_report':str(OLD.relative_to(ROOT)),'historical_report_sha256':sha(OLD),
 'historical_modes':{mode:{'status':old['tespec_'+mode]['status'],'report':old['tespec_'+mode]['report'],'report_sha256':sha(ROOT/old['tespec_'+mode]['report'])} for mode in ['off','on']},
 'evaluation_plan':str(PLAN.relative_to(ROOT)),'evaluation_plan_sha256':sha(PLAN),
 'binds':old['binds'],'binds_sha256':old['binds_sha256'],
 'executor_sha256':sha(ROOT/'bin/tespec-symexec'),
 'executor_build':json.loads((ROOT/'bin/tespec-symexec.build.json').read_text()),
 'evaluation_source_snapshot':snapshot(),
 'runner_sha256':sha(Path(__file__)),
 'scope':'Only this source revision and this verify_main input, native teSpec spatial SMT OFF/ON. No other example, CN/Fulminate run, universal QCP verification or ITP model call is included.',
 'metric':'Wall seconds per native execution; GNU time maximum process RSS in KiB, not sum of simultaneous process memory. Native execution uses no model tokens. Shared host, one observation per mode; not a speed comparison.',
 'correction':'Remove six duplicate a slots and the matching zero/one/two slots in their value assertions. Keep all other explicit slots, value assertions, array resources, program body, contracts and frozen PASS expectation.',
 'modes':{},
}
save(OUT/'results.json',receipt)
for mode in ['off','on']:
 folder=OUT/('tespec-'+mode)
 assert not folder.exists()
 command=list(old['tespec_'+mode]['command'])
 command[command.index('--output-dir')+1]=str(folder/'artifacts')
 m=measure(command,folder,timeout=90)
 report_path=folder/'artifacts/report.json'
 m['report']=str(report_path.relative_to(ROOT)) if report_path.exists() else None
 report=json.loads(report_path.read_text()) if report_path.exists() else {}
 rows=report.get('results',[])
 result=rows[0] if len(rows)==1 else {}
 for k in ['status','reason','precondition_result','execution_completed','phases','residual_vcs','spatial_smt']:
  m[k]=result.get(k)
 m['vc_status_counts']=dict(collections.Counter(v['status'] for v in result.get('vc_results',[])))
 m['expected_matched']=m['status']=='PASS'
 m['evidence']=result.get('evidence')
 m['report_sha256']=sha(report_path) if report_path.exists() else None
 m['stdout_sha256']=sha(ROOT/m['stdout']);m['stderr_sha256']=sha(ROOT/m['stderr'])
 receipt['modes'][mode]=m
 save(OUT/'results.json',receipt)
 print(json.dumps({'mode':mode,'status':m['status'],'residual_vcs':m['residual_vcs'],'vc_status_counts':m['vc_status_counts'],'wall_seconds':m['wall_seconds'],'resources':m['resources']},ensure_ascii=False),flush=True)
receipt['finished_utc']=datetime.datetime.now(datetime.timezone.utc).isoformat()
receipt['complete']=len(receipt['modes'])==2 and all(m['expected_matched'] and m['execution_completed'] and not m['residual_vcs'] for m in receipt['modes'].values())
receipt['itp']={'status':'NOT_NEEDED_AUTOMATIC_PASS' if receipt['complete'] else 'NOT_PERFORMED','model_calls':0}
assert sha(SOURCE)==receipt['source_after_sha256']
assert sha(OLD)==receipt['historical_report_sha256']
assert sha(PLAN)==receipt['evaluation_plan_sha256']
save(OUT/'results.json',receipt)
raise SystemExit(0 if receipt['complete'] else 1)
