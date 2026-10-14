#!/usr/bin/env python3
"""Replay immutable suites; selection and all tool identities are recorded.

This is a bounded regression check, not a performance experiment or a proof of
CN/QCP contract equivalence. UNKNOWN is never counted as a killed mutation.
"""
import argparse
from collections import Counter
from concurrent.futures import ThreadPoolExecutor, as_completed
import copy
import importlib.util
import json
from pathlib import Path
import re
import shutil
import subprocess
import sys
import time

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
spec = importlib.util.spec_from_file_location('frozen_helpers', HERE/'expansion80/run-suites.py')
h = importlib.util.module_from_spec(spec)
spec.loader.exec_module(h)

def save(path, data):
    path.write_text(json.dumps(data, indent=2, ensure_ascii=False)+'\n')

def size(item):
    return len(item.get('graph', {}).get('nodes', [])) + sum(len(v) for v in item.get('arrays', {}).values())

def select(suite, count):
    rows = suite['inputs']
    if count == 0 or count >= len(rows): return rows
    chosen = []
    def add(row):
        if row not in chosen and len(chosen) < count: chosen.append(row)
    add(rows[0])
    for kind in ('impl', 'spec'):
        for violated in (True, False):
            found = next((r for r in rows if r[kind+'_mutation_violated'] == violated), None)
            if found is not None: add(found)
    add(max(rows, key=size))
    add(rows[-1])
    for fraction in (0.5, 0.25, 0.75): add(rows[int((len(rows)-1)*fraction)])
    for row in rows: add(row)
    return [r for r in rows if r in chosen]

def harness(source, suite, oracle):
    if not suite.get('memory_control'): return h.harness(source, suite, oracle)
    blocks=[]
    for index,item in enumerate(suite['inputs']):
        arrays=item.get('arrays',{});cells=item.get('cells',{})
        setup=' '.join('int '+name+'['+str(max(1,len(values)))+'] = {'+', '.join(map(str,values or [0]))+'};' for name,values in arrays.items())
        setup+=' '.join('int '+name+' = '+str(value)+';' for name,value in cells.items())
        boxes=suite.get('pointer_boxes',{})
        setup+=' '.join('struct pointer_box '+name+' = { &'+target+' };' for name,target in boxes.items())
        def argument(name):
            if name in arrays:return name
            if name in cells or name in boxes:return '&'+name
            if name in suite.get('pointer_offsets',{}):
                offset=suite['pointer_offsets'][name]
                return offset['base']+' + '+str(item['args'][offset['index_arg']])
            return str(item['args'][name])
        call=suite['function']+'('+', '.join(argument(n) for n in suite['parameter_order'])+');'
        checks=''
        if oracle:
            for name,expected in item['expected_heap'].items():
                if isinstance(expected,list):
                    checks+=' '.join(f'if ({name}[{i}] != {value}) return 14;' for i,value in enumerate(expected))
                else:checks+=f'if ({name} != {expected}) return 14;'
            checks+=' '.join('if ('+name+'.ptr != &'+target+') return 14;' for name,target in boxes.items())
        blocks.append(f'case {index}: {{ {setup} {call} {checks} return 0; }}')
    return source+'\nint getchar(void);\nint main(void) /*@ ensures return == 0; @*/ { switch(getchar()) {\n'+'\n'.join(blocks)+'\ndefault:return 13;} }\n'

def replay(folder, args, prefix):
    started = time.monotonic()
    original = json.loads((folder/'suite.json').read_text())
    ident = original['id']
    for name, digest in original['files'].items():
        if h.sha(folder/name) != digest: raise ValueError((ident, name, 'hash mismatch'))
    suite = copy.deepcopy(original)
    suite['inputs'] = select(suite, args.sample_count)
    suite['input_count'] = len(suite['inputs'])
    root = args.output/ident
    root.mkdir()
    save(root/'selection.json', {'suite_sha256': h.sha(folder/'suite.json'),
        'suite_path': str(folder.relative_to(ROOT)), 'total_inputs': original['input_count'],
        'selected_ids': [r['id'] for r in suite['inputs']], 'inputs': suite['inputs']})
    groups = []
    for variant in suite['variants']:
        dest = root/variant
        dest.mkdir()
        for name in suite['files']:
            if name.endswith(('.v','.h','.strategies')): shutil.copyfile(folder/name, dest/name)
        source = (folder/(variant+'.cn.c')).read_text()
        expected = {r['id']: ('FAIL' if variant != 'reference' and r[variant+'_violated'] else 'PASS') for r in suite['inputs']}
        if 'native' in args.tools and variant == 'reference':
            target = dest/'oracle.c'
            target.write_text(harness(re.sub(r'^\s*#include[^\n]*','',source,flags=re.M),suite,True))
            for bits in (32,64):
                exe = dest/('native'+str(bits))
                build = h.paired.execute(['gcc','-std=c11','-m'+str(bits),'-O1',*suite.get('native_c_flags',[]),str(target),'-o',str(exe)], dest, 'native'+str(bits)+'-build',args.build_timeout)
                rows = []
                if build['returncode'] == 0:
                    for i, item in enumerate(suite['inputs']):
                        run = h.execute_input([str(exe)],dest,'native'+str(bits)+'-'+item['id'],args.timeout,i)
                        rows.append({'id': item['id'], 'status': 'PASS' if run['returncode']==0 else 'ERROR', 'expected':'PASS','returncode':run['returncode']})
                groups.append({'variant':variant,'tool':'native'+str(bits),'build':build,'results':rows})
        if 'fulminate' in args.tools:
            target = dest/'driver.cn.c'
            target.write_text(harness(source,suite,False))
            instrumented = dest/'instrumented'
            instrumented.mkdir()
            build = h.execute_input(prefix+['cn','instrument','--run','--cc=/usr/bin/gcc','--output-dir='+str(instrumented),str(target)],dest,'fulminate-build',args.build_timeout,0)
            exe = instrumented/'driver.cn.exec.out'
            if not exe.exists(): exe = instrumented/'driver.exec.out'
            rows = []
            if exe.exists():
                for i,item in enumerate(suite['inputs']):
                    run = h.execute_input([str(exe)],dest,'fulminate-'+item['id'],args.timeout,i)
                    log = (dest/('fulminate-'+item['id']+'.log')).read_text(errors='replace')
                    status = ('PASS' if run['returncode']==0 else 'FAIL' if isinstance(run['returncode'],int) and ('Failed at' in log or 'CN assertion failed' in log) else 'UNKNOWN' if run['returncode']=='TIMEOUT' else 'ERROR')
                    rows.append({'id':item['id'],'status':status,'expected':expected[item['id']],'returncode':run['returncode']})
            groups.append({'variant':variant,'tool':'fulminate','build':build,'results':rows})
        if 'qcp' in args.tools:
            target = dest/'subject.qcp.c'
            shutil.copyfile(folder/(variant+'.qcp.c'),target)
            binds = dest/'binds.json'
            save(binds,[r['qcp_bind'] for r in suite['inputs']])
            command = [sys.executable,'-m','spectest','run',str(target),'--function',suite['function'],'--binds',str(binds),'--output-dir',str(dest/'qcp'),'--execution-mode','entry-exit','--loop-unroll-limit',str(args.limit),'--call-depth-limit',str(args.limit),'--timeout',str(args.timeout),'--compact','-I',str(ROOT/'runtime/qcip/QCP_examples/QCP_demos_human')]
            for include in suite.get('qcp_include_dirs',[]):
                directory = (ROOT/include).resolve()
                if not directory.is_relative_to(ROOT) or not directory.is_dir(): raise ValueError(include)
                command += ['-I',str(directory)]
            run = h.paired.execute(command,dest,'qcp',args.timeout*len(suite['inputs'])+60)
            evidence = dest/'qcp/report.json'
            rows = []
            if evidence.exists():
                for row in json.loads(evidence.read_text()).get('results',[]):
                    rows.append({'id':row['id'],'status':row.get('test_result') or row.get('status'),'expected':expected[row['id']], 'diagnostic_status':row.get('status'),'precondition_result':row.get('precondition_result'),'reason':row.get('reason')})
            groups.append({'variant':variant,'tool':'qcp','execution':run,'results':rows})
        save(root/'groups.json',groups)
    for group in groups:
        rows = group['results']
        group['counts'] = dict(Counter(r['status'] for r in rows))
        group['false_pass'] = sum(r['status']=='PASS' and r['expected']=='FAIL' for r in rows)
        group['false_fail'] = sum(r['status']=='FAIL' and r['expected']=='PASS' for r in rows)
        group['missing_results'] = len(suite['inputs']) - len(rows)
        group['mismatches'] = sum(r['status']!=r['expected'] for r in rows)
    result = {'id':ident,'total_inputs':original['input_count'],'selected_inputs':len(suite['inputs']), 'full_suite':len(suite['inputs'])==original['input_count'], 'seconds':round(time.monotonic()-started,3),'groups':groups}
    save(root/'report.json',result)
    return result

def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--output',type=Path,required=True)
    ap.add_argument('--suites',type=Path,default=HERE/'expansion80/suites')
    ap.add_argument('--cases',nargs='+')
    ap.add_argument('--sample-count',type=int,default=8,help='0 replays every frozen input')
    ap.add_argument('--jobs',type=int,default=2)
    ap.add_argument('--tools',default='native,fulminate,qcp')
    ap.add_argument('--switch',default='tespec-cn-5.2')
    ap.add_argument('--timeout',type=float,default=5)
    ap.add_argument('--build-timeout',type=float,default=120)
    ap.add_argument('--limit',type=int,default=128)
    args=ap.parse_args()
    if args.sample_count < 0 or args.jobs < 1 or args.limit < 1 or args.timeout<=0 or args.build_timeout<=0: ap.error('Invalid bounds')
    args.tools=set(args.tools.split(','))
    if args.tools-{'native','fulminate','qcp'}: ap.error('Invalid tool')
    args.output=args.output.resolve()
    args.suites=args.suites.resolve()
    args.output.mkdir(parents=True,exist_ok=False)
    folders=[args.suites/c for c in args.cases] if args.cases else sorted(p.parent for p in args.suites.glob('*/suite.json'))
    if not folders:ap.error('No suites selected')
    prefix=['opam','exec','--switch='+args.switch,'--']
    report={'schema':'tespec-frozen-replay/v1','scope':'bounded regression, not performance or equivalence proof', 'execution_mode':'entry-exit','sample_count':args.sample_count,'jobs':args.jobs,'timeout':args.timeout,'loop_and_call_limit':args.limit,'tools':sorted(args.tools),'driver_sha256':h.sha(Path(__file__)),'helper_sha256':h.sha(HERE/'expansion80/run-suites.py'),'paired_helper_sha256':h.sha(HERE/'run.py'),'binary_sha256':h.sha(ROOT/'bin/tespec-symexec'),'cases':[],'errors':[]}
    report['python']=sys.version
    report['gcc']=subprocess.check_output(['gcc','--version'],text=True).splitlines()[0]
    report['spectest_files']={str(p.relative_to(ROOT)):h.sha(p) for p in sorted((ROOT/'spectest').glob('*.py'))}
    if 'fulminate' in args.tools:
        binary=Path(subprocess.check_output(prefix+['which','cn'],text=True).strip())
        report['cn_binary_sha256']=h.sha(binary)
        report['cn_version']=subprocess.check_output(prefix+['cn','--version'],text=True).strip()
    shutil.copyfile(Path(__file__),args.output/'driver-snapshot.py')
    save(args.output/'report.json',report)
    with ThreadPoolExecutor(max_workers=args.jobs) as pool:
        futures={pool.submit(replay,folder,args,prefix):folder.name for folder in folders}
        for future in as_completed(futures):
            name=futures[future]
            try:
                result=future.result();report['cases'].append(result)
                print(name, result['seconds'], 'seconds', flush=True)
            except Exception as e:
                report['errors'].append({'id':name,'error':str(e)}); print(name,repr(e),flush=True)
            save(args.output/'report.json',report)
    report['cases'].sort(key=lambda c:c['id'])
    groups=[g for c in report['cases'] for g in c['groups']]
    report['summary']={'subjects':len(report['cases']),'selected_inputs':sum(c['selected_inputs'] for c in report['cases']), 'fully_replayed_subjects':sum(c['full_suite'] for c in report['cases']), 'false_pass':sum(g['false_pass'] for g in groups),'false_fail':sum(g['false_fail'] for g in groups),'missing_results':sum(g['missing_results'] for g in groups),'mismatches':sum(g['mismatches'] for g in groups),'errors':len(report['errors'])}
    report['summary']['by_tool']={tool:dict(Counter(r['status'] for g in groups if g['tool']==tool for r in g['results'])) for tool in sorted({g['tool'] for g in groups})}
    save(args.output/'report.json',report)
    print(json.dumps(report['summary']),flush=True)
    return int(bool(report['errors']) or any(g['mismatches'] or g['missing_results'] for g in groups))

if __name__=='__main__': raise SystemExit(main())
