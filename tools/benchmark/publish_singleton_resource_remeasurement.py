#!/usr/bin/env python3
"""Publish three actual whole-check remeasurements; never run a model or prover.

The selected current measurement set substitutes complete checker invocations,
not individual missing fields. Every historical observation stays immutable.
"""
from __future__ import annotations
import argparse
import copy
import hashlib
import json
from pathlib import Path
import statistics

from publish_singleton_completed import (Publication as BasePublication, ROOT, BASE, GROUP, PROGRAM, CANONICAL,
    load, need, reference, rel, digest, encoded, aggregate_itp, csv_bytes, COST_FIELDS,
    prepared_evidence_reader)
from validate_canonical_group import execution_metrics, audit_canonical_group
from singleton_canonical_support import canonical_sha, group_workload

SCHEMA = 'whole-check-remeasurement/v1'
PROFILE_PATH = BASE / 'evidence/resource-remeasurement.json'
BASELINE_TARGETS = [BASE/'index.json', CANONICAL, BASE/'result-cost.json', BASE/'result-cost.csv',
    BASE/'result-cost.md', BASE/'tespec/statistics.json', BASE/'tespec/results.json',
    BASE/'coverage-gap.json', PROGRAM/'manifest.json']
JOB_IDS = ['legacy-execution-00-attempt-2', 'legacy-execution-00-attempt-3', 'active-execution-03-attempt-1']


class Publication(BasePublication):
    def json(self,path,value,compact=True):
        return super().json(path,value,compact=compact)


def snapshot_baseline(pub):
    current = load(CANONICAL)
    if current.get('measurement_profile'):
        profile_ref = current['measurement_profile']
        need(digest(ROOT/profile_ref['path']) == profile_ref['sha256'], 'Current measurement profile changed')
        old = load(ROOT/profile_ref['path'])
        need(old['schema'] == SCHEMA, 'Cannot replace another cost selection profile')
        ref = old['baseline_snapshot']
        need(digest(ROOT/ref['path']) == ref['sha256'], 'Original baseline snapshot changed')
        snapshot = load(ROOT/ref['path'])
    else:
        need(current.get('verdict_complete') is True and current.get('complete') is False,
             'Expected checked singleton verdicts with historical resource gaps')
        documents = {}
        for path in BASELINE_TARGETS:
            content = path.read_bytes()
            documents[rel(path)] = {'sha256': hashlib.sha256(content).hexdigest(), 'text': content.decode('utf-8')}
        snapshot = {'schema': 'singleton-cost-baseline/v1', 'documents': documents,
            'scope': 'Exact original publication summaries only; proof receipts and objects are referenced, never duplicated.'}
        content = encoded(snapshot, compact=True)
        ref = pub.put(BASE/'evidence/itp/objects'/hashlib.sha256(content).hexdigest()/'cost-baseline.json', content)
    for path, item in snapshot['documents'].items():
        need(hashlib.sha256(item['text'].encode('utf-8')).hexdigest() == item['sha256'], 'Baseline document hash mismatch')
    def original(path):
        return json.loads(snapshot['documents'][rel(path)]['text'])
    return snapshot, ref, original


def object_reference(pub, path):
    path = path.resolve()
    if path.is_relative_to(ROOT) and '/evidence/itp/objects/' in str(path):
        return reference(path)
    content = path.read_bytes()
    sha = hashlib.sha256(content).hexdigest()
    existing = sorted((BASE/'evidence/itp/objects'/sha).glob('*'))
    if existing:
        need(existing[0].read_bytes() == content, 'Existing object differs')
        return reference(existing[0])
    return pub.object(path, path.name)


def resolve_raw(value):
    path = Path(value['path'])
    if not path.is_absolute():
        path = ROOT/path
    need(path.is_file() and digest(path) == value['sha256'], 'Remeasurement source missing/changed: '+str(path))
    return path


def selected_metrics(models, checks):
    return execution_metrics(models, checks)


def prepare(run_root):
    pub = Publication()
    snapshot, snapshot_ref, original = snapshot_baseline(pub)
    baseline = original(CANONICAL)
    need(baseline['final_status_counts'] == {'PASS':28} and baseline['itp_executions'] == 14,
         'Baseline verdict scope changed')
    gaps = baseline['missing_measurements']
    need(len(gaps) == 9, 'Expected the nine explicitly retained historical gaps')
    plan_path = run_root/'plan.json'
    plan = load(plan_path)
    need(plan['profile'] == SCHEMA and plan['group'] == GROUP and [j['id'] for j in plan['jobs']] == JOB_IDS,
         'Wrong remeasurement plan')
    plan_ref = object_reference(pub, plan_path)
    replacements, replacement_checks, resources = [], {}, {}
    for job in plan['jobs']:
        path = run_root/job['id']/'receipt.json'
        need(path.is_file(), 'Real remeasurement is not finished: '+job['id'])
        replay = load(path)
        need(replay['schema'] == 'tespec-singleton-resource-remeasurement/v1' and replay['profile'] == SCHEMA and
             replay['status'] in ('KERNEL_CHECKED','UNKNOWN') and replay['verdict_authority'] is False and
             replay['model_calls'] == replay['tokens'] == 0, 'Incomplete/unexpected replay receipt')
        need(replay['plan']['sha256'] == digest(plan_path), 'Replay/plan differs')
        for key, value in job.items():
            need(replay.get(key) == value, 'Replay changes prepared job: '+key)
        source_path = resolve_raw(job['source_execution'])
        source = load(source_path)
        old = next(c for c in source['checks'] if c['attempt'] == job['original_check_attempt'])
        need(canonical_sha(old) == job['original_check_sha256'] and
             old['controller_receipt_sha256'] == job['original_controller_receipt_sha256'], 'Old check changed')
        expected_stage_names = [s['stage'] for s in job['original_commands']]
        need([s['stage'] for s in replay['stages']] == expected_stage_names,
             'A whole checker invocation was not measured')
        for stage in replay['stages']:
            need(isinstance(stage.get('wall_seconds'), (int,float)) and stage['wall_seconds'] >= 0 and
                 (stage.get('resources') or {}).get('max_process_rss_kib', 0) > 0, 'New stage has incomplete time/RSS')
            resource_path = Path(stage['resource_file'])
            need(digest(resource_path) == stage['resource_sha256'], 'GNU time resource bytes changed')
            resource_text = resource_path.read_bytes().decode('utf-8')
            need(json.loads(resource_text) == stage['resources'], 'Stage/GNU time resource values differ')
            resources[stage['resource_sha256']] = resource_text
            need(digest(Path(stage['log'])) == stage['log_sha256'], 'Measured log changed before publication')
        need(replay['whole_check']['resources_complete'] is True, 'New whole-check cost incomplete')
        input_refs = []
        for name, value in job['files'].items():
            input_refs.append({'name':name, 'evidence':object_reference(pub, resolve_raw(value))})
        manifest = run_root/job['id']/'check/manifest.json'
        need(digest(manifest) == job['certificate_manifest_sha256'], 'Rerun certificate manifest changed')
        input_refs.append({'name':'manifest.json','evidence':object_reference(pub, manifest)})
        covered = [g for g in gaps if g['execution_index'] == job['execution_index'] and
            g['check_attempt'] == job['original_check_attempt'] and g['proof_context'] == job['proof_context']]
        need(len(covered) == (1 if job['proof_context'] == 'legacy' else 7), 'Unexpected historical gap selection')
        replay_ref = object_reference(pub, path)
        replacement = {'id':job['id'], 'execution_index':job['execution_index'], 'proof_context':job['proof_context'],
            'original_receipt':reference(source_path), 'original_check_attempt':job['original_check_attempt'],
            'original_check_sha256':job['original_check_sha256'],
            'original_controller_receipt_sha256':job['original_controller_receipt_sha256'],
            'new_replay':replay_ref, 'input_artifacts':input_refs,
            'gap_keys':[{'stage':g['stage'],'field':g['field']} for g in covered]}
        replacements.append(replacement)
        replacement_checks[(digest(source_path),job['original_check_sha256'])] = {
            'schema':'qcp-spectest-certificate-report/v1', 'stages':copy.deepcopy(replay['stages'])}
    resource_capsule = {'schema':'singleton-remeasurement-resources/v1','records':resources}
    capsule_bytes = encoded(resource_capsule, compact=True)
    resource_ref = pub.put(BASE/'evidence/itp/objects'/hashlib.sha256(capsule_bytes).hexdigest()/'remeasurement-resources.json',capsule_bytes)
    per_execution, current_receipts, all_receipts = [], [], []
    touched, baseline_checks, original_tokens, original_models = set(),0,0,0
    for row in baseline['runs']:
        if not row.get('itp_receipt'):
            continue
        active_path = ROOT/row['itp_receipt']['path']
        need(digest(active_path) == row['itp_receipt']['sha256'], 'Original proof receipt changed')
        active = load(active_path)
        context_refs = active.get('legacy_cost_receipts',[]) + [row['itp_receipt']]
        models, checks, current_checks, new_checks = [], [], [], []
        for context_ref in context_refs:
            source_path = ROOT/context_ref['path']
            need(digest(source_path) == context_ref['sha256'], 'Original context cost receipt changed')
            source = load(source_path)
            models.extend(source['model_attempts'])
            for check in source['checks']:
                key = (context_ref['sha256'],canonical_sha(check))
                checks.append(check)
                if key in replacement_checks:
                    fresh = replacement_checks[key]
                    current_checks.append(fresh); new_checks.append(fresh); touched.add(key)
                else:
                    current_checks.append(check)
        current_metrics = selected_metrics(models,current_checks)
        all_metrics = selected_metrics(models,checks+new_checks)
        need(current_metrics['total']['resource_metrics_complete'] is True, 'Selected current costs still incomplete')
        original_tokens += active['metrics']['agent']['tokens']; original_models += active['metrics']['agent']['model_calls']
        baseline_checks += len(checks)
        per_execution.append({'execution_index':active['execution_index'], 'current_metrics':current_metrics,
            'all_incurred_metrics':all_metrics})
        current_receipts.append({'metrics':current_metrics,'resource_metrics_complete':True,'missing_measurements':[],
            'strategy':active['strategy'],'spatial_smt':active['spatial_smt']})
        all_receipts.append({'metrics':all_metrics,'resource_metrics_complete':all_metrics['total']['resource_metrics_complete'],
            'missing_measurements':[g for g in gaps if g['execution_index']==active['execution_index']]})
    need(len(per_execution)==14 and len(touched)==3 and baseline_checks==26 and original_models==23 and original_tokens==2215390,
         'Baseline task/call/check/token inventory changed')
    current_stats, all_stats = aggregate_itp(current_receipts), aggregate_itp(all_receipts)
    need(current_stats['check_attempts']==26 and all_stats['check_attempts']==29 and
         current_stats['stages']['total']['tokens_total']==all_stats['stages']['total']['tokens_total']==2215390,
         'Remeasurement duplicates models or checks')
    current_work = group_workload(baseline['runs'],current_receipts,baseline['group_shared_setup'])
    all_work = group_workload(baseline['runs'],all_receipts,baseline['group_shared_setup'])
    profile = {'schema':SCHEMA,'group':GROUP,'completion_basis':'current whole-check measurement selection; historical observations never backfilled',
        'baseline_snapshot':snapshot_ref, 'baseline_publications':[{'target_path':path,'sha256':item['sha256']} for path,item in snapshot['documents'].items()],
        'baseline_evaluation':{'target_path':rel(CANONICAL),'sha256':snapshot['documents'][rel(CANONICAL)]['sha256']},
        'runner_plan':plan_ref,'measurement_artifacts':resource_ref,'replacements':replacements,
        'metrics':{'current':current_stats,'all_incurred':all_stats}, 'per_execution':per_execution,
        'workload':{'current':current_work,'all_incurred':all_work},
        'counters':{'case_pairs':7,'native_executions':28,'itp_executions':14,'model_calls':23,'tokens':2215390,
            'original_checks':26,'current_checks':26,'new_checks':3,'all_incurred_checks':29},
        'current_resource_metrics_complete':True,'historical_cumulative_resource_metrics_complete':False,
        'current_missing_measurements':[],'historical_missing_measurements':gaps,
        'scope':'Original 23 model calls and complete checks are retained. Three incomplete checks are replaced as whole invocations only in the current selected cost view. All-incurred includes every original and new check once; historical nine missing fields remain null. No new proof verdict or input is created.'}
    profile_ref=pub.json(PROFILE_PATH,profile,compact=True)
    evaluation=copy.deepcopy(baseline)
    evaluation.update(complete=True,resource_metrics_complete=True,current_resource_metrics_complete=True,
        historical_cumulative_resource_metrics_complete=False,measurement_profile=profile_ref,
        completion_basis=SCHEMA,missing_measurements=[],historical_missing_measurements=gaps,
        tespec_group_workload=current_work,historical_all_incurred_workload=all_work)
    evaluation_ref=pub.json(CANONICAL,evaluation,compact=True)
    latest={'evidence':evaluation_ref['path'],'sha256':evaluation_ref['sha256'],'case_pairs':7,'executions':28,
        'complete':True,'verdict_complete':True,'resource_metrics_complete':True,'measurement_profile':profile_ref,
        'historical_cumulative_resource_metrics_complete':False,'pending_itp_executions':0,'completed_independent_itp_executions':14}
    stats=original(BASE/'tespec/statistics.json')
    stats.update(complete=True,resource_metrics_complete=True,current_resource_metrics_complete=True,
        historical_cumulative_resource_metrics_complete=False,measurement_profile=profile_ref,missing_measurements=[],
        historical_missing_measurements=gaps,itp_statistics=current_stats,all_incurred_itp_statistics=all_stats,
        tespec_group_workload=current_work,historical_all_incurred_workload=all_work,latest_native_recheck=latest,
        metric_scope='复用同证明的分阶段重测口径；原模型费用与完整检查保留，3个缺测check整项替换。全部实际历史费用另列，旧缺失不回填。')
    for key,mode in stats['modes'].items():
        matching=[r for r in current_receipts if r['strategy']==mode['execution_strategy'] and r['spatial_smt']==mode['spatial_smt']]
        if matching:mode['itp']=aggregate_itp(matching)
    pub.json(BASE/'tespec/statistics.json',stats)
    results=original(BASE/'tespec/results.json')
    results.update(evidence=evaluation_ref['path'],evidence_sha256=evaluation_ref['sha256'],latest_native_recheck=latest,measurement_profile=profile_ref)
    results['summary'].update(complete=True,resource_metrics_complete=True,current_resource_metrics_complete=True,historical_cumulative_resource_metrics_complete=False)
    pub.json(BASE/'tespec/results.json',results)
    table=original(BASE/'result-cost.json')
    labels={'agent':'agent 填写证明','coq_compile_and_assumption_audit':'Coq 编译与假设审计','independent_kernel_check':'独立内核检查','total':'ITP 平均合计'}
    for stage,label in labels.items():
        matches=[row for row in table['costs'] if row['tool']=='tespec inline ITP' and row['stage']==label]
        need(len(matches)==1,'Missing/ambiguous current ITP cost row')
        value=current_stats['stages'][stage]
        matches[0].update(wall_seconds=value['wall_seconds_mean'],peak_process_memory_mib=value['peak_process_memory_mib_mean'],
            tokens=value['tokens_mean'],status='MEASURED',unit='14次执行均值；复用同证明的分阶段重测口径',source=rel(BASE/'tespec/statistics.json'))
    table.update(complete=True,resource_metrics_complete=True,current_resource_metrics_complete=True,
        historical_cumulative_resource_metrics_complete=False,measurement_profile=profile_ref,completion_basis=SCHEMA,
        canonical_evaluation=evaluation_ref,latest_native_recheck=latest,missing_measurements=[],historical_missing_measurements=gaps,
        itp_statistics=current_stats,all_incurred_itp_statistics=all_stats,tespec_group_workload=current_work,
        historical_all_incurred_workload=all_work,coverage_gap=None,
        test_modes={'statistics':rel(BASE/'tespec/statistics.json'),'modes':stats['modes']},
        group_measured_work_wall_seconds=current_work['wall_seconds_total']+sum(c['wall_seconds'] for i,c in enumerate(table['costs'][:8]) if i!=5),
        group_known_work_wall_seconds_lower_bound=current_work['known_wall_seconds_lower_bound']+sum(c['wall_seconds'] for i,c in enumerate(table['costs'][:8]) if i!=5),
        group_measured_work_scope='Current whole-check selection across four tools; historical all-incurred costs are reported separately and retain missing values.')
    table['evaluation_notes'].append('本次采用 whole-check-remeasurement/v1：3个缺测检查按同Goal/Candidate/依赖整项实测，当前成本齐全；历史累计仍有9项缺测，未用新数值冒充旧观测。新增模型调用/token均为0。')
    pub.json(BASE/'result-cost.json',table)
    pub.put(BASE/'result-cost.csv',csv_bytes(table['costs'],COST_FIELDS))
    md=['# Dbl_Linked_List__singleton：结果与成本表','','7对输入，inline/modular × 空间SMT OFF/ON共28种配置全部PASS；modular的14次原生PASS，inline的14次原生UNKNOWN均由独立ITP核证。',
        '', '**当前成本已齐全：复用同证明的分阶段重测口径。** 原23次模型调用与完整检查保留，3个缺测检查整项使用本次真实重放；新模型调用与token为0。',
        '历史累计另列：原26个check加本次3个，共29个实际check；原9项缺测仍保留，历史累计时间/RSS不能声称完整。当前选择仍为26个check，不增加测试分母。',
        '', '| 工具 | 阶段 | 时间（秒） | 峰值进程内存（MiB） | token | 口径 |','|---|---|---:|---:|---:|---|']
    def display(v):return '缺失' if v is None else f'{v:.4f}'
    for cost in table['costs']:
        md.append('| '+' | '.join([cost['tool'],cost['stage'],display(cost['wall_seconds']),display(cost['peak_process_memory_mib']),display(cost['tokens']),cost['unit']])+' |')
    md += ['',f"全部实际工作量的已测时间下界：{all_work['known_wall_seconds_lower_bound']:.6f} 秒；历史总量未知，RSS峰值不以重跑倒填。",'',
        'QCP全称证书仅属于旧抽象地址上下文；当前teSpec证明属于显式ABI，未声称两者等价。',
        '', '[重测选择、全部实际成本与证据](evidence/resource-remeasurement.json) · [逐输入与证明](evidence/tespec-native.json)']
    pub.put(BASE/'result-cost.md','\n'.join(md)+'\n')
    index=original(BASE/'index.json')
    index.update(complete=True,resource_metrics_complete=True,current_resource_metrics_complete=True,
        historical_cumulative_resource_metrics_complete=False,measurement_profile=profile_ref,completion_basis=SCHEMA,
        canonical_evaluation=evaluation_ref,latest_native_recheck=latest,missing_measurements=[],historical_missing_measurements=gaps,
        coverage_gap=None,tespec_current_run_status='ALL_EXPECTED_MATCHED_CURRENT_REMEASUREMENT_COMPLETE')
    pub.json(BASE/'index.json',index)
    gap=original(BASE/'coverage-gap.json')
    gap.update(status='CURRENT_MEASUREMENT_COMPLETE_HISTORICAL_GAPS_RETAINED',complete=True,resource_metrics_complete=True,
        current_resource_metrics_complete=True,historical_cumulative_resource_metrics_complete=False,active_gap=False,
        measurement_profile=profile_ref,canonical_evaluation=evaluation_ref,latest_native_recheck=latest,
        missing_measurements=[],historical_missing_measurements=gaps)
    pub.json(BASE/'coverage-gap.json',gap)
    manifest=original(PROGRAM/'manifest.json')
    manifest.update(primary_selection_status='CN_COMPAT_VERIFIED_QCP_LEGACY_KERNEL_CHECKED_TESPEC_ABI_VERDICTS_CHECKED_CURRENT_REMEASUREMENT_COMPLETE',
        current_coverage_gap=None,measurement_profile=profile_ref,canonical_evaluation=evaluation_ref)
    manifest['evaluation_notes']=table['evaluation_notes']
    pub.json(PROGRAM/'manifest.json',manifest)
    update_globals(pub,evaluation_ref,profile_ref,gaps)
    need(not any(path.name.startswith('execution-') and '/evidence/itp/abi-context/' in str(path) for path in pub.files),
         'Remeasurement must not mutate original proof receipts')
    return pub,profile,evaluation,index


def update_globals(pub,evaluation_ref,profile_ref,gaps):
    path=ROOT/'benchmark/results/group-result-cost-index.json';data=load(path)
    target=next(g for g in data['groups'] if g['program_group']==GROUP)
    need(sum(bool(g['complete']) for g in data['groups'] if g['program_group']!=GROUP)==22,'Other completed groups changed')
    target.update(complete=True,verdict_complete=True,resource_metrics_complete=True,measurement_profile=profile_ref,
        historical_cumulative_resource_metrics_complete=False,canonical_evaluation=evaluation_ref,completion_basis=SCHEMA)
    data['complete_groups']=23
    data['current_completion_summary'].update(complete_groups=23,incomplete_groups=22,complete_group_case_pairs=908,
        last_evaluated_group=GROUP,last_group_resource_metrics_complete=True,last_group_evidence=evaluation_ref,
        last_group_missing_measurements=[],last_group_historical_missing_measurements=gaps,
        last_group_measurement_profile=profile_ref,last_group_historical_cumulative_resource_metrics_complete=False,
        current_instruction='Group 23 current remeasurement is complete. Await instruction for the next group; do not start group 24 in this publication.',
        next_group_pending_itp_executions=None,
        next_incomplete_group=next(g['program_group'] for g in data['groups'] if not g['complete']),
        scope='23 current four-tool measurement sets are complete; singleton uses explicitly disclosed whole-check remeasurement. Its historical all-incurred resource gaps remain preserved.')
    data['current_completion_summary'].pop('next_group_current_native_evidence',None)
    if 'next_group_context_transition' in data['current_completion_summary']:
        data['current_completion_summary']['last_group_context_transition']=data['current_completion_summary'].pop('next_group_context_transition')
    pub.json(path,data)
    mdpath=path.with_suffix('.md');text=mdpath.read_text();prefix=f'| [{GROUP}]({GROUP}/result-cost.md) | '
    lines=[line for line in text.splitlines() if line.startswith(prefix)];need(len(lines)==1,'Ambiguous global group row')
    pub.put(mdpath,text.replace(lines[0],prefix+'当前测量齐全；同证明分阶段重测 |'))
    path=ROOT/'benchmark/results/index.json';data=load(path)
    data.update(complete_current_groups=23,pending_current_groups=22,
        coverage='23/45 groups have complete current measurement profiles (908 input pairs); singleton historical all-incurred costs retain nine missing fields.')
    data['current_singleton_summary']={'evidence':evaluation_ref,'case_pairs':7,'executions':28,'complete':True,
        'verdict_complete':True,'resource_metrics_complete':True,'measurement_profile':profile_ref,'historical_cumulative_resource_metrics_complete':False}
    pub.json(path,data)
    path=ROOT/'benchmark/results/tespec-unexpected/index.json';data=load(path)
    target=data['current_group_rechecks'][GROUP]
    target.update(evidence=evaluation_ref['path'],sha256=evaluation_ref['sha256'],complete=True,resource_metrics_complete=True,
        measurement_profile=profile_ref,historical_cumulative_resource_metrics_complete=False,missing_measurements=[],historical_missing_measurements=gaps)
    pub.json(path,data)
    doc=ROOT/'docs/benchmark-evaluation-progress.md';text=doc.read_text()
    begin=text.index('## 当前汇总\n');end=text.index('| 组 | 配置／语言记录',begin)
    paragraph='''## 当前汇总

第23组 singleton 已完成用户要求的资源补测，继续使用 `gpt-6.1-sol` 的原23次模型证据；本次只重放证明检查，无新增模型调用，未启动下一组。

当前已归档完整 **23/45组，共908对“变体×输入”**，还有 **22组未完整**。完整表示当前测量口径的结果与证据收齐，不表示所有工具均符合预期：Fulminate 为896/908预期匹配，teSpec完整测试为908/908。singleton使用明确标识的同证明分阶段重测口径；其历史累计资源缺项仍保留。权威入口为[全局结果成本索引](../benchmark/results/group-result-cost-index.json)。

45组都曾扫描或尝试运行，不能据此称为45组完整。下文及夜间状态中的20组是2026-10-16截止时的历史计数；补齐array_load后为21组，再补齐const_example_lessgood后为22组，singleton新增7对输入后为当前23组。前22组没有在本次重跑，工程回归与正式组结果范围保持独立。

第23组 `Dbl_Linked_List__singleton` 的7个合法输入，在inline/modular × 空间SMT OFF/ON共28种配置下最终 **28 PASS、0 UNKNOWN**。modular的14次原生PASS；inline的14次原生UNKNOWN逐执行完成原始Dll蕴含和父VC的ITP、Coq编译与假设审计及完整独立内核检查，输入与预期未改。

CN与Fulminate复用匹配的既有证据，Fulminate为7/7；QCP原始4个全称VC的历史证书仍限于旧抽象地址上下文，不作为当前显式ABI谓词的全称证明。结果、成本和证据见[第23组结果成本表](../benchmark/results/Dbl_Linked_List__singleton/result-cost.md)。

<!-- singleton-current-itp-progress -->
当前成本采用 `whole-check-remeasurement/v1`，即“复用同证明的分阶段重测口径”：原23次模型调用、2,215,390 tokens与其他完整检查继续计入；3个缺测checker整项替换为本次真实完整重放的时间和RSS。当前选择仍为26个check、14个ITP执行任务，按14次任务展示均值，当前资源完整，可计入23个完整组。

全部实际发生的检查另记为29次：原26次加本次3次。历史的两次超时RSS缺失，以及一次文件系统中断留下的6个阶段墙钟、整次峰值缺失，仍为原9项null；历史累计时间/RSS不宣称完整，只保存已测下界。不会把新RSS配上旧300秒，也不会把重跑增加为新输入。6份原生报告补跑的1.588379秒仍保留；0.45秒ABI准备和5.01秒恢复准备各按组计一次。

[当前逐执行结果与证明](../benchmark/results/Dbl_Linked_List__singleton/evidence/tespec-native.json) · [当前选择与全部实际成本](../benchmark/results/Dbl_Linked_List__singleton/evidence/resource-remeasurement.json)。旧QCP抽象地址上下文与当前teSpec显式ABI上下文的等价性未获证明。
<!-- /singleton-current-itp-progress -->

'''
    text=text[:begin]+paragraph+text[end:]
    pub.put(doc,text)


def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--run-root',type=Path,required=True)
    parser.add_argument('--apply',action='store_true')
    args=parser.parse_args()
    pub,profile,evaluation,index=prepare(args.run_root.resolve())
    evidence=prepared_evidence_reader(pub)(ROOT,index['measurement_profile'])
    audit_canonical_group(GROUP,type(evidence)(ROOT),index)
    if args.apply:
        old=pub.apply()
        try:audit_canonical_group(GROUP,ROOT,index)
        except BaseException:pub.rollback(old);raise
    print(json.dumps({'preflight':'PASS','applied':args.apply,'files':len(pub.files),'current_resource_metrics_complete':True,
        'historical_cumulative_resource_metrics_complete':False,'complete_groups':23,'complete_group_case_pairs':908,
        'model_calls':23,'tokens':2215390,'current_checks':26,'all_incurred_checks':29}))


if __name__=='__main__':main()
