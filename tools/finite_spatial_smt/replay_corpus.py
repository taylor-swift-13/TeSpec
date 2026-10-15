"""Offline SMT replay of frozen spatial VCs, never an end-to-end program test."""
import argparse
import collections
import hashlib
import json
from pathlib import Path
import resource
import time
import z3
from finite_spatial_smt import check
from concrete_oracle import judge


def replay(corpus,out,timeout_ms):
    out.mkdir(parents=True,exist_ok=False);(out/'queries').mkdir()
    cases=json.loads(corpus.read_text());rows=[];start=time.monotonic();counts=collections.Counter();oracles=collections.Counter()
    with (out/'results.jsonl').open('w') as stream:
        for index,case in enumerate(cases,1):
            result=check(case['vc'],timeout_ms=timeout_ms,include_smt=True)
            smt=result.pop('smt2',None)
            if smt is not None:
                name=case['id']+'.smt2';(out/'queries'/name).write_text(smt)
                result.update(query_file='queries/'+name,query_sha256=hashlib.sha256(smt.encode()).hexdigest())
            expected=judge(case['vc'])
            if expected!='NOT_APPLICABLE' and result['status']!=expected:
                raise AssertionError({'id':case['id'],'independent_oracle':expected,'smt':result})
            result.update(id=case['id'],raw_ids=case['raw_ids'],independent_ground_oracle=expected)
            rows.append(result);counts[result['status']]+=1;oracles[expected]+=1
            stream.write(json.dumps(result)+'\n');stream.flush()
            if index%50==0:print(f'replayed {index}/{len(cases)}: {dict(counts)}',flush=True)
    times=sorted(r['wall_seconds'] for r in rows)
    summary={'schema':'finite-spatial-replay/v1','unique_normalized_vcs':len(cases),
             'status_counts':dict(counts),'raw_vc_counts':dict(collections.Counter({s:sum(len(r['raw_ids']) for r in rows if r['status']==s) for s in counts})),
             'independent_ground_oracle':dict(oracles),'vacuous_valid':sum(r.get('vacuous',False) for r in rows),
             'total_wall_seconds':time.monotonic()-start,'median_case_seconds':times[len(times)//2] if times else None,
             'max_case_seconds':max(times,default=0),'process_peak_rss_kib':resource.getrusage(resource.RUSAGE_SELF).ru_maxrss,
             'memory_metric':'Peak RSS of the entire offline Python replay process, not per-VC peak.',
             'z3_version':z3.get_version_string(),'timeout_ms_per_query':timeout_ms,
             'model_calls':0,'tokens':0,'executor_runs':0,'itp_runs':0,
             'certificate':'NOT_CHECKED','corpus_sha256':hashlib.sha256(corpus.read_bytes()).hexdigest(),
             'scope':'VC judgement only; historical test verdicts and path reachability are not changed.'}
    (out/'summary.json').write_text(json.dumps(summary,indent=2)+'\n');print(json.dumps(summary,indent=2),flush=True)


if __name__=='__main__':
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('--corpus',type=Path,required=True)
    p.add_argument('--output',type=Path,required=True);p.add_argument('--timeout-ms',type=int,default=2000)
    args=p.parse_args();replay(args.corpus,args.output,args.timeout_ms)
