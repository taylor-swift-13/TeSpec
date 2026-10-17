#!/usr/bin/env python3
"""Summarize preserved array_load native diagnostics without rerunning experiments."""
import collections
import hashlib
import json
import statistics
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
BASE = ROOT / 'benchmark/results/array_load'
OUT = BASE / '20261018-source-repairs'
STAGES = ('fulminate_pipeline', 'fulminate_test', 'tespec_off', 'tespec_on')
BATCHES = (
    ('20261016-evaluation', 'historical_baseline'),
    ('20261017-client-region-annotation-fix', 'source_revision_diagnostic'),
    ('20261018-source-repairs/attempt1', 'source_revision_diagnostic'),
    ('20261018-source-repairs/attempt2', 'source_revision_diagnostic'),
    ('20261018-source-repairs/attempt3', 'source_revision_diagnostic'),
    ('20261018-evaluation', 'harness_compatibility_diagnostic'),
    ('20261018-evaluation-v2', 'harness_compatibility_diagnostic'),
)


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def rel(path):
    return path.resolve().relative_to(ROOT.resolve()).as_posix()


def read(path):
    return json.loads(path.read_text())


def observations(data):
    if isinstance(data, list):
        for row in data:
            yield row, 'tespec_' + row['mode'], row['measurement'], row
    elif 'modes' in data:
        for mode, measurement in data['modes'].items():
            row = dict(data, qcp_source_sha256=data['source_after_sha256'])
            yield row, 'tespec_' + mode, measurement, measurement
    else:
        for row in data['runs']:
            for stage in STAGES:
                yield row, stage, row.get(stage), row.get(stage) or {}


def summarize(items):
    executed = [x for x in items if x['executed']]
    walls = [x['wall_seconds'] for x in executed if x['wall_seconds'] is not None]
    peaks = [x['max_process_rss_kib'] for x in executed if x['max_process_rss_kib'] is not None]
    return {
        'measurement_records': len(items),
        'executed_measurements': len(executed),
        'not_executed': len(items) - len(executed),
        'measured_wall_seconds': sum(walls) if walls else None,
        'mean_wall_seconds_per_measured_execution': statistics.mean(walls) if walls else None,
        'maximum_process_rss_kib': max(peaks) if peaks else None,
        'mean_per_execution_peak_process_rss_kib': statistics.mean(peaks) if peaks else None,
        'missing_wall_measurements': len(executed) - len(walls),
        'missing_rss_measurements': len(executed) - len(peaks),
        'raw_status_counts': dict(sorted(collections.Counter(x['status'] for x in items).items())),
        'expected_matches': sum(x['expected_matched'] is True for x in items),
        'expected_mismatches': sum(x['expected_matched'] is False for x in items),
        'tokens': 0,
        'model_calls': 0,
    }


def main():
    measurements = []
    unexecuted = []
    seen = {}
    duplicates = []
    batches = []
    for batch_id, purpose in BATCHES:
        path = BASE / batch_id / 'results.json'
        data = read(path)
        batch_records = []
        references = 0
        for row, stage, m, verdict in observations(data):
            references += 1
            m = m or {}
            assert m.get('tokens', 0) == 0 and m.get('model_calls', 0) == 0
            executed = bool(m.get('command') and m.get('stdout'))
            status = verdict.get('status') or m.get('status')
            if status is None:
                status = 'EXIT_' + str(m['exit_code']) if 'exit_code' in m else 'NOT_EXECUTED'
            expected = row.get('plan_case', {}).get('expected_by_tool', {}).get(
                stage, row.get('expected'))
            expected_matched = status == expected if stage != 'fulminate_pipeline' and executed and expected is not None else None
            category = purpose
            if purpose == 'historical_baseline' and stage.startswith('tespec') and expected_matched is False:
                category = 'source_revision_diagnostic'
            resources = m.get('resources') or {}
            item = {
                'batch_id': batch_id, 'batch_purpose': purpose, 'category': category,
                'case': row.get('case'), 'variant': row.get('variant'),
                'paired_qcp_variant': row.get('paired_qcp_variant'),
                'stage': stage, 'executed': executed, 'status': status,
                'expected': expected, 'expected_matched': expected_matched,
                'reason': verdict.get('reason'), 'execution_completed': verdict.get('execution_completed'),
                'source_sha256': row.get('qcp_source_sha256', row.get('source_sha256')) if stage.startswith('tespec') else row.get('cn_source_sha256'),
                'binds_sha256': row.get('binds_sha256'),
                'wall_seconds': m.get('wall_seconds') if executed else None,
                'max_process_rss_kib': resources.get('max_process_rss_kib') if executed else None,
                'tokens': 0, 'model_calls': 0,
                'measurement_record': rel(path), 'measurement_record_sha256': sha(path),
            }
            if not executed:
                assert m.get('wall_seconds') is None and not resources
                item['status'] = status if status != 'EXIT_None' else 'NOT_EXECUTED'
                unexecuted.append(item)
                batch_records.append(item)
                continue
            item.update(command=m['command'], exit_code=m.get('exit_code'), resources=m.get('resources'))
            for stream in ('stdout', 'stderr'):
                stream_path = ROOT / m[stream]
                digest = sha(stream_path)
                if m.get(stream + '_sha256'):
                    assert digest == m[stream + '_sha256']
                item[stream] = rel(stream_path)
                item[stream + '_sha256'] = digest
            report = verdict.get('report', m.get('report'))
            if report:
                report_path = ROOT / report
                digest = sha(report_path)
                declared = verdict.get('report_sha256', m.get('report_sha256'))
                if declared:
                    assert digest == declared
                item['report'] = rel(report_path)
                item['report_sha256'] = digest
                raw = read(report_path)['results']
                assert len(raw) == 1 and raw[0]['status'] == status
                item['reason'] = raw[0].get('reason')
                item['execution_completed'] = raw[0].get('execution_completed')
            identity = json.dumps([m['command'], item['stdout']], ensure_ascii=False, separators=(',', ':'))
            item['measurement_id'] = hashlib.sha256(identity.encode()).hexdigest()
            if identity in seen:
                prior = seen[identity]
                for field in ('wall_seconds', 'resources', 'exit_code', 'stdout_sha256', 'stderr_sha256'):
                    assert item[field] == prior[field], ('Conflicting duplicate measurement', identity, field)
                duplicates.append({'measurement_id': item['measurement_id'], 'first_batch': prior['batch_id'], 'duplicate_batch': batch_id})
                continue
            seen[identity] = item
            measurements.append(item)
            batch_records.append(item)
        batches.append({
            'batch_id': batch_id, 'purpose': purpose, 'results': rel(path),
            'results_sha256': sha(path), 'observed_stage_references': references,
            'summary': summarize(batch_records),
            'stages': {stage: summarize([x for x in batch_records if x['stage'] == stage]) for stage in STAGES},
            'successful_native_retests': [
                {'case': x['case'], 'stage': x['stage'], 'measurement_id': x['measurement_id'], 'source_sha256': x['source_sha256']}
                for x in batch_records
                if purpose == 'source_revision_diagnostic' and x['expected_matched'] is True
            ],
        })
    all_records = measurements + unexecuted
    result = {
        'schema': 'tespec-array-load-native-diagnostic-costs/v1',
        'program_group': 'array_load',
        'generator': rel(Path(__file__)), 'generator_sha256': sha(Path(__file__)),
        'scope': 'Preserved historical baseline and native source/harness repair measurements only; no experiment is rerun by this generator.',
        'excluded': ['20261018-evaluation-v3', 'primary CN verification', 'primary QCP generation/proof/audit/kernel checks', 'all test ITP model/compile/audit/kernel stages'],
        'deduplication': 'Exact JSON command argument list plus canonical stdout path. Shared references count once; different invocations remain separate even when their source/binds match.',
        'cost_policy': 'Wall totals sum actual stage work, not continuous end-to-end latency. RSS is GNU time maximum single-process RSS; maxima are not summed. fulminate_pipeline includes instrumentation/build and its --run invocation; fulminate_test is the separately measured binary execution.',
        'verdict_policy': 'Old native states are preserved. Source revisions are new tests with new source hashes, not ITP resolutions of an old same-source execution. Harness repair attempts remain diagnostics, including teSpec runs that passed inside an otherwise failed batch.',
        'missing_policy': 'NOT_BUILT/unexecuted stages retain null time/RSS. Summaries count only measured executed stages and separately disclose missing fields.',
        'summary': summarize(all_records),
        'stages': {stage: summarize([x for x in all_records if x['stage'] == stage]) for stage in STAGES},
        'categories': {category: summarize([x for x in all_records if x['category'] == category]) for category in sorted({x['category'] for x in all_records})},
        'batches': batches, 'duplicate_references_excluded': duplicates,
        'measurements': measurements, 'unexecuted_stages': unexecuted,
    }
    lines = [
        '# array_load preserved native diagnostic costs', '',
        'This report covers the seven explicitly listed historical/repair batches. It excludes final batch 20261018-evaluation-v3, all primary CN/QCP verification, and all test ITP costs. Original evidence is read only.', '',
        'Amounts are measured stage work, not end-to-end latency. RSS is the largest measured process RSS; maxima are never summed. fulminate_pipeline includes its initial --run; fulminate_test is a distinct binary invocation. Deduplication uses exact command arguments plus canonical stdout path.', '',
        '| Stage | Executed | Not executed | Total seconds | Maximum process RSS (KiB) | Tokens | Model calls |',
        '|---|---:|---:|---:|---:|---:|---:|',
    ]
    def fmt(value, digits=6):
        return 'N/A' if value is None else f'{value:.{digits}f}'
    for stage in STAGES:
        s = result['stages'][stage]
        lines.append(f"| {stage} | {s['executed_measurements']} | {s['not_executed']} | {fmt(s['measured_wall_seconds'])} | {s['maximum_process_rss_kib'] or 'N/A'} | 0 | 0 |")
    s = result['summary']
    lines += ['', f"Total: **{s['executed_measurements']}** unique executed measurements, **{s['not_executed']}** unexecuted stages, **{fmt(s['measured_wall_seconds'])} seconds** of measured work. Global observed maximum process RSS: **{s['maximum_process_rss_kib']} KiB**. Native-stage token/model calls: **0 / 0**.", '',
        '| Batch | Purpose | Executed / not executed | Seconds | Raw stage outcomes |',
        '|---|---|---:|---:|---|']
    for batch in batches:
        s = batch['summary']
        outcomes = ', '.join(f'{k}: {v}' for k, v in s['raw_status_counts'].items())
        lines.append(f"| {batch['batch_id']} | {batch['purpose']} | {s['executed_measurements']} / {s['not_executed']} | {fmt(s['measured_wall_seconds'])} | {outcomes} |")
    lines += ['', 'Classification and interpretation:', '',
        '- The historical 67-pair batch is retained in full. Its teSpec mismatches are source_revision_diagnostic; original UNKNOWN/FAIL labels are not overwritten.',
        '- The annotation-fix and attempt1/2/3 batches are source-revision diagnostics. Successful native retests are listed separately in JSON, bound to their new source hashes. They are not same-source ITP certificates.',
        '- 20261018-evaluation and 20261018-evaluation-v2 are harness compatibility attempts: the latest CN/Fulminate rejects fixed-width i32 literals where integer expressions are required. The first batch has no built test binaries; the second builds 60 helper tests while seven client harnesses remain unbuilt. Their actually executed pipeline and teSpec work still counts.',
        '- NOT_BUILT contributes no fabricated execution time or RSS. Its measured failed pipeline is counted separately.',
        '- This native report has no model calls. It does not assert that the complete repair process or ITP has zero token cost.',
        '- Final benchmark correctness/completeness and the final current-source cost table must reference their own final batch and checked ITP receipts; this report is an additional diagnostic-cost component.',
        '', 'Per-measurement commands, source hashes where recorded, raw statuses, report/log hashes, per-stage metrics, and missing-stage records are in [diagnostic-costs.json](diagnostic-costs.json).', '']
    OUT.mkdir(parents=True, exist_ok=True)
    (OUT/'diagnostic-costs.json').write_text(json.dumps(result, ensure_ascii=False, indent=2) + '\n')
    (OUT/'diagnostic-costs.md').write_text('\n'.join(lines))
    print(json.dumps({'summary': result['summary'], 'stages': result['stages'], 'duplicates': len(duplicates)}, indent=2))


if __name__ == '__main__':
    main()
