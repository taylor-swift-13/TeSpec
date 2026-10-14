#!/usr/bin/env python3
"""Probe original industrial field offsets for paired ABI admission."""
import argparse
import hashlib
import json
import subprocess
from pathlib import Path
HERE = Path(__file__).resolve().parent
EXP = HERE.parents[1]
SHA = lambda p: hashlib.sha256(p.read_bytes()).hexdigest()
FIELDS = {'list_head': ['next', 'prev'], 'hyp_page': ['refcount', 'order', 'flags'],
          'hyp_pool': ['free_area', 'range_start', 'range_end', 'max_order']}

def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', required=True, type=Path)
    out = parser.parse_args().output.resolve()
    out.mkdir(parents=True, exist_ok=False)
    probe = out / 'layout.c'
    calls = []
    for struct, fields in FIELDS.items():
        calls.append(f'printf("{struct} size %lu align %lu\\n", (unsigned long)sizeof(struct {struct}), (unsigned long)_Alignof(struct {struct}));')
        for field in fields:
            calls.append(f'printf("{struct} {field} %lu %lu\\n", (unsigned long)__builtin_offsetof(struct {struct}, {field}), (unsigned long)sizeof(((struct {struct} *)0)->{field}));')
    probe.write_text('#define main original_client_main\n#include "native-adapter.c"\n#undef main\nint main(void) {\n'+'\n'.join(calls)+'\nreturn 0;\n}\n')
    rows = []
    for bits in (32, 64):
        exe = out / f'layout{bits}'
        command = ['gcc', '-std=gnu11', '-O1', f'-m{bits}', '-I'+str(HERE), str(probe), '-o', str(exe)]
        build = subprocess.run(command, capture_output=True, text=True)
        (out/f'build{bits}.log').write_text(build.stdout+build.stderr)
        assert build.returncode == 0, build.stderr
        run = subprocess.run([str(exe)], capture_output=True, text=True, check=True)
        (out/f'run{bits}.log').write_text(run.stdout+run.stderr)
        structs = {}
        for line in run.stdout.splitlines():
            parts = line.split()
            struct, field, left = parts[:3]
            if field == 'size':
                assert parts[3] == 'align' and len(parts) == 5
                structs[struct] = {'size': int(left), 'alignment': int(parts[4]), 'fields': {}}
            else:
                structs[struct]['fields'][field] = {'offset': int(left), 'size': int(parts[3])}
        assert structs['list_head']['fields']['next'] == {'offset':0, 'size':bits//8}
        assert structs['list_head']['fields']['prev'] == {'offset':bits//8, 'size':bits//8}
        assert structs['list_head']['size'] == bits//4
        assert structs['hyp_page']['size'] == 4
        assert structs['hyp_pool']['fields']['free_area']['size'] == 11*structs['list_head']['size']
        for struct in structs.values():
            for field in struct['fields'].values():
                assert 0 <= field['offset'] and field['offset']+field['size'] <= struct['size']
        for struct in structs.values():
            covered = set()
            for field in struct['fields'].values():
                region = set(range(field['offset'], field['offset']+field['size']))
                assert covered.isdisjoint(region)
                covered.update(region)
            padding = sorted(set(range(struct['size'])) - covered)
            intervals = []
            for byte in padding:
                if intervals and byte == intervals[-1][1]:
                    intervals[-1][1] += 1
                else:
                    intervals.append([byte, byte+1])
            struct['padding_intervals'] = intervals
        rows.append({'abi':bits, 'build_returncode':0, 'run_returncode':0, 'structs':structs})
    report = {'scope':'Compiler-observed original industrial structure layout; not full heap/predicate correspondence',
              'generator_sha256':SHA(Path(__file__)),
              'dependencies':{'industrial/pkvm-buddy/native-adapter.c':SHA(HERE/'native-adapter.c')},
              'source_files':{name:SHA(EXP/'source-snapshots/fulminate/pkvm-buddy'/name) for name in ('types.h','memory.h','gfp.h')},
              'runs':rows, 'full_qcp_field_address_correspondence_proved':False,
              'files':{p.name:SHA(p) for p in out.iterdir() if p.suffix in ('.c','.log')}}
    (out/'report.json').write_text(json.dumps(report,indent=2)+'\n')
    print(json.dumps(rows,indent=2))

if __name__ == '__main__': main()
