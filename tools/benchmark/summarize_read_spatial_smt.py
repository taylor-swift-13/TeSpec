#!/usr/bin/env python3
"""Audit read OFF/ON observations, replay SMT queries and publish matched costs."""
from pathlib import Path
import collections,csv,hashlib,io,json
from test_read_variants import ROOT,sha,save
from evidence_paths import evidence_path
OUT=ROOT/'benchmark/results/read/20261015-spatial-smt'
def main():
    import z3
    path=OUT/'results.json';r=json.loads(path.read_text());assert len(r['runs'])==61
    itp=json.loads((ROOT/'benchmark/results/read/20261015-itp-per-execution/receipt.json').read_text())
    proofs={(x['variant'],x['case']):x for x in itp['cases']}
    changed=[];csvrows=[];query_seconds=0;backend_seconds=0
    for row in r['runs']:
        assert sha(ROOT/row['source'])==row['source_sha256'] and sha(ROOT/row['binds'])==row['binds_sha256']
        assert row['off']['status']==row['historical_native_status'] and row['on']['status']==row['expected']
        key=row['variant'],row['case'];states={}
        for mode in ['off','on']:
            s=row[mode];assert sha(ROOT/s['report'])==s['report_sha256'];report=json.loads((ROOT/s['report']).read_text());case=report['results'][0];states[mode]=case
            assert case['status']==s['status'] and report['itp_vcs']==s['itp_vcs']
            assert json.loads((ROOT/s['stdout']).with_name('resources.json').read_text())==s['resources']
            assert s['wall_seconds']>0 and s['resources']['max_process_rss_kib']>0 and s['tokens']==0
            assert ('--spatial-smt' if mode=='on' else '--no-spatial-smt') in s['command']
            if s['goal']:assert sha(ROOT/s['goal'])==s['goal_sha256']
        assert row['off']['goal_sha256']==row['on']['goal_sha256']
        if row['off']['status']=='UNKNOWN':
            assert key in proofs and row['on']['status']=='FAIL'
            assert row['off']['goal_sha256']==proofs[key]['original_goal_sha256']
            info=states['on']['spatial_smt'];assert info['attempted']==1 and info['return_residual_coverage'] and not info['itp_required']
            assert row['on']['itp_vcs']==[] and info['certificate']=='NOT_CHECKED'
            raw=Path(states['on']['artifacts']['stdout']) if isinstance(states['on'].get('artifacts'),dict) and 'stdout' in states['on']['artifacts'] else None
            for item in info['results']:
                decision=json.loads(evidence_path(item['artifact']).read_text());query=evidence_path(decision['query'])
                assert decision['status']=='INVALID' and decision['solver_result']=='sat' and decision['antecedent_satisfiability']=='sat' and decision['vacuous'] is False
                assert sha(query)==decision['query_sha256'];solver=z3.Solver();solver.set(timeout=2000);solver.from_string(query.read_text());assert solver.check()==z3.sat
                heap=decision['countermodel']['heap'];assert len(heap)==4
                actual=bytes(x['byte'] for x in sorted(heap,key=lambda x:x['address']));assert actual==row['initial'].to_bytes(4,'big',signed=True)
                assert [x['address'] for x in sorted(heap,key=lambda x:x['address'])]==list(range(4096,4100))
                query_seconds+=decision['wall_seconds']
            backend_seconds+=info['wall_seconds'];changed.append(key)
        else:
            assert row['on']['status']==row['off']['status']
            assert states['on']['spatial_smt']['attempted']==0
        csvrows.append({'variant':row['variant'],'case':row['case'],'expected':row['expected'],'off_native':row['off']['status'],'on':row['on']['status'],'off_final_with_reused_itp':'FAIL' if row['off']['status']=='UNKNOWN' else row['off']['status'],'on_matches_expected':row['on_matches_expected'],'off_seconds':row['off']['wall_seconds'],'on_seconds':row['on']['wall_seconds'],'off_peak_rss_kib':row['off']['resources']['max_process_rss_kib'],'on_peak_rss_kib':row['on']['resources']['max_process_rss_kib']})
    assert len(changed)==12
    stats={'schema':'tespec-read-spatial-smt-comparison/v1','results_sha256':sha(path),'case_pairs':61,'modes':{},'smt_queries_replayed':12,'countermodels_checked':12,'agreement_with_existing_kernel_refutations':12,'correct_cases_regressed':0,'raw_classifications_unchanged':49,'smt_backend_wall_seconds_total':backend_seconds,'smt_solver_query_wall_seconds_total':query_seconds,'certificate':'NOT_CHECKED','model_calls_this_run':0,'tokens_this_run':0,'working_tree_feature_uncommitted':r['working_tree_feature_uncommitted']}
    for mode in ['off','on']:
        rr=[x[mode] for x in r['runs']];unknown=[x for x in r['runs'] if x[mode]['status']=='UNKNOWN'];total=sum(x['wall_seconds'] for x in rr)
        final=[('FAIL' if x[mode]['status']=='UNKNOWN' and (x['variant'],x['case']) in proofs else x[mode]['status']) for x in r['runs']]
        s={'native_status_counts':dict(collections.Counter(x['status'] for x in rr)),'final_status_counts':dict(collections.Counter(final)),
            'expected_matches':sum(status==x['expected'] for status,x in zip(final,r['runs'])),'execution_wall_seconds_total':total,'mean_execution_wall_seconds':total/61,
            'maximum_execution_peak_rss_mib':max(x['resources']['max_process_rss_kib'] for x in rr)/1024,'mean_execution_peak_rss_mib':sum(x['resources']['max_process_rss_kib'] for x in rr)/61/1024,
            'executions_requiring_itp_for_verdict':len(unknown),'residual_itp_groups_in_native_inventory':sum(len(x['itp_vcs']) for x in rr),
            'itp_source':'benchmark/results/read/20261015-itp-per-execution/receipt.json' if mode=='off' else None,
            'itp_wall_seconds_counted':itp['metrics']['total_itp_wall_seconds'] if mode=='off' else 0,
            'mean_itp_seconds_when_required':itp['metrics']['total_itp_wall_seconds']/12 if mode=='off' else None,
            'itp_tokens_counted':itp['metrics']['token_usage']['total_tokens'] if mode=='off' else 0,
            'tokens_newly_consumed':0,'model_calls_newly_executed':0}
        s['complete_measured_stage_seconds']=total+s['itp_wall_seconds_counted'];s['mean_complete_seconds_per_test']=s['complete_measured_stage_seconds']/61
        stats['modes'][mode]=s
    stats['inventory_note']='20 already-FAIL numeric cases retain raw residual groups in both modes; decisive INVALID obligations already determine FAIL. This inventory is not the number of unresolved test verdicts. The 12 former UNKNOWN groups have empty ITP scheduling lists in ON mode.'
    save(OUT/'statistics.json',stats)
    b=io.StringIO();w=csv.DictWriter(b,fieldnames=list(csvrows[0]),lineterminator='\n');w.writeheader();w.writerows(csvrows);(OUT/'cases.csv').write_text(b.getvalue())
    a=stats['modes']['off'];b=stats['modes']['on']
    text=f"""# read：spatial SMT 模式对照

相同的 61 对输入分别运行显式关闭与开启模式，共 122 次新执行。OFF 复现历史分类；ON 将 12 个 UNKNOWN 全部变为 FAIL，其他 49 条分类不变。最终两种完整流程均为 22 PASS、32 FAIL、7 个预期 ERROR，61/61 符合预期；OFF 的 12 次 ITP 使用目标哈希匹配的已有逐次证据，ON 无需额外 ITP 判定测试结果。

| 项目 | OFF | ON |
|---|---:|---:|
| 原生结果 PASS / FAIL / UNKNOWN / ERROR | 22 / 20 / 12 / 7 | 22 / 32 / 0 / 7 |
| 执行阶段每次平均时间（秒） | {a['mean_execution_wall_seconds']:.6f} | {b['mean_execution_wall_seconds']:.6f} |
| 执行阶段平均单次峰值 RSS（MiB） | {a['mean_execution_peak_rss_mib']:.4f} | {b['mean_execution_peak_rss_mib']:.4f} |
| 执行阶段最大峰值 RSS（MiB） | {a['maximum_execution_peak_rss_mib']:.4f} | {b['maximum_execution_peak_rss_mib']:.4f} |
| 需 ITP 判定的测试执行数 | 12 | 0 |
| 所需 ITP 的平均时间（秒） | {a['mean_itp_seconds_when_required']:.4f}（复用实测） | —（无需） |
| 本次新消耗 token | 0 | 0 |

OFF 的完整成本仍包括复用的 ITP token，不能将“本次未调用模型”写成历史 ITP 免费。原始分阶段成本见已有 tespec 统计及本目录 statistics.json。ON 的判定只使用 SMT，新增 ITP 时间与 token 均为 0。

12 条查询均保存 SMT-LIB 和 SAT 反例堆，已重放确认 SAT，并逐条核对四字节整数反例及原始 VC 哈希；结论与已有 Coq 内核反证一致。SMT 结果的 certificate 保持 NOT_CHECKED，不冒充新生成的 Coq 证书。查询预算每条 2000 ms；Z3 {r['z3_version']}。

20 条本来已 FAIL 的数值错误用例仍保留 residual ITP 清单，属于原始义务记录；已有决定性 INVALID 足以判 FAIL，不需要为判定测试结果继续证明其余义务。ON 消解的 12 条 UNKNOWN 其待处理 ITP 组均为空。

本次测试使用当前工作区的 spatial-smt 功能，相关实现尚未提交；results.json 保存精确模块哈希和起始 Git revision，不把它伪称为仅由该 revision 即可复现的功能。两次模式调用的顺序固定为 OFF 后 ON，仅一轮测量，细小时间差不用于宣称执行阶段加速。

原始结果见 [results.json](results.json)，指标见 [statistics.json](statistics.json)，逐例对照见 [cases.csv](cases.csv)。
"""
    (OUT/'comparison.md').write_text(text)
    print('PASS: 61 matched OFF/ON cases; 12 SAT queries and concrete countermodels replayed; exact Coq VC agreement; 49 unchanged cases; resources and scheduling checked.',flush=True)
    print(json.dumps(stats,ensure_ascii=False),flush=True)
if __name__=='__main__':main()
