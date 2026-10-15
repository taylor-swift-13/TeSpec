"""Import already-recorded UNKNOWN VCs. Does not run the original programs.

Input is the JSON inventory produced by scan_history.py. All exclusions and raw
assertions are retained. A normalized VC is replayed once, never per file copy.
"""
import argparse
import collections
import gzip
import hashlib
import json
from pathlib import Path
import time

from finite_spatial_smt import Unsupported, encode
from qcp_import import import_record


def digest(data):return hashlib.sha256(data).hexdigest()
def canonical(data):return json.dumps(data,sort_keys=True,separators=(',',':'))


def collect(inventory,out):
    out.mkdir(parents=True,exist_ok=False)
    rows=json.loads(inventory.read_text());raw={};source_hashes={};cases={};reasons=collections.Counter()
    for row in rows:
        v=row['vc']
        key=digest(canonical([v['kind'],v['path'],v['goal'],row.get('layout')]).encode())
        raw.setdefault(key,{'id':key,'record':row,'occurrences':[]})['occurrences'].append(
            {k:row.get(k) for k in ('source','index','case_id','entry','completed','semantics','function')})
    start=time.monotonic()
    with gzip.open(out/'inventory.jsonl.gz','wt',encoding='utf8') as stream:
        for count,(key,record) in enumerate(sorted(raw.items()),1):
            row=record['record']
            try:
                converted=import_record(row)
                if not any(a['spatial'] for side in ('pre','post') for a in converted[side]):
                    raise Unsupported('pure_only_not_spatial_corpus')
                # Validate bounds/schema before admitting to the replay corpus.
                encode(converted)
                cid=digest(canonical(converted).encode())
                record['import_status']='SUPPORTED';record['normalized_id']=cid
                cases.setdefault(cid,{'id':cid,'vc':converted,'raw_ids':[]})['raw_ids'].append(key)
            except Unsupported as exc:
                record['import_status']='UNSUPPORTED';record['reason']=str(exc)
                reasons[str(exc).split(':',1)[0]]+=1
            for source in record['occurrences']:
                name=source['source']
                if name not in source_hashes:
                    source_hashes[name]=digest(Path(name).read_bytes()) if Path(name).is_file() else None
                source['source_sha256']=source_hashes[name]
            stream.write(json.dumps(record,separators=(',',':'))+'\n')
            if count%2000==0:print(f'imported {count}/{len(raw)}; normalized supported {len(cases)}',flush=True)
    (out/'cases.json').write_text(json.dumps(list(cases.values()),indent=2)+'\n')
    summary={'schema':'finite-spatial-corpus/v1','historical_observations':len(rows),
             'unique_raw_vcs':len(raw),'supported_raw_vcs':sum(len(c['raw_ids']) for c in cases.values()),
             'unique_normalized_supported_vcs':len(cases),'unsupported_raw_vcs':sum(reasons.values()),
             'exclusion_reasons':dict(reasons),'source_files':len(source_hashes),
             'inventory_input_sha256':digest(inventory.read_bytes()),'collection_seconds':time.monotonic()-start,
             'scope':'Offline replay of historical UNKNOWN spatial VCs; no executor runs, no status replacement.',
             'compatibility':'Built-in semantic adapter, not a certified historical-runtime equivalence proof.'}
    (out/'collection-summary.json').write_text(json.dumps(summary,indent=2)+'\n')
    print(json.dumps(summary,indent=2),flush=True)


if __name__=='__main__':
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('--inventory',type=Path,required=True)
    p.add_argument('--output',type=Path,required=True);args=p.parse_args();collect(args.inventory,args.output)
