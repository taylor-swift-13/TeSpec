"""Freeze historical unit-test fixtures only after independent oracle agreement."""
import argparse
import collections
import gzip
import json
from pathlib import Path
from finite_spatial_smt import Unsupported
from qcp_import import import_record
from concrete_oracle import judge


def freeze(corpus,output):
    replay={x['id']:x for x in map(json.loads,(corpus/'replay/results.jsonl').read_text().splitlines())}
    supported=[];unsupported=[];reasons=collections.Counter()
    for line in gzip.open(corpus/'inventory.jsonl.gz','rt'):
        raw=json.loads(line)
        if raw['import_status']=='SUPPORTED':
            expected=judge(import_record(raw['record']))
            if expected not in ('VALID','INVALID') or replay[raw['normalized_id']]['status']!=expected:
                raise ValueError('No independent oracle agreement for '+raw['id'])
            supported.append({'id':raw['id'],'record':raw['record'],
                              'source_sha256':raw['occurrences'][0]['source_sha256'],'expected':expected})
        else:
            reason=raw['reason'].split(':',1)[0]
            if reason in {'pure_only_not_spatial_corpus','check_mode_not_established'} or reasons[reason]>=3:continue
            try:import_record(raw['record'])
            except Unsupported:
                unsupported.append({'id':raw['id'],'record':raw['record'],'expected':'UNKNOWN','reason':raw['reason']})
                reasons[reason]+=1
    output.parent.mkdir(parents=True,exist_ok=True)
    output.write_text(json.dumps({'schema':'historical-vc-unit-fixtures/v1','supported':supported,'unsupported':unsupported},indent=2)+'\n')
    print(json.dumps({'supported':len(supported),'unsupported':len(unsupported)}))


if __name__=='__main__':
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('--corpus',type=Path,required=True)
    p.add_argument('--output',type=Path,required=True);args=p.parse_args();freeze(args.corpus,args.output)
