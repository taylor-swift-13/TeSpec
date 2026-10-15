from pathlib import Path
import json,re,subprocess,hashlib
b=Path(__file__).resolve().parent;m=json.loads((b/'manifest.json').read_text());receipts=[]
for row in m['records']:
 for v in row['variants']:
  if not v['files']:continue
  cn=(b/v['files']['cn']['path']).read_text();qcp=(b/v['files']['qcp']['path']).read_text()
  clean=lambda s:re.sub(r'/\*.*?\*/','',s,flags=re.S).replace('#include "verification_stdlib.h"\n','').strip()
  assert clean(cn)==clean(qcp),(row['id'],v['id'],'different bodies')
  base=row['variants'][0];basecn=(b/base['files']['cn']['path']).read_text();baseq=(b/base['files']['qcp']['path']).read_text()
  if v['kind']=='spec':assert clean(cn)==clean(basecn)
  if v['kind']=='impl':
   assert re.findall(r'/\*@.*?\*/',cn,re.S)==re.findall(r'/\*@.*?\*/',basecn,re.S)
   assert re.findall(r'/\*@.*?\*/',qcp,re.S)==re.findall(r'/\*@.*?\*/',baseq,re.S)
  w=v['witness'];sig=clean(cn).split('{',1)[0];target=row['target'];isptr='*p' in sig;void=sig.startswith('void');unsigned='unsigned' in sig
  if isptr:
   ty='unsigned int' if unsigned else 'int';null=w.get('pointer')=='NULL'
   setup=ty+' cell = '+str(w.get('initial',7))+'; '
   arg='(('+ty+'*)0)' if null else '&cell'
   call=target+'('+arg+')'
   main=setup+(call+'; printf("%lld\\n", (long long)cell);' if void else 'long long result = '+call+'; printf("%lld %lld\\n",result,(long long)cell);')
  else:
   args=[w[k] for k in (['x','y'] if 'y' in w else ['x'] if 'x' in w else ['n'])]
   main='long long result = '+target+'('+','.join('(-2147483647-1)' if x==-2147483648 else str(x) for x in args)+'); printf("%lld\\n",result);'
  out=b/'cases'/row['id']/v['id']/'witness';out.mkdir(exist_ok=True)
  text='#include <stdio.h>\n#include <limits.h>\n'+clean(cn)+'\nint main(void) { '+main+' return 0; }\n'
  harness=out/'witness.c';harness.write_text(text);exe=out/'witness.exe'
  p=subprocess.run(['gcc','-std=c11','-fno-builtin','-fsanitize=undefined','-fno-sanitize-recover=all',str(harness),'-o',str(exe)],capture_output=True,text=True)
  assert p.returncode==0,p.stderr
  p=subprocess.run([str(exe)],capture_output=True,text=True,timeout=5)
  (out/'execution.log').write_text('exit='+str(p.returncode)+'\nstdout='+p.stdout+'\nstderr='+p.stderr)
  expected_ub=w.get('pointer')=='NULL' or w.get('actual') in ['signed overflow','invalid access','invalid write','invalid read']
  if expected_ub:ok=p.returncode!=0 and 'runtime error:' in p.stderr
  else:
   values=[int(x) for x in p.stdout.split()];expected=w.get('expected') if v['kind']=='correct' else w.get('actual')
   ok=p.returncode==0
   if isinstance(expected,int):ok=ok and values[0]==expected
   if 'cell remains' in str(expected) or expected=='empty heap':ok=ok and isptr
   if isptr and not void and v['kind']!='impl':ok=ok and values[-1]==w.get('initial',7)
  receipt={'source':row['id'],'variant':v['id'],'status':'OBSERVED' if ok else 'MISMATCH','exit_code':p.returncode,'stdout':p.stdout.strip(),'expected_ub':expected_ub,'harness_sha256':hashlib.sha256(text.encode()).hexdigest(),'scope':'Concrete C observation; ownership/emp failures additionally rely on checked resource semantics, not on this observation alone.'}
  receipts.append(receipt)
  assert ok,receipt
(b/'witness-receipts.json').write_text(json.dumps(receipts,indent=2)+'\n')
print('Identical CN/QCP bodies and mutation isolation checked; concrete observations:',len(receipts))
