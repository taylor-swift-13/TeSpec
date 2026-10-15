#!/usr/bin/env python3
"""Audit every current teSpec expectation mismatch without altering verdicts."""
from pathlib import Path
import collections,csv,hashlib,io,json
from test_read_variants import ROOT,sha,save
from evidence_paths import evidence_path
OUT=ROOT/'benchmark/results/tespec-unexpected'
def rel(p):return str(p.relative_to(ROOT))
def read(p):return json.loads(p.read_text())
def reproduction(command,issue):
    cmd=[x.replace('/home/yangfp/teSpec-benchmark-tespec','/home/yangfp/teSpec') for x in command]
    if '--output-dir' in cmd:cmd[cmd.index('--output-dir')+1]='/tmp/tespec-reproduce-'+issue
    return cmd

def make_issue(group,row,mode,measurement,final=None,itp=None):
    actual=measurement.get('status') or (measurement.get('statuses') or ['ERROR'])[0];final=final or actual;expected=row.get('expected',row.get('expected_result'))
    if actual==expected and final==expected:return None
    key=json.dumps([group,row['variant'],row['case'],mode,row.get('qcp_source_sha256'),row.get('binds_sha256')],sort_keys=True);issue=hashlib.sha256(key.encode()).hexdigest()[:20]
    p=evidence_path(measurement['report']) if measurement.get('report') else None;report=read(p) if p and p.exists() else {};case=(report.get('results') or [{}])[0]
    assert case.get('status',actual)==actual, 'Aggregate/raw automatic status mismatch: '+issue
    classification='RESOLVED_AUTOMATIC_GAP' if final==expected else 'UNRESOLVED_UNKNOWN' if actual=='UNKNOWN' else 'UNEXPECTED_ACCEPTANCE' if actual=='PASS' else 'UNEXPECTED_REJECTION' if actual=='FAIL' else 'UNEXPECTED_EXECUTOR_ERROR'
    vc=[]
    if p and p.exists():
        for goal in sorted(p.parent.rglob('*_goal.v')):vc.append({'path':rel(goal),'sha256':sha(goal)})
    return {'id':issue,'group':group,'variant':row['variant'],'paired_qcp_variant':row.get('paired_qcp_variant'),'case':row['case'],'input':row.get('initial'),'mode':mode,'expected':expected,'automatic_status':actual,'final_status':final,'final_matches_expected':final==expected,'classification':classification,'triage_status':'RESOLVED' if final==expected else 'NEEDS_TRIAGE','reason':case.get('reason'),'executor_error':case.get('executor_error'),'source':report.get('source'),'source_sha256':report.get('provenance',{}).get('source_sha256',row.get('qcp_source_sha256')),'binds':row.get('binds'),'binds_sha256':row.get('binds_sha256'),'report':rel(p) if p and p.exists() else measurement.get('report'),'report_sha256':sha(p) if p and p.exists() else None,'stdout':measurement.get('stdout'),'stderr':measurement.get('stderr'),'original_command':measurement.get('command'),'reproduction_command':reproduction(measurement.get('command',[]),issue),'vc_artifacts':vc,'vc_artifacts_status':'PRESENT' if vc else 'NOT_GENERATED_OR_UNAVAILABLE','residual_vcs':case.get('residual_vcs'),'itp':itp or {'status':'NOT_PERFORMED'},'mode_comparison_statistics':f'benchmark/results/{group}/20261016-evaluation/statistics.json' if group!='read' else 'benchmark/results/read/20261015-spatial-smt/statistics.json','policy':'Expected result is independently reviewed; preserve original automatic classification. UNKNOWN and unexpected ERROR are not successful detection. Final ITP verdict recorded separately.'}

def collect():
    issues=[];coverage=[]
    for path in sorted((ROOT/'benchmark/results').glob('*/20261016-evaluation/results.json')):
        data=read(path);group=data['program_group'];runs=data['runs'];coverage.append({'group':group,'input_pairs_scanned':len(runs),'execution_modes':['off','on'],'report':rel(path),'report_sha256':sha(path)})
        finalpath=path.parent.parent/'tespec/results.json';finals={}
        if finalpath.exists():
            for r in read(finalpath).get('cases',[]):finals[(r['variant'],r['case'])]=r
        for row in runs:
            for mode in ['off','on']:
                if 'tespec_'+mode not in row:continue
                final=finals.get((row['variant'],row['case']),{}).get('actual') if mode=='off' else None
                issue=make_issue(group,row,mode,row['tespec_'+mode],final)
                if issue:issues.append(issue)
    old=ROOT/'benchmark/results/read/complete/results.json'
    if old.exists():
        data=read(old);coverage.append({'group':'read','input_pairs_scanned':len(data['cases']),'execution_modes':['official OFF + independently checked ITP; ON comparison referenced'],'report':rel(old),'report_sha256':sha(old)})
        for row in data['cases']:
            issue=make_issue('read',row,'off',row['execution_stage'],row['final_result'],row['itp_stage'])
            if issue:issues.append(issue)
    triage=OUT/'triage.json';manual=read(triage) if triage.exists() else {}
    for issue in issues:
        if issue['id'] in manual:issue['review']=manual[issue['id']]
        save(OUT/'cases'/(issue['id']+'.json'),issue)
    counts=collections.Counter(i['classification'] for i in issues);open_issues=[i for i in issues if not i['final_matches_expected']]
    report={'schema':'tespec-unexpected-ledger/v1','coverage':coverage,'scanned_groups':len(coverage),'scanned_input_pairs':sum(c['input_pairs_scanned'] for c in coverage),'open_final_mismatches':len(open_issues),'resolved_automatic_gaps':sum(i['final_matches_expected'] for i in issues),'classification_counts':dict(counts),'issues':issues,'not_scanned_policy':'Groups not yet evaluated are absent, not counted as zero errors. Diagnostic excluded runs are not official evaluations. Error expected by an explicit per-input oracle is not an unexpected result.'};save(OUT/'index.json',report)
    buf=io.StringIO();fields=['id','group','variant','case','mode','expected','automatic_status','final_status','classification','triage_status','report'];w=csv.DictWriter(buf,fieldnames=fields);w.writeheader();w.writerows({k:r[k] for k in fields} for r in issues);(OUT/'index.csv').write_text(buf.getvalue())
    text=f'# teSpec 不符合预期的专项台账\n\n已扫描 {len(coverage)} 组、{report["scanned_input_pairs"]} 对变体与输入。最终不匹配 **{len(open_issues)}** 条；自动阶段缺口经独立 ITP 解决 **{report["resolved_automatic_gaps"]}** 条。未评测组不计为零异常。原始分类不改写，人工分析追加到 triage.json，重建不覆盖人工结论。\n\n| 组 | 变体 | 输入 | 模式 | 预期 | 自动 | 最终 | 分类 | 证据 |\n|---|---|---|---|---|---|---|---|---|\n'
    for r in issues:text+=f'| {r["group"]} | {r["variant"]} | {r["case"]} | {r["mode"]} | {r["expected"]} | {r["automatic_status"]} | {r["final_status"]} | {r["classification"]} | [详情](cases/{r["id"]}.json) |\n'
    text+='\n每条详情包含原始／最终状态、模式对照引用、输入、复现命令（写入独立 /tmp 目录）、原始日志、源码与 VC 哈希、ITP 结论和分类。read 的 12 条为旧自动阶段 UNKNOWN，经逐执行 Coq 反证完成；不是 12 个尚未解决的最终错误。开启空间 SMT 的逐例证据另见 read 模式对照。\n';(OUT/'README.md').write_text(text);print(f'teSpec ledger: {len(coverage)} groups, {len(open_issues)} open final mismatches, {report["resolved_automatic_gaps"]} resolved automatic gaps',flush=True);return report
if __name__=='__main__':collect()
