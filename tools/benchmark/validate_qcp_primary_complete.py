#!/usr/bin/env python3
"""Audit full universal QCP verification evidence and resource accounting."""
from pathlib import Path
import hashlib,json,math,re

ROOT=Path(__file__).resolve().parents[2]
OUT=ROOT/'benchmark/results/read/20261015-qcp-verify-complete'
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()

def main():
    r=json.loads((OUT/'receipt.json').read_text());m=r['metrics'];model=r['model']
    assert r['status']=='VERIFIED_KERNEL_CHECKED' and r['kernel_check']['exit_code']==0
    assert sha(ROOT/r['original_goal'])==r['original_goal_sha256']==sha(ROOT/r['goal'])
    assert sha(ROOT/r['proof'])==r['proof_sha256']==model['candidate_sha256']
    text=(ROOT/r['proof']).read_text();assert not re.search(r'\b(?:Admitted|admit|Axiom|Parameter)\b',text)
    assert 'Module PrimaryReadCertificate : PrimaryQcpGoal.VC_Correct.' in text
    assert (ROOT/r['compilation'][-1]['stdout']).read_text().strip()=='Closed under the global context'
    events=json.loads((OUT/'usage-events.json').read_text());assert [e['usage'] for e in events if e['type']=='turn.completed']==model['token_usage']
    assert model['requested_model']=='gpt-6.1-sol' and model['exit_code']==0
    usage={}
    for turn in model['token_usage']:
        for k,v in turn.items():usage[k]=usage.get(k,0)+v
    usage['total_tokens']=usage['input_tokens']+usage['output_tokens'];assert usage==m['token_usage']
    stages=r['compilation']+[r['kernel_check']]
    for stage in stages:
        assert stage['exit_code']==0 and stage['resources']['max_process_rss_kib']>0
        for k in ['stdout','stderr']:assert sha(ROOT/stage[k])==stage[k+'_sha256']
        assert json.loads((ROOT/stage['stdout']).with_name('resources.json').read_text())==stage['resources']
    expected=r['native']['measurement']['wall_seconds']+model['wall_seconds']+sum(s['wall_seconds'] for s in stages)
    assert math.isclose(m['wall_seconds'],expected)
    assert m['coq_peak_process_rss_kib']==max(s['resources']['max_process_rss_kib'] for s in stages)
    print('PASS: complete universal QCP goal and VC_Correct module, closed assumptions, independent kernel replay and actual model/time/memory/token receipts.')

if __name__=='__main__':main()
