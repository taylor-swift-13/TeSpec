#!/usr/bin/env python3
"""Adapt legacy builtin names for the independently pinned September BV tool."""
import argparse
import hashlib
import importlib.util
import json
from pathlib import Path
import re

HERE = Path(__file__).resolve().parent
ALIASES = '''
function (u64) xor_uf(u64 x, u64 y) { x ^ y }
function (u64) bw_fls_uf(u64 x) { bw_fls(x) }
'''
spec = importlib.util.spec_from_file_location('bv_syntax', HERE / 'prepare-cn-bv.py')
bv = importlib.util.module_from_spec(spec)
spec.loader.exec_module(bv)


def adapt_annotation(match):
    candidate = bv.adapt(match)
    return re.sub(r'\b(lemma|apply)\s+page_size_of_order\s*\(',
                  r'\1 page_size_of_order_fact(', candidate)


def candidate_text(original, suffix, name):
    candidate, groups = original, 0
    if suffix in ('.c', '.h'):
        candidate = re.sub(r'/\*@.*?\*/', adapt_annotation, candidate, flags=re.S)
        candidate = re.sub(r'power_uf\(2u64,\s*\(u64\) order\)',
                           'shift_left(1u64, (u64) order)', candidate)
        assert 'power_uf(' not in candidate, name
        if name in ('defs.h', 'bug1.defs.h'):
            candidate = candidate.replace('/*@', '/*@' + ALIASES, 1)
        candidate, groups = bv.syntax.merge_contracts(candidate)
    assert bv.syntax.c_tokens(candidate) == bv.syntax.c_tokens(original), name
    return candidate, groups


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    args.output.mkdir(parents=True, exist_ok=False)
    sha = lambda p: hashlib.sha256(p.read_bytes()).hexdigest()
    rows = []
    for source in sorted(bv.syntax.SOURCE.iterdir()):
        if not source.is_file():
            continue
        candidate, groups = candidate_text(source.read_text(), source.suffix, source.name)
        destination = args.output / source.name
        destination.write_text(candidate)
        rows.append({'file': source.name, 'original_sha256': sha(source),
                     'candidate_sha256': sha(destination), 'merged_comment_groups': groups})
    report = {'scope': 'September BV candidate with builtin aliases, checked base-two power rewriting and lemma alpha renaming; original numeric casts and C tokens retained; full contract equivalence and tool verdicts pending.',
              'generator_sha256': sha(Path(__file__)),
              'dependencies': {name: sha(HERE / name) for name in
                               ('prepare-cn-bv.py', 'migrate-cn-syntax.py')},
              'files': rows}
    (args.output / 'migration.json').write_text(json.dumps(report, indent=2) + '\n')
    print(json.dumps({'files': len(rows), 'numeric_types': 'original bitvectors'}))


if __name__ == '__main__':
    main()
