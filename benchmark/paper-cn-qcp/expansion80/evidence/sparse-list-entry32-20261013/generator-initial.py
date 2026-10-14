#!/usr/bin/env python3
"""Generate an entry SAT certificate from an owned finite list graph.

Only the original entry VC is selected. Kernel checking remains mandatory;
this generator does not assign an execution verdict.
"""
import argparse
import hashlib
import json
import sys
from pathlib import Path

HERE = Path(__file__).resolve().parent
EXP = HERE.parents[1]
ROOT = HERE.parents[4]
sys.path.insert(0, str(ROOT))
from spectest.certificates import prepare_certificate

def numbers(values):
    return '[' + ';'.join(str(x) if x >= 0 else '(' + str(x) + ')' for x in values) + ']'

def word_bytes(value):
    return list((value % (1 << 32)).to_bytes(4, 'big'))

def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--report', type=Path, required=True)
    parser.add_argument('--suite', type=Path, required=True)
    parser.add_argument('--input-id', required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    suite = json.loads(args.suite.read_text())
    assert suite['graph_schema'] == {'c_type': 'struct list', 'value_fields': ['data'], 'link_fields': ['next']}
    item = next(x for x in suite['inputs'] if x['id'] == args.input_id)
    automatic = json.loads(args.report.read_text())
    case = next(x for x in automatic['results'] if x['id'] == args.input_id)
    assert case['arguments'] == item['qcp_bind']['args']
    assert case['bindings'] == item['qcp_bind']['values']
    assert case['execution_semantics'] == 'inline-preserve/v1'
    assert len(case['preconditions']) == 1
    goal = case['preconditions'][0]['goal']
    proof_name = 'proof_of_' + goal
    prepared = prepare_certificate(Path(case['vc']['manifest']), args.output, only={proof_name})
    output = Path(prepared['editable']).parent
    prefix = (EXP / 'theory/ConcreteByteWitness.v').read_text()
    prefix += (EXP / 'theory/SparseByteWitness.v').read_text().replace('Require Import ConcreteByteWitness.\n', '')
    prefix += (EXP / 'theory/DistinctAddressCheck.v').read_text()
    prefix += '\nRequire Import Goal SimpleC.EE.QCP_demos_human.sll_layout32.\nModule Proofs.\n'
    nodes = {x['id']: x for x in item['graph']['nodes']}
    heads = []
    visited = []
    cells = []
    for parameter in suite['parameter_order']:
        chain = []
        node_id = item['graph']['heads'][parameter]
        while node_id is not None:
            assert node_id not in visited, 'cycle or shared ownership'
            visited.append(node_id)
            node = nodes[node_id]
            p, value = node['address'], node['data']
            nextp = 0 if node['next'] is None else nodes[node['next']]['address']
            assert 0 < p and p % 4 == 0 and p + 7 <= 4294967295
            assert -(1 << 31) <= value < (1 << 31)
            assert 0 <= nextp <= 4294967295
            encoded = word_bytes(value) + word_bytes(nextp)
            chunk = f'(indexed_bytes {p} {numbers(encoded)})'
            index = len(cells)
            cells.append((chunk, p, value, nextp, encoded))
            chain.append(index)
            node_id = node['next']
        assert [cells[index][2] for index in chain] == item['logical_lists'][parameter]
        heads.append((parameter, chain))
    assert set(visited) == set(nodes), 'unaccounted owned node'
    addresses = [p + offset for _, p, _, _, _ in cells for offset in range(8)]
    assert len(addresses) == len(set(addresses))
    for index, (chunk, p, value, nextp, encoded) in enumerate(cells):
        prefix += f'''Lemma encode_node_{index} : cell_resources {chunk} |--
  store_int {p} ({value}) ** store_ptr ({p} + 4) {nextp}.
Proof.
  assert (Hdata : byte_resources {p} {numbers(encoded[:4])} |-- store_int {p} ({value})).
  {{ unfold store_int. entailer!.
    try (apply four_byte_resources_encode_word; vm_compute; reflexivity).
    all: vm_compute; intuition discriminate. }}
  assert (Hnext : byte_resources ({p} + 4) {numbers(encoded[4:])} |-- store_ptr ({p} + 4) {nextp}).
  {{ unfold store_ptr. entailer!.
    try (apply four_byte_resources_encode_word; vm_compute; reflexivity).
    all: vm_compute; intuition discriminate. }}
  eapply derivable1_trans; [apply (proj1 (indexed_bytes_are_byte_resources _ _))|].
  eapply derivable1_trans; [apply (byte_resources_append {numbers(encoded[:4])} {p} {numbers(encoded[4:])})|].
  apply derivable1_sepcon_mono; [exact Hdata|exact Hnext].
Qed.
'''
    concat = lambda indices: '(' + ' ++ '.join([cells[i][0] for i in indices] + ['[]']) + ')'
    head_targets = []
    for h, (parameter, chain) in enumerate(heads):
        p = item['qcp_bind']['args'][parameter]
        target = f'sll32 {p} {numbers(item["logical_lists"][parameter])}'
        head_targets.append(target)
        prefix += f'Lemma encode_head_{h} : cell_resources {concat(chain)} |-- {target}.\nProof.\n'
        for offset, index in enumerate(chain):
            prefix += f'  sep_apply (cell_resources_append {cells[index][0]} {concat(chain[offset + 1:])}).\n'
            prefix += f'  sep_apply encode_node_{index}.\n'
        prefix += '  cbn [cell_resources sll32].\n'
        if chain:
            prefix += '  Exists ' + ' '.join(str(cells[i][3]) for i in chain) + '.\n'
        prefix += '  entailer!.\nQed.\n'
    whole_expr = '(' + ' ++ '.join([concat(chain) for _, chain in heads] + ['[]']) + ')'
    prefix += f'Lemma encode_entry : cell_resources {whole_expr} |-- ' + ' ** '.join('(' + x + ')' for x in head_targets) + '.\nProof.\n'
    for h, (_, chain) in enumerate(heads):
        suffix = '(' + ' ++ '.join([concat(tail) for _, tail in heads[h + 1:]] + ['[]']) + ')'
        prefix += f'  sep_apply (cell_resources_append {concat(chain)} {suffix}).\n  sep_apply encode_head_{h}.\n'
    prefix += '  cbn [cell_resources]. entailer!.\nQed.\n'
    prefix += f'''Lemma {proof_name} : Goal.{goal}.
Proof.
  unfold Goal.{goal}. intro Hfalse.
  assert (Hdistinct : NoDup (map fst {whole_expr})).
  {{ apply distinct_addresses_sound. vm_compute. reflexivity. }}
  pose (whole := memory_state (cell_memory {whole_expr})).
  pose proof (encode_entry whole (distinct_byte_cells_have_witness _ Hdistinct)) as Howned.
  apply (Hfalse whole).
  cbn [naive_C_Rules.andp naive_C_Rules.coq_prop].
  repeat first [exact Howned | reflexivity | split | (vm_compute; intuition discriminate)].
Qed.
End Proofs.
'''
    (output / 'Candidate.v').write_text(prefix)
    sha = lambda p: hashlib.sha256(p.read_bytes()).hexdigest()
    record = {'scope': 'generated entry SAT proof; no execution verdict',
              'input_id': args.input_id, 'suite_sha256': sha(args.suite),
              'report_sha256': sha(args.report), 'generator_sha256': sha(Path(__file__)),
              'candidate_sha256': sha(output / 'Candidate.v'), 'byte_cell_count': len(addresses),
              'manifest_sha256': prepared['manifest_sha256']}
    (output / 'generation.json').write_text(json.dumps(record, indent=2) + '\n')
    print(json.dumps(prepared, indent=2))

if __name__ == '__main__':
    main()
