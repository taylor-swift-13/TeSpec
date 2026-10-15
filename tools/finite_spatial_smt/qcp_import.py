"""Fail-closed importer for the QCP PROP/LOCAL/SEP diagnostic representation.

Only built-in cells, concrete builtin arrays and integer existential binders.
No arbitrary predicate unfolding, unknown function approximation, or LOCAL loss.
"""
import re
import z3
if __package__:
    from .finite_spatial_smt import Expressions, Unsupported, integer, boolean
else:
    from finite_spatial_smt import Expressions, Unsupported, integer, boolean
if __package__:
    from .finite_qcp_terms import list_values, pure_terms, materialize_list_binders
else:
    from finite_qcp_terms import list_values, pure_terms, materialize_list_binders


TYPES={'signed int':'i32','unsigned int':'u32','signed I8':'i8','unsigned I8':'u8',
       'signed char':'i8','unsigned char':'u8','signed short':'i16','unsigned short':'u16',
       'signed I64':'i64','unsigned I64':'u64','signed long long':'i64',
       'unsigned long long':'u64','_Bool':'bool'}
ARRAYS={'CharArray':'i8','UCharArray':'u8','ShortArray':'i16','UShortArray':'u16',
        'IntArray':'i32','UIntArray':'u32','Int64Array':'i64','UInt64Array':'u64','PtrArray':'ptr'}


def split_top(text, sep=','):
    out=[];depth=0;start=0
    for i,c in enumerate(text):
        if c=='(': depth+=1
        elif c==')':
            depth-=1
            if depth<0: raise Unsupported('unbalanced_parentheses')
        elif c==sep and depth==0:
            out.append(text[start:i].strip());start=i+1
    if depth: raise Unsupported('unbalanced_parentheses')
    if text[start:].strip():out.append(text[start:].strip())
    elif out: raise Unsupported('trailing_separator')
    return out


def call(text):
    m=re.fullmatch(r'([A-Za-z_]\w*(?:\.\w+)?)\s*\((.*)\)',text.strip(),re.S)
    if not m: raise Unsupported('unsupported_term:'+text[:100])
    return m[1],split_top(m[2])


def scalar_type(text):
    text=' '.join(text.split())
    if text.endswith('*') and re.fullmatch(r'[\w *]+',text): return 'ptr'
    if text not in TYPES: raise Unsupported('unknown_qcp_type:'+text)
    return TYPES[text]


def scalar(text):
    text=text.strip()
    # POINTER_OFFSET is explicitly lowered to addr + offset * size in QCP.
    if text.startswith('pointer_offset('):
        name,args=call(text)
        if len(args)!=4: raise Unsupported('pointer_offset_arity')
        scalar_type(args[3])
        text=f'({scalar(args[0])}) + ({scalar(args[1])}) * ({scalar(args[2])})'
    parsed=z3.simplify(integer(Expressions().parse(text)))
    return str(parsed.as_long()) if z3.is_int_value(parsed) else text


def concrete(text):
    v=z3.simplify(Expressions().parse(scalar(text)))
    if not z3.is_int_value(v):raise Unsupported('nonconcrete_array_length')
    return v.as_long()


def finite_list(text,limit=512):
    values=[]
    while True:
        name,args=call(text)
        if name=='nil' and args==['Z_1']: return values
        if name=='cons' and len(args)==3 and args[0]=='Z_1':
            values.append(scalar(args[1]));text=args[2]
            if len(values)>limit: raise Unsupported('list_budget')
            continue
        if name=='repeat_Z' and len(args)==3 and args[0]=='Z_1':
            n=max(0,concrete(args[2]))
            if n+len(values)>limit: raise Unsupported('list_budget')
            return values+[scalar(args[1])]*n
        # zeros and user-defined functions are deliberately NOT assumed by name.
        raise Unsupported('unsupported_list_constructor:'+name)


def spatial(text,lists=None):
    name,args=call(text)
    if name=='store' and len(args)==3:
        return {'kind':'cell','address':scalar(args[0]),'value':scalar(args[1]),'type':scalar_type(args[2])}
    if name=='has_permission' and len(args)==2:
        return {'kind':'cell','address':scalar(args[0]),'value':None,'type':scalar_type(args[1])}
    if '.' in name:
        module,method=name.split('.')
        if module not in ARRAYS:raise Unsupported('unsupported_array_module:'+module)
        typ=ARRAYS[module]
        if method=='full' and len(args)==3:
            n=concrete(args[1]);values=list_values(args[2],lists)
            if n!=len(values):raise Unsupported('array_length_mismatch')
            return {'kind':'array','address':scalar(args[0]),'type':typ,'length':n,'values':values}
        if method=='undef_full' and len(args)==2:
            return {'kind':'array','address':scalar(args[0]),'type':typ,'length':concrete(args[1])}
        if method=='seg' and len(args)==4:
            lo,hi=concrete(args[1]),concrete(args[2]);values=list_values(args[3],lists)
            if hi-lo!=len(values):raise Unsupported('array_length_mismatch')
            return {'kind':'array','address':scalar(args[0]),'type':typ,'length':hi-lo,'start':lo,'values':values}
    raise Unsupported('unsupported_spatial_predicate:'+name)


PATTERN=re.compile(r'\s*(?P<ex>(?:EX\s+[^\n]+\n\s*)*)PROP\[(?P<pure>.*?)\]\s*LOCAL\[(?P<local>.*?)\]\s*SEP\[(?P<spatial>.*?)\]\s*',re.S)


def assertions(text):
    if not isinstance(text,str) or not text.strip():raise Unsupported('missing_assertion')
    result=[];pos=0
    while pos<len(text):
        m=PATTERN.match(text,pos)
        if not m:raise Unsupported('unsupported_assertion_format:'+text[pos:pos+100])
        if m['local'].strip():raise Unsupported('local_environment_requires_typed_adapter')
        names=[]
        for line in m['ex'].strip().splitlines():
            if line.strip(): names.extend(line.strip().removeprefix('EX ').split())
        original_pure=split_top(m['pure'],';')
        names,lists=materialize_list_binders(names,original_pure,m[0])
        pure=[]
        for p in original_pure:
            p={'prop_false':'False','prop_true':'True'}.get(p,p)
            pure.extend(pure_terms(p,lists))
        atoms=[spatial(s,lists) for s in split_top(m['spatial'],';')]
        result.append({'exists':names,'pure':pure,'spatial':atoms})
        pos=m.end()
    if not result:raise Unsupported('missing_assertion')
    return result


def import_record(row):
    layout=row.get('layout')
    if not isinstance(layout,dict):raise Unsupported('missing_target_layout')
    if layout.get('field_address_semantics')!='base-plus-byte-offset/v1':
        raise Unsupported('unsupported_address_semantics')
    kind=row['vc'].get('kind')
    # Only return VCs have an unambiguous exact-heap interpretation here.
    # Other diagnostic kinds must be imported with an explicit checked mode.
    if kind!='return':raise Unsupported('check_mode_not_established:'+str(kind))
    return {'schema':'finite-spatial-vc/v1',
            'layout':{k:layout.get(k) for k in ('architecture_bits','byte_order','memory_rules')},
            'mode':'exact','pre':assertions(row['vc']['path']),'post':assertions(row['vc']['goal'])}
