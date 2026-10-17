from pathlib import Path
import sys,json,hashlib,shutil,tempfile,datetime
R=Path(__file__).resolve().parents[4];O=Path(__file__).resolve().parent;G=R/'benchmark/results/Dbl_Linked_List__singleton';C=R/'benchmark/programs/Dbl_Linked_List__singleton/compat/cn-5.2'
sys.path.insert(0,str(R/'tools/benchmark'))
from cn_toolchain import CN,installed_identity
from test_read_variants import measure,save,sha
identity=installed_identity();assert identity==json.loads((O/'toolchain.json').read_text())
base=json.loads((G/'20261016-evaluation/results.json').read_text())
result={'schema':'tespec-cn-fulminate-compatibility-evaluation/v1','group':'Dbl_Linked_List__singleton','started_utc':datetime.datetime.now(datetime.timezone.utc).isoformat(),'toolchain':identity,'compatibility_manifest':str((C/'manifest.json').relative_to(R)),'compatibility_manifest_sha256':sha(C/'manifest.json'),'runs':[],'teSpec':'USER_REQUESTED_SKIP_MISSING_ALLOCATOR_BODY','model_calls':0,'tokens':0}
if (O/'finite-results.json').exists():raise FileExistsError('Immutable measured batch already exists; use a fresh output location for reproduction.')
save(O/'finite-results.json',result)
for row in base['runs']:
 old=R/row['harness'];assert sha(old)==row['harness_sha256']
 inputs=R/'benchmark/programs/Dbl_Linked_List__singleton/variants/cn_original_Dbl_Linked_List__singleton/tests/20261018-cn52'/row['case'];inputs.mkdir(parents=True,exist_ok=False)
 new=inputs/'fulminate.cn.c';new.write_text(old.read_text().replace('return == 0i32','return == 0'))
 dest=O/'finite'/row['case'];out=dest/'generated';out.mkdir(parents=True,exist_ok=False)
 m=measure([CN,'instrument','--run','--cc='+str(C/'gcc-with-runtime.sh'),'--output-dir='+str(out),'-I'+str(C/'Dbl_Linked_List'),new],dest/'pipeline',timeout=90)
 binaries=list(out.glob('*.exec.out'));record={'case':row['case'],'element':row['initial'],'expected':row['expected'],'variant':row['variant'],'paired_qcp_variant':row['paired_qcp_variant'],'original_harness':row['harness'],'original_harness_sha256':row['harness_sha256'],'harness':str(new.relative_to(R)),'harness_sha256':sha(new),'pipeline':m,'test':None,'generated_sources':[{'path':str(p.relative_to(R)),'sha256':sha(p)} for p in out.glob('*.exec.c')]}
 if m['exit_code']==0 and len(binaries)==1:
  record['binary_sha256']=sha(binaries[0]);test=measure([binaries[0]],dest/'test',timeout=30);test['status']='PASS' if test['exit_code']==0 else 'FAIL';record['test']=test
 result['runs'].append(record);save(O/'finite-results.json',result);print(row['case'],m['exit_code'],record['test']['status'] if record['test'] else 'NOT_BUILT',flush=True)
 if record['test'] is None or record['test']['status']!='PASS':raise SystemExit('Unexpected positive result; preserve logs and stop.')
# Negative diagnostic: same contract, one in-range data mutation, input 5.
positive=next(x for x in result['runs'] if x['element']==5);src=(R/positive['harness']).read_text();assert src.count('n->data = element;')==1
neg=O/'negative-control.c';neg.write_text(src.replace('n->data = element;','n->data = element + 1;'))
nd=O/'negative-control';out=nd/'generated';out.mkdir(parents=True,exist_ok=False)
nm=measure([CN,'instrument','--run','--cc='+str(C/'gcc-with-runtime.sh'),'--output-dir='+str(out),'-I'+str(C/'Dbl_Linked_List'),neg],nd/'pipeline',timeout=90)
binaries=list(out.glob('*.exec.out'));n={'expected':'FAIL','element':5,'source':str(neg.relative_to(R)),'source_sha256':sha(neg),'pipeline':nm,'test':None,'generated_sources':[{'path':str(p.relative_to(R)),'sha256':sha(p)} for p in out.glob('*.exec.c')]}
if len(binaries)==1:
 n['binary_sha256']=sha(binaries[0]);n['test']=measure([binaries[0]],nd/'test',timeout=30)
result['negative_diagnostic']=n;result['finished_utc']=datetime.datetime.now(datetime.timezone.utc).isoformat();save(O/'finite-results.json',result)
print('negative',nm['exit_code'],None if n['test'] is None else n['test']['exit_code'],flush=True)
assert n['test'] is not None and n['test']['exit_code']!=0
