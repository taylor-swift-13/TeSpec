#!/usr/bin/env python3
"""Build an auditable compatibility candidate without changing allocator C tokens."""
import argparse
import hashlib
import json
from pathlib import Path
import re
HERE=Path(__file__).resolve().parent
SOURCE=HERE.parents[1]/'source-snapshots/fulminate/pkvm-buddy'
ALIASES='''
function (u64) xor_uf(u64 x, u64 y) { x ^ y }
function (u64) power_uf(u64 x, u64 y) { power(x,y) }
function (u64) bw_fls_uf(u64 x) { bw_fls(x) }
'''
sha=lambda data:hashlib.sha256(data).hexdigest()
comments=re.compile(r'/\*[\s\S]*?\*/')

def c_tokens(text):
    return re.sub(r'\s+','',re.sub(r'/\*[\s\S]*?\*/|//[^\n]*','',text))

def adapt_annotation(match):
    text=match.group(0).replace('member_shift<hyp_pool>', 'member_shift<struct hyp_pool>')
    def accesses(m):
        names=re.findall(r'[A-Za-z_][A-Za-z_0-9]*',m.group(1))
        return ' '.join('accesses '+name+';' for name in names)
    text=re.sub(r'\baccesses\s+((?:[A-Za-z_][A-Za-z_0-9]*\s*;\s*)+)',accesses,text)
    if 'spec memset(pointer b, i32 cc, u64 len);' in text:
        text=text.replace('spec memset(pointer b, i32 cc, u64 len);',
                          'spec memset(pointer b, integer cc, integer len);')
        text=text.replace('b_i+len', 'b_i+(u64)len')
    return text

def merge_contracts(text):
    matches=list(comments.finditer(text));replacements=[];i=0
    while i<len(matches):
        if not matches[i].group(0).startswith('/*@'):i+=1;continue
        last=i;j=i+1;previous=i
        while j<len(matches) and not text[matches[previous].end():matches[j].start()].strip():
            if matches[j].group(0).startswith('/*@'):last=j
            previous=j;j+=1
        if last==i:i+=1;continue
        fragments=[m.group(0)[3:-2].rstrip().removesuffix('@').rstrip()
                   for m in matches[i:last+1] if m.group(0).startswith('/*@')]
        seen=set()
        def keyword(m):
            name=m.group(0)
            if name in seen:return ''
            seen.add(name);return name
        body=re.sub(r'\b(?:requires|ensures|inv)\b',keyword,'\n'.join(fragments))
        replacements.append((matches[i].start(),matches[last].end(),'/*@ '+body+' @*/'))
        i=last+1
    for start,end,replacement in reversed(replacements):text=text[:start]+replacement+text[end:]
    return text,len(replacements)

def main():
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('--output',required=True,type=Path);a=p.parse_args()
    dest=a.output.resolve();dest.mkdir(parents=True,exist_ok=False);rows=[]
    for path in sorted(SOURCE.iterdir()):
        if not path.is_file():continue
        original=path.read_text();normalized=original
        if path.suffix in ('.c','.h'):
            normalized=re.sub(r'/\*@.*?\*/',adapt_annotation,normalized,flags=re.S)
            if path.name in ('defs.h','bug1.defs.h'):normalized=normalized.replace('/*@','/*@'+ALIASES,1)
            normalized,groups=merge_contracts(normalized)
        else:groups=0
        assert c_tokens(original)==c_tokens(normalized),path.name
        (dest/path.name).write_text(normalized)
        rows.append({'file':path.name,'original_sha256':sha(path.read_bytes()),
                     'normalized_sha256':sha((dest/path.name).read_bytes()),
                     'c_tokens_sha256':sha(c_tokens(original).encode()),'merged_comment_groups':groups})
    report={'scope':'Compatibility candidate: explicit struct tag, old builtin-name aliases, explicit access-list entries, and adjacent contract-fragment joining; allocator C tokens unchanged. Full specification equivalence and runtime verdicts not yet established.',
            'source_revision':'66afeefe9556bc32b8b027d5b7f62bc3a7069703','generator_sha256':sha(Path(__file__).read_bytes()),'files':rows}
    (dest/'migration.json').write_text(json.dumps(report,indent=2)+'\n')
    print(json.dumps({'files':len(rows),'merged_groups':sum(r['merged_comment_groups'] for r in rows)}))

if __name__=='__main__':main()
