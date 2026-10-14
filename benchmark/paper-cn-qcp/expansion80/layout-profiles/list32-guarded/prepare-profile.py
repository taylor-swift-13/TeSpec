#!/usr/bin/env python3
"""Prepare an explicit 32-bit list layout profile without changing suite inputs."""
import argparse
import hashlib
import json
import re
import shutil
import subprocess
from pathlib import Path
HERE = Path(__file__).resolve().parent
EXP = HERE.parents[1]
SHA = lambda p: hashlib.sha256(p.read_bytes()).hexdigest()

def body(text):
    text = re.sub(r'/\*.*?\*/|//[^\n]*', '', text, flags=re.S)
    text = re.sub(r'^\s*#include[^\n]*', '', text, flags=re.M)
    return re.sub(r'\s+', '', text)

def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--case', required=True)
    parser.add_argument('--input-ids', nargs='*')
    parser.add_argument('--output', required=True, type=Path)
    args = parser.parse_args()
    suite_path = EXP / 'suites' / args.case / 'suite.json'
    suite = json.loads(suite_path.read_text())
    assert suite['graph_schema'] == {'c_type':'struct list','value_fields':['data'],'link_fields':['next']}
    inputs = [item for item in suite['inputs'] if args.input_ids is None or item['id'] in args.input_ids]
    assert inputs and (args.input_ids is None or {item['id'] for item in inputs} == set(args.input_ids))
    out = args.output.resolve();out.mkdir(parents=True,exist_ok=False)
    for name in ('sll_layout32_def.h','sll_layout32.strategies'):
        shutil.copy2(HERE/name,out/name)
    probe = out/'layout.c'
    probe.write_text('#include <stdio.h>\n#include "sll_layout32_def.h"\nint main(void) { printf("%lu %lu %lu %lu %lu\\n", (unsigned long)sizeof(int), (unsigned long)sizeof(void *), (unsigned long)sizeof(struct list), (unsigned long)__builtin_offsetof(struct list,data), (unsigned long)__builtin_offsetof(struct list,next)); return 0; }\n')
    cmd = ['gcc','-std=c11','-m32',str(probe),'-o',str(out/'layout')]
    build = subprocess.run(cmd,capture_output=True,text=True)
    (out/'layout-build.log').write_text(build.stdout+build.stderr)
    assert build.returncode == 0,build.stderr
    observed = subprocess.check_output([str(out/'layout')],text=True)
    (out/'layout-run.log').write_text(observed)
    assert list(map(int,observed.split())) == [4,4,8,0,4]
    sources = []
    for variant in ('reference','spec_mutation','impl_mutation'):
        old = suite_path.parent/(variant+'.qcp.c');text=old.read_text()
        assert '#include "sll_def.h"' in text
        changed=text.replace('#include "sll_def.h"','#include "sll_layout32_def.h"')
        changed=re.sub(r'/\*@.*?\*/',lambda match:re.sub(r'\bsll\b','sll32',match.group(0)),changed,flags=re.S)
        assert body(text) == body(changed)
        target=out/(variant+'.qcp.c');target.write_text(changed)
        sources.append({'variant':variant,'original_path':str(old.relative_to(EXP)),'original_sha256':SHA(old),'profile_source_sha256':SHA(target),'c_body_sha256':hashlib.sha256(body(text).encode()).hexdigest()})
    (out/'binds.json').write_text(json.dumps([item['qcp_bind'] for item in inputs],indent=2)+'\n')
    record={'scope':'Experimental explicit list-layout profile preserving nonempty unfold guards; unchanged C bodies, inputs and mathematical list property; not suite admission', 'case':args.case,'function':suite['function'],'architecture_bits':32,'input_ids':[item['id'] for item in inputs], 'suite_path':str(suite_path.relative_to(EXP)),'suite_sha256':SHA(suite_path),'generator_sha256':SHA(Path(__file__)),'layout':{'int_bytes':4,'pointer_bytes':4,'node_bytes':8,'data_offset':0,'next_offset':4},'sources':sources,'profile_dependencies':{name:SHA(HERE/name) for name in ('sll_layout32_def.h','sll_layout32.strategies')},'admission_complete':False}
    (out/'profile.json').write_text(json.dumps(record,indent=2)+'\n')
    print(json.dumps({'case':args.case,'inputs':len(inputs),'C_bodies_unchanged':True,'admission_complete':False}))

if __name__ == '__main__': main()
