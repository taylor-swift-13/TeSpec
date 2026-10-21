#!/usr/bin/env python3
"""Migrate completed legacy groups to durable evidence, with before/after audit.

Default is a read-only plan. --apply writes all
durable evidence before deleting any regenerable file. Never runs experiments.
"""
import argparse
import csv
import hashlib
import io
import json
from pathlib import Path
import re
import subprocess

ROOT = Path(__file__).resolve().parents[2]


def digest(data):
    return hashlib.sha256(data).hexdigest()


def load(p):
    return json.loads(p.read_text())


def encoded(x):
    return (json.dumps(x, ensure_ascii=False, indent=2) + '\n').encode()


def leaves(x):
    if isinstance(x, dict):
        for k, v in x.items():
            yield from leaves(v)
    elif isinstance(x, list):
        for v in x:
            yield from leaves(v)
    else:
        yield x


def decision_cost_facts(obj, path=()):
    """Every number/boolean/verdict survives path compaction unchanged."""
    if isinstance(obj, dict):
        return [fact for k, v in obj.items() if not k.endswith(('_omitted', '_diagnostic'))
                for fact in decision_cost_facts(v, path + (k,))]
    if isinstance(obj, list):
        return [fact for i, v in enumerate(obj) for fact in decision_cost_facts(v, path + (i,))]
    if isinstance(obj, (int, float, bool)) or obj in ('PASS', 'FAIL', 'UNKNOWN', 'ERROR', 'VALID', 'INVALID', 'VERIFIED', 'VERIFIED_KERNEL_CHECKED'):
        return [(path, obj)]
    return []


class Migration:
    def __init__(self, groups):
        self.groups = groups
        self.output = {}
        self.alias = {}
        self.queue = []
        self.proofs = set()
        self.baseline = {}
        self.claims = []
        self.inputs = {}
        self.source_files = {}
        self.primary = {}
        self.candidates = set()

    def relative(self, p):
        return p.resolve().relative_to(ROOT).as_posix()

    def path(self, s):
        if not isinstance(s, str):
            return None
        if s.startswith('benchmark/') or s.startswith('runtime/') or s.startswith('arxiv/'):
            p = ROOT / s.split('#')[0]
        elif s.startswith(str(ROOT) + '/'):
            p = Path(s)
        else:
            return None
        if p.is_file() and p.resolve().is_relative_to(ROOT):
            return p
        return None

    def add(self, src, dst=None):
        src = Path(src)
        if not src.is_file():
            raise FileNotFoundError(src)
        old = self.relative(src)
        new = dst or old
        if old in self.alias:
            return self.alias[old]
        self.alias[old] = new
        self.output[new] = src.read_bytes()
        if src.suffix == '.json':
            self.queue.append((old, new, load(src)))
        elif src.suffix == '.v':
            self.proofs.add(new)
            # Preserve local Coq module names and dependencies for recompilation.
            source_text = src.read_text()
            for dep in src.parent.glob('*.v'):
                if dep != src and re.search(r'\b' + re.escape(dep.stem) + r'\b', source_text):
                    self.add(dep)
        return new

    def add_json(self, dst, obj):
        self.output[dst] = encoded(obj)

    def proof_refs(self, obj):
        for s in leaves(obj):
            p = self.path(s)
            if p and p.suffix == '.v':
                self.add(p)

    def follow(self, obj, key=''):
        if isinstance(obj, dict):
            if key in ('qcp_input_fixture', 'qcp_execution_wrapper') and obj.get('path'):
                fixture = self.path(obj['path'])
                if fixture:
                    self.add(fixture)
            # Model logs and prompts are represented by hashes already in receipt.
            for k, v in obj.items():
                self.follow(v, k)
        elif isinstance(obj, list):
            for v in obj:
                self.follow(v, key)
        else:
            p = self.path(obj)
            if not p or p.suffix != '.json':
                return
            name = p.name
            if (name == 'receipt.json' or 'receipt' in key or
                    name in ('itp-average.json', 'supplementary-costs.json') or
                    key in ('statistics', 'statistics_source', 'result_source', 'resolved_results') or
                    (key == 'evidence' and name != 'report.json')):
                self.add(p)

    def capture_inputs(self, group, data):
        for row in data.get('runs', []):
            if not isinstance(row, dict) or 'case' not in row:
                continue
            vid = row.get('variant')
            if not vid:
                continue
            item = {k: row[k] for k in ('variant', 'paired_qcp_variant', 'case', 'initial',
                    'expected', 'expected_by_tool', 'expected_by_execution_strategy',
                    'precondition_valid', 'harness_sha256', 'binds_sha256') if k in row}
            for field in ('binds', 'harness'):
                p = self.path(row.get(field))
                if p:
                    item[field + '_sha256'] = digest(p.read_bytes())
                    if field == 'binds':
                        item['bindings'] = load(p)
                    else:
                        match = re.search(r'\bint\s+main\s*\([^)]*\)\s*(?:/\*.*?\*/\s*)?\{(.*)\}\s*$', p.read_text(), re.S)
                        assert match, p
                        item['cn_body'] = re.sub(r'\breturn\s+0(?:i32)?\s*;\s*$', '', match[1]).strip()
            measurement = row.get('tespec_off', row.get('tespec', {}))
            argv = measurement.get('command', [])
            if '--function' in argv:
                item['function'] = argv[argv.index('--function') + 1]
            for dep in row.get('runtime_dependency_fixtures', []) + ([row['qcp_execution_wrapper']] if row.get('qcp_execution_wrapper') else []):
                p = self.path(dep.get('path'))
                if p:
                    self.add(p)
            self.inputs.setdefault(group, {})[(vid, row['case'])] = item

    def prepare_group(self, group):
        b = ROOT / 'benchmark/results' / group
        g = ROOT / 'benchmark/programs' / group
        manifest = load(g / 'manifest.json')
        idx = load(b / 'index.json')
        self.candidates.update(p for p in b.rglob('*') if p.is_file())
        self.candidates.update(p for p in g.glob('variants/*/tests/**/*') if p.is_file())
        for v in manifest['variants']:
            vm = load(ROOT / v['manifest'])
            for info in vm.get('files', {}).values():
                p = ROOT / info['path']
                actual = digest(p.read_bytes())
                assert actual == info['sha256'], ('source mismatch', p)
                self.source_files[info['path']] = actual
        # All published four-tool tables/statistics are immutable cost records.
        for p in b.iterdir():
            if p.is_file() and p.suffix in ('.json', '.csv', '.md'):
                self.add(p)
                if p.name.startswith(('result-cost.', 'comparison.', 'stages.')):
                    self.baseline[self.relative(p)] = digest(p.read_bytes())
        for tool in ('cn', 'qcp', 'fulminate', 'tespec'):
            for p in (b / tool).rglob('*'):
                if p.is_file() and p.suffix in ('.json', '.csv', '.md'):
                    self.add(p)
        ev = idx.get('evaluation') or idx.get('official_read_result', {}).get('results')
        assert ev, ('missing evaluation', group)
        ep = ROOT / ev
        self.add(ep)
        self.capture_inputs(group, load(ep))
        # read's complete report contains cases rather than raw input rows.
        if group == 'read':
            raw = ROOT / idx['runs'][0]['results']
            self.add(raw)
            self.capture_inputs(group, load(raw))
        for p in ep.parent.iterdir():
            if p.is_file() and p.name in ('statistics.json', 'statistics.csv', 'cases.csv', 'comparison.md'):
                self.add(p)
        for key in ('native_receipt', 'qcp_receipt', 'active_itp_receipt'):
            if idx.get(key):
                self.add(ROOT / idx[key])
        qp = load(b / 'qcp/results.json')
        receipt = qp.get('receipt') or qp.get('complete_proof_receipt')
        assert receipt, group
        q = load(ROOT / receipt)
        assert q['status'] == 'VERIFIED_KERNEL_CHECKED', group
        assert q['kernel_check']['exit_code'] == 0, group
        for key, hk in (('proof', 'proof_sha256'), ('original_goal', 'original_goal_sha256')):
            p = ROOT / q[key]
            assert digest(p.read_bytes()) == q[hk], (group, key)
        self.primary[group] = {'receipt': receipt, 'goal_sha256': q['original_goal_sha256'],
                               'proof_sha256': q['proof_sha256']}
        self.add(ROOT / receipt)
        # Preserve all old attempt cost summaries, but no duplicated old case traces.
        attempts = []
        for p in sorted(b.rglob('result-cost.json')):
            if p == b / 'result-cost.json':
                continue
            d = load(p)
            attempts.append({'origin': self.relative(p), 'sha256': digest(p.read_bytes()),
                'cost_summary': {k: v for k, v in d.items() if k not in
                    ('cases', 'decisions', 'runs', 'case_results', 'per_execution', 'historical_four_tool_table')}})
        self.add_json(f'benchmark/results/{group}/evidence/attempts.json', {'attempts': attempts})
        latest = ROOT / f'benchmark/results/strategy-expectations-20261021/groups/{group}/result-cost.json'
        if latest.is_file():
            self.candidates.update(p for p in latest.parent.iterdir() if p.is_file())
            dst = f'benchmark/results/{group}/evidence/strategies.json'
            self.add(latest, dst)
            for ext in ('md', 'csv'):
                sibling = latest.with_suffix('.' + ext)
                if sibling.is_file():
                    self.add(sibling, f'benchmark/results/{group}/evidence/strategies.{ext}')
            self.baseline[dst] = digest(latest.read_bytes())
            self.claims.extend((group, d['variant'], d['case'], d['strategy'], d['mode'],
                                d['expected'], d['raw_status'], d['final_status'])
                               for d in load(latest)['decisions'])
            for decision in load(latest)['decisions']:
                item = self.inputs.get(group, {}).get((decision['variant'], decision['case']))
                if item is not None:
                    item.setdefault('expected_by_execution_strategy', {})[decision['strategy']] = decision['expected']
            stream = io.StringIO()
            writer = csv.DictWriter(stream, fieldnames=['variant', 'case', 'strategy', 'mode', 'expected', 'raw_status', 'final_status'], lineterminator='\n')
            writer.writeheader()
            writer.writerows({key: d[key] for key in writer.fieldnames} for d in load(latest)['decisions'])
            self.output[f'benchmark/results/{group}/cases.csv'] = stream.getvalue().encode()
        else:
            for strategy in ('inline', 'modular'):
                s = manifest.get('execution_strategy_evidence', {}).get(strategy)
                assert s, ('missing strategy', group, strategy)
                self.add(ROOT / s, f'benchmark/results/{group}/evidence/{strategy}.json')
        audit = ROOT / f'benchmark/results/expectation-audit-20261021/groups/{group}/audit.json'
        if audit.is_file():
            self.candidates.add(audit)
            self.add(audit, f'benchmark/results/{group}/evidence/expectations.json')
        plan = g / 'evaluation-plan.json'
        legacy_inputs = {self.relative(p).split('/variants/', 1)[1].split('/tests/', 1)[0]: load(p)
                         for p in g.glob('variants/*/tests/inputs.json')}
        if plan.is_file():
            self.add(plan)
            plan_data = load(plan)
            for pair in plan_data['pairings']:
                for case in pair['cases']:
                    replay = self.inputs.get(group, {}).get((pair['cn_variant'], case['id']), {})
                    if replay.get('expected_by_execution_strategy'):
                        case['expected_by_execution_strategy'] = replay['expected_by_execution_strategy']
            if legacy_inputs:
                plan_data['legacy_input_catalogs'] = legacy_inputs
            self.output[self.relative(plan)] = encoded(plan_data)
        else:
            assert self.inputs.get(group), ('no replay inputs', group)
            pairs = {}
            for item in self.inputs[group].values():
                key = (item['variant'], item['paired_qcp_variant'], item['function'])
                pair = pairs.setdefault(key, {'cn_variant': key[0], 'qcp_variant': key[1], 'function': key[2], 'cases': []})
                bindings = item['bindings']
                if isinstance(bindings, list):
                    assert len(bindings) == 1
                    bindings = bindings[0]
                expectation = item.get('expected', item.get('expected_by_execution_strategy', {}).get('inline'))
                assert expectation in ('PASS', 'FAIL', 'ERROR')
                case = {'id': item['case'], 'value': item.get('initial'), 'expected': expectation,
                        'precondition_valid': item.get('precondition_valid', True),
                        'cn_body': item['cn_body'], 'binds': {k: v for k, v in bindings.items() if k != 'id'}}
                if item.get('expected_by_execution_strategy'):
                    case['expected_by_execution_strategy'] = item['expected_by_execution_strategy']
                pair['cases'].append(case)
            self.add_json(self.relative(plan), {'schema': 'tespec-group-evaluation-plan/v1',
                'program_group': group, 'run_id': 'replay', 'function': next(iter(pairs))[2],
                'pairings': list(pairs.values()), 'legacy_input_catalogs': legacy_inputs})
        # Record source/input identities even when old plans use different schemas.
        for p in (ROOT / 'benchmark/results/spatial-smt-regressions').glob(f'*/{group}/**/*'):
            if p.is_file():
                self.candidates.add(p)

    def discover(self):
        for g in self.groups:
            self.prepare_group(g)
        seen = set()
        while self.queue:
            old, new, obj = self.queue.pop(0)
            if old in seen:
                continue
            seen.add(old)
            self.follow(obj)
            if 'receipt' in Path(old).name or 'itp' in Path(old).name:
                self.proof_refs(obj)
        # Keep receipts' formal local libraries, and standalone audited assumption text.
        for old, new in list(self.alias.items()):
            if Path(old).name == 'receipt.json':
                obj = load(ROOT / old)
                for s in leaves(obj):
                    p = self.path(s)
                    if p and p.suffix in ('.txt', '.log') and any(w in p.as_posix().lower() for w in ('assumption', 'audit')):
                        if p.stat().st_size < 131072:
                            self.add(p)

    def normalize(self, obj):
        if isinstance(obj, list):
            return [self.normalize(x) for x in obj]
        if not isinstance(obj, dict):
            if isinstance(obj, str) and obj in self.alias:
                return self.alias[obj]
            return obj
        result = {}
        for key, value in obj.items():
            p = self.path(value)
            if p and self.relative(p) in self.candidate_names and self.relative(p) not in self.alias:
                # Never keep a live link to intentionally removed regenerable data.
                if key not in ('command',):
                    result[key + '_omitted'] = {'sha256': digest(p.read_bytes())}
                    if key in ('stdout', 'stderr') and p.stat().st_size:
                        text = p.read_text(errors='replace')
                        if any(t in text.lower() for t in ('error', 'failed', 'exception', 'permission', 'closed under', 'axioms:')):
                            result[key + '_diagnostic'] = text[:2000] + (text[-2000:] if len(text) > 2000 else '')
                    continue
            result[key] = self.normalize(value)
        return result

    def finish(self):
        self.candidate_names = {self.relative(p) for p in self.candidates}
        original_facts = {}
        # Retained graph may contain proof sets outside group roots; do not delete
        # shared global artifacts here. Only explicit per-group scope is swept.
        for name, data in list(self.output.items()):
            if name.endswith('.json'):
                original = json.loads(data)
                compact = self.normalize(original)
                assert decision_cost_facts(original) == decision_cost_facts(compact), ('changed costs/verdicts', name)
                original_facts[name] = digest(encoded(decision_cost_facts(original)))
                self.output[name] = encoded(compact)
        # Rewrite live references in manifests, global indexes and docs. Proof
        # source bytes never change; original commands remain as historical records.
        moves = [(old.encode(), new.encode()) for old, new in self.alias.items() if old != new]
        patterns = Path('/tmp/tespec-storage-moved-paths.txt')
        patterns.write_bytes(b'\n'.join(old for old, new in moves) + b'\n')
        found = subprocess.run(['git', 'grep', '--threads=2', '-l', '-F', '-f', str(patterns), '--',
            ':(glob)benchmark/programs/**/manifest.json', ':(glob)benchmark/programs/**/evaluation-plan.json',
            ':(glob)benchmark/results/*.*', ':(glob)benchmark/results/*/index.*',
            ':(glob)benchmark/results/*/result-cost.*', ':(glob)benchmark/results/*/summary.json',
            'docs'], cwd=ROOT, capture_output=True, check=False)
        assert found.returncode in (0, 1)
        for filename in found.stdout.decode().splitlines():
            p = ROOT / filename
            if p.suffix not in ('.json', '.md', '.csv') or p in self.candidates or self.relative(p) in self.output:
                continue
            content = p.read_bytes()
            revised = content
            for old, new in moves:
                revised = revised.replace(old, new)
            if revised != content:
                self.output[self.relative(p)] = revised
        # Preserve hashes of all formal source files and unchanged cost records.
        proof_hashes = {n: digest(self.output[n]) for n in sorted(self.proofs)}
        for g in self.groups:
            ip = f'benchmark/results/{g}/index.json'
            idx = json.loads(self.output[ip])
            idx['storage_policy'] = 'docs/benchmark-storage-policy.md'
            idx['durable_evidence'] = {
                'inputs': f'benchmark/programs/{g}/evaluation-plan.json',
                'attempts': f'benchmark/results/{g}/evidence/attempts.json',
                'primary_proof': self.primary[g],
            }
            s = f'benchmark/results/{g}/evidence/strategies.json'
            if s in self.output:
                idx['durable_evidence']['strategies'] = s
            self.output[ip] = encoded(idx)
        self.facts = original_facts
        return proof_hashes

    def relink_hashes(self):
        old_hash_targets = {digest((ROOT / old).read_bytes()): new
            for old, new in self.alias.items() if old.endswith('.json')}
        def visit(x):
            if isinstance(x, list):
                return [visit(v) for v in x]
            if not isinstance(x, dict):
                return x
            y = {k: visit(v) for k, v in x.items()}
            for k, v in list(y.items()):
                if not isinstance(v, str):
                    continue
                if k in ('results_sha256', 'native_receipt_sha256', 'evidence_sha256', 'receipt_sha256') and v in old_hash_targets:
                    y[k] = digest(self.output[old_hash_targets[v]])
                target = self.alias.get(v, v)
                if target in self.output:
                    if k == 'path' and 'sha256' in y:
                        y['sha256'] = digest(self.output[target])
                    if k + '_sha256' in y:
                        y[k + '_sha256'] = digest(self.output[target])
            return y
        for _ in range(12):
            changes = 0
            for name, data in list(self.output.items()):
                if name.endswith('.json'):
                    updated = encoded(visit(json.loads(data)))
                    if len(updated) > 32768:
                        updated = (json.dumps(json.loads(updated), ensure_ascii=False, separators=(',', ':')) + '\n').encode()
                    changes += data != updated
                    self.output[name] = updated
            if not changes:
                return
        raise AssertionError('Cyclic mutable JSON receipt hashes')

    def run(self, apply):
        self.discover()
        proofs = self.finish()
        self.relink_hashes()
        Path('/tmp/tespec-storage-retention-plan.json').write_bytes(encoded({
            'files': {n: len(data) for n, data in self.output.items()},
            'largest': sorted(((len(v), k) for k, v in self.output.items()), reverse=True)[:25]}))
        remove = sorted(p for p in self.candidates if self.relative(p) not in self.output)
        before = sum(p.stat().st_size for p in self.candidates)
        retained = sum(len(v) for n, v in self.output.items() if n in self.candidate_names or '/evidence/' in n)
        summary = {'schema': 'tespec-storage-migration-audit/v1', 'groups': self.groups,
            'before_files': len(self.candidates), 'before_bytes': before,
            'deleted_files': len(remove), 'retained_bytes': retained,
            'source_hashes': self.source_files, 'primary_proofs': self.primary,
            'proof_files': proofs, 'cost_records_before': self.baseline,
            'numeric_and_verdict_invariants': self.facts,
            'strategy_decisions': len(self.claims),
            'strategy_decision_sha256': digest(encoded(self.claims)),
            'scope': 'Storage migration only; no experiments rerun or measured costs changed.'}
        if apply:
            for name, h in self.facts.items():
                assert digest(encoded(decision_cost_facts(json.loads(self.output[name])))) == h, name
            for name, data in self.output.items():
                p = ROOT / name
                p.parent.mkdir(parents=True, exist_ok=True)
                p.write_bytes(data)
            # All outputs exist before any removal; only paths within explicit
            # selected result roots or generated test fixtures can be removed.
            for p in remove:
                assert p.resolve().is_relative_to(ROOT / 'benchmark')
                p.unlink()
            for g in self.groups:
                for parent in (ROOT / 'benchmark/results' / g, ROOT / 'benchmark/programs' / g / 'variants'):
                    for p in sorted(parent.rglob('*'), key=lambda p: len(p.parts), reverse=True):
                        if p.is_dir() and not any(p.iterdir()):
                            p.rmdir()
            for name, h in self.source_files.items():
                assert digest((ROOT / name).read_bytes()) == h
            for name, h in proofs.items():
                assert digest((ROOT / name).read_bytes()) == h
            for name, h in self.facts.items():
                assert digest(encoded(decision_cost_facts(load(ROOT / name)))) == h, name
            summary['retained_files'] = sum(1 for n in self.output if n in self.candidate_names or '/evidence/' in n)
            summary['formal_sources_hash_checked'] = True
            summary['retained_json_hashes'] = {n: digest(v) for n, v in self.output.items() if n.endswith('.json')}
            baseline = Path('/tmp/tespec-storage-baseline-validation.json')
            if baseline.is_file():
                summary['legacy_validator_baseline'] = [
                    {'group': x['group'], 'exit_code': x['returncode'],
                     'diagnostic': x['output'][-300:]} for x in load(baseline)]
            (ROOT / 'benchmark/results/storage-migration-audit.json').write_bytes(encoded(summary))
        print(json.dumps({k: v for k, v in summary.items() if k not in
            ('source_hashes', 'proof_files', 'primary_proofs', 'cost_records_before',
             'numeric_and_verdict_invariants', 'retained_json_hashes', 'legacy_validator_baseline')}, ensure_ascii=False, indent=2))


def audit_compacted_group(group, root=ROOT):
    audit = load(root / 'benchmark/results/storage-migration-audit.json')
    assert group in audit['groups']
    prefixes = (f'benchmark/results/{group}/', f'benchmark/programs/{group}/')
    for name, h in audit['source_hashes'].items():
        if name.startswith(prefixes):
            assert digest((root / name).read_bytes()) == h, name
    for name, h in audit['proof_files'].items():
        if name.startswith(prefixes):
            assert digest((root / name).read_bytes()) == h, name
    for name, h in audit['numeric_and_verdict_invariants'].items():
        if name.startswith(prefixes):
            assert digest(encoded(decision_cost_facts(load(root / name)))) == h, name
    for name, h in audit['retained_json_hashes'].items():
        if name.startswith(prefixes):
            assert digest((root / name).read_bytes()) == h, name
    p = audit['primary_proofs'][group]
    proof = load(root / p['receipt'])
    assert proof['status'] == 'VERIFIED_KERNEL_CHECKED'
    assert proof['kernel_check']['exit_code'] == 0
    assert proof['original_goal_sha256'] == p['goal_sha256']
    assert digest((root / proof['original_goal']).read_bytes()) == p['goal_sha256']
    assert digest((root / proof['proof']).read_bytes()) == p['proof_sha256']
    assert not re.search(r'\b(?:Admitted|admit|Axiom)\b', (root / proof['proof']).read_text())
    b = root / 'benchmark/results' / group
    assert load(b / 'cn/results.json')['verdict'] == 'VERIFIED'
    strategy = b / 'evidence/strategies.json'
    if strategy.is_file():
        data = load(strategy)
        assert data['complete']
        assert all(d['final_status'] == d['expected'] for d in data['decisions'])
        assert len({(d['variant'], d['case'], d['strategy'], d['mode']) for d in data['decisions']}) == len(data['decisions'])
        count = len(data['decisions'])
    else:
        count = 0
        for mode in ('inline', 'modular'):
            data = load(b / f'evidence/{mode}.json')
            assert data['summary']['passed']
            count += len(data['runs'])
    print(f'PASS {group}: unchanged source/proof bytes, all cost/verdict invariants, {count} final strategy decisions; stored historical receipts audited, no proof rerun claimed.')


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--apply', action='store_true')
    ap.add_argument('--audit', action='store_true')
    args = ap.parse_args()
    index = load(ROOT / 'benchmark/results/group-result-cost-index.json')
    groups = [g['program_group'] for g in index['groups'] if g['complete']]
    if args.audit:
        groups = load(ROOT / 'benchmark/results/storage-migration-audit.json')['groups']
        for group in groups:
            audit_compacted_group(group)
        receipt = load(ROOT / 'benchmark/results/storage-migration-audit.json')
        for name, expected_hash in receipt['proof_files'].items():
            assert digest((ROOT / name).read_bytes()) == expected_hash, name
        for name, expected_hash in receipt['retained_json_hashes'].items():
            # Live global indexes may grow when later groups are evaluated.
            # The group evidence and formal proof graph remain immutable here.
            if name.count('/') == 2 and (name.endswith('-index.json') or name.endswith('/index.json')):
                continue
            assert digest((ROOT / name).read_bytes()) == expected_hash, name
        print('PASS all shared formal sources and retained JSON receipt hashes.')
        return
    assert len(groups) == 22
    assert not (ROOT / 'benchmark/results/storage-migration-audit.json').exists(), 'Already migrated: use --audit'
    Migration(groups).run(args.apply)


if __name__ == '__main__':
    main()
