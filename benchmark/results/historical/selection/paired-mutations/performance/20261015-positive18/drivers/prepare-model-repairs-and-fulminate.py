from pathlib import Path
import json,subprocess,ast,os,time,signal,hashlib
ROOT=Path('/home/yangfp/teSpec-benchmark-tespec');OUT=ROOT/'benchmark/selection/paired-mutations/performance/20261015-positive18';WIN=Path('/mnt/c/Users/50635/Documents/Codex/2026-10-14/jin/work/positive-model-runs')
results=json.loads((OUT/'model-proof-results.json').read_text());definition=(ROOT/'runtime/qcip/SeparationLogic/SeparationLogic/IntLib.v').read_text().splitlines()[:28]
for row in results:
 if row['status']!='FAILED':continue
 d=WIN/row['source'];old=d/'attempt-1';old.mkdir(exist_ok=True)
 for name in ['Candidate.v','prompt.txt','agent.stdout.jsonl','agent.stderr.log','model-receipt.json']:(old/name).write_bytes((d/name).read_bytes())
 errors='\n'.join(x.get('stderr','') for x in row['compilation'] if x['exit_code']!=0)
 prompt=(d/'prompt.txt').read_text()+'\n\nThe external compiler rejected the first attempt. Repair Candidate.v using this exact feedback. This remains the same proof task and all immutable-statement restrictions apply. Do not simply repeat the prior proof.\n'+errors+'\n\nActual runtime IntLib definitions (note the distinction between Z.rem and Z.modulo notation):\n'+'\n'.join(definition)+'\n\nYour current candidate:\n'+(d/'Candidate.v').read_text()
 (d/'prompt.txt').write_text(prompt)
# Reuse the same measured-process helper without re-running its main experiment.
source=Path('/mnt/c/Users/50635/Documents/Codex/2026-10-14/jin/work/measure-positive-performance.py').read_text();tree=ast.parse(source)
ns={'Path':Path,'json':json,'subprocess':subprocess,'os':os,'time':time,'signal':signal,'hashlib':hashlib,'ROOT':ROOT,'OUT':OUT,'ENV':os.environ.copy()}
for name in ['sha','measure']:
 node=next(n for n in tree.body if isinstance(n,ast.FunctionDef) and n.name==name);exec(compile(ast.Module(body=[node],type_ignores=[]),'<helper>','exec'),ns)
data=json.loads((OUT/'raw-results.json').read_text())
for row in data['runs']:
 cmd=row['fulminate_pipeline']['command'];tmp=Path(next(s.split('=',1)[1] for s in cmd if s.startswith('--output-dir=')));executables=list(tmp.glob('*.exec.out'));assert len(executables)==1,(tmp,executables)
 d=OUT/row['source']/('repeat-'+str(row['repeat']))/'fulminate-test'
 row['fulminate_test']=ns['measure']([executables[0]],d)
 assert row['fulminate_test']['exit_code']==0
(OUT/'raw-results.json').write_text(json.dumps(data,indent=2)+'\n')
print('Prepared four model repairs; Fulminate standalone runtime measurements:',len(data['runs']))
