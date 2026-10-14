#!/usr/bin/env python3
from pathlib import Path
import argparse
from collections import Counter
import json,hashlib,gzip,shutil
root=Path(__file__).resolve().parent
parser=argparse.ArgumentParser(description='Archive latest per-case/variant/tool suite evidence, in report order')
parser.add_argument('--reports',nargs='+',type=Path,required=True)
parser.add_argument('--archive-name',required=True)
parser.add_argument('--cases',nargs='+',help='Archive only named cases whose full eight tool groups are available')
parser.add_argument('--report-name',default='array-replay-evidence.json')
a=parser.parse_args()
assert Path(a.archive_name).name==a.archive_name
assert Path(a.report_name).name==a.report_name and a.report_name.endswith('.json')
paths=a.reports
sha=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
selected={};sources=[]
for path in paths:
 report=json.loads(path.read_text());sources.append({'path':str(path),'sha256':sha(path),'driver_sha256':report['driver_sha256'],'tespec_binary_sha256':report['tespec_binary_sha256']})
 for row in report['runs']:
  if a.cases and row['case'] not in a.cases:continue
  selected[(row['case'],row['variant'],row['tool'])]=(path,row)
if a.cases:assert {key[0] for key in selected}==set(a.cases)
rows=[]
archive=root/'evidence'/a.archive_name
if archive.exists():parser.error('Archive directory must be fresh')
archive.mkdir(parents=True)
for key,(path,row) in sorted(selected.items()):
 ident,variant,tool=key;suite=json.loads((root/'suites'/ident/'suite.json').read_text());folder=path.parent/ident/variant
 record=dict(row);record['source_report']=str(path);record['input_suite_sha256']=sha(root/'suites'/ident/'suite.json')
 if tool=='qcp':
  assert (folder/'subject.qcp.c').read_bytes()==(root/'suites'/ident/f'{variant}.qcp.c').read_bytes()
  src=folder/'qcp/report.json';out=archive/ident/variant/'qcp-report.json.gz';out.parent.mkdir(parents=True,exist_ok=True)
  with gzip.open(out,'wb') as f:f.write(src.read_bytes())
  record['portable_report']=str(out.relative_to(root))
 if tool=='fulminate':
  driver=folder/'driver.cn.c';assert driver.read_text().startswith((root/'suites'/ident/f'{variant}.cn.c').read_text())
  for src in [driver,folder/'fulminate-build.log']:
   out=archive/ident/variant/(src.name+'.gz');out.parent.mkdir(parents=True,exist_ok=True)
   with gzip.open(out,'wb') as f:f.write(src.read_bytes())
  record['portable_driver']=str((archive/ident/variant/'driver.cn.c.gz').relative_to(root))
 record['summary']=dict(Counter(r['status'] for r in row['results']))
 record['expected_result_mismatches']=sum(r['status']!=r['expected'] for r in row['results'])
 record['false_pass']=sum(r['status']=='PASS' and r['expected']=='FAIL' for r in row['results'])
 record['missing_results']=len(suite['inputs'])-len(row['results'])
 assert record['false_pass']==0 and record['missing_results']==0
 rows.append(record)
summary={'subjects':len({r['case'] for r in rows}),'positive_inputs':sum(json.loads((root/'suites'/c/'suite.json').read_text())['input_count'] for c in {r['case'] for r in rows}),'tool_groups':len(rows),'false_pass':sum(r['false_pass'] for r in rows),'missing_results':sum(r['missing_results'] for r in rows),'strong_result_mismatches':sum(r['expected_result_mismatches'] for r in rows),'mismatch_statuses':dict(Counter(i['status'] for r in rows for i in r['results'] if i['status']!=i['expected']))}
assert summary['tool_groups']==8*summary['subjects']
report={'schema':'tespec-prepared-suite-evidence/v1','scope':'prepared subjects, complete original/spec/impl input suites; native heap and return oracles; Fulminate and ATP comparison; no ITP completion claimed','sources':sources,'summary':summary,'runs':rows,'portable_files':{str(p.relative_to(root)):sha(p) for p in archive.rglob('*') if p.is_file()}}
(root/'suites'/a.report_name).write_text(json.dumps(report,indent=2)+'\n');print(json.dumps(summary,indent=2))
