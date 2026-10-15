#!/usr/bin/env python3
"""Audit frozen legacy evidence in an isolated copy of its original layout."""
from pathlib import Path
import shutil, subprocess, sys, tempfile

ROOT = Path(__file__).resolve().parents[2]

def main():
    tracked = subprocess.check_output(
        ['git', '-C', str(ROOT), 'ls-files', '-z', 'benchmark-support/selection', 'third_party/fulminate-cn'],
    ).decode().split('\0')
    with tempfile.TemporaryDirectory(prefix='tespec-archive-audit-') as workspace:
        view = Path(workspace)
        for path in filter(None, tracked):
            if path.startswith('third_party/fulminate-cn/'):
                old = 'benchmark/selection/sources/fulminate-cn/' + path[len('third_party/fulminate-cn/'):]
            else:
                old = 'benchmark/selection/' + path[len('benchmark-support/selection/'):]
            target = view / old
            target.parent.mkdir(parents=True, exist_ok=True)
            shutil.copyfile(ROOT / path, target)
        base = view / 'benchmark/selection/paired-mutations'
        for script in ['grouping/validate.py', 'grouping/validate-reuse.py', 'validate.py']:
            subprocess.run([sys.executable, str(base / script)], check=True, cwd=view)
    print('PASS: archived validators ran in an isolated original-layout copy; no archive or benchmark records rewritten.')

if __name__ == '__main__':
    main()
