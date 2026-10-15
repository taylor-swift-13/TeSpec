#!/usr/bin/env python3
"""Build reviewed, semantic CN/QCP mutation pairs; never fill missing rows with clones."""
from pathlib import Path
import hashlib,json
HERE=Path(__file__).resolve().parent
ROOT=HERE.parents[2]
SOURCE=ROOT/'benchmark/selection/sources/fulminate-cn/src/examples'
from scalar_memory import extra, build_extra
SLOTS=['correct','spec_1','spec_2','spec_3','impl_1','impl_2','impl_3']
def digest(data): return hashlib.sha256(data).hexdigest()
def make():
 records=[]
 for source in sorted(SOURCE.rglob('*.c')):
  original=source.relative_to(SOURCE).as_posix()
  ident=original[:-2].replace('/','__')
  record={'id':ident,'original':str(source.relative_to(ROOT)),'original_sha256':digest(source.read_bytes()),'status':'PENDING_BASELINE_AND_MUTATIONS','variants':[]}
  if original in ['zero.c','3.c','abs.c','add_0.c','add_1.c','add_2.c'] or original in extra:
   variants=build_extra(original) if original in extra else build(original)
   for slot,(sig,cn,qcp,body,note,witness) in zip(SLOTS,variants):
    d=HERE/'cases'/ident/slot; d.mkdir(parents=True,exist_ok=True)
    files={}
    for language,spec in [('cn',cn),('qcp',qcp)]:
     text=('' if language=='cn' else '#include "verification_stdlib.h"\n')+sig+'\n/*@ '+spec+' @*/\n'+body+'\n'
     if language=='qcp':text=text.replace(' @*/',' */')
     p=d/(language+'.c');p.write_text(text)
     files[language]={'path':str(p.relative_to(HERE)),'sha256':digest(text.encode())}
    record['variants'].append({'id':slot,'kind':slot.split('_')[0],'expected':'ACCEPT' if slot=='correct' else 'REJECT','mutation':note,'witness':witness,'files':files,'verification':'NOT_RUN'})
   record['status']='GENERATED_NOT_YET_VALIDATED'
   record['target']=variants[0][0].split('(')[0].split()[-1]
   record['legacy_target_hint']='zero' if original in ['zero.c','3.c'] else ('abs' if original=='abs.c' else 'add')
   record['scope']='Selected function; original trusted main excluded. Both languages use identical executable body.'
   record['baseline_changes']='Explicit functional postcondition supplied where original omitted it; no trusted function body.'
  else:
   record['variants']=[{'id':s,'expected':'ACCEPT' if s=='correct' else 'REJECT','verification':'PENDING','files':{}} for s in SLOTS]
  records.append(record)
 manifest={'schema':'tespec-paired-semantic-mutations/v1','requested':{'sources':76,'variants_per_source':7,'language_files':1064},'policy':{'source_unit':'Pinned source C file; duplicate bodies retained as distinct source lineages. Report semantic duplicates separately.','negative':'Wrong specification holds implementation fixed; wrong implementation holds correct specification fixed.','correctness':'Positive requires CN verify success and QCP automatic plus checked manual proofs. Negative requires a semantic witness, no parse/tool failure credit.','scope':'Function coverage explicit per source; no claim of whole-program coverage.','trusted':'No trusted annotation permitted on mutation targets.','status':'Missing files are pending, never counted as generated or verified.'},'records':records}
 (HERE/'manifest.json').write_text(json.dumps(manifest,indent=2)+'\n')
 print('source rows',len(records),'generated pairs',sum(bool(v['files']) for x in records for v in x['variants']))
def build(source):
 if source in ['zero.c','3.c']:
  sig='void zero(int *p)'
  cn='requires take u = Block<int>(p); ensures take v = Owned<int>(p); v == 0i32;'
  q='Require undef_data_at(p,int) Ensure data_at(p,int,0)'
  body='{ *p = 0; }'
  return [(sig,cn,q,body,'Correct initialization',{'initial':7,'expected':0}),
   (sig,cn.replace('0i32','1i32'),q.replace('int,0)','int,1)'),body,'Wrong initialized value',{'initial':7,'actual':0,'claimed':1}),
   (sig,'requires true; ensures true;','Require emp Ensure emp',body,'Missing write permission',{'pointer':'NULL','actual':'invalid write'}),
   (sig,'requires take old = Owned<int>(p); ensures take v = Owned<int>(p); v == old;','With old Require data_at(p,int,old) Ensure data_at(p,int,old)',body,'Incorrect preservation of old contents',{'initial':7,'actual':0,'claimed':7}),
   (sig,cn,q,'{ *p = 1; }','Wrong stored constant',{'initial':7,'actual':1,'expected':0}),
   (sig,cn,q,'{ }','Missing store',{'initial':7,'actual':7,'expected':0}),
   (sig,cn,q,'{ *p = -1; }','Wrong sign/value stored',{'initial':7,'actual':-1,'expected':0})]
 if source=='abs.c':
  sig='int abs(int x)';body='{ if (x >= 0) { return x; } else { return -x; } }'
  cn='requires MINi32() < x; ensures return == ((x >= 0i32) ? x : (0i32-x));'
  q='Require -2147483648 < x && emp Ensure ((x >= 0 && __return == x) || (x < 0 && __return == -x)) && emp'
  return [(sig,cn,q,body,'Correct absolute value',{'x':-2,'expected':2}),
   (sig,'requires MINi32() < x; ensures return == x;','Require -2147483648 < x && emp Ensure __return == x && emp',body,'Incorrect identity postcondition',{'x':-2,'actual':2,'claimed':-2}),
   (sig,'requires MINi32() < x; ensures return == 0i32-x;','Require -2147483648 < x && emp Ensure __return == -x && emp',body,'Incorrect negation postcondition',{'x':2,'actual':2,'claimed':-2}),
   (sig,cn.replace('MINi32() < x','true'),q.replace('-2147483648 < x && ','') ,body,'Missing signed-negation safety precondition',{'x':-2147483648,'actual':'signed overflow'}),
   (sig,cn,q,body.replace('x >= 0','x < 0'),'Reversed branch condition',{'x':2,'actual':-2,'expected':2}),
   (sig,cn,q,'{ return x; }','Missing negative branch',{'x':-2,'actual':-2,'expected':2}),
   (sig,cn,q,'{ return -x; }','Unconditional negation',{'x':2,'actual':-2,'expected':2})]
 sig='int add(int x, int y)';body='{ return x+y; }'
 pre='requires let sum = (i64)x + (i64)y; -2147483648i64 <= sum; sum <= 2147483647i64; '
 cn=pre+'ensures return == (i32)sum;'
 qp='Require -2147483648 <= x+y && x+y <= 2147483647 && emp '
 q=qp+'Ensure __return == x+y && emp'
 return [(sig,cn,q,body,'Correct signed addition',{'x':2,'y':3,'expected':5}),
  (sig,pre+'ensures (i64)return == (i64)x - (i64)y;',qp+'Ensure __return == x-y && emp',body,'Subtraction claimed instead of addition',{'x':2,'y':3,'actual':5,'claimed':-1}),
  (sig,pre+'ensures return == x;',qp+'Ensure __return == x && emp',body,'Second operand omitted from postcondition',{'x':2,'y':3,'actual':5,'claimed':2}),
  (sig,'requires true; ensures true;','Require emp Ensure emp',body,'Missing signed-addition safety precondition',{'x':2147483647,'y':1,'actual':'signed overflow'}),
  (sig,cn,q,'{ return x-y; }','Subtraction implementation',{'x':2,'y':3,'actual':-1,'expected':5}),
  (sig,cn,q,'{ return x*y; }','Multiplication implementation',{'x':2,'y':3,'actual':6,'expected':5}),
  (sig,cn,q,'{ return y; }','First operand omitted',{'x':2,'y':3,'actual':3,'expected':5})]
if __name__=='__main__': make()
