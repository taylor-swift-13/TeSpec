#!/usr/bin/env python3
"""Measure Coq validation of model-generated read refutations, including failures."""
from pathlib import Path
import argparse, hashlib, json, re, shlex, shutil, subprocess, time

ROOT = Path(__file__).resolve().parents[2]
TASK = Path('/mnt/c/Users/50635/Documents/Codex/2026-10-14/jin/work/read-itp-metered')
OUT = ROOT/'benchmark/results/read/20261015-itp-metered'
COQ = Path('/home/yangfp/.opam/qcp-8.20/bin')
RUNTIME = ROOT/'runtime/qcip/SeparationLogic'

def sha(p): return hashlib.sha256(p.read_bytes()).hexdigest()
def save(p,d):
    p.parent.mkdir(parents=True,exist_ok=True);p.write_text(json.dumps(d,ensure_ascii=False,indent=2)+'\n')

def measure(command,folder,cwd):
    folder.mkdir(parents=True,exist_ok=True);resource=folder/'resources.json'
    wrapped=['/usr/bin/time','--quiet','-f','{"max_process_rss_kib":%M,"user_seconds":%U,"system_seconds":%S,"wall_seconds_gnu":%e}','-o',str(resource),*map(str,command)]
    start=time.monotonic()
    with (folder/'stdout.log').open('wb') as stdout,(folder/'stderr.log').open('wb') as stderr:
        p=subprocess.run(wrapped,cwd=cwd,stdout=stdout,stderr=stderr)
    resources=json.loads(resource.read_text()) if resource.exists() and resource.stat().st_size else None
    return {'command':list(map(str,command)),'exit_code':p.returncode,'wall_seconds':time.monotonic()-start,'resources':resources,
            'stdout':(folder/'stdout.log').relative_to(ROOT).as_posix(),'stdout_sha256':sha(folder/'stdout.log'),
            'stderr':(folder/'stderr.log').relative_to(ROOT).as_posix(),'stderr_sha256':sha(folder/'stderr.log')}

def statements(text):
    return [(m[1],re.sub(r'\s+',' ',m[2]).strip()) for m in re.finditer(r'(?:Theorem|Lemma)\s+(case_\d\d_\w+)\s*:\s*(.*?)\.\s*Proof\.',text,re.S)]

def main():
    parser=argparse.ArgumentParser();parser.add_argument('--attempt',type=int,default=1);args=parser.parse_args()
    attempt=OUT/('attempt-'+str(args.attempt));src=attempt/'proofs';src.mkdir(parents=True,exist_ok=True)
    assert not (attempt/'coq-receipt.json').exists(),'Do not overwrite a measured attempt'
    model=TASK/('attempt-'+str(args.attempt));receipt=json.loads((model/'model-receipt.json').read_text())
    assert receipt['exit_code']==0 and receipt['token_usage'] and receipt['requested_model']=='gpt-6.1-sol'
    for name in ['model-receipt.json','usage-events.json','Candidate.v']:
        shutil.copyfile(model/name,attempt/name)
    shutil.copyfile(TASK/'prompt.txt',attempt/'prompt.txt')
    template=(TASK/'prompt.txt').read_text().split('Candidate template:\n',1)[1]
    candidate=(attempt/'Candidate.v').read_text()
    assert statements(candidate)==statements(template) and len(statements(candidate))==36
    assert not re.search(r'\b(?:Admitted|admit|Axiom|Parameter)\b',candidate)
    for name,digest in receipt['locked_goal_and_helper_sha256'].items():
        assert sha(TASK/name)==digest
        shutil.copyfile(TASK/name,src/name)
    assert sha(attempt/'Candidate.v')==receipt['candidate_sha256']
    shutil.copyfile(attempt/'Candidate.v',src/'Candidate.v')
    tokens=shlex.split((RUNTIME/'_CoqProject').read_text());flags=[str(RUNTIME/t) if i%3==1 else t for i,t in enumerate(tokens)]+['-Q',str(src),'']
    report={'schema':'tespec-metered-coq-validation/v1','attempt':args.attempt,'model_receipt':(attempt/'model-receipt.json').relative_to(ROOT).as_posix(),
            'coq_version':subprocess.check_output([str(COQ/'coqc'),'--version'],text=True).strip(),'compilation':[],
            'candidate':(src/'Candidate.v').relative_to(ROOT).as_posix(),'candidate_sha256':sha(src/'Candidate.v'),
            'scope':'Fresh model-generated 36-theorem candidate; original exact goals and previously checked concrete-heap helper reused. No prior refutation solution supplied to the model.'}
    paths=[src/'ReadCounterHeap.v',*sorted(src.glob('ReadUnknown*Goal.v')),src/'Candidate.v']
    for p in paths:
        stage=measure([COQ/'coqc',*flags,p],attempt/'compilation'/p.stem,src);stage['source']=p.relative_to(ROOT).as_posix();stage['source_sha256']=sha(p);report['compilation'].append(stage)
        save(attempt/'coq-receipt.json',report)
        print(p.name,'compiled',stage['exit_code'],'RSS KiB',stage['resources']['max_process_rss_kib'],flush=True)
        if stage['exit_code']:
            print((ROOT/stage['stderr']).read_text()[-3000:],flush=True);raise SystemExit(1)
    audit=(ROOT/report['compilation'][-1]['stdout']).read_text()
    assert audit.count('Closed under the global context')==36,audit[-3000:]
    report['assumption_audit']='36 Closed under the global context'
    report['kernel_check']=measure([COQ/'coqchk','-silent',*flags,'Candidate'],attempt/'kernel-check',src)
    report['status']='KERNEL_CHECKED' if report['kernel_check']['exit_code']==0 else 'KERNEL_CHECK_FAILED'
    save(attempt/'coq-receipt.json',report)
    print(json.dumps({'status':report['status'],'kernel_wall_seconds':report['kernel_check']['wall_seconds'],'kernel_resources':report['kernel_check']['resources']}),flush=True)
    assert report['status']=='KERNEL_CHECKED'

if __name__=='__main__':main()
