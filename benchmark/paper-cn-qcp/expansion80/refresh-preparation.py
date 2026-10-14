#!/usr/bin/env python3
"""Reconcile 80-subject preparation and replay coverage without declaring admission."""
from collections import Counter
import json
from pathlib import Path
HERE=Path(__file__).resolve().parent
read=lambda p:json.loads(p.read_text())
write=lambda p,data:p.write_text(json.dumps(data,indent=2)+'\n')
catalog=read(HERE/'catalog.json')
suites={p.parent.name:read(p) for p in (HERE/'suites').glob('*/suite.json')}
reports={name:read(HERE/'suites'/name) for name in ['replay-evidence.json','array-replay-evidence.json','cell-replay-evidence.json','string-replay-evidence.json','array-query-replay-evidence.json', 'more-scalar-replay-evidence.json', 'memory-replay-evidence.json', 'algorithm-replay-evidence.json', 'struct-majority-replay-evidence.json', 'interface-replay-evidence.json', 'existing-simple-replay-evidence.json', 'search-root-replay-evidence.json', 'weak-call-replay-evidence.json', 'power-replay-evidence.json', 'list-length-replay-evidence.json', 'list-reverse-replay-evidence.json', 'list-append-replay-evidence.json'] if (HERE/'suites'/name).exists()}
def mutation_inputs(suite):
 counts = {}
 for kind in ('spec', 'impl'):
  flags = [item[kind + '_mutation_violated'] for item in suite['inputs']]
  assert all(type(flag) is bool for flag in flags)
  counts[kind] = {'witnessed_violations': sum(flags),
                  'satisfying_survivors': len(flags) - sum(flags)}
 return counts

rows=[];verdicts={tool:Counter() for tool in ['native32','native64','fulminate','qcp']}
for item in catalog['programs']:
 ident=item['id'];suite=suites.get(ident)
 matches=[r for report in reports.values() for r in report['runs'] if r['case']==ident]
 nwrong=sum(r['expected_result_mismatches'] for r in matches)
 if suite:
  item['input_suite_path']=f'suites/{ident}/suite.json'
  relevant=[name for name,report in reports.items() if any(r['case']==ident for r in report['runs'])]
  if relevant:item['suite_evidence_path']='suites/'+relevant[-1]
  item['suite_replay_status']='expected verdicts match' if matches and not nwrong else 'residual or diagnostic expected-verdict mismatches' if matches else 'not replayed'
  for r in matches:
   if r['variant']=='reference':verdicts[r['tool']].update(x['status'] for x in r['results'])
 rows.append({'id':ident,'source_status':item['status'],'category':item['category'],'prepared_positive_inputs':suite['input_count'] if suite else 0,'prepared_both_mutation_kinds':bool(suite),'mutation_input_counts':mutation_inputs(suite) if suite else None,'paired_replay_tool_groups':len(matches),'strong_expected_result_mismatches':nwrong,'false_pass':sum(r['false_pass'] for r in matches),'missing_results':sum(r['missing_results'] for r in matches),'full_admission_verified':False,'remaining':(['full CN/QCP correspondence and owned-domain review','large admitted input suite and independent oracle','both witnessed mutation kinds','matched native/Fulminate/ATP+ITP replay'] if not suite else ['independently reviewed freeze/admission record','complete strong expected verdicts on residual VCs' if nwrong else 'held-out input and capability-coverage admission checks'])})
catalog['prepared_suite_subjects']=len(suites);catalog['prepared_positive_inputs']=sum(s['input_count'] for s in suites.values());catalog['full_80_tool_admission_complete']=False
write(HERE/'catalog.json',catalog)
summary={'scope':'80-subject completion audit; prepared suites and historical smoke pairs are separate from final admission','subjects':len(rows),'prepared_subjects':len(suites),'prepared_positive_inputs':catalog['prepared_positive_inputs'],'reference_verdicts':{t:dict(c) for t,c in verdicts.items()},'mutation_input_counts':{kind:{label:sum(mutation_inputs(suite)[kind][label] for suite in suites.values()) for label in ('witnessed_violations','satisfying_survivors')} for kind in ('spec','impl')},'mutation_expectation_policy':{'witnessed_violation':'FAIL under the strong standard; UNKNOWN only under separately reported weak standard','satisfying_survivor':'PASS; applying a mutation does not make every input a negative'},'strong_expected_result_mismatches':sum(r['strong_expected_result_mismatches'] for r in rows),'false_pass':sum(r['false_pass'] for r in rows),'missing_results':sum(r['missing_results'] for r in rows),'industrial_model_traces':catalog.get('industrial_model_traces_prepared',0),'industrial_production_admission_checked':False,'full_goal_complete':False,'programs':rows}
write(HERE/'coverage-status.json',summary)
print(json.dumps({k:v for k,v in summary.items() if k!='programs'},indent=2))
