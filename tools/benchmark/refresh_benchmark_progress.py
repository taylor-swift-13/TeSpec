#!/usr/bin/env python3
"""Refresh current group coverage and overnight handoff from published tables."""
from pathlib import Path
import argparse,json
from test_read_variants import ROOT,save

def refresh():
    path=ROOT/'benchmark/results/group-result-cost-index.json';index=json.loads(path.read_text());done=[r['program_group'] for r in index['groups'] if r['complete']];pending=sorted([r['program_group'] for r in index['groups'] if not r['complete']],key=str.casefold)
    rootpath=ROOT/'benchmark/results/index.json';root=json.loads(rootpath.read_text());root['current_groups']=[{'group':g,'index':f'benchmark/results/{g}/index.json'} for g in done];root['complete_current_groups']=len(done);root['pending_current_groups']=len(pending);root['coverage']=f'{len(done)}/45 groups have complete current result/cost tables. Remaining {len(pending)} retain historical evidence and explicit current gaps.';root['tespec_unexpected_ledger']='benchmark/results/tespec-unexpected/index.json';save(rootpath,root)
    statepath=ROOT/'benchmark/results/nightly-20261016/status.json'
    if statepath.exists():
        state=json.loads(statepath.read_text());state['complete_groups']=done;state['pending_groups']=pending
        if state.get('current_group') in done:
            deferred=state.get('deferred_groups',{});ready=[g for g in pending if g not in deferred];state['current_group']=ready[0] if ready else None;state['current_stage']='READY_FOR_NEXT_GROUP' if ready else 'ALL_COMPLETE' if not pending else 'DEFERRED_GAPS_REMAIN';state['current_process_session']=None
        save(statepath,state)
        ledgerpath=ROOT/'benchmark/results/tespec-unexpected/index.json';ledger=json.loads(ledgerpath.read_text()) if ledgerpath.exists() else {}
        text=f'# 夜间评测进度\n\n完整组 {len(done)}/45；待补齐 {len(pending)}。截止北京时间 2026-10-16 08:00。\n\n当前组：{state.get("current_group") or "无"}；阶段：{state.get("current_stage")}。\n\nteSpec 最终不匹配 {ledger.get("open_final_mismatches","未扫描")} 条，已解决自动阶段缺口 {ledger.get("resolved_automatic_gaps","未扫描")} 条。详情见 ../tespec-unexpected/README.md；未评测组不算零异常。\n\n| 程序组 | 状态 | 结果成本表 |\n|---|---|---|\n'
        for r in index['groups']:text+=f'| {r["program_group"]} | {"完整" if r["complete"] else "待补齐"} | [表](../{r["program_group"]}/result-cost.md) |\n'
        (statepath.parent/'progress.md').write_text(text)
    print(f'Current completion {len(done)}/45, pending {len(pending)}',flush=True)
if __name__=='__main__':refresh()
