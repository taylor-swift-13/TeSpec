#!/usr/bin/env python3
"""Audit frozen legacy evidence in an isolated copy of its original layout."""
from pathlib import Path
import json, shutil, subprocess, sys, tempfile

ROOT = Path(__file__).resolve().parents[2]

def main():
    tracked = subprocess.check_output(
        ['git', '-C', str(ROOT), 'ls-files', '-z', 'arxiv/benchmark-support/selection', 'arxiv/fulminate-cn', 'benchmark/results/historical/selection'],
    ).decode().split('\0')
    reverse = {r['new']: r['old'] for r in json.loads((ROOT / 'benchmark/results/relocation-map.json').read_text())['files']}
    with tempfile.TemporaryDirectory(prefix='tespec-archive-audit-') as workspace:
        view = Path(workspace)
        for path in filter(None, tracked):
            actual_path = path
            path = reverse.get(path, path)
            if path.startswith('arxiv/fulminate-cn/'):
                old = 'benchmark/selection/sources/fulminate-cn/' + path[len('arxiv/fulminate-cn/'):]
            else:
                old = 'benchmark/selection/' + path[len('arxiv/benchmark-support/selection/'):]
            target = view / old
            target.parent.mkdir(parents=True, exist_ok=True)
            shutil.copyfile(ROOT / actual_path, target)
        base = view / 'benchmark/selection/paired-mutations'
        for script in ['grouping/validate.py', 'grouping/validate-reuse.py', 'validate.py']:
            subprocess.run([sys.executable, str(base / script)], check=True, cwd=view)
    print('PASS: archived validators ran in an isolated original-layout copy; no archive or benchmark records rewritten.')

if __name__ == '__main__':
    main()
