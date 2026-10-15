#!/usr/bin/env python3
"""Derive concrete original-guard-mutation overlap witnesses from frozen C states."""
import argparse
import gzip
import hashlib
import json
from pathlib import Path
import subprocess
HERE=Path(__file__).resolve().parent
EXP=HERE.parents[1]
sha=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
NATIVE=EXP/'evidence/pkvm-native-20261013/report.json.gz'

def main():
    parser=argparse.ArgumentParser(description=__doc__);parser.add_argument('--output',required=True,type=Path);a=parser.parse_args()
    out=a.output.resolve();out.mkdir(parents=True,exist_ok=False)
    source=out/'layout.c';source.write_text('#define main original_client_main\n#include "native-adapter.c"\n#undef main\nint main(void) { printf("%lu %lu %lu %lu\\n", (unsigned long)sizeof(void *), (unsigned long)sizeof(struct list_head), (unsigned long)sizeof(struct hyp_page), (unsigned long)sizeof(struct hyp_pool)); return 0; }\n')
    with gzip.open(NATIVE,'rt') as f:native=json.load(f)
    report={'scope':'Concrete byte-footprint contradiction for original bug1 ownership guard mutation; actual original reference states and compiler ABI layouts; no full contract-tool verdict',
            'generator_sha256':sha(Path(__file__)),'native_report_path':str(NATIVE.relative_to(EXP)),
            'native_report_sha256':sha(NATIVE),'driver_sha256':sha(HERE/'native-adapter.c'),
            'source_files':{name:sha(EXP/'source-snapshots/fulminate/pkvm-buddy'/name) for name in ['defs.h','bug1.defs.h','types.h']},
            'runs':[]}
    for row in native['runs']:
        if row['variant']!='reference':continue
        bits=row['abi'];exe=out/f'layout{bits}';cmd=['gcc','-std=gnu11','-O1',f'-m{bits}','-I'+str(HERE),str(source),'-o',str(exe)]
        build=subprocess.run(cmd,text=True,capture_output=True);(out/f'build{bits}.log').write_text(build.stdout+build.stderr);assert build.returncode==0,build.stderr
        observed=subprocess.check_output([str(exe)],text=True).strip();(out/f'layout{bits}.log').write_text(observed+'\n')
        pointer,header,page,pool=map(int,observed.split());assert header==2*pointer and pointer==bits//8 and page==4
        results=[]
        for item in row['results']:
            assert item['status']=='PASS' and item['native_returncode']==0
            state=item['native_states'][0];witnesses=[]
            # Offset=0 actual arena addresses and initial pool endpoints were
            # independently frozen by the original native execution fixture.
            traces=json.loads((HERE/'model-traces.json').read_text())['traces']
            trace=next(t for t in traces if t['id']==item['id'])
            base=trace['initial_state']['model_start_pfn']*4096
            for root,order in state['free']:
                assert state['meta'][root][:2]==[0,order]
                if order==0:continue
                for child in range(root+1,root+(1<<order)):
                    assert state['meta'][child][:2]==[0,255]
                    address=base+child*4096;start=base+root*4096+header;finish=base+(root+(1<<order))*4096
                    assert 0<header<=4096 and start<=address<finish and address<address+header
                    witnesses.append({'root_page':root,'root_order':order,'child_page':child,
                        'root_zero_part':[start,finish],'child_owned_header':[address,address+header],
                        'shared_owned_byte':address,'child_metadata':state['meta'][child],
                        'original_child_guard':False,'mutated_child_guard':True})
            assert witnesses
            results.append({'id':item['id'],'native_reference_status':'PASS','initial_native_state':state,
                            'original_guard_spec_mutation_witnessed':True,'overlap_witnesses':witnesses})
        record={'abi':bits,'compiler_layout':{'pointer_bytes':pointer,'list_head_bytes':header,'hyp_page_bytes':page,'hyp_pool_bytes':pool},
                'build_command':cmd,'build_returncode':0,'results':results,
                'summary':{'traces':len(results),'traces_with_overlap_witness':len(results),'overlapping_child_headers':sum(len(r['overlap_witnesses']) for r in results)}}
        report['runs'].append(record)
        with gzip.open(out/'report.json.gz','wt') as f:json.dump(report,f,indent=2)
        print(json.dumps(record['summary']),flush=True)
    return 0

if __name__=='__main__':raise SystemExit(main())
