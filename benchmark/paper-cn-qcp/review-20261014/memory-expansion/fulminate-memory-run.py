#!/usr/bin/env python3
"""Replay frozen upstream Fulminate memory exercises; no random generation."""
import argparse,hashlib,json,re,subprocess,time
from collections import Counter
from pathlib import Path
HERE=Path(__file__).resolve().parent;ROOT=HERE.parents[2]
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def read(p):return json.loads(p.read_text())
def save(p,v):p.write_text(json.dumps(v,indent=2)+'\n')
def execute(cmd,log,data=None,timeout=60):
 t=time.monotonic()
 with log.open('wb') as f:
  try:r=subprocess.run(cmd,cwd=ROOT,input=data,stdout=f,stderr=subprocess.STDOUT,timeout=timeout);code=r.returncode
  except subprocess.TimeoutExpired:code='TIMEOUT'
 return {'returncode':code,'seconds':round(time.monotonic()-t,3),'log_sha256':sha(log),'command':cmd}
def main():
 ap=argparse.ArgumentParser();ap.add_argument('--output',type=Path,required=True);a=ap.parse_args();out=a.output.resolve();out.mkdir(parents=True,exist_ok=False)
 report={'driver_sha256':sha(Path(__file__)),'scope':'original Fulminate track; QCP translation pending; native addresses normalized','runs':[]}
 for e in read(HERE/'catalog.json')['programs']:
  folder=HERE/e['path'];c=read(folder/'case.json');rows=read(folder/'inputs.json');origin=ROOT/c['source']
  assert sha(origin)==c['source_sha256']==sha(folder/'reference.cn.c')
  for n,d in c['files'].items():assert sha(folder/n)==d
  for variant in ['reference','spec_mutation','impl_mutation']:
   dest=out/c['id']/variant;dest.mkdir(parents=True)
   source=(folder/(variant+'.cn.c')).read_text()
   source=re.sub(r'#include "([^\"]+)"',lambda m:'#include "'+str((origin.parent/m[1]).resolve())+'"',source)
   def driver(native):
    cases=[]
    for i,r in enumerate(rows):cases.append(f'case {i}: {{ '+r['native_setup']+r['native_call']+(r['native_checks'] if native else '')+'return 0;}')
    adapter='\n#include <stdlib.h>\nvoid *cn_malloc(size_t n){return malloc(n);}\nvoid cn_free_sized(void *p,size_t n){(void)n;free(p);}\n' if native else ''
    return source+adapter+'\nint getchar(void);\nint main(void) /*@ ensures return == 0; @*/ {switch(getchar()){'+''.join(cases)+'default:return 13;}}\n'
   for tool in ['native32','native64','fulminate']:
    target=dest/(tool+'.c');target.write_text(driver(tool!='fulminate'));exe=dest/tool
    if tool=='fulminate':
     inst=dest/'instrumented';inst.mkdir();cmd=['opam','exec','--switch=tespec-cn-5.2','--','cn','instrument','--run','--cc=/usr/bin/gcc','--output-dir='+str(inst),str(target)];exe=inst/'fulminate.exec.out'
    else:cmd=['gcc','-std=c11','-m'+tool[-2:],str(target),'-o',str(exe)]
    build=execute(cmd,dest/(tool+'-build.log'));results=[]
    if exe.exists():
     for i,r in enumerate(rows):
      log=dest/(tool+'-'+r['id']+'.log');run=execute([str(exe)],log,bytes([i]),5);code=run['returncode'];txt=log.read_text(errors='replace')
      expected='FAIL' if variant!='reference' and r[variant+'_violated'] and (tool=='fulminate' or variant=='impl_mutation') else 'PASS'
      status='PASS' if code==0 else 'UNKNOWN' if code=='TIMEOUT' else 'FAIL' if (tool!='fulminate' and code in [12,14]) or 'Failed at' in txt or 'CN assertion failed' in txt else 'ERROR'
      results.append({'id':r['id'],'status':status,'expected':expected,**run})
    report['runs'].append({'case':c['id'],'variant':variant,'tool':tool,'build':build,'results':results,'missing_results':len(rows)-len(results),'case_sha256':sha(folder/'case.json')});save(out/'report.json',report)
   print(c['id'],variant,'complete',flush=True)
 report['summary']={'subjects':len(read(HERE/'catalog.json')['programs']),'fixed_inputs':sum(e['inputs'] for e in read(HERE/'catalog.json')['programs']),'missing_results':sum(g['missing_results'] for g in report['runs']),'mismatches':sum(r['status']!=r['expected'] for g in report['runs'] for r in g['results']),'counts':{t:dict(Counter(r['status'] for g in report['runs'] if g['tool']==t for r in g['results'])) for t in ['native32','native64','fulminate']}}
 save(out/'report.json',report);print(json.dumps(report['summary']))
if __name__=='__main__':main()
