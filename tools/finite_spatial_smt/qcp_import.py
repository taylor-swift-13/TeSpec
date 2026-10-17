"""Fail-closed importer for the QCP PROP/LOCAL/SEP diagnostic representation.

Only built-in cells, concrete builtin arrays and integer existential binders.
Nonempty LOCAL requires a checked, unchanged program-environment fragment.
No arbitrary predicate unfolding, unknown function approximation, or LOCAL loss.
"""
import ast
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
        if method=='missing_i' and len(args)==5:
            # ArrayLibCore.missing_i delegates to the recursive definition in
            # CommonAssertion.v:409-414. It skips exactly one index and keeps
            # the original complete list; nil/out-of-range is FALSE, not full.
            i,lo,hi=(concrete(x) for x in args[1:4])
            values=list_values(args[4],lists)
            if hi-lo!=len(values):raise Unsupported('array_length_mismatch')
            if not lo<=i<hi:raise Unsupported('missing_index_out_of_range')
            address=scalar(args[0]);cut=i-lo
            return [
                {'kind':'array','address':address,'type':typ,'length':cut,
                 'start':lo,'values':values[:cut]},
                {'kind':'array','address':address,'type':typ,'length':hi-i-1,
                 'start':i+1,'values':values[cut+1:]}]
    raise Unsupported('unsupported_spatial_predicate:'+name)


PATTERN=re.compile(r'\s*(?P<ex>(?:EX\s+[^\n]+\n\s*)*)PROP\[(?P<pure>.*?)\]\s*LOCAL\[(?P<local>.*?)\]\s*SEP\[(?P<spatial>.*?)\]\s*',re.S)


LOCAL_SEMANTICS = 'same-program-environment/v1'
LOCAL_SYMBOL_PREFIX = 'qcp_local_env_'


def assertion_parts(text):
    """Parse complete disjuncts once; never silently drop trailing fragments."""
    if not isinstance(text,str) or not text.strip():raise Unsupported('missing_assertion')
    result=[];pos=0
    while pos<len(text):
        m=PATTERN.match(text,pos)
        if not m:raise Unsupported('unsupported_assertion_format:'+text[pos:pos+100])
        result.append(m);pos=m.end()
    if not result:raise Unsupported('missing_assertion')
    return result


def existential_names(part):
    names=[]
    for line in part['ex'].strip().splitlines():
        if line.strip():names.extend(line.strip().removeprefix('EX ').split())
    return names


def local_bindings(part):
    """Accept only unambiguous Temp name -> global integer-expression maps.

    The native printer emits prog_var_info.name, not its unique ID. Duplicate
    names, bound expressions and changed/new consequent bindings are therefore
    outside this adapter, even when a richer typed protocol could decide them.
    """
    result={};bound=set(existential_names(part))
    for item in split_top(part['local'],';'):
        m=re.fullmatch(r'Temp\s+([A-Za-z_][A-Za-z0-9_]*)\s+(.+)',item,re.S)
        if not m:raise Unsupported('unsupported_local_binding:'+item[:100])
        name,expression=m.groups()
        if name in result:raise Unsupported('ambiguous_local_name:'+name)
        # Check before simplification too: this protocol admits global bindings,
        # not an existential expression whose arithmetic happens to cancel out.
        if any(re.search(r'\b'+re.escape(n)+r'\b',expression) for n in bound):
            raise Unsupported('existential_local_binding:'+name)
        value=scalar(expression)
        try:tree=ast.parse(value,mode='eval')
        except SyntaxError as error:raise Unsupported('unsupported_local_expression') from error
        if any(isinstance(n,ast.Name) and n.id in bound for n in ast.walk(tree)):
            raise Unsupported('existential_local_binding:'+name)
        result[name]=(value,ast.dump(tree,include_attributes=False))
    return result


def checked_local_symbols(pre_parts,post_parts,whole_text,semantics):
    """Retain LOCAL as pure equalities after checking the same-environment rule.

    A Temp is an environment binding; its actual storage remains in SEP.
    Source semantics: native InnerAsrtPrinter.c:501-509 and the addressable
    variable translation described in SymExec/frontend_brief.txt:13-29,74-82.
    A consequent may observe fewer locals, but every observed binding must be
    identical in every antecedent alternative. No name-based value inference.
    """
    if semantics not in (None,LOCAL_SEMANTICS):
        raise Unsupported('unsupported_local_semantics:'+str(semantics))
    parts=pre_parts+post_parts
    if not any(p['local'].strip() for p in parts):return None
    if semantics!=LOCAL_SEMANTICS:
        raise Unsupported('local_environment_requires_typed_adapter')
    if re.search(r'\b'+LOCAL_SYMBOL_PREFIX+r'\w*\b',whole_text):
        raise Unsupported('local_environment_symbol_collision')
    pre=[local_bindings(p) for p in pre_parts]
    post=[local_bindings(p) for p in post_parts]
    for left in pre:
        for right in post:
            for name,(_,syntax) in right.items():
                if name not in left:raise Unsupported('new_consequent_local:'+name)
                if left[name][1]!=syntax:raise Unsupported('changed_consequent_local:'+name)
    return {name:LOCAL_SYMBOL_PREFIX+name for env in pre+post for name in env}


def assertions(text,*,local_symbols=None):
    result=[]
    for m in assertion_parts(text):
        if m['local'].strip() and local_symbols is None:
            raise Unsupported('local_environment_requires_typed_adapter')
        names=existential_names(m)
        original_pure=split_top(m['pure'],';')
        names,lists=materialize_list_binders(names,original_pure,m[0])
        pure=[]
        for p in original_pure:
            p={'prop_false':'False','prop_true':'True'}.get(p,p)
            pure.extend(pure_terms(p,lists))
        for name,(value,_) in local_bindings(m).items():
            if name not in local_symbols:
                raise Unsupported('unchecked_local_binding:'+name)
            pure.append(f'{local_symbols[name]} == ({value})')
        atoms=[]
        for term in split_top(m['spatial'],';'):
            imported=spatial(term,lists)
            atoms.extend(imported if isinstance(imported,list) else [imported])
        result.append({'exists':names,'pure':pure,'spatial':atoms})
    return result


def import_record(row,*,check_mode=None,local_semantics=None):
    """Import a native query only after its exact-heap mode is established.

    Return VCs retain the existing exact default. The caller must explicitly
    attest exact mode for entailment queries using the copy-only/check-preserve
    protocol; an entailment/call kind alone never selects exact versus frame.
    """
    layout=row.get('layout')
    if not isinstance(layout,dict):raise Unsupported('missing_target_layout')
    if layout.get('field_address_semantics')!='base-plus-byte-offset/v1':
        raise Unsupported('unsupported_address_semantics')
    kind=row['vc'].get('kind')
    if kind=='return':
        if check_mode not in (None,'exact'):
            raise Unsupported('unsupported_return_check_mode:'+str(check_mode))
    elif kind=='entailment':
        if check_mode!='exact':
            raise Unsupported('check_mode_not_established:'+str(kind))
    else:
        raise Unsupported('check_mode_not_established:'+str(kind))
    pre_text=row['vc']['path'];post_text=row['vc']['goal']
    pre_parts=assertion_parts(pre_text);post_parts=assertion_parts(post_text)
    symbols=checked_local_symbols(pre_parts,post_parts,pre_text+'\n'+post_text,local_semantics)
    pre=assertions(pre_text,local_symbols=symbols)
    post=assertions(post_text,local_symbols=symbols)
    # The bundled PtrArray.storeA uses a literal 4-byte stride, whereas a
    # 64-bit pointer cell is 8 bytes. Do not silently substitute an 8-byte
    # array interpretation until this runtime profile has an explicit adapter.
    if layout.get('architecture_bits')!=32 and any(
        atom['kind']=='array' and atom['type']=='ptr'
        for assertion in pre+post for atom in assertion['spatial']):
        raise Unsupported('pointer_array_stride_not_established')
    return {'schema':'finite-spatial-vc/v1',
            'layout':{k:layout.get(k) for k in ('architecture_bits','byte_order','memory_rules')},
            'mode':'exact','pre':pre,'post':post}
