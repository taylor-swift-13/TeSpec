#!/usr/bin/env python3
"""Matched read benchmark with spatial SMT disabled/enabled; no universal reruns."""
from pathlib import Path
import collections,csv,datetime,hashlib,io,json,subprocess,sys
from test_read_variants import ROOT,measure,sha,save
OUT=ROOT/'benchmark/results/read/20261015-spatial-smt'
RAW=ROOT/'benchmark/results/read/20261015-variants/results.json'
def fingerprints():
    files=sorted((ROOT/'spectest').glob('*.py'))+sorted((ROOT/'tools/finite_spatial_smt').glob('*.py'))+[ROOT/'bin/tespec-symexec',Path(__file__)]
    return {p.relative_to(ROOT).as_posix():sha(p) for p in files}
def main():
    assert not (OUT/'results.json').exists(),'Use a fresh directory; never overwrite measured results'
    original=json.loads(RAW.read_text());complete=json.loads((ROOT/'benchmark/results/read/complete/results.json').read_text())
    expected={(x['variant'],x['case']):x for x in complete['cases']}
    manifests={}
    for p in (ROOT/'benchmark/programs/read/variants').glob('*/manifest.json'):
        m=json.loads(p.read_text());manifests[m['id']]=m
    locked=fingerprints()
    report={'schema':'tespec-read-spatial-smt-benchmark/v1','started_utc':datetime.datetime.now(datetime.timezone.utc).isoformat(),'source_fingerprints':locked,
        'git_head':subprocess.check_output(['git','rev-parse','HEAD'],cwd=ROOT,text=True).strip(),
        'working_tree_feature_uncommitted':bool(subprocess.check_output(['git','status','--porcelain','--','spectest','tools/finite_spatial_smt','pyproject.toml'],cwd=ROOT,text=True)),
        'python':sys.version,'z3_version':subprocess.check_output([sys.executable,'-c','import z3; print(z3.get_version_string())'],text=True).strip(),
        'old_report':RAW.relative_to(ROOT).as_posix(),'old_report_sha256':sha(RAW),'mode_policy':'Matched fresh OFF/ON executions of unchanged sources/bindings; historical CN/Fulminate/QCP and required OFF ITP proofs reused by hash. No models or Coq rerun unless an unresolved unmatched VC remains.',
        'memory_definition':'GNU time max process RSS KiB per complete CLI invocation, not concurrent process-tree sum. Mean peak is arithmetic mean of per-execution peaks. Remote model memory excluded.',
        'timeout_ms_per_query':2000,'runs':[]}
    for old in original['runs']:
        source=ROOT/manifests[old['paired_qcp_variant']]['files']['qcp']['path'];binds=ROOT/old['binds']
        assert sha(source)==old['qcp_source_sha256'] and sha(binds)==old['binds_sha256']
        slug=Path(old['tespec']['report']).parts[-5]
        row={'variant':old['variant'],'case':old['case'],'initial':old['initial'],'source':source.relative_to(ROOT).as_posix(),'source_sha256':sha(source),'binds':old['binds'],'binds_sha256':sha(binds),'historical_native_status':old['tespec']['statuses'][0],'expected':expected[old['variant'],old['case']]['expected_result']}
        for mode,flag in [('off','--no-spatial-smt'),('on','--spatial-smt')]:
            folder=OUT/mode/old['variant'].replace(':','_')/old['case'];artifacts=folder/'artifacts'
            stage=measure([sys.executable,'-m','spectest','run',source,'--function','read','--binds',binds,'--execution-mode','all-boundaries','--output-dir',artifacts,'--timeout','30','--compact',flag,'--spatial-smt-timeout-ms','2000'],folder,timeout=90)
            path=artifacts/'report.json';assert path.is_file(),(folder,stage)
            data=json.loads(path.read_text());assert len(data['results'])==1
            case=data['results'][0];stage.update(report=path.relative_to(ROOT).as_posix(),report_sha256=sha(path),status=case['status'],itp_vcs=data.get('itp_vcs'),spatial_smt=case.get('spatial_smt'))
            goal=list(artifacts.glob('artifacts/*/vc/input_goal.v'));stage['goal']=goal[0].relative_to(ROOT).as_posix() if len(goal)==1 else None;stage['goal_sha256']=sha(goal[0]) if len(goal)==1 else None
            row[mode]=stage
        row['off_matches_historical']=row['off']['status']==row['historical_native_status']
        row['on_matches_expected']=row['on']['status']==row['expected']
        report['runs'].append(row);save(OUT/'partial-results.json',report)
        print(old['variant'],old['case'],row['off']['status'],'->',row['on']['status'],'expected',row['expected'],flush=True)
    assert fingerprints()==locked,'Source changed during matched benchmark'
    report['summary']={'case_pairs':len(report['runs']),'executions':2*len(report['runs']),'off_counts':dict(collections.Counter(r['off']['status'] for r in report['runs'])),'on_counts':dict(collections.Counter(r['on']['status'] for r in report['runs'])),'on_expected_matches':sum(r['on_matches_expected'] for r in report['runs']),'off_historical_matches':sum(r['off_matches_historical'] for r in report['runs'])}
    save(OUT/'results.json',report);(OUT/'partial-results.json').unlink();print(json.dumps(report['summary']),flush=True)
if __name__=='__main__':main()
