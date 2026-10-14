#!/usr/bin/env python3
"""Prepare the original tree-size suite with explicit ABI32 tree resources."""
import argparse
import hashlib
import json
import re
import shutil
import subprocess
from pathlib import Path

HERE = Path(__file__).resolve().parent
EXP = HERE.parents[1]


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def body(text):
    text = re.sub(r'/\*.*?\*/|//[^\n]*', '', text, flags=re.S)
    text = re.sub(r'^\s*#include[^\n]*', '', text, flags=re.M)
    return re.sub(r'\s+', '', text)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--input-ids', nargs='*')
    args = parser.parse_args()
    suite_path = EXP / 'suites/control_tree_size/suite.json'
    suite = json.loads(suite_path.read_text())
    assert suite['graph_schema'] == {'c_type': 'struct tree',
                                    'value_fields': ['key', 'value'], 'link_fields': ['left', 'right']}
    inputs = [i for i in suite['inputs'] if args.input_ids is None or i['id'] in args.input_ids]
    assert inputs and (args.input_ids is None or {i['id'] for i in inputs} == set(args.input_ids))
    out = args.output.resolve()
    out.mkdir(parents=True, exist_ok=False)
    for source in [HERE / 'TreeLayout32.v', HERE / 'tree_layout32.strategies', suite_path.parent / 'TreeMeasure.v']:
        shutil.copyfile(source, out / source.name)
    probe = out / 'layout.c'
    probe.write_text('#include <stdio.h>\n#include <stddef.h>\n'
                     'struct tree { int key; int value; struct tree *left; struct tree *right; };\n'
                     'int main(void) { printf("%zu %zu %zu %zu %zu %zu %zu\\n", sizeof(int), sizeof(void *), sizeof(struct tree), offsetof(struct tree,key), offsetof(struct tree,value), offsetof(struct tree,left), offsetof(struct tree,right)); }\n')
    command = ['gcc', '-std=c11', '-m32', str(probe), '-o', str(out / 'layout')]
    compiled = subprocess.run(command, capture_output=True, text=True)
    (out / 'layout-build.log').write_text(compiled.stdout + compiled.stderr)
    assert compiled.returncode == 0, compiled.stderr
    observed = subprocess.check_output([str(out / 'layout')], text=True)
    (out / 'layout-run.log').write_text(observed)
    assert list(map(int, observed.split())) == [4, 4, 16, 0, 4, 8, 12]
    sources = []
    for variant in ['reference', 'spec_mutation', 'impl_mutation']:
        original = suite_path.parent / (variant + '.qcp.c')
        text = original.read_text()
        changed = re.sub(r'/\*@.*?\*/', lambda m: re.sub(r'\bstore_tree\b', 'store_tree32', m.group(0)), text, flags=re.S)
        for strategy in ['bst.strategies', 'teSpec_tree_size.strategies']:
            token = f'/*@ include strategies "QCP_demos_human/{strategy}"*/'
            assert token in changed
            changed = changed.replace(token, '')
        changed = changed.replace('/*@ Import Coq Require Import TreeMeasure */',
                                  '/*@ Import Coq Require Import TreeLayout32 */\n'
                                  '/*@ include strategies "tree_layout32.strategies" */')
        assert body(text) == body(changed)
        target = out / (variant + '.qcp.c')
        target.write_text(changed)
        sources.append({'variant': variant, 'original_path': str(original.relative_to(EXP)),
                        'original_sha256': sha(original), 'profile_source_sha256': sha(target),
                        'c_body_sha256': hashlib.sha256(body(text).encode()).hexdigest()})
    (out / 'binds.json').write_text(json.dumps([i['qcp_bind'] for i in inputs], indent=2) + '\n')
    record = {'scope': 'Experimental ABI32 tree profile; original C bodies, properties and inputs preserved',
              'case': 'control_tree_size', 'function': suite['function'], 'architecture_bits': 32,
              'admission_complete': False, 'suite_sha256': sha(suite_path),
              'generator_sha256': sha(Path(__file__)), 'input_ids': [i['id'] for i in inputs],
              'layout': {'int_bytes': 4, 'pointer_bytes': 4, 'node_bytes': 16,
                         'key_offset': 0, 'value_offset': 4, 'left_offset': 8, 'right_offset': 12},
              'sources': sources,
              'profile_dependencies': {n: sha(out / n) for n in ['TreeLayout32.v', 'TreeMeasure.v', 'tree_layout32.strategies']}}
    (out / 'profile.json').write_text(json.dumps(record, indent=2) + '\n')
    print(json.dumps({'inputs': len(inputs), 'C_bodies_unchanged': True, 'layout': record['layout']}))


if __name__ == '__main__':
    main()
