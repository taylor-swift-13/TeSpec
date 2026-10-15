from pathlib import Path
import collections, hashlib, json

R = Path(__file__).resolve().parents[2]
P = R / 'benchmark/results/read/20261015-itp-refutations'

def sha(p):
    return hashlib.sha256(p.read_bytes()).hexdigest()

receipt = json.loads((P/'receipt.json').read_text())
assert receipt.get('kernel_check', {}).get('exit_code') == 0, 'Independent kernel check is not complete'
assert len(receipt['cases']) == 12
raw_path = R/'benchmark/results/read/20261015-variants/results.json'
raw = json.loads(raw_path.read_text())
assert sha(R/'bin/tespec-symexec') == raw['toolchain']['tespec_executor_sha256']
resolutions = {}
for row in receipt['cases']:
    assert row['itp_status'] == 'REFUTED_KERNEL_CHECKED'
    assert sha(R/row['original_goal']) == row['original_goal_sha256'] == row['goal_copy_sha256'] == sha(R/row['goal_copy'])
    assert sha(R/row['proof']) == row['proof_sha256']
    proof = (R/row['proof']).read_text()
    assert 'Admitted' not in proof and 'Axiom ' not in proof
    assert 'input_proof_auto' not in proof and 'input_proof_manual' not in proof
    audit = (R/row['refutation_compile']['log']).read_text()
    assert audit.count('Closed under the global context') == 3
    resolutions[row['variant'],row['case']] = row

print("PASS: twelve original and spatial VCs refuted, twelve entries satisfiable; all proofs hash-matched, assumption audits closed and independent kernel check successful. Executor unchanged.")
