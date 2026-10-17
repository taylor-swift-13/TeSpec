#!/usr/bin/env python3
"""Run finite tests for read variants; never invoke universal verification."""
from pathlib import Path
import collections, datetime, hashlib, json, os, re, signal, subprocess, sys, tempfile, threading, time

ROOT = Path(__file__).resolve().parents[2]
GROUP = ROOT / 'benchmark/programs/read'
OUT = ROOT / 'benchmark/results/read/20261015-variants'
from cn_toolchain import SWITCH, CN, ENV, installed_identity
PAIRS = {
    'cn_original:read': 'qcp_existing:da492a72f5083bc517fc',
    'cn_original:read.broken': 'qcp_existing:5f0745ae2e1e60380a4b',
    'cn_original:read2': 'qcp_existing:12b7b9308ca320855b72',
}

def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()

def save(path, value):
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(value, ensure_ascii=False, indent=2) + '\n')

def measure(command, folder, timeout=60):
    folder.mkdir(parents=True, exist_ok=True)
    resource = folder / 'resources.json'
    wrapper = ['/usr/bin/time', '--quiet', '-f', '{"max_process_rss_kib":%M,"user_seconds":%U,"system_seconds":%S}', '-o', str(resource), *map(str, command)]
    start = time.monotonic()
    with (folder / 'stdout.log').open('wb') as stdout, (folder / 'stderr.log').open('wb') as stderr:
        process = subprocess.Popen(wrapper, cwd=ROOT, env=ENV, stdout=stdout, stderr=stderr, start_new_session=True)
        try:
            code = process.wait(timeout=timeout)
        except subprocess.TimeoutExpired:
            os.killpg(process.pid, signal.SIGKILL)
            process.wait()
            code = 'TIMEOUT'
    resources = None
    if resource.exists() and resource.stat().st_size:
        try:
            resources = json.loads(resource.read_text())
        except ValueError:
            pass
    return {'command': list(map(str, command)), 'exit_code': code, 'wall_seconds': time.monotonic() - start,
            'resources': resources, 'tokens': 0, 'model_calls': 0,
            'stdout': (folder / 'stdout.log').relative_to(ROOT).as_posix(),
            'stderr': (folder / 'stderr.log').relative_to(ROOT).as_posix()}

def main():
    import argparse
    global OUT
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, default=OUT, help='Fresh results directory under benchmark/results; old measurements are never overwritten.')
    OUT = parser.parse_args().output.resolve()
    if not OUT.is_relative_to((ROOT / 'benchmark/results').resolve()):
        parser.error('output must stay under benchmark/results')
    cn_build = installed_identity()
    if OUT.exists() and any(OUT.iterdir()):
        raise SystemExit('Results already exist; do not overwrite a measured run.')
    manifests = {}
    for path in (GROUP / 'variants').glob('*/manifest.json'):
        v = json.loads(path.read_text())
        manifests[v['id']] = (path, v)
    configs = []
    for vid, (path, v) in manifests.items():
        if 'cn' not in v['files']:
            continue
        qvid = PAIRS.get(vid, vid)
        qpath, qv = manifests[qvid]
        configs.append((vid, path, v, qvid, qv))
    report = {'schema': 'tespec-read-variant-tests/v1', 'started_utc': datetime.datetime.now(datetime.timezone.utc).isoformat(),
              'scope': 'Finite testing only. No CN verify, no QCP universal verification, no model calls. Original main excluded; only read is exercised.',
              'metric': 'Wall clock per case/stage; GNU time %M is peak RSS of the largest measured process, not aggregate simultaneous tree memory.',
              'toolchain': {'cn_build': cn_build, 'cn_sha256': sha(CN), 'tespec_executor_sha256': sha(ROOT / 'bin/tespec-symexec'), 'driver_sha256': sha(Path(__file__))}, 'runs': []}
    values = [-2147483648, -1, 0, 1, 7, 2147483647]
    for vid, path, v, qvid, qv in configs:
        cn_source = ROOT / v['files']['cn']['path']
        qcp_source = ROOT / qv['files']['qcp']['path']
        source = re.split(r'\nint main\s*\(', cn_source.read_text(), maxsplit=1)[0]
        qcp = qcp_source.read_text()
        variable = re.search(r'\bWith\s+(\w+)\s+Require', qcp)
        variable = variable[1] if variable else None
        cases = [('value_' + str(i), value, False) for i, value in enumerate(values)]
        missing_ownership = 'requires true;' in source
        if missing_ownership:
            cases.append(('null_pointer', None, True))
        slug = path.parent.name
        for cid, value, null in cases:
            inputs = path.parent / 'tests/generated' / cid
            literal = '(-2147483647-1)' if value == -2147483648 else str(value)
            body = 'read((int*)0);' if null else 'int cell = ' + literal + '; read(&cell);'
            harness = source + '\nint main(void) /*@ ensures return == 0i32; @*/ { ' + body + ' return 0; }\n'
            inputs.mkdir(parents=True, exist_ok=True)
            harness_path = inputs / 'fulminate.cn.c'
            harness_path.write_text(harness)
            binds = [{'id': cid, 'args': {'p': 0 if null else 4096}, 'values': {variable: value} if variable else {}}]
            binds_path = inputs / 'binds.json'
            save(binds_path, binds)
            folder = OUT / slug / cid
            row = {'variant': vid, 'paired_qcp_variant': qvid, 'related_variant_records': sorted({vid, qvid}),
                   'case': cid, 'initial': value, 'pointer_null': null,
                   'cn_source_sha256': sha(cn_source), 'qcp_source_sha256': sha(qcp_source),
                   'harness': harness_path.relative_to(ROOT).as_posix(), 'harness_sha256': sha(harness_path),
                   'binds': binds_path.relative_to(ROOT).as_posix(), 'binds_sha256': sha(binds_path),
                   'alignment': 'Reviewed read-target contract pairing; original trusted main is not tested.',
                   'input_scope': 'Precondition emp permits null; concrete read requires memory absent from the contract.' if missing_ownership else 'Owned non-null int cell within signed int bounds.'}
            with tempfile.TemporaryDirectory(prefix='tespec-read-test-') as tmp:
                row['fulminate_pipeline'] = measure([CN, 'instrument', '--run', '--cc=/usr/bin/gcc', '--output-dir=' + tmp, harness_path], folder / 'fulminate-pipeline')
                binaries = list(Path(tmp).glob('*.exec.out'))
                if len(binaries) == 1:
                    row['fulminate_test'] = measure([binaries[0]], folder / 'fulminate-test')
                    row['fulminate_test']['status'] = 'PASS' if row['fulminate_test']['exit_code'] == 0 else 'RUNTIME_FAILURE'
                else:
                    row['fulminate_test'] = {'status': 'NOT_BUILT', 'exit_code': None, 'wall_seconds': None, 'resources': None, 'tokens': 0, 'model_calls': 0}
            native_out = folder / 'tespec/artifacts'
            row['tespec'] = measure([sys.executable, '-m', 'spectest', 'run', qcp_source, '--function', 'read', '--binds', binds_path, '--execution-mode', 'all-boundaries', '--output-dir', native_out, '--timeout', '30', '--compact'], folder / 'tespec', timeout=90)
            result = native_out / 'report.json'
            row['tespec']['statuses'] = [x.get('status') for x in json.loads(result.read_text()).get('results', [])] if result.exists() else []
            row['tespec']['report'] = result.relative_to(ROOT).as_posix() if result.exists() else None
            report['runs'].append(row)
            save(OUT / 'results.json', report)
            print(vid, cid, 'Fulminate', row['fulminate_test']['status'], 'teSpec', row['tespec']['statuses'], flush=True)
    report['summary'] = {'configurations': len(configs), 'covered_variant_records': len({v for r in report['runs'] for v in r['related_variant_records']}),
                         'case_pairs': len(report['runs']), 'fulminate': dict(collections.Counter(r['fulminate_test']['status'] for r in report['runs'])),
                         'tespec': dict(collections.Counter(s for r in report['runs'] for s in r['tespec']['statuses']))}
    save(OUT / 'results.json', report)
    print(json.dumps(report['summary']), flush=True)

if __name__ == '__main__':
    main()
