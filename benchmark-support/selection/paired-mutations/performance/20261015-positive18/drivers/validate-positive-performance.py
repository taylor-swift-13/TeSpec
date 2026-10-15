from pathlib import Path
import json,hashlib,re,csv,math
ROOT=Path('/home/yangfp/teSpec-benchmark-tespec');BASE=ROOT/'benchmark/selection/paired-mutations';OUT=BASE/'performance/20261015-positive18';AUTO=OUT/'automatic-final'
summary=json.loads((OUT/'summary.json').read_text());raw=json.loads((AUTO/'raw-results.json').read_text());models=json.loads((OUT/'model-proof-results.json').read_text());manifest=json.loads((BASE/'manifest.json').read_text());selected={x['id']:x for x in manifest['records'] if x['variants'][0].get('verification')=='PAIRED_ACCEPTED'}
sha=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
assert sha(BASE/'manifest.json')==raw['toolchain']['manifest_sha256']
assert len(summary['programs'])==len(selected)==18
assert len(raw['runs'])==54 and sum(r['test_input_count'] for r in summary['programs'])==85
for run in raw['runs']:
 d=AUTO/run['source'];assert json.loads((d/'binds.json').read_text())
 for stage in ['cn','qcp_auto','fulminate_pipeline','fulminate_test','tespec_auto']:
  data=run[stage];folder=AUTO/data['folder'];assert sha(folder/'stdout.log')==data['stdout_sha256'];assert sha(folder/'stderr.log')==data['stderr_sha256'];assert data['exit_code']==0;assert data['wall_seconds']>0
  assert json.loads((folder/'resources.json').read_text())==data['resources'];assert data['resources']['max_process_rss_kib']>0
 assert run['qcp_auto']['native_result']=='success'
 native=json.loads((AUTO/run['qcp_auto']['folder']/'stdout.log').read_text())
 witnesses=[x for x in native.get('WitnessList',[]) if x.get('Witness')]
 assert witnesses and selected[run['source']]['target'] in [x['functionName'] for x in witnesses]
 assert sum(x['Witness']['total_witness_count']['auto_solved']+x['Witness']['total_witness_count']['manual'] for x in witnesses)>0
 assert '-- pass' in (AUTO/run['cn']['folder']/'stdout.log').read_text()
 assert all(x=='PASS' for x in run['tespec_auto']['statuses'])
for row in summary['programs']:
 assert row['configured_model']=='gpt-6.1-sol' and row['tespec_total_tokens']==0
 assert row['qcp_total_tokens']==row['qcp_input_tokens']+row['qcp_output_tokens']
 assert row['qcp_cached_input_tokens']<=row['qcp_input_tokens']
 if row['qcp_model_attempts']:
  m=next(x for x in models if x['source']==row['program']);assert m['status']=='KERNEL_CHECKED' and m['kernel_replay']['exit_code']==0
  modeldir=OUT/row['program']/'model';assert (modeldir/'assumption-audit/stdout.log').read_text().strip()=='Closed under the global context'
  # Validate telemetry rather than trusting a model's final answer.
  token_counts={'input_tokens':0,'output_tokens':0,'cached_input_tokens':0}
  for folder in [OUT/row['program']/'model-attempt-1',modeldir]:
   events=[]
   for line in (folder/'agent.stdout.jsonl').read_text().splitlines():
    try:e=json.loads(line)
    except ValueError:continue
    if e.get('type')=='turn.completed':events.append(e['usage'])
   assert events
   for u in events:
    for k in token_counts:token_counts[k]+=u.get(k,0)
  for k,count in token_counts.items():assert row['qcp_'+k]==count
 else:assert row['qcp_total_tokens']==0
csvrows=list(csv.DictReader((OUT/'program-metrics.csv').open()));assert len(csvrows)==18
print('PASS: 18 programs, 54 repeated automatic runs, all resource/log hashes and actual two-attempt token telemetry checked.')
