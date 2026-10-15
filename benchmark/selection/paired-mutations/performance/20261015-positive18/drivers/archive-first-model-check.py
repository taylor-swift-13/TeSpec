from pathlib import Path
import shutil
b=Path('/home/yangfp/teSpec-benchmark-tespec/benchmark/selection/paired-mutations/performance/20261015-positive18')
old=b/'model-proof-results.json';new=b/'model-proof-results-attempt-1.json'
if old.exists() and not new.exists():new.write_bytes(old.read_bytes())
for ident in ['slf0_basic_incr','slf0_incr.broken','slf1_basic_example_let','slf2_basic_quadruple']:
 src=b/ident/'model';dst=b/ident/'model-attempt-1'
 if src.exists() and not dst.exists():shutil.copytree(src,dst,ignore=shutil.ignore_patterns('*.vo','*.vos','*.vok','*.glob','.*.aux'))
print('First failed compilation and model attempts retained.')
