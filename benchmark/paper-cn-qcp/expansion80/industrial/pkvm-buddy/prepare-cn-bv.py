#!/usr/bin/env python3
"""Prepare a legacy bitvector candidate, retaining the original numeric types."""
import argparse
import hashlib
import importlib.util
import json
from pathlib import Path
import re

HERE = Path(__file__).resolve().parent
spec = importlib.util.spec_from_file_location('cn_syntax', HERE / 'migrate-cn-syntax.py')
syntax = importlib.util.module_from_spec(spec)
spec.loader.exec_module(syntax)


def adapt(match):
    text = match.group(0).replace('member_shift<hyp_pool>', 'member_shift<struct hyp_pool>')
    def accesses(m):
        names = re.findall(r'[A-Za-z_][A-Za-z_0-9]*', m.group(1))
        return ' '.join('accesses ' + name + ';' for name in names)
    return re.sub(r'\baccesses\s+((?:[A-Za-z_][A-Za-z_0-9]*\s*;\s*)+)', accesses, text)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    args.output.mkdir(parents=True, exist_ok=False)
    sha = lambda p: hashlib.sha256(p.read_bytes()).hexdigest()
    rows = []
    for source in sorted(syntax.SOURCE.iterdir()):
        if not source.is_file():
            continue
        original = source.read_text()
        candidate = original
        merged_groups = 0
        if source.suffix in ('.c', '.h'):
            candidate = re.sub(r'/\*@.*?\*/', adapt, candidate, flags=re.S)
            candidate, merged_groups = syntax.merge_contracts(candidate)
        assert syntax.c_tokens(candidate) == syntax.c_tokens(original), source.name
        destination = args.output / source.name
        destination.write_text(candidate)
        rows.append({'file': source.name, 'original_sha256': sha(source),
                     'candidate_sha256': sha(destination), 'merged_comment_groups': merged_groups})
    report = {'scope': 'Legacy BV compatibility candidate: explicit struct tag, access clauses and adjacent contract-fragment joining; C tokens, original builtin names and BV casts retained. Full equivalence and verdicts pending.',
              'generator_sha256': sha(Path(__file__)),
              'dependency_sha256': sha(HERE / 'migrate-cn-syntax.py'),
              'required_option': '--allow-split-magic-comments', 'files': rows}
    (args.output / 'migration.json').write_text(json.dumps(report, indent=2) + '\n')
    print(json.dumps({'files': len(rows), 'numeric_types': 'original bitvectors'}))


if __name__ == '__main__':
    main()
