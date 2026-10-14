#!/usr/bin/env python3
"""Replay frozen scalar and array suites against native ABIs, Fulminate and teSpec ATP.

Each mutation is run on the entire admitted input suite. Only independently
witnessed violations have expected FAIL; surviving executions expect PASS.
"""
import argparse
from collections import Counter
import hashlib
import importlib.util
import json
from pathlib import Path
import re
import shutil
import subprocess
import sys

HERE=Path(__file__).resolve().parent
ROOT=HERE.parents[2]
spec=importlib.util.spec_from_file_location('paired_run',HERE.parent/'run.py')
paired=importlib.util.module_from_spec(spec);spec.loader.exec_module(paired)

def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def c_int(value):
    return str(value) if value!=-2147483648 else '(-2147483647 - 1)'
def harness(source,suite,oracle):
    code=[]
    for index,item in enumerate(suite['inputs']):
        graph=item.get('graph')
        if graph is not None:
            schema=suite['graph_schema'];nodes=graph['nodes']
            pointer=lambda name: '&'+name if name is not None else '0'
            setup=' '.join(schema['c_type']+' '+n['id']+';' for n in nodes)
            for node in nodes:
                setup+=' '.join(f"{node['id']}.{field} = {c_int(node[field])};" for field in schema['value_fields'])
                setup+=' '.join(f"{node['id']}.{field} = {pointer(node[field])};" for field in schema['link_fields'])
            call=suite['function']+'('+', '.join(pointer(graph['heads'][p]) for p in suite['parameter_order'])+')'
            if oracle:
                expected=(pointer(item['expected_return_node']) if 'expected_return_node' in item
                          else c_int(item['expected_return']))
                statement=f'if ({call} != {expected}) return 12;'
                for node in item['expected_graph_nodes']:
                    statement+=' '.join(f"if ({node['id']}.{field} != {c_int(node[field])}) return 14;" for field in schema['value_fields'])
                    statement+=' '.join(f"if ({node['id']}.{field} != {pointer(node[field])}) return 14;" for field in schema['link_fields'])
            else:statement=call+';'
            code.append(f'case {index}: {{ {setup} {statement} return 0; }}')
            continue
        arrays=item.get('arrays',{})
        cells=item.get('cells',{})
        structs=item.get('structs',{})
        aliases=suite.get('pointer_aliases',{})
        c_type=suite.get('element_c_type','int')
        literal=lambda v: str(v)+'U' if c_type=='unsigned int' else c_int(v)
        setup=' '.join(f"{c_type} {name}[{max(1,len(values))}] = {{"+', '.join(literal(v) for v in (values or [0]))+'};' for name,values in arrays.items())
        setup+=' '.join(f'{c_type} {name} = {literal(v)};' for name,v in cells.items())
        setup+=' '.join(suite['struct_types'][name]+' '+name+' = {'+
                        ', '.join(literal(fields[field]) for field in suite['struct_field_order'][name])+'};'
                        for name,fields in structs.items())
        order=suite.get('parameter_order',list(item['args']))
        args=', '.join('&'+aliases.get(name,name) if aliases.get(name,name) in cells or aliases.get(name,name) in structs else
            name if name in arrays else literal(item['args'][name]) for name in order)
        if not oracle and suite.get('cn_ghost_parameters'):
            ghosts=', '.join(c_int(item['logical_values'][name]) for name in suite['cn_ghost_parameters'])
            args+=' /*@ '+ghosts+' @*/'
        call=f"{suite['function']}({args})"
        if oracle:
            expected_return=(suite['return_pointer_parameter'] if suite.get('return_pointer_parameter')
                             else literal(item['expected_return']))
            statement=(f"if ({call} != {expected_return}) return 12;" if suite.get('return_kind','int')!='void' else f'{call};')
            if suite.get('return_contract', {}).get('kind') == 'search_index':
                contract=suite['return_contract'];pointer=contract['array']
                target=literal(item['args'][contract['target']]);length=len(arrays[pointer])
                statement=(f'int observed_return = {call}; '
                           f'if (observed_return == -1) {{ for (int check_index=0; check_index<{length}; ++check_index) '
                           f'if ({pointer}[check_index] == {target}) return 12; }} '
                           f'else if (observed_return < 0 || observed_return >= {length} || '
                           f'{pointer}[observed_return] != {target}) return 12;')
            statement+=' '.join(f'if ({name}[{i}] != {literal(v)}) return 14;' for name,values in item.get('expected_heap',{}).items() if name in arrays for i,v in enumerate(values))
            statement+=' '.join(f'if ({name} != {literal(v)}) return 14;' for name,v in item.get('expected_heap',{}).items() if name in cells)
            statement+=' '.join(f'if ({name}.{field} != {literal(v)}) return 14;'
                                for name,fields in item.get('expected_heap',{}).items() if name in structs
                                for field,v in fields.items())
        else:
            # A discarded call is valid for both return kinds. The tested CN
            # frontend crashes on an explicit void cast around a void call.
            statement=f"{call};"
        if suite.get('cn_ghost_parameters') and not oracle:
            # The tested CN ghost-call extraction skips switch label bodies.
            # Conditional dispatch keeps exactly the same inputs and calls.
            code.append(f'if (index == {index}) {{ {setup} {statement} return 0; }}')
        else:
            code.append(f'case {index}: {{ {setup} {statement} return 0; }}')
    # getchar selects a frozen input; no argv heap is needed by the driver.
    if suite.get('cn_ghost_parameters') and not oracle:
        return source+'\nint getchar(void);\nint main(void) /*@ ensures return == 0; @*/ { int index = getchar();\n'+'\n'.join(code)+'\nreturn 13; }\n'
    return source+'\nint getchar(void);\nint main(void) /*@ ensures return == 0; @*/ { int index = getchar(); switch(index) {\n'+'\n'.join(code)+'\ndefault: return 13; } }\n'

def execute_input(cmd,dest,label,timeout,index):
    log=dest/(label+'.log')
    with log.open('wb') as stream:
        try:
            completed=subprocess.run(cmd,cwd=ROOT,input=bytes([index]),stdout=stream,stderr=subprocess.STDOUT,timeout=timeout)
            code=completed.returncode
        except subprocess.TimeoutExpired:
            code='TIMEOUT'
    return {'command':cmd,'returncode':code,'log':str(log),'log_sha256':sha(log),'stdin_hex':bytes([index]).hex()}

def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output',type=Path,required=True)
    parser.add_argument('--cases',nargs='+')
    parser.add_argument('--tools',default='native,fulminate,qcp')
    parser.add_argument('--switch',default='tespec-cn-5.2')
    parser.add_argument('--timeout',type=float,default=120)
    parser.add_argument('--loop-unroll-limit',type=int,default=128)
    parser.add_argument('--call-depth-limit',type=int,default=128)
    args=parser.parse_args();out=args.output.resolve()
    if args.loop_unroll_limit < 1 or args.call_depth_limit < 1:
        parser.error('Execution limits must be positive')
    if out.exists():parser.error('Output must be fresh')
    out.mkdir(parents=True)
    tools=set(args.tools.split(','))
    if tools-{'native','fulminate','qcp'}:parser.error('Unknown tool')
    folders=[HERE/'suites'/c for c in args.cases] if args.cases else sorted(p.parent for p in (HERE/'suites').glob('*/suite.json'))
    report={'schema':'tespec-paired-suite-replay/v1','scope':'scalar/array input regression; ATP-only teSpec results; not isolated performance','switch':args.switch,'driver_sha256':sha(Path(__file__)),'tespec_binary_sha256':sha(ROOT/'bin/tespec-symexec'),'runs':[]}
    report['execution_limits']={'loop_unroll_limit':args.loop_unroll_limit,
                                'call_depth_limit':args.call_depth_limit}
    if 'fulminate' in tools:
        prefix=['opam','exec','--switch='+args.switch,'--']
        binary=Path(subprocess.check_output(prefix+['which','cn'],text=True).strip())
        report['cn_binary_sha256']=sha(binary)
        report['cn_version']=subprocess.check_output(prefix+['cn','--version'],text=True).strip()
    def save(): (out/'report.json').write_text(json.dumps(report,indent=2)+'\n')
    save()
    for folder in folders:
        suite=json.loads((folder/'suite.json').read_text());ident=suite['id']
        assert suite['input_count']<=256,'The byte-index driver supports at most 256 inputs'
        for name,digest in suite['files'].items():assert sha(folder/name)==digest,(ident,name)
        for variant,metadata in suite['variants'].items():
            dest=out/ident/variant;dest.mkdir(parents=True)
            for name in suite['files']:
                if name.endswith(('.v','.h','.strategies')):
                    shutil.copyfile(folder/name,dest/name)
            source=(folder/f'{variant}.cn.c').read_text()
            expected={i['id']:('FAIL' if variant!='reference' and i[variant+'_violated'] else 'PASS') for i in suite['inputs']}
            if 'native' in tools and variant=='reference':
                native=dest/'oracle.c';native.write_text(harness(re.sub(r'^\s*#include[^\n]*','',source,flags=re.M),suite,True))
                for bits in (32,64):
                    exe=dest/f'native{bits}'
                    build=paired.execute(['gcc','-std=c11',f'-m{bits}','-O1',*suite.get('native_c_flags',[]),str(native),'-o',str(exe)],dest,f'native{bits}-build',args.timeout)
                    rows=[]
                    if build['returncode']==0:
                        for index,item in enumerate(suite['inputs']):
                            run=execute_input([str(exe)],dest,f"native{bits}-{item['id']}",args.timeout,index)
                            rows.append({'id':item['id'],'status':'PASS' if run['returncode']==0 else 'ERROR','expected':'PASS','returncode':run['returncode']})
                    report['runs'].append({'case':ident,'variant':variant,'tool':f'native{bits}','build':build,'results':rows});save()
            if 'fulminate' in tools:
                instrumented=dest/'instrumented';instrumented.mkdir()
                target=dest/'driver.cn.c';target.write_text(harness(source,suite,False))
                build=execute_input(prefix+['cn','instrument','--run','--cc=/usr/bin/gcc','--output-dir='+str(instrumented),str(target)],dest,'fulminate-build',args.timeout,0)
                exe=instrumented/'driver.cn.exec.out'
                # Generated output name is based on the basename without .c.
                if not exe.exists():exe=instrumented/'driver.exec.out'
                rows=[]
                if exe.exists():
                    for index,item in enumerate(suite['inputs']):
                        run=execute_input([str(exe)],dest,'fulminate-'+item['id'],args.timeout,index)
                        log=(dest/('fulminate-'+item['id']+'.log')).read_text(errors='replace')
                        status='PASS' if run['returncode']==0 else 'FAIL' if isinstance(run['returncode'],int) and run['returncode']!=0 and ('Failed at' in log or 'CN assertion failed' in log) else 'UNKNOWN' if run['returncode']=='TIMEOUT' else 'ERROR'
                        rows.append({'id':item['id'],'status':status,'expected':expected[item['id']],'returncode':run['returncode']})
                report['runs'].append({'case':ident,'variant':variant,'tool':'fulminate','build':build,'results':rows});save()
            if 'qcp' in tools:
                target=dest/'subject.qcp.c';shutil.copyfile(folder/f'{variant}.qcp.c',target)
                binds=dest/'binds.json';binds.write_text(json.dumps([i['qcp_bind'] for i in suite['inputs']],indent=2)+'\n')
                command=[sys.executable,'-m','spectest','run',str(target),'--function',suite['function'],'--binds',str(binds),'--output-dir',str(dest/'qcp'),'--execution-mode','expand','--loop-unroll-limit',str(args.loop_unroll_limit),'--call-depth-limit',str(args.call_depth_limit),'--timeout',str(args.timeout),'--compact','-I',str(ROOT/'runtime/qcip/QCP_examples/QCP_demos_human')]
                for include in suite.get('qcp_include_dirs', []):
                    directory=(ROOT/include).resolve()
                    assert directory.is_relative_to(ROOT) and directory.is_dir(), include
                    command.extend(['-I', str(directory)])
                run=paired.execute(command,dest,'qcp',args.timeout*len(suite['inputs'])+60)
                evidence=dest/'qcp/report.json';rows=[]
                if evidence.exists():
                    for result in json.loads(evidence.read_text()).get('results',[]):
                        rows.append({'id':result['id'],'status':result.get('test_result') or result.get('status'),'diagnostic_status':result.get('status'),'expected':expected[result['id']],'precondition_result':result.get('precondition_result'),'reason':result.get('reason')})
                report['runs'].append({'case':ident,'variant':variant,'tool':'qcp','execution':run,'results':rows});save()
            print(ident,variant,'completed',flush=True)
    for row in report['runs']:
        row['summary']=dict(Counter(x['status'] for x in row['results']))
        row['expected_result_mismatches']=sum(x['status']!=x['expected'] for x in row['results'])
        row['false_pass']=sum(x['status']=='PASS' and x['expected']=='FAIL' for x in row['results'])
        row['missing_results']=len(json.loads((HERE/'suites'/row['case']/'suite.json').read_text())['inputs'])-len(row['results'])
    save()
    print(json.dumps({'runs':len(report['runs']),'false_pass':sum(r['false_pass'] for r in report['runs']),'mismatches':sum(r['expected_result_mismatches'] for r in report['runs']),'missing_results':sum(r['missing_results'] for r in report['runs'])}),flush=True)
    return 1 if any(r['false_pass'] or r['expected_result_mismatches'] or r['missing_results'] for r in report['runs']) else 0

if __name__=='__main__':raise SystemExit(main())
