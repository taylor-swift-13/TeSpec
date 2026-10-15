#!/usr/bin/env python3
"""Capture evaluator/backend source identities and relevant Python dependencies."""
from pathlib import Path
import datetime,hashlib,importlib.metadata,subprocess,sys
from test_read_variants import ROOT

def snapshot(reference_commit=None):
    modules={}
    for folder in [ROOT/'spectest',ROOT/'tools/finite_spatial_smt']:
        for path in sorted(folder.rglob('*.py')):
            content=path.read_bytes();rel=str(path.relative_to(ROOT));modules[rel]=hashlib.sha256(content).hexdigest()
            if reference_commit:
                old=subprocess.check_output(['git','show',reference_commit+':'+rel],cwd=ROOT);assert old==content,rel
    revision=subprocess.check_output(['git','rev-parse','HEAD'],cwd=ROOT,text=True).strip();dirty=subprocess.check_output(['git','status','--porcelain','--','spectest','tools/finite_spatial_smt'],cwd=ROOT,text=True).splitlines()
    return {'schema':'tespec-evaluation-source-snapshot/v1','recorded_utc':datetime.datetime.now(datetime.timezone.utc).isoformat(),'git_revision':revision,'reference_commit_audited':reference_commit,'module_working_tree_changes':dirty,'source_files_sha256':modules,'python_version':sys.version,'z3_solver_installed_version':importlib.metadata.version('z3-solver'),'scope':'Evaluator and optional spatial backend source identities; binary/runtime/input hashes are recorded by each execution.','capture_mode':'POST_RUN_MATCHES_REFERENCE_COMMIT' if reference_commit else 'BEFORE_MEASUREMENTS'}
