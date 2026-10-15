#!/usr/bin/env python3
"""Audit fresh model telemetry, Coq resource logs and exact read proof bindings."""
from pathlib import Path
import collections, hashlib, json, math, re

ROOT=Path(__file__).resolve().parents[2]
OUT=ROOT/'benchmark/results/read/20261015-itp-metered'
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()

def main():
    r=json.loads((OUT/'receipt.json').read_text());m=r['metrics'];assert len(r['cases'])==12
    total=collections.Counter();comp=[];kernels=[]
    for a,model in zip(r['attempts'],r['models']):
        assert model['requested_model']=='gpt-6.1-sol' and '--model' in model['command']
        assert model['command'][model['command'].index('--model')+1]=='gpt-6.1-sol'
        p=ROOT/a['model_receipt'];events=json.loads(p.with_name('usage-events.json').read_text())
        assert [e['usage'] for e in events if e['type']=='turn.completed']==model['token_usage']
        for usage in model['token_usage']:
            total.update(usage)
        assert model['wall_seconds']>0 and model['resources']['max_process_peak_working_set_bytes']>0
        assert sha(ROOT/a['candidate'])==a['candidate_sha256']==model['candidate_sha256']
        for name,h in model['locked_goal_and_helper_sha256'].items():
            assert sha((ROOT/a['candidate']).parent/name)==h
        comp.extend(a['compilation'])
        if 'kernel_check' in a:kernels.append(a['kernel_check'])
    for stage in comp+kernels:
        assert stage['wall_seconds']>0 and stage['resources']['max_process_rss_kib']>0
        for name in ['stdout','stderr']:
            assert sha(ROOT/stage[name])==stage[name+'_sha256']
        resources=json.loads((ROOT/stage['stdout']).with_name('resources.json').read_text())
        assert resources==stage['resources']
    accepted=r['attempts'][-1];assert accepted['status']=='KERNEL_CHECKED' and accepted['kernel_check']['exit_code']==0
    proof=ROOT/accepted['candidate'];text=proof.read_text();assert not re.search(r'\b(?:Admitted|admit|Axiom|Parameter)\b',text)
    names=[f'case_{i:02d}_{k}' for i in range(12) for k in ['return_refuted','spatial_refuted','entry_sat']]
    assert re.findall(r'Print Assumptions\s+(case_\w+)\.',text)==names
    assert (ROOT/accepted['compilation'][-1]['stdout']).read_text().count('Closed under the global context')==36
    for c in r['cases']:
        assert sha(ROOT/c['original_goal'])==c['original_goal_sha256']==sha(ROOT/c['goal_copy'])
        assert sha(ROOT/c['proof'])==c['proof_sha256']==accepted['candidate_sha256']
        assert c['itp_status']=='REFUTED_KERNEL_CHECKED' and len(c['theorems'])==3
    total['total_tokens']=total['input_tokens']+total['output_tokens']
    assert dict(total)==m['token_usage']
    assert m['coq_peak_process_rss_kib']==max(s['resources']['max_process_rss_kib'] for s in comp+kernels)
    assert math.isclose(m['total_itp_wall_seconds'],sum(x['wall_seconds'] for x in r['models'])+sum(x['wall_seconds'] for x in comp+kernels))
    raw=json.loads((ROOT/'benchmark/results/read/20261015-variants/results.json').read_text())
    assert sha(ROOT/'bin/tespec-symexec')==raw['toolchain']['tespec_executor_sha256']
    print('PASS: metered gpt-6.1-sol usage events, time, process memory, 12 exact VC bindings and 36 closed kernel-checked theorems.')

if __name__=='__main__':main()
