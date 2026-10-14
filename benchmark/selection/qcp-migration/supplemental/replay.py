#!/usr/bin/env python3
"""Recompile and kernel-check recorded supplemental manual and negative proofs."""
import argparse,hashlib,json,re,shlex,shutil,subprocess
from pathlib import Path
HERE=Path(__file__).resolve().parent
PREFIX="benchmark/selection/qcp-migration/supplemental/"
def digest(p): return hashlib.sha256(p.read_bytes()).hexdigest()
def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--runtime",type=Path,required=True)
    parser.add_argument("--check-only",action="store_true",help="Validate frozen sources/proofs without recompiling")
    args=parser.parse_args();runtime=args.runtime.resolve(strict=True)
    coqc,coqchk=shutil.which("coqc"),shutil.which("coqchk")
    if not coqc or not coqchk or "8.20" not in subprocess.check_output([coqc,"--version"],text=True): parser.error("Activate matching Coq 8.20 first")
    positive=json.loads((HERE/"manual-proof-receipts.json").read_text())["results"]
    negative=json.loads((HERE/"negative-proof-receipts.json").read_text())["results"]
    for row in json.loads((HERE/"manifest.json").read_text())["cases"]:
        if digest(HERE/row["qcp"].removeprefix(PREFIX))!=row["qcp_sha256"]: raise ValueError("Changed input: "+row["id"])
    for row in positive:
        raw=HERE/row["id"]/"native/vc"/(row["id"]+".qcp_goal.v")
        expected=raw.read_text().replace(row["id"]+".qcp_",row["id"]+"_")
        if row["id"]=="runway_snapshot":expected="Require Import StateResources.\n"+expected
        if (HERE/row["id"]/"proofs"/(row["id"]+"_goal.v")).read_text()!=expected:raise ValueError("Changed goal adapter")
        if digest(raw)!=row["generated_goal_sha256"]:raise ValueError("Changed native goal")
        for name,expected in row["artifacts"].items():
            if digest(HERE/row["id"]/"proofs"/name)!=expected: raise ValueError("Changed proof: "+name)
    for row in negative:
        if digest(HERE/row["proof_file"])!=row["proof_sha256"]: raise ValueError("Changed refutation: "+row["id"])
        raw=HERE/row["id"]/"native/vc"/(row["id"]+".qcp_goal.v")
        if digest(raw)!=row["generated_goal_sha256"]: raise ValueError("Changed original goal: "+row["id"])
    for rel,expected in json.loads((HERE/"negative-proof-receipts.json").read_text())["supporting_artifacts"].items():
        if digest(HERE/rel)!=expected:raise ValueError("Changed countermodel: "+rel)
    if args.check_only:
        print("Frozen supplemental source, proof and native-goal hashes match.");return
    tokens=shlex.split((runtime/"_CoqProject").read_text())
    flags=[str(runtime/x) if i%3==1 else x for i,x in enumerate(tokens)]
    folders=[HERE/"dll-lib",HERE/"runway-normalization",HERE/"negative-proofs",HERE/"dependencies/slf0_basic_incr",HERE/"succ_attempt_leak/proofs"]+[HERE/r["id"]/"proofs" for r in positive]
    for folder in folders:flags += ["-Q",str(folder),""]
    def compile(path,proof=False):
        if proof and re.search(r"\b(?:Admitted|Axiom|Parameter)\b",path.read_text()): raise ValueError("Unproved proof declaration in "+str(path))
        subprocess.run([coqc,*flags,str(path)],check=True)
    compile(HERE/"dll-lib/DLLSupplement.v",True)
    compile(HERE/"runway-normalization/RunwayValidEquivalence.v",True)
    dep=HERE/"dependencies/slf0_basic_incr"
    compile(dep/"slf0_basic_incr_goal.v");compile(dep/"slf0_basic_incr_proof_manual.v",True)
    for row in positive:
        folder=HERE/row["id"]/"proofs"
        if (folder/"StateResources.v").exists():compile(folder/"StateResources.v",True)
        compile(folder/(row["id"]+"_goal.v"));compile(folder/(row["id"]+"_proof_manual.v"),True)
    compile(HERE/"negative-proofs/ResourceCounterHeap.v",True);compile(HERE/"negative-proofs/ResourceDoubleHeap.v",True)
    for row in negative:
        compile(HERE/"negative-proofs"/(row["id"]+"_neg_goal.v"));compile(HERE/row["proof_file"],True)
    component=HERE/"succ_attempt_leak/proofs"
    compile(component/"succ_attempt_leak_goal.v");compile(component/"succ_attempt_leak_incr_manual.v",True)
    modules=[row["id"]+"_proof_manual" for row in positive]+[row["id"]+"_refutation" for row in negative]+["DLLSupplement","RunwayValidEquivalence","succ_attempt_leak_incr_manual"]
    subprocess.run([coqchk,"-silent",*flags,*modules],check=True)
    print("Supplemental manual proofs, resource lemmas, encoding equivalence and five original-VC negations passed kernel checking.")
if __name__=="__main__":main()
