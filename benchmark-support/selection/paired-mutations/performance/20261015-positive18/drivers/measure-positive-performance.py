from pathlib import Path
import json,subprocess,os,time,signal,hashlib,sys,statistics,re,datetime,threading
ROOT=Path('/home/yangfp/teSpec-benchmark-tespec');BASE=ROOT/'benchmark/selection/paired-mutations'
OUT=BASE/'performance/20261015-positive18/automatic-final';OUT.mkdir(parents=True,exist_ok=True)
if (OUT/'raw-results.json').exists():raise SystemExit('Final automatic measurements already exist; choose a new output directory.')
SW=Path('/home/yangfp/.opam/tespec-cn-20260416');QCP=Path('/home/yangfp/tespec-baselines/qcp-benchmark-vc-printer/build/release/symexec');ENV=os.environ.copy();ENV.update(OPAM_SWITCH_PREFIX=str(SW),PATH=str(SW/'bin')+':/usr/local/bin:/usr/bin:/bin')
INCLUDE=ROOT/'runtime/qcip/QCP_examples/QCP_demos_human'
MAN=json.loads((BASE/'manifest.json').read_text());SUBJECTS=[r for r in MAN['records'] if r['variants'][0].get('verification')=='PAIRED_ACCEPTED']
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def measure(cmd,folder,env=None,timeout=120):
 folder.mkdir(parents=True,exist_ok=True);res=folder/'resources.json';log=folder/'stdout.log';error=folder/'stderr.log'
 wrapper=['/usr/bin/time','--quiet','-f','{"max_process_rss_kib":%M,"user_seconds":%U,"system_seconds":%S,"wall_seconds_gnu":%e}','-o',str(res),*map(str,cmd)]
 start=time.monotonic()
 with log.open('wb') as stdout,error.open('wb') as stderr:
  proc=subprocess.Popen(wrapper,cwd=ROOT,env=env or ENV,stdout=stdout,stderr=stderr,start_new_session=True)
  expired=threading.Event()
  def terminate():
   if proc.poll() is None:
    expired.set()
    try:os.killpg(proc.pid,signal.SIGKILL)
    except ProcessLookupError:pass
  timer=threading.Timer(timeout,terminate);timer.daemon=True;timer.start()
  proc.wait();timer.cancel();code='TIMEOUT' if expired.is_set() else proc.returncode
 elapsed=time.monotonic()-start
 resources=json.loads(res.read_text()) if res.exists() and res.stat().st_size else None
 return {'command':list(map(str,cmd)),'exit_code':code,'wall_seconds':elapsed,'resources':resources,'stdout_sha256':sha(log),'stderr_sha256':sha(error),'folder':str(folder.relative_to(OUT))}
def literal(x,unsigned=False):return '(-2147483647-1)' if x==-2147483648 else str(x)+('U' if unsigned else '')
def fixtures(row,source):
 sig=re.sub(r'/\*.*?\*/','',source,flags=re.S).split('{',1)[0];pointer='*p' in sig;unsigned='unsigned int' in sig;void=sig.strip().startswith('void');ident=row['id'];target=row['target']
 if pointer:
  if target=='zero':vals=[7]
  elif target=='inplace_double':vals=[-1073741824,-1,0,1,1073741823]
  elif unsigned:vals=[0,1,2,4294967294,4294967295]
  elif target=='incr':vals=[-2147483648,-1,0,1,2147483646]
  else:vals=[-2147483648,-1,0,1,2147483647]
  binds=[{'id':'input_'+str(i),'args':{'p':4096},'values':{} if target=='zero' else {'old':v}} for i,v in enumerate(vals)]
  tests=[]
  for i,v in enumerate(vals):
   setup=('unsigned int' if unsigned else 'int')+' cell_'+str(i)+' = '+literal(v,unsigned)+';'
   tests.append(setup+' '+target+'(&cell_'+str(i)+');')
 else:
  if target=='add':vals=[(-2147483648,0),(2147483647,0),(2147483646,1),(-2147483647,-1),(0,0),(5,-3)];keys=['x','y']
  else:
   keys=['x'] if target=='abs' else ['n']
   vals=[(v,) for v in ([0,1,2,4294967294,4294967295] if unsigned else [-2147483647,-1,0,1,2147483647] if target=='abs' else [-536870912,-1,0,1,536870911] if target=='quadruple' else [-1073741824,-1,0,1,1073741823])]
  binds=[{'id':'input_'+str(i),'args':dict(zip(keys,v)),'values':{}} for i,v in enumerate(vals)]
  tests=[target+'('+','.join(literal(x,unsigned) for x in v)+');' for v in vals]
 harness=source+'\nint main(void) /*@ ensures return == 0i32; @*/ {\n'+'\n'.join(tests)+'\nreturn 0; }\n'
 return binds,harness
report={'schema':'tespec-positive-performance/v1','started_utc':datetime.datetime.now(datetime.timezone.utc).isoformat(),'requested_model':'gpt-6.1-sol','subjects':len(SUBJECTS),'repetitions':3,'concurrency':1,'metric':'blocking wait with monotonic wall clock and asynchronous deadline; wall median across three fresh processes; peak process RSS maximum across repetitions, GNU time %M; this is not aggregate simultaneous process-tree RSS or remote model GPU memory','scope':'CN/QCP universal function verification; Fulminate/teSpec same frozen finite inputs; no cached proof generation attributed to the requested model','toolchain':{'cn_sha256':sha(SW/'bin/cn'),'qcp_sha256':sha(QCP),'tespec_sha256':sha(ROOT/'bin/tespec-symexec'),'manifest_sha256':sha(BASE/'manifest.json'),'driver_sha256':sha(Path(__file__)),'uname':subprocess.check_output(['uname','-a'],text=True).strip(),'cpu_count':os.cpu_count(),'load_average_at_start':os.getloadavg(),'meminfo_at_start':Path('/proc/meminfo').read_text().splitlines()[:3]},'runs':[]}
for row in SUBJECTS:
 ident=row['id'];d=OUT/ident;d.mkdir(exist_ok=True);cn=BASE/row['variants'][0]['files']['cn']['path'];qcp=BASE/row['variants'][0]['files']['qcp']['path']
 binds,harness=fixtures(row,cn.read_text());(d/'binds.json').write_text(json.dumps(binds,indent=2)+'\n');(d/'fulminate-harness.cn.c').write_text(harness)
 for rep in range(3):
  dest=d/('repeat-'+str(rep+1));dest.mkdir(exist_ok=True);result={'source':ident,'repeat':rep+1,'input_count':len(binds)}
  result['cn']=measure([SW/'bin/cn','verify',cn],dest/'cn')
  raw=dest/'qcp/native';raw.mkdir(parents=True,exist_ok=True)
  cmd=[QCP,'--input-file='+str(qcp),'--Json-output','--no-strategy-gen','--gen-and-backup','--coq-output-dir='+str(raw/'vc'),'--no-logic-path','--disable-solver-info','--no-exec-info','-I'+str(INCLUDE)]
  result['qcp_auto']=measure(cmd,dest/'qcp')
  try:
   data=json.loads((dest/'qcp/stdout.log').read_text());result['qcp_auto']['native_result']=data.get('result');result['qcp_auto']['manual']=sum(x['Witness']['total_witness_count']['manual'] for x in data.get('WitnessList',[]) if x.get('Witness'))
  except (ValueError,KeyError):result['qcp_auto']['native_result']='UNPARSEABLE'
  tmp=Path('/tmp')/('tespec-perf-'+ident+'-'+str(rep)+'-'+str(os.getpid()));tmp.mkdir(exist_ok=True)
  result['fulminate_pipeline']=measure([SW/'bin/cn','instrument','--run','--cc=/usr/bin/gcc','--output-dir='+str(tmp),d/'fulminate-harness.cn.c'],dest/'fulminate-pipeline')
  executables=list(tmp.glob('*.exec.out'));exe=executables[0] if len(executables)==1 else tmp/'not-built'
  if exe.exists():result['fulminate_test']=measure([exe],dest/'fulminate-test')
  else:result['fulminate_test']={'exit_code':'NOT_BUILT','reason':'instrumentation/compilation failed'}
  result['tespec_auto']=measure([sys.executable,'-m','spectest','run',qcp,'--function',row['target'],'--binds',d/'binds.json','--execution-mode','all-boundaries','--output-dir',dest/'tespec/automatic','--timeout','30','--compact'],dest/'tespec',env=ENV,timeout=180)
  path=dest/'tespec/automatic/report.json'
  if path.exists():
   tr=json.loads(path.read_text());result['tespec_auto']['statuses']=[x.get('status') for x in tr.get('results',[])];result['tespec_auto']['report']=str(path.relative_to(OUT))
  report['runs'].append(result);(OUT/'raw-results.json').write_text(json.dumps(report,indent=2)+'\n')
  print(ident,rep+1,'CN',result['cn']['exit_code'],'QCP',result['qcp_auto'].get('native_result'),'Fulminate',result['fulminate_pipeline']['exit_code'],'teSpec',result['tespec_auto'].get('statuses',result['tespec_auto']['exit_code']),flush=True)
print('Automatic measurements complete',flush=True)
