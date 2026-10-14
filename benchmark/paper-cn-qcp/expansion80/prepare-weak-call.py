#!/usr/bin/env python3
"""Exhaust the admitted domain of the weak recursive-helper control."""
import ctypes
import importlib.util
import json
from pathlib import Path
import re
import subprocess
import tempfile
HERE = Path(__file__).resolve().parent
spec = importlib.util.spec_from_file_location('helpers', HERE / 'prepare-scalar.py')
h = importlib.util.module_from_spec(spec)
spec.loader.exec_module(h)

def main():
    ident = 'control_weak_call'
    source = HERE.parent / 'cases' / ident
    cn = (source / 'subject.cn.c').read_text()
    qcp = (source / 'subject.qcp.c').read_text()
    ce = ('w == v + 3;', 'w == v + 4;')
    qe = ('Ensure data_at(p, int, v + 3)', 'Ensure data_at(p, int, v + 4)')
    ie = ('*p = *p + 1;', '*p = *p;')
    variants = {'reference': (cn, qcp),
                'spec_mutation': (h.edit_once(cn, ce), h.edit_once(qcp, qe)),
                'impl_mutation': (h.edit_code_once(cn, ie), h.edit_code_once(qcp, ie))}
    folder = HERE / 'suites' / ident
    folder.mkdir(parents=True, exist_ok=True)
    for variant, (c, q) in variants.items():
        assert h.body(c) == h.body(q)
        (folder / f'{variant}.cn.c').write_text(c)
        (folder / f'{variant}.qcp.c').write_text(q)
    functions = []
    with tempfile.TemporaryDirectory(prefix='weak-call-native-') as tmp:
        for variant in ('reference', 'impl_mutation'):
            src = Path(tmp) / f'{variant}.c'
            lib = Path(tmp) / f'{variant}.so'
            src.write_text(re.sub(r'^\s*#include[^\n]*', '', variants[variant][0], flags=re.M))
            subprocess.run(['gcc', '-std=c11', '-O1', '-shared', '-fPIC', '-Wl,-Bsymbolic', str(src), '-o', str(lib)], check=True, capture_output=True)
            fn = ctypes.CDLL(str(lib)).sample
            fn.argtypes = [ctypes.POINTER(ctypes.c_int)]
            fn.restype = None
            functions.append(fn)
        inputs = []
        for v in range(98):
            observed, mutant = ctypes.c_int(v), ctypes.c_int(v)
            functions[0](ctypes.byref(observed))
            functions[1](ctypes.byref(mutant))
            assert observed.value == v + 3 and mutant.value == v
            name = f'input_{v:03d}'
            args = {'p': 4096}
            inputs.append({'id': name, 'args': args, 'cells': {'p': v},
                           'qcp_bind': {'id': name, 'args': args, 'values': {'v': v}},
                           'expected_return': None, 'expected_heap': {'p': v + 3},
                           'native_reference_return': None, 'native_reference_heap': {'p': observed.value},
                           'native_mutant_return': None, 'native_mutant_heap': {'p': mutant.value},
                           'spec_mutation_violated': observed.value != v + 4,
                           'impl_mutation_violated': mutant.value != v + 3})
    suite = {'schema': 'tespec-paired-input-suite/v1', 'id': ident, 'function': 'sample',
             'parameter_order': ['p'], 'cell_logical_values': {'p': 'v'}, 'pointer_aliases': {},
             'element_c_type': 'int', 'return_kind': 'void', 'input_count': len(inputs),
             'domain_complete': True, 'domain_ranges': {'p': [0, 97]},
             'admission': 'One owned int cell, 0<=v<=97; every admitted data value is included.',
             'review_scope': 'CN RW<int>/QCP data_at(int) and exact final v+3; helper contracts both expose only monotonicity. The spec mutant changes the top-level postcondition; the implementation mutant removes the increment and violates the top-level postcondition while satisfying every helper contract.',
             'reviewed_cn_sha256': h.sha(source / 'subject.cn.c'),
             'reviewed_qcp_sha256': h.sha(source / 'subject.qcp.c'),
             'generator_path': Path(__file__).name, 'generator_sha256': h.sha(Path(__file__)),
             'generator_dependencies': {'prepare-scalar.py': h.sha(HERE / 'prepare-scalar.py')},
             'tool_runs_checked': False, 'native_abi': 'Typed host int-cell oracle; shared library binds its own symbols to avoid libc step interposition; separate native32/native64 executable controls.',
             'variants': {'reference': {'kind': 'reference'},
                          'spec_mutation': {'kind': 'spec', 'cn_edit': ce, 'qcp_edit': qe},
                          'impl_mutation': {'kind': 'impl', 'shared_c_edit': ie}},
             'inputs': inputs, 'files': {p.name: h.sha(p) for p in folder.glob('*.c')}}
    (folder / 'suite.json').write_text(json.dumps(suite, indent=2) + '\n')
    print(json.dumps({'id': ident, 'domain_complete': True, 'positive_inputs': 98,
                      'spec_negative_witnesses': 98, 'impl_negative_witnesses': 98}))

if __name__ == '__main__':
    main()
