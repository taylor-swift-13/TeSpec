from pathlib import Path
import json,sys,hashlib,shutil,datetime
R=Path(__file__).resolve().parents[4];O=Path(__file__).resolve().parent
sys.path.insert(0,str(R/'tools/benchmark'))
from cn_toolchain import CN,installed_identity
from test_read_variants import measure,save,sha
G=R/'benchmark/programs/dll_add'
C=R/'benchmark/programs/Dbl_Linked_List__singleton/compat/cn-5.2'
plan=json.loads((G/'evaluation-plan.json').read_text())
variants={json.loads(p.read_text())['id']:json.loads(p.read_text()) for p in G.glob('variants/*/manifest.json')}
primary=variants[plan['primary_cn_variant']]['files']['cn']
report={'schema':'tespec-group-scope-recheck/v1','program_group':'dll_add','inspection_order':24,'toolchain':installed_identity(),'started_utc':datetime.datetime.now(datetime.timezone.utc).isoformat(),'compatibility_manifest':str((C/'manifest.json').relative_to(R)),'compatibility_manifest_sha256':sha(C/'manifest.json'),'scope':'Diagnostic compatibility recheck; original sources/specifications/expectations unchanged; no nonempty-list coverage added. teSpec allocator execution deferred by user.','tespec':{'status':'SKIPPED_ALLOCATOR_DEFERRED','new_execution_count':0},'runs':[]}
if (O/'results.json').exists():raise FileExistsError('Preserved batch; use fresh output location')
save(O/'results.json',report)
source=R/primary['path'];assert sha(source)==primary['sha256']
report['cn_original_dependencies']=measure([CN,'verify',*['-I'+str(R/x) for x in primary['include_dirs']],source],O/'cn-original',timeout=90)
report['cn_compatible_dependencies']=measure([CN,'verify','-I'+str(C/'Dbl_Linked_List'),source],O/'cn-compatible',timeout=90)
save(O/'results.json',report)
for pair in plan['pairings']:
 v=variants[pair['cn_variant']];f=v['files']['cn'];source=R/f['path'];assert sha(source)==f['sha256']
 for case in pair['cases']:
  dest=O/v['id'].replace(':','_')/case['id'];dest.mkdir(parents=True)
  harness=dest/'input.cn.c';harness.write_text(source.read_text()+'\nint main(void) /*@ ensures return == 0; @*/ { '+case['cn_body']+' return 0; }\n')
  out=dest/'generated';out.mkdir()
  pipe=measure([CN,'instrument','--run','--cc='+str(C/'gcc-with-runtime.sh'),'--output-dir='+str(out),'-I'+str(C/'Dbl_Linked_List'),harness],dest/'pipeline',timeout=90)
  row={'variant':pair['cn_variant'],'paired_qcp_variant':pair['qcp_variant'],'case':case['id'],'plan_case':case,'source':f['path'],'source_sha256':sha(source),'harness':str(harness.relative_to(R)),'harness_sha256':sha(harness),'pipeline':pipe,'test':None,'generated_sources':[{'path':str(p.relative_to(R)),'sha256':sha(p)} for p in out.glob('*.exec.c')]}
  bins=list(out.glob('*.exec.out'))
  if len(bins)==1:
   row['binary_sha256']=sha(bins[0]);row['test']=measure([bins[0]],dest/'test',timeout=30)
   row['status']='PASS' if row['test']['exit_code']==0 else 'FAIL'
  else:row['status']='NOT_BUILT'
  report['runs'].append(row);save(O/'results.json',report)
  print(v['id'],case['id'],row['status'],flush=True)
report['finished_utc']=datetime.datetime.now(datetime.timezone.utc).isoformat()
save(O/'results.json',report)
print('CN exits',report['cn_original_dependencies']['exit_code'],report['cn_compatible_dependencies']['exit_code'],flush=True)
