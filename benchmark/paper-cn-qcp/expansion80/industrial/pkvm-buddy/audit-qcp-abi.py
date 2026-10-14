#!/usr/bin/env python3
"""Compare the current QCP byte model with compiler-observed allocator ABIs."""
import argparse
import gzip
import hashlib
import json
import re
import subprocess
from pathlib import Path

HERE = Path(__file__).resolve().parent
EXP = HERE.parents[1]
REPO = EXP.parents[2]
MODEL = REPO / 'runtime/qcip/SeparationLogic/SeparationLogic/CommonAssertion.v'
SHA = lambda p: hashlib.sha256(p.read_bytes()).hexdigest()


def model_facts():
    text = MODEL.read_text()
    pointer = re.search(r'Definition store_ptr\b(.*?)(?=Definition undef_store_ptr)', text, re.S).group(1)
    assert 'store_4byte x v' in pointer and 'Int.max_unsigned' in pointer
    merge = re.search(r'Definition merge_int\b(.*?)(?=Definition merge_int64)', text, re.S).group(1)
    assert all(term in merge for term in ('x1 mod (2^8) * (2^24)', 'x2 mod (2^8) * (2^16)', 'x3 mod (2^8) * (2^8)', 'x4 mod (2^8)'))
    return {'pointer_bytes': 4, 'list_head_bytes': 8, 'byte_order': 'big',
            'pointer_definition': 'store_ptr', 'encoding_definition': 'merge_int'}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', required=True, type=Path)
    out = parser.parse_args().output.resolve()
    out.mkdir(parents=True, exist_ok=False)
    probe = out / 'abi.c'
    probe.write_text('#define main original_client_main\n#include "native-adapter.c"\n#undef main\nint main(void) { unsigned int x=0x01020304; unsigned char *b=(unsigned char *)&x; printf("%lu %lu %u %u %u %u\\n", (unsigned long)sizeof(void *), (unsigned long)sizeof(struct list_head), b[0], b[1], b[2], b[3]); return 0; }\n')
    model = model_facts()
    rows = []
    for bits in (32, 64):
        exe = out / f'abi{bits}'
        command = ['gcc', '-std=gnu11', '-O1', f'-m{bits}', '-I'+str(HERE), str(probe), '-o', str(exe)]
        build = subprocess.run(command, capture_output=True, text=True)
        (out / f'build{bits}.log').write_text(build.stdout + build.stderr)
        assert build.returncode == 0, build.stderr
        result = subprocess.run([str(exe)], capture_output=True, text=True, check=True)
        (out / f'run{bits}.log').write_text(result.stdout + result.stderr)
        ptr, header, *encoded = map(int, result.stdout.split())
        assert ptr == bits//8 and header == 2*ptr
        assert encoded in ([1,2,3,4], [4,3,2,1])
        byte_order = 'big' if encoded == [1,2,3,4] else 'little'
        rows.append({'abi': bits, 'pointer_bytes': ptr, 'list_head_bytes': header,
                     'byte_order': byte_order, 'encoded_uint32_01020304': encoded,
                     'pointer_width_matches_qcp': ptr == model['pointer_bytes'],
                     'header_size_matches_qcp': header == model['list_head_bytes'],
                     'byte_order_matches_qcp': byte_order == model['byte_order'],
                     'full_resource_correspondence_proved': False})
    report = {'scope': 'ABI admission check; no full CN/QCP contract equivalence or tool verdict',
              'model_path': str(MODEL.relative_to(REPO)), 'model_sha256': SHA(MODEL),
              'generator_sha256': SHA(Path(__file__)), 'qcp': model, 'native': rows,
              'dependencies': {'industrial/pkvm-buddy/native-adapter.c': SHA(HERE/'native-adapter.c')},
              'required_before_industrial_admission': [
                  'Use the same pointer width in both paired executions and proofs.',
                  'Prove an explicit byte-encoding correspondence for nonzero pointers.',
                  'Prove both original typed-header/byte resource conversions including validity and alignment.',
                  'Keep the 64-bit industrial execution distinct until its heap model is supported.']}
    report['files'] = {p.name: SHA(p) for p in out.iterdir() if p.suffix in ('.c', '.log')}
    (out/'report.json').write_text(json.dumps(report, indent=2)+'\n')
    print(json.dumps({'qcp': model, 'native': rows}, indent=2))

if __name__ == '__main__':
    main()
