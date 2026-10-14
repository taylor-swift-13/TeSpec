#!/usr/bin/env python3
"""Summarize residual causes from immutable complete-suite ATP reports."""
from collections import Counter
import gzip
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent


def diagnose():
    paths = sorted(p for p in (HERE / 'suites').glob('*.json')
                   if p.name == 'replay-evidence.json' or p.name.endswith('-replay-evidence.json'))
    sources = {}
    rows = []
    seen = set()
    totals = Counter()
    reasons = Counter()
    phases = Counter()
    vc_kinds = Counter()
    sha = lambda p: hashlib.sha256(p.read_bytes()).hexdigest()
    for path in paths:
        evidence = json.loads(path.read_text())
        sources[str(path.relative_to(HERE))] = sha(path)
        for group in evidence['runs']:
            if group['tool'] != 'qcp':
                continue
            key = (group['case'], group['variant'])
            assert key not in seen, key
            seen.add(key)
            portable = HERE / group['portable_report']
            sources[group['portable_report']] = sha(portable)
            with gzip.open(portable, 'rt') as stream:
                automatic = json.load(stream)
            results = {r['id']: r for r in automatic['results']}
            assert len(results) == len(automatic['results']) == len(group['results'])
            counts = Counter()
            group_reasons = Counter()
            group_phases = Counter()
            group_vcs = Counter()
            for expected in group['results']:
                result = results[expected['id']]
                assert result['status'] == expected['status']
                counts['inputs'] += 1
                counts['expected_' + expected['expected']] += 1
                counts['actual_' + result['status']] += 1
                if result['status'] != expected['expected']:
                    counts['expected_verdict_mismatches'] += 1
                if result['status'] != 'UNKNOWN':
                    continue
                counts['unknown_execution_' + str(result.get('execution_completed'))] += 1
                group_reasons[result.get('reason') or 'not_recorded'] += 1
                for phase, verdict in result.get('phases', {}).items():
                    if verdict == 'UNKNOWN':
                        group_phases[phase] += 1
                for vc in result.get('vc_results', []):
                    if vc.get('status') == 'UNKNOWN':
                        group_vcs[vc.get('kind') or 'not_recorded'] += 1
            totals.update(counts)
            reasons.update(group_reasons)
            phases.update(group_phases)
            vc_kinds.update(group_vcs)
            rows.append({'case': key[0], 'variant': key[1], 'counts': dict(counts),
                         'unknown_reason_counts': dict(group_reasons),
                         'unknown_phase_input_counts': dict(group_phases),
                         'unknown_vc_obligation_counts': dict(group_vcs)})
    return {'schema': 'tespec-residual-diagnostics/v1',
            'scope': 'Complete archived ATP groups; reasons and phases describe remaining obligations, not final ITP verdicts or automatic proof feasibility.',
            'generator_sha256': sha(Path(__file__)), 'sources': sources,
            'subjects': len({case for case, variant in seen}), 'tool_groups': len(rows),
            'counts': dict(totals), 'unknown_reason_counts': dict(reasons),
            'unknown_phase_input_counts': dict(phases),
            'unknown_vc_obligation_counts': dict(vc_kinds),
            'phase_count_policy': 'One input may have several UNKNOWN phases; VC counts count obligations, not inputs.',
            'groups': rows}


if __name__ == '__main__':
    result = diagnose()
    (HERE / 'residual-diagnostics.json').write_text(json.dumps(result, indent=2) + '\n')
    print(json.dumps({k: v for k, v in result.items() if k not in ('groups', 'sources')}, indent=2))
