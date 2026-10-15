#!/usr/bin/env python3
"""Publish a result/cost table for every group, preserving explicit missing measurements."""
from pathlib import Path
import csv, io, json
ROOT=Path(__file__).resolve().parents[2]
OUT=ROOT/'benchmark/results'
TOOLS=['cn','qcp','fulminate','tespec']
def read(p): return json.loads(p.read_text())
def save(p,j): p.parent.mkdir(parents=True,exist_ok=True);p.write_text(json.dumps(j,ensure_ascii=False,indent=2)+'\n')
def main():
    index=[]
    for manifest in sorted((ROOT/'benchmark/programs').glob('*/manifest.json')):
        group=read(manifest);name=group['program_group'];folder=OUT/name
        entries=group.get('tool_results',{});results=[];costs=[]
        for tool in TOOLS:
            entry=entries.get(tool,{})
            rp=ROOT/entry['results'] if entry.get('results') else folder/tool/'results.json'
            sp=ROOT/entry['statistics'] if entry.get('statistics') else folder/tool/'statistics.json'
            available=rp.is_file() and sp.is_file()
            stat=read(sp) if available else {}
            result=read(rp) if available else {}
            summary=result.get('summary',{})
            count=summary.get('case_pairs',summary.get('final_total'))
            correct=summary.get('correct',summary.get('final_correct'))
            results.append({'tool':tool,'scope':'主程序全称验证一次' if tool in ['cn','qcp'] else '各变体的有限测试',
                'result':result.get('verdict') or (str(correct)+'/'+str(count) if count is not None and correct is not None else 'PENDING'),
                'test_pairs':count,'expected_matches':correct,'available':available,
                'result_source':rp.relative_to(ROOT).as_posix() if available else None,
                'statistics_source':sp.relative_to(ROOT).as_posix() if available else None})
            def add(stage,seconds=None,memory=None,tokens=None,unit='已测工作总量',estimate=False):
                costs.append({'tool':tool,'stage':stage,'unit':unit,'wall_seconds':seconds,'peak_process_memory_mib':memory,
                    'tokens':tokens,'estimated':estimate,'status':'MEASURED' if seconds is not None and memory is not None and tokens is not None else 'PENDING',
                    'source':sp.relative_to(ROOT).as_posix() if available else None})
            if tool=='cn':
                add('主程序验证',stat.get('wall_seconds'),stat.get('peak_process_resident_mib'),stat.get('tokens'),'一次主程序验证')
            elif tool=='fulminate':
                add('插桩、编译与首次执行',stat.get('instrument_compile_initial_execution_wall_seconds_total'),stat.get('pipeline_peak_process_rss_kib',0)/1024 if available else None,stat.get('tokens'))
                add('单独运行测试',stat.get('test_execution_wall_seconds_total'),stat.get('test_peak_process_rss_kib',0)/1024 if available else None,stat.get('tokens'))
            else:
                stages=stat.get('stages',[]);native=stages[0] if stages else {}
                add('VC 生成与自动处理' if tool=='qcp' else '测试执行、VC 生成与自动处理',native.get('wall_seconds'),native.get('peak_process_memory_mib'),native.get('total_tokens'))
                meanpath=folder/tool/'itp-average.json'
                avg=read(meanpath) if meanpath.is_file() else None
                for sid,label,mkey in [('agent_proof_filling','agent 填写证明','mean_agent_proof_filling_seconds'),('coq_compilation_and_assumption_audit','Coq 编译与假设审计','mean_coq_compile_audit_seconds'),('independent_kernel_check','独立内核检查','mean_independent_kernel_check_seconds')]:
                    stage=next((x for x in stages if x['stage']==sid),{})
                    seconds=avg[mkey] if avg else stage.get('wall_seconds')
                    tokens=avg['mean_total_tokens'] if avg and sid=='agent_proof_filling' else stage.get('total_tokens')
                    add(label,seconds,avg.get('process_memory',{}).get(sid,{}).get('mean_per_execution_peak_mib',stage.get('peak_process_memory_mib')) if avg else stage.get('peak_process_memory_mib'),tokens,'每次需 ITP 的执行均值；内存为各次峰值均值' if avg and not avg.get('estimated',True) else '每次需 ITP 的执行均值；内存为批次峰值' if avg else '一次主程序验证' if tool=='qcp' else 'PENDING_PER_EXECUTION_MEAN',bool(avg and avg.get('estimated',True)))
                    if avg:costs[-1]['source']=meanpath.relative_to(ROOT).as_posix()
                    if stage.get('required') is False:
                        costs[-1].update(wall_seconds=0,peak_process_memory_mib=None,tokens=0,status='NOT_REQUIRED',unit='本批无需该阶段，总成本为 0；均值不适用')
                itprows=costs[-3:]
                measured=all(x['status']=='MEASURED' for x in itprows)
                add('ITP 平均合计',sum(x['wall_seconds'] for x in itprows) if measured else None,
                    avg.get('process_memory',{}).get('itp',{}).get('mean_per_execution_peak_mib',max(x['peak_process_memory_mib'] for x in itprows)) if measured and avg else max(x['peak_process_memory_mib'] for x in itprows) if measured else None,
                    sum(x['tokens'] for x in itprows) if measured else None,
                    '每次需 ITP 的执行均值；内存为各次峰值均值' if avg and not avg.get('estimated',True) else '每次需 ITP 的执行均值；内存为批次峰值' if avg else '一次主程序验证' if tool=='qcp' else 'PENDING_PER_EXECUTION_MEAN',bool(avg and avg.get('estimated',True)))
                if all(x['status']=='NOT_REQUIRED' for x in itprows):
                    costs[-1].update(wall_seconds=0,peak_process_memory_mib=None,tokens=0,status='NOT_REQUIRED',unit='本批无需 ITP，总成本为 0；均值不适用')
        mode_stats_path=ROOT/group['test_modes_statistics'] if group.get('test_modes_statistics') else folder/'20261015-spatial-smt/statistics.json'
        test_modes=None
        if mode_stats_path.is_file():
            test_modes=read(mode_stats_path)
            on=test_modes['modes']['on']
            costs.append({'tool':'tespec --spatial-smt','stage':'测试执行、VC 生成与空间 SMT','unit':'每次测试执行均值；内存为逐次峰值均值','wall_seconds':on['mean_execution_wall_seconds'],'peak_process_memory_mib':on['mean_execution_peak_rss_mib'],'tokens':0,'estimated':False,'status':'MEASURED','source':mode_stats_path.relative_to(ROOT).as_posix()})
            if on['executions_requiring_itp_for_verdict']==0:
                costs.append({'tool':'tespec --spatial-smt','stage':'ITP（无需）','unit':'本批无需额外 ITP，总成本为 0；均值不适用','wall_seconds':0,'peak_process_memory_mib':None,'tokens':0,'estimated':False,'status':'NOT_REQUIRED','source':mode_stats_path.relative_to(ROOT).as_posix()})
        complete=all(x['available'] and x['result']!='PENDING' for x in results) and all(x['status'] in ['MEASURED','NOT_REQUIRED'] for x in costs) and next(x['result'] for x in results if x['tool']=='cn')=='VERIFIED' and next(x['result'] for x in results if x['tool']=='qcp').startswith('VERIFIED_KERNEL_CHECKED')
        report={'schema':'tespec-group-result-cost/v1','program_group':name,'primary_variant':group.get('primary_variant'),
            'variant_language_records':len(group['variants']),'complete':complete,
            'results':results,'costs':costs,'evidence_catalog':group['evidence_catalog'],
            'missing_policy':'PENDING/null means not published or not bound to matching evidence; never replace missing data with zero. Existing historical evidence must be reused after hash/scope checks.',
            'itp_policy':'One test execution and all its unresolved VCs form one ITP unit; display mean costs only. read uses 12 independently measured execution ITP tasks; legacy batch estimates are historical. Memory is a measured process peak and is never divided. ITP subtotal overlaps its component rows and must not be added again.'}
        if group.get('current_coverage_gap'):
            report['coverage_gap']=group['current_coverage_gap']
        if test_modes:
            report['test_modes']={'comparison':(mode_stats_path.parent/'comparison.md').relative_to(ROOT).as_posix(),'statistics':mode_stats_path.relative_to(ROOT).as_posix(),'modes':test_modes['modes'],'certificate':'SMT decisions are NOT_CHECKED by Coq; matching historical refutations are separate evidence.'}
        save(folder/'result-cost.json',report)
        buf=io.StringIO();writer=csv.DictWriter(buf,fieldnames=list(costs[0]),lineterminator='\n');writer.writeheader();writer.writerows(costs);(folder/'result-cost.csv').write_text(buf.getvalue())
        text=f"# {name}：结果与成本表\n\n完整状态：{'已齐全' if complete else '待补齐'}。语言版本记录 {len(group['variants'])} 条；主程序：{group.get('primary_variant') or '待绑定已有验证证据'}。\n\n"
        if group.get('current_coverage_gap'):
            text+='本组尚未完成；已测失败尝试和未运行阶段分别保留，见 [覆盖缺口](coverage-gap.json)。\n\n'
        text+='| 工具 | 范围 | 结果／预期匹配 | 测试对数 |\n|---|---|---|---:|\n'
        for x in results:text+=f"| {x['tool']} | {x['scope']} | {x['result']} | {x['test_pairs'] if x['test_pairs'] is not None else '—'} |\n"
        text+='\n| 工具 | 阶段 | 时间（秒） | 峰值进程内存（MiB） | token | 口径 |\n|---|---|---:|---:|---:|---|\n'
        def fmt(v):return '待补齐' if v is None else f'{v:.4f}'
        for x in costs:text+=f"| {x['tool']} | {x['stage']} | {fmt(x['wall_seconds'])} | {('—' if x['status']=='NOT_REQUIRED' else fmt(x['peak_process_memory_mib']))} | {fmt(x['tokens'])} | {x['unit']}{'（均摊估算）' if x['estimated'] else ''} |\n"
        text+='\nITP 以一次测试执行的所有待处理 VC 为单位，只展示平均开销；read 的 12 次所需 ITP 各自独立测量后取平均。内存不将总峰值除以次数；read ITP 展示逐次实测峰值的平均值。ITP 合计行与其三个分项重叠，不能再次相加。CN/QCP 与两种测试工具的对象和次数不同。\n\n缺测记为待补齐，不表示已有历史证据作废；须绑定匹配证据后发布。原始证据、计量来源与缺项见 [result-cost.json](result-cost.json)，成本 CSV 见 [result-cost.csv](result-cost.csv)。\n'
        if test_modes:
            off=test_modes['modes']['off'];on=test_modes['modes']['on']
            text+='\n## teSpec 空间 SMT 模式\n\n| 项目 | 关闭 | 开启 |\n|---|---:|---:|\n'
            text+=f"| 原生 PASS / FAIL / UNKNOWN / ERROR | {' / '.join(str(off['native_status_counts'].get(k,0)) for k in ['PASS','FAIL','UNKNOWN','ERROR'])} | {' / '.join(str(on['native_status_counts'].get(k,0)) for k in ['PASS','FAIL','UNKNOWN','ERROR'])} |\n| 最终预期匹配（含所需 ITP） | {off['expected_matches']}/{test_modes['case_pairs']} | {on['expected_matches']}/{test_modes['case_pairs']} |\n| 每次执行平均时间（秒） | {off['mean_execution_wall_seconds']:.6f} | {on['mean_execution_wall_seconds']:.6f} |\n| 平均单次峰值 RSS（MiB） | {off['mean_execution_peak_rss_mib']:.4f} | {on['mean_execution_peak_rss_mib']:.4f} |\n| 需 ITP 判定的执行数 | {off['executions_requiring_itp_for_verdict']} | {on['executions_requiring_itp_for_verdict']} |\n"
            text+=f"\n模式逐次结果、成本和证书范围见 [模式对照]({mode_stats_path.parent.name}/comparison.md)。无需 ITP 时成本记 0，均值和峰值不适用。SMT 决策不作为 Coq 证书。\n"
        (folder/'result-cost.md').write_text(text)
        index.append({'program_group':name,'complete':complete,'report':(folder/'result-cost.md').relative_to(ROOT).as_posix(),'json':(folder/'result-cost.json').relative_to(ROOT).as_posix(),'csv':(folder/'result-cost.csv').relative_to(ROOT).as_posix()})
    save(OUT/'group-result-cost-index.json',{'groups':index,'groups_total':len(index),'complete_groups':sum(x['complete'] for x in index)})
    (OUT/'group-result-cost-index.md').write_text('# 各程序组结果与成本表\n\n| 程序组 | 完整状态 |\n|---|---|\n'+''.join(f"| [{x['program_group']}]({x['program_group']}/result-cost.md) | {'已齐全' if x['complete'] else '待补齐'} |\n" for x in index))
    print(f"Published {len(index)} group result/cost tables; {sum(x['complete'] for x in index)} complete, {sum(not x['complete'] for x in index)} explicitly pending.")
if __name__=='__main__':main()
