#!/usr/bin/env python3
"""Measure missing primary native stages and prepare an isolated model task."""
import argparse,json,re,shutil
from pathlib import Path
from test_read_variants import ROOT,CN,measure,sha,save

def main():
    p=argparse.ArgumentParser();p.add_argument('--group',required=True);p.add_argument('--task-dir',type=Path,required=True);p.add_argument('--continue-after-cn-failure',action='store_true',help='Preserve failed original CN measurement and independently measure QCP; never marks the group complete.');a=p.parse_args();g=ROOT/'benchmark/programs'/a.group;plan=json.loads((g/'evaluation-plan.json').read_text());variants={json.loads(p.read_text())['id']:json.loads(p.read_text()) for p in (g/'variants').glob('*/manifest.json')};out=ROOT/'benchmark/results'/a.group/'20261016-primary-native';rp=out/'receipt.json'
    cn=ROOT/variants[plan['primary_cn_variant']]['files']['cn']['path'];qcp=ROOT/variants[plan['primary_qcp_variant']]['files']['qcp']['path']
    # Materialize only explicitly requested proof-strategy dependencies, never engine code.
    dependency_path=g/'dependencies.json';dependencies=json.loads(dependency_path.read_text()) if dependency_path.exists() else {'dependencies':[]}
    for filename in re.findall(r'include\s+strategies\s+"([^"]+)"',qcp.read_text()):
        target=(qcp.parent/filename).resolve()
        assert target.is_relative_to(qcp.parent.resolve()),'Strategy dependency must remain inside the variant directory'
        if target.exists():continue
        search=[ROOT/inc for inc in variants[plan['primary_qcp_variant']]['files']['qcp'].get('include_dirs',[])]+[ROOT/'runtime/qcip/QCP_examples/QCP_demos_human']
        origin=next((folder/filename for folder in search if (folder/filename).is_file()),None)
        assert origin is not None,'Missing declared strategy dependency: '+filename
        target.parent.mkdir(parents=True,exist_ok=True);shutil.copyfile(origin,target)
        dependencies['dependencies'].append({'path':str(target.relative_to(ROOT)),'sha256':sha(target),'provenance':str(origin.relative_to(ROOT)),'reason':'Explicit logical proof-strategy dependency for legacy source-relative QCP include; byte-identical fixture, not executor implementation.'})
        save(dependency_path,dependencies)
    # Reuse an archived native measurement only after exact CN and QCP input locks.
    if not rp.exists():
        performance=ROOT/'benchmark/results/historical/selection/paired-mutations/performance/20261015-positive18/automatic-final/raw-results.json'
        if performance.exists():
            historical=json.loads(performance.read_text())
            for index,row in enumerate(historical['runs']):
                inputs=performance.parent.parent/'inputs'/row['source']
                if row.get('repeat')!=1 or not all((inputs/(lang+'.c')).exists() for lang in ['cn','qcp']):continue
                if sha(inputs/'cn.c')!=sha(cn) or sha(inputs/'qcp.c')!=sha(qcp):continue
                cm,qm=row['cn'],row['qcp_auto']
                vc=performance.parent/qm['folder']/'native/vc';goals=list(vc.glob('*_goal.v'))
                if cm['exit_code']!=0 or qm['exit_code']!=0 or len(goals)!=1:continue
                for measurement in [cm,qm]:
                    for stream in ['stdout','stderr']:
                        assert sha(performance.parent/measurement['folder']/(stream+'.log'))==measurement[stream+'_sha256']
                goal=goals[0]
                receipt={'schema':'tespec-group-primary-native/v1','program_group':a.group,'mode':'REUSED_EXACT_SOURCE_NATIVE_MEASUREMENTS','cn':cm,'qcp':qm,'cn_source':str(cn.relative_to(ROOT)),'cn_source_sha256':sha(cn),'qcp_source':str(qcp.relative_to(ROOT)),'qcp_source_sha256':sha(qcp),'goal':str(goal.relative_to(ROOT)),'goal_sha256':sha(goal),'historical_report':str(performance.relative_to(ROOT)),'historical_report_sha256':sha(performance),'cn_pointer':f'/runs/{index}/cn','qcp_pointer':f'/runs/{index}/qcp_auto','measurement_reason':'Both immutable primary language inputs and archived stdout/stderr hashes match. Reuse one primary native measurement; complete unbound QCP certificate separately.'}
                save(rp,receipt);print('Reused native primary measurements',row['source'],flush=True);break
    if not rp.exists():
        cn_command=[CN,'verify',*['-I'+str(ROOT/inc) for inc in variants[plan['primary_cn_variant']]['files']['cn'].get('include_dirs',[])],cn]
        pending=out/'pending-receipt.json'
        if a.continue_after_cn_failure and pending.exists():
            saved=json.loads(pending.read_text());cm=saved['cn']
            assert cm['exit_code']!=0 and list(map(str,cn_command))==cm['command']
            assert sha(cn)==variants[plan['primary_cn_variant']]['files']['cn']['sha256']
            assert (ROOT/cm['stdout']).is_file() and (ROOT/cm['stderr']).is_file()
            print('Preserved original failed CN measurement; measuring QCP independently.',flush=True)
        else:cm=measure(cn_command,out/'cn')
        save(pending,{'cn':cm,'cn_source_sha256':sha(cn)})
        assert cm['exit_code']==0 or a.continue_after_cn_failure,(ROOT/cm['stderr']).read_text()
        vc=out/'qcp/vc';qm=measure([ROOT/'bin/tespec-symexec','--input-file='+str(qcp),'--Json-output','--no-strategy-gen','--gen-and-backup','--coq-output-dir='+str(vc),'--no-logic-path','--disable-solver-info','--no-exec-info','-I'+str(ROOT/'runtime/qcip/QCP_examples/QCP_demos_human'),*['-I'+str(ROOT/inc) for inc in variants[plan['primary_qcp_variant']]['files']['qcp'].get('include_dirs',[])]],out/'qcp');save(out/'pending-receipt.json',{'cn':cm,'qcp':qm});assert qm['exit_code']==0,(ROOT/qm['stderr']).read_text();goals=list(vc.glob('*_goal.v'));assert len(goals)==1,goals;goal=goals[0]
        receipt={'schema':'tespec-group-primary-native/v1','program_group':a.group,'cn':cm,'qcp':qm,'cn_source':str(cn.relative_to(ROOT)),'cn_source_sha256':sha(cn),'qcp_source':str(qcp.relative_to(ROOT)),'qcp_source_sha256':sha(qcp),'goal':str(goal.relative_to(ROOT)),'goal_sha256':sha(goal),'native_binary_sha256':sha(ROOT/'bin/tespec-symexec'),'measurement_reason':'Historical exact-source records lack complete measured time/RSS and checked proof costs; preserve historical records and measure missing stages.'};save(rp,receipt);(out/'pending-receipt.json').unlink()
    else:receipt=json.loads(rp.read_text());goal=ROOT/receipt['goal'];assert sha(cn)==receipt['cn_source_sha256'] and sha(qcp)==receipt['qcp_source_sha256'] and sha(goal)==receipt['goal_sha256']
    task=a.task_dir;task.mkdir(parents=True,exist_ok=True);assert not(task/'Candidate.v').exists(),'Use a fresh isolated proof task';(task/'PrimaryQcpGoal.v').write_bytes(goal.read_bytes());text=goal.read_text();header=text.split('(*----- Function ')[0];interface=text.split('Module Type VC_Correct.')[1].split('End VC_Correct.')[0];obligations=re.findall(r'Axiom (\w+)\s*:\s*(\w+)\.',interface);assert obligations
    c='Require Import PrimaryQcpGoal.\n'+header+'\n'+''.join(f'Theorem primary_{name} : PrimaryQcpGoal.{name}.\nProof. Admitted.\n' for _,name in obligations)+'Module PrimaryCertificate : PrimaryQcpGoal.VC_Correct.\n'+''.join(f'Definition {field} := primary_{name}.\n' for field,name in obligations)+'End PrimaryCertificate.\n'+''.join(f'Print Assumptions primary_{name}.\n' for _,name in obligations)
    runtime_context='\nRuntime arithmetic interface: IntLib notation x % y denotes Z.rem x y; unsigned_last_nbits x n is Z.modulo x (2^n). For nonnegative a and positive b, Z.rem_mod_nonneg relates rem and modulo.\n'
    if '**' in text:
        runtime_context+='\nCoq compiler searches have a 90-second / 4-GiB address-space cap. Do not use unbounded firstorder on concrete heap predicates. For spatial commutation, preserve the two heap predicate facts, swap their sepcon witnesses, and reason directly about the join pointwise; generic join/sepcon commutation lemmas can bring functional extensionality. Runtime names are qualified ConAssertion.state_join, ConAssertion.TokenSet_join, ConAssertion.STS_state_join (not unqualified). Actual declarations:\n'
        lines=(ROOT/'runtime/qcip/SeparationLogic/SeparationLogic/ConAssertion.v').read_text().splitlines()
        runtime_context+='\n'.join(lines[52:55]+lines[73:81])+'\nThe runtime Mem.mem_join_comm proves memory-join commutation without new axioms and takes its three memory arguments implicitly. Sets equivalence is pointwise; sets_unfold in a named hypothesis exposes its pointwise statement.\n'
    if 'Array.full' in text:
        core=(ROOT/'runtime/qcip/SeparationLogic/SeparationLogic/ArrayLibCore.v').read_text()
        match=re.search(r'Lemma full_split_to_missing_i[^.]+\.',core,re.S)
        if match:runtime_context+='Runtime generic array lemma instantiated as IntArray/UIntArray.full_split_to_missing_i (base,index,length,list,default):\n'+match[0]+'\nUse an existing runtime lemma only with honest Print Assumptions auditing; standard-library dependencies must be disclosed, not declared locally.\n'
    (task/'Candidate.v').write_text(c);(task/'prompt.txt').write_text('Fill every universally quantified Coq 8.20 proof in Candidate.v. Preserve imports, original statements, VC_Correct module implementation and Print Assumptions. PrimaryQcpGoal.v is immutable actual unbound QCP verification output. No Admitted/admit, new axioms, parameters, changed definitions or proof escapes. Edit Candidate.v only; do not read prior benchmark proof solutions, call models, or delegate. External compiler and independent kernel check are controller-owned. WSL runtime access is unavailable inside this isolated task; do not waste a call trying it. The controller can supply actual runtime declarations on a diagnostic repair. Simple entailments can be introduced directly as predicates over heaps. A block of several pure heap conditions can be grouped as ONE conjunction before the spatial assertion. Split the pure block from the spatial subgoal, then prove the entire PURE block (repeat split/assumption there only); do not use one outer split per individual arithmetic fact. Avoid untyped change (forall h, _ -> _) and avoid cbv on arithmetic comparisons before lia. If an original heap witness is disjoined with a pure reduction, prefer proving the original heap witness. Preserve unchanged spatial frames directly; entailer! and the generic sepcon commutation lemma can introduce functional extensionality. Runtime sets_unfold supports only the goal or one named hypothesis, not in *. INT_MAX, INT_MIN and UINT_MAX are notations for integer literals, not unfoldable definitions. If hnf leaves a pure heap assertion applied to h, use change to its underlying arithmetic proposition before lia. Return briefly.\n\nActual immutable goal:\n'+text+'\nCandidate:\n'+c+runtime_context);print('Prepared',a.group,len(obligations),'universal obligations',flush=True)
if __name__=='__main__':main()
