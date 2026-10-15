from pathlib import Path
import json,subprocess,hashlib,zipfile,shutil,sys,re
ROOT=Path('/home/yangfp/teSpec-benchmark-tespec');BASE=ROOT/'benchmark/selection/paired-mutations';PERF=BASE/'performance/20261015-positive18';WORK=Path('/mnt/c/Users/50635/Documents/Codex/2026-10-14/jin/work');OUT=WORK.parent/'outputs'
drivers=PERF/'drivers';drivers.mkdir(exist_ok=True)
names=['measure-positive-performance.py','prepare-positive-model-tasks.py','run-positive-model-measurements.py','prepare-model-repairs-and-fulminate.py','archive-first-model-check.py','check-positive-model-proofs.py','summarize-positive-performance.py','validate-positive-performance.py','export-positive-performance.py']
for name in names:(drivers/name).write_bytes((WORK/name).read_bytes())
manifest=json.loads((BASE/'manifest.json').read_text());inputs=[]
(PERF/'source-manifest.json').write_bytes((BASE/'manifest.json').read_bytes())
for row in manifest['records']:
 if row['variants'][0].get('verification')!='PAIRED_ACCEPTED':continue
 entry={'source':row['id'],'function':row['target'],'files':{}}
 for language,f in row['variants'][0]['files'].items():
  dest=PERF/'inputs'/row['id']/(language+'.c');dest.parent.mkdir(parents=True,exist_ok=True);dest.write_bytes((BASE/f['path']).read_bytes())
  entry['files'][language]={'path':str(dest.relative_to(PERF)),'sha256':f['sha256']}
 inputs.append(entry)
(PERF/'positive-inputs.json').write_text(json.dumps(inputs,indent=2)+'\n')
metadata={'tespec_git_head':subprocess.check_output(['git','-C',str(ROOT),'rev-parse','HEAD'],text=True).strip(),'runtime_git_tree':subprocess.check_output(['git','-C',str(ROOT),'rev-parse','HEAD:runtime/qcip'],text=True).strip(),'cn_version':json.loads((BASE/'toolchain.json').read_text())['cn_version'],'coq_version':subprocess.check_output(['/home/yangfp/.opam/qcp-8.20/bin/coqc','--version'],text=True).strip(),'gcc_version':subprocess.check_output(['gcc','--version'],text=True).splitlines()[0],'cpu_model':next((x.split(':',1)[1].strip() for x in Path('/proc/cpuinfo').read_text().splitlines() if x.startswith('model name')),None),'configured_model':'gpt-6.1-sol','evidence_definition':'Automatic pilot and final rounds distinguished; all model attempts retained.','driver_sha256':{name:hashlib.sha256((drivers/name).read_bytes()).hexdigest() for name in names}}
(PERF/'environment.json').write_text(json.dumps(metadata,indent=2)+'\n')
for source,target in [('program-metrics.csv','positive-performance.csv'),('summary.json','positive-performance.json'),('README.md','positive-performance.md')]:
 (OUT/target).write_bytes((PERF/source).read_bytes())
excluded={'.vo','.vos','.vok','.glob','.exe','.pyc','.o'};names_excluded={'qcp_proof_auto.v','qcp_proof_manual.v','qcp_goal_check.v'};files=[]
with zipfile.ZipFile(OUT/'positive-performance-evidence.zip','w',zipfile.ZIP_DEFLATED) as z:
 for p in sorted(PERF.rglob('*')):
  if not p.is_file() or p.suffix in excluded or p.name in names_excluded or p.name.endswith('.aux') or '__pycache__' in p.parts:continue
  if re.search(r'_(?:proof_auto|proof_manual|goal_check)\.v$',p.name):continue
  if p.read_bytes()[:4]==bytes([127,69,76,70]):raise RuntimeError('Unexpected ELF '+str(p))
  rel=p.relative_to(PERF).as_posix();z.write(p,'positive-performance/'+rel);files.append(rel)
with zipfile.ZipFile(OUT/'positive-performance-evidence.zip') as z:assert z.testzip() is None
print('Exported',len(files),'evidence files; archive bytes',(OUT/'positive-performance-evidence.zip').stat().st_size)
