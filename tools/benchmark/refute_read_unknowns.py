#!/usr/bin/env python3
"""Refute the exact twelve read UNKNOWN VCs with Coq; preserve raw test verdicts."""
from pathlib import Path
import hashlib, json, os, re, shlex, subprocess, time

ROOT = Path(__file__).resolve().parents[2]
OUT = ROOT / 'benchmark/results/read/20261015-itp-refutations'
SRC = OUT / 'proofs'
COQ = Path('/home/yangfp/.opam/qcp-8.20/bin')
RUNTIME = ROOT / 'runtime/qcip/SeparationLogic'

def sha(p):
    return hashlib.sha256(p.read_bytes()).hexdigest()

def save(p, data):
    p.parent.mkdir(parents=True, exist_ok=True)
    p.write_text(json.dumps(data, ensure_ascii=False, indent=2) + '\n')

def flags():
    tokens = shlex.split((RUNTIME / '_CoqProject').read_text())
    return [str(RUNTIME / t) if i % 3 == 1 else t for i, t in enumerate(tokens)] + ['-Q', str(SRC), '']

def run(command, log):
    start = time.monotonic()
    with log.open('w') as stream:
        result = subprocess.run(list(map(str, command)), cwd=SRC, stdout=stream, stderr=subprocess.STDOUT)
    return {'command': list(map(str, command)), 'exit_code': result.returncode, 'wall_seconds': time.monotonic()-start, 'log': log.relative_to(ROOT).as_posix(), 'log_sha256': sha(log)}

def main():
    SRC.mkdir(parents=True, exist_ok=True)
    original = json.loads((ROOT / 'benchmark/results/read/20261015-variants/results.json').read_text())
    cases = [r for r in original['runs'] if r['tespec']['statuses'] == ['UNKNOWN']]
    assert len(cases) == 12
    old = ROOT / 'arxiv/benchmark-support/selection/qcp-migration/supplemental/negative-proofs/ResourceCounterHeap.v'
    header = old.read_text().split('Definition st ')[0]
    helper = header + '''
Definition st (m:mem) : naive_C_Rules.model := {|ConAssertion.s_mem:=m;ConAssertion.s_STS:=Sets.full;ConAssertion.s_token:=Sets.empty|}.
Definition tail2 (b2 b3:Z) : mem := fun x=>if Z.eqb x 4098 then value b2 else if Z.eqb x 4099 then value b3 else Noperm.
Definition tail1 (b1 b2 b3:Z) : mem := fun x=>if Z.eqb x 4097 then value b1 else tail2 b2 b3 x.
Definition cell (b0 b1 b2 b3:Z) : mem := fun x=>if Z.eqb x 4096 then value b0 else tail1 b1 b2 b3 x.
Lemma st_join : forall a b c, mem_join a b c -> naive_C_Rules.join (st a) (st b) (st c).
Proof. intros; unfold naive_C_Rules.join, ConAssertion.state_join, st; cbn; split; [assumption|]. unfold ConAssertion.TokenSet_join, ConAssertion.STS_state_join; sets_unfold; tauto. Qed.
Ltac byte_join := unfold mem_join, single_byte_mem, cell, tail1, tail2, addr_eqb; intro x;
 repeat match goal with |- context[Z.eqb ?y ?k] => let E:=fresh in destruct (Z.eqb y k) eqn:E; [apply Z.eqb_eq in E|apply Z.eqb_neq in E] end; try lia; eauto 12.
Lemma join2 : forall a b, mem_join (single_byte_mem 4098 a) (single_byte_mem 4099 b) (tail2 a b).
Proof. intros; byte_join. Qed.
Lemma join1 : forall a b c, mem_join (single_byte_mem 4097 a) (tail2 b c) (tail1 a b c).
Proof. intros; byte_join. Qed.
Lemma join0 : forall a b c d, mem_join (single_byte_mem 4096 a) (tail1 b c d) (cell a b c d).
Proof. intros; byte_join. Qed.
Lemma byte_at : forall p v, naive_C_Rules.mstore p v (st (single_byte_mem p v)).
Proof. intros; unfold naive_C_Rules.mstore,st; exists v; split; [apply Byte.eqm_refl|]; repeat split; try reflexivity; sets_unfold; tauto. Qed.
Lemma cell_not_emp : forall a b c d, ~ emp (st (cell a b c d)).
Proof. intros a b c d H; unfold naive_C_Rules.emp, naive_C_Rules.is_unit, ConAssertion.state_empty, st in H; cbn in H; destruct H as [H _]; unfold mem_empty in H; specialize (H 4096); cbn [cell] in H; discriminate. Qed.
'''
    values = sorted({r['initial'] for r in cases})
    witnesses = {}
    for index, value in enumerate(values):
        b = list((value % 2**32).to_bytes(4, 'big'))
        bs = ' '.join(map(str, b)); val = '(' + str(value) + ')'
        name = 'cell_value_' + str(index)
        helper += f'''
Lemma {name} : (4096 # Int |-> {val}) (st (cell {bs})).
Proof.
 unfold store_int, naive_C_Rules.andp, naive_C_Rules.coq_prop; split.
 - vm_compute; intuition congruence.
 - unfold store_4byte, naive_C_Rules.exp, naive_C_Rules.andp, naive_C_Rules.coq_prop.
   exists {b[0]}, {b[1]}, {b[2]}, {b[3]}; split.
   + unfold merge_int; vm_compute; reflexivity.
   + unfold naive_C_Rules.sepcon; exists (st (single_byte_mem 4096 {b[0]})), (st (tail1 {b[1]} {b[2]} {b[3]})); split; [apply st_join; apply join0|]; split; [apply byte_at|].
     exists (st (single_byte_mem 4097 {b[1]})), (st (tail2 {b[2]} {b[3]})); split; [apply st_join; apply join1|]; split; [apply byte_at|].
     exists (st (single_byte_mem 4098 {b[2]})), (st (single_byte_mem 4099 {b[3]})); split; [apply st_join; apply join2|]; split; apply byte_at.
Qed.
'''
        witnesses[value] = (name, bs, val)
    (SRC / 'ReadCounterHeap.v').write_text(helper)
    report = {'schema': 'tespec-read-itp-refutations/v1', 'scope': 'Negation of each exact generated UNKNOWN VC and its spatial split; original test results unchanged. Entry satisfiability also proved. No generated Admitted proof module is imported.', 'coq_version': subprocess.check_output([str(COQ/'coqc'),'--version'],text=True).strip(), 'cases': []}
    result = run([COQ/'coqc', *flags(), SRC/'ReadCounterHeap.v'], OUT/'helper-compile.log')
    report['helper_compile'] = result
    if result['exit_code']:
        save(OUT/'receipt.json', report)
        raise SystemExit((OUT/'helper-compile.log').read_text()[-3500:])
    modules = []
    for index, row in enumerate(cases):
        native = json.loads((ROOT/row['tespec']['report']).read_text())['results'][0]
        goal = Path(native['generated_source']).parent/'vc/input_goal.v'
        goal_name = f'ReadUnknown{index:02d}Goal'
        proof_name = f'ReadUnknown{index:02d}Refutation'
        goal_copy = SRC/(goal_name+'.v'); goal_copy.write_bytes(goal.read_bytes())
        name, bs, val = witnesses[row['initial']]
        body = goal.read_text().split('Definition read_return_wit_1 :=',1)[1].split('Definition read_return_wit_1_split_goal_spatial',1)[0]
        branches = body.split('\\/')
        assert len(branches)==2
        counts = [len(re.findall(r'\(PreH\d+\s*:', branch)) for branch in branches]
        spatial = goal.read_text().split('Definition read_return_wit_1_split_goal_spatial :=',1)[1].split('Definition read_precondition_wit_1',1)[0]
        count_spatial = len(re.findall(r'\(PreH\d+\s*:', spatial))
        def specialize(n):
            return f'(H 4096 {val} ' + ' '.join(['ltac:(vm_compute; intuition congruence)']*n) + f' (st (cell {bs})) {name})'
        proof = f'Require Import ReadCounterHeap {goal_name}.\n' + header
        proof += f'''\nTheorem original_VC_refuted : ~ read_return_wit_1.
Proof. unfold read_return_wit_1; intros [H|H]; apply (cell_not_emp {bs}).
 - pose proof {specialize(counts[0])} as K; exact (proj2 K).
 - pose proof {specialize(counts[1])} as K; exact (proj2 K).
Qed.
Theorem spatial_VC_refuted : ~ read_return_wit_1_split_goal_spatial.
Proof. unfold read_return_wit_1_split_goal_spatial; intro H; apply (cell_not_emp {bs}); pose proof {specialize(count_spatial)} as K; exact (proj2 K). Qed.
Theorem entry_satisfiable : read_precondition_wit_1.
Proof. unfold read_precondition_wit_1; exists 4096, {val}; intro H; apply (H (st (cell {bs}))); split; [split; vm_compute; reflexivity|exact {name}]. Qed.
Print Assumptions original_VC_refuted.
Print Assumptions spatial_VC_refuted.
Print Assumptions entry_satisfiable.
'''
        proof_path = SRC/(proof_name+'.v'); proof_path.write_text(proof)
        entry = {'variant':row['variant'],'case':row['case'],'initial':row['initial'],'original_test_report':row['tespec']['report'],'original_goal':goal.relative_to(ROOT).as_posix(),'original_goal_sha256':sha(goal),'goal_copy':goal_copy.relative_to(ROOT).as_posix(),'goal_copy_sha256':sha(goal_copy),'proof':proof_path.relative_to(ROOT).as_posix(),'proof_sha256':sha(proof_path),'raw_status':'UNKNOWN','itp_status':'PENDING'}
        for label, source in [('goal',goal_copy),('refutation',proof_path)]:
            entry[label+'_compile'] = run([COQ/'coqc',*flags(),source],OUT/(proof_name+'-'+label+'.log'))
            if entry[label+'_compile']['exit_code']:
                report['cases'].append(entry);save(OUT/'receipt.json',report)
                raise SystemExit((ROOT/entry[label+'_compile']['log']).read_text()[-3500:])
        audit = (ROOT/entry['refutation_compile']['log']).read_text()
        assert audit.count('Closed under the global context')==3,audit
        entry['assumptions']='Closed under the global context (all three theorems)'
        entry['itp_status']='REFUTATION_COMPILED_PENDING_KERNEL'
        report['cases'].append(entry);save(OUT/'receipt.json',report);modules.append(proof_name)
        print(index+1,row['variant'],row['case'],'compiled; assumptions closed',flush=True)
    report['kernel_check']=run([COQ/'coqchk','-silent',*flags(),*modules],OUT/'kernel-check.log')
    assert report['kernel_check']['exit_code']==0,(OUT/'kernel-check.log').read_text()[-3000:]
    for row in report['cases']:
        row['itp_status']='REFUTED_KERNEL_CHECKED';row['resolved_test_status']='FAIL'
    report['summary']={'raw_unknown':12,'formally_refuted':12,'entry_satisfiable_proved':12,'spatial_splits_refuted':12,'kernel_check_exit':0,'assumption_audits_closed':36,'solver_or_executor_modified':False}
    save(OUT/'receipt.json',report)
    print(json.dumps(report['summary']),flush=True)

if __name__=='__main__':
    main()
