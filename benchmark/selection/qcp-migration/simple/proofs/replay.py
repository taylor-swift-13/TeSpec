#!/usr/bin/env python3
"""Recompile and independently check the all recorded complete VC modules."""
import argparse
import json
from pathlib import Path
import re
import shlex
import shutil
import subprocess

HERE = Path(__file__).resolve().parent
IDS = [row["id"] for row in json.loads((HERE / "report.json").read_text())["results"]]

def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--runtime", type=Path, required=True, help="QCP SeparationLogic library root with _CoqProject")
    args = parser.parse_args()
    runtime = args.runtime.resolve(strict=True)
    coqc, coqchk = shutil.which("coqc"), shutil.which("coqchk")
    if not coqc or not coqchk:
        parser.error("Activate the Coq 8.20 environment first")
    version = subprocess.check_output([coqc, "--version"], text=True)
    if "8.20" not in version:
        parser.error("The recorded QCP dependencies require Coq 8.20")
    tokens = shlex.split((runtime / "_CoqProject").read_text())
    flags = [str(runtime / token) if i % 3 == 1 else token for i, token in enumerate(tokens)]
    all_flags = list(flags)
    for ident in IDS:
        all_flags += ["-Q", str(HERE / ident), ""]
    guarded = HERE.parent / "advanced/queue-guarded"
    all_flags += ["-Q", str(guarded), ""]
    subprocess.run([coqc, *flags, str(runtime / "examples/QCP_demos_human/sll_lib.v")], check=True)
    order = sorted(IDS, key=lambda x: {"mergesort": 1, "list_all": 2, "slf_sized_stack": 3}.get(x, 0))
    for ident in order:
        folder = HERE / ident
        module = "case3" if ident == "3" else ident.replace(".", "_")
        manual = (folder / (module + "_proof_manual.v")).read_text()
        if re.search(r"\b(?:Admitted|Axiom|Parameter)\b", manual):
            raise ValueError("Unproved declaration in " + ident)
        extras = [folder / "FulminateMerge.v", folder / "ReverseStrategySound.v", folder / (module + "_def.v")]
        for path in extras:
            if path.exists():
                subprocess.run([coqc, *all_flags, str(path)], check=True)
        for suffix in ["goal", "proof_manual", "goal_check"]:
            subprocess.run([coqc, *all_flags, str(folder / (module + "_" + suffix + ".v"))], check=True)
    extra_modules = ["ReverseStrategySound"]
    for name in ["CNQueueGuarded", "QueueGraphCounterexample"]:
        subprocess.run([coqc, *all_flags, str(guarded / (name + ".v"))], check=True)
        extra_modules.append(name)
    subprocess.run([coqchk, "-silent", *all_flags, *[("case3" if ident == "3" else ident.replace(".", "_")) + "_goal_check" for ident in IDS], *extra_modules], check=True)
    print("All recorded complete VC modules and supplementary certificates passed kernel checking.")

if __name__ == "__main__":
    main()
