"""Independent executable semantics for ground finite symbolic heaps.

No SMT imports. Used to cross-check offline results, not as the encoding backend.
No quantifier guessing: symbolic expressions/existentials return NOT_APPLICABLE.
"""
import ast
from dataclasses import dataclass


class NotGround(ValueError):pass
PARAMS={'i8':(1,1,-128,127),'u8':(1,1,0,255),'bool':(1,1,0,1),
 'i16':(2,2,-32768,32767),'u16':(2,2,0,65535),
 'i32':(4,4,-2147483648,2147483647),'u32':(4,4,0,4294967295),
 'i64':(8,4,-2**63,2**63-1),'u64':(8,4,0,2**64-1),
 'i128':(16,4,-2**127,2**127-1),'u128':(16,4,0,2**128-1)}
NAMED_INTEGERS={'INT_MIN':-2147483648,'INT_MAX':2147483647,'UINT_MAX':4294967295,
 'SHRT_MIN':-32768,'SHRT_MAX':32767,'USHRT_MAX':65535,
 'SCHAR_MIN':-128,'SCHAR_MAX':127,'UCHAR_MAX':255,
 'LLONG_MIN':-9223372036854775808,'LLONG_MAX':9223372036854775807,'ULLONG_MAX':18446744073709551615}


def evaluate(value,env=None):
    env=env or {}
    if type(value) in (int,bool):return value
    if not isinstance(value,str):raise NotGround()
    def visit(n):
        if isinstance(n,ast.Constant) and type(n.value) in (int,bool):return n.value
        if isinstance(n,ast.Name) and n.id in env:return env[n.id]
        if isinstance(n,ast.Name) and n.id in NAMED_INTEGERS:return NAMED_INTEGERS[n.id]
        if isinstance(n,ast.UnaryOp):
            a=visit(n.operand)
            if isinstance(n.op,ast.USub):return -a
            if isinstance(n.op,ast.UAdd):return a
            if isinstance(n.op,ast.Not):return not a
        if isinstance(n,ast.BinOp):
            a,b=visit(n.left),visit(n.right)
            if isinstance(n.op,ast.Add):return a+b
            if isinstance(n.op,ast.Sub):return a-b
            if isinstance(n.op,ast.Mult):return a*b
            if isinstance(n.op,ast.FloorDiv) and b>0:return a//b
            if isinstance(n.op,ast.Mod) and b>0:return a%b
        if isinstance(n,ast.BoolOp):
            values=[visit(a) for a in n.values]
            return all(values) if isinstance(n.op,ast.And) else any(values)
        if isinstance(n,ast.Compare):
            values=[visit(n.left)]+[visit(x) for x in n.comparators];answers=[]
            for a,op,b in zip(values,n.ops,values[1:]):
                if isinstance(op,ast.Eq):answers.append(a==b)
                elif isinstance(op,ast.NotEq):answers.append(a!=b)
                elif isinstance(op,ast.Lt):answers.append(a<b)
                elif isinstance(op,ast.LtE):answers.append(a<=b)
                elif isinstance(op,ast.Gt):answers.append(a>b)
                elif isinstance(op,ast.GtE):answers.append(a>=b)
                else:raise NotGround()
            return all(answers)
        raise NotGround()
    try:return visit(ast.parse(value,mode='eval').body)
    except (SyntaxError,TypeError,ZeroDivisionError) as exc:raise NotGround() from exc


def heap(assertion,bits,env=None):
    env=env or {}
    if any(n not in env for n in assertion.get('exists',[])):raise NotGround()
    # Evaluate all expressions; do not hide unsupported terms behind False.
    props=[evaluate(p,env) for p in assertion.get('pure',[])]
    memory={};valid=all(props)
    for atom in assertion['spatial']:
        typ=atom['type']
        size,align,lo,hi=(bits//8,bits//8,0,2**bits-1) if typ=='ptr' else PARAMS[typ]
        base=evaluate(atom['address'],env)
        if atom['kind']=='cell':elements=[(base,atom.get('value'))]
        elif atom['kind']=='array':
            n=atom['length'];start=atom.get('start',0)
            elements=[(base+(start+i)*size,None if atom.get('values') is None else atom['values'][i]) for i in range(n)]
        else:raise NotGround()
        for address,value in elements:
            value=None if value is None else evaluate(value,env)
            if address<0 or address+size>2**bits or address%align:valid=False
            if value is not None and not lo<=value<=hi:valid=False
            raw=[None]*size if value is None else list((value%(1<<(8*size))).to_bytes(size,'big'))
            for p,b in zip(range(address,address+size),raw):
                if p in memory:valid=False
                memory[p]=b
    return memory if valid else None


def judge(vc):
    if len(vc['pre'])!=1 or len(vc['post'])!=1:return 'NOT_APPLICABLE'
    try:
        left=heap(vc['pre'][0],vc['layout']['architecture_bits'])
        post=vc['post'][0];bits=vc['layout']['architecture_bits'];witnesses={}
        if post.get('exists') and left is not None:
            # Independent witness reconstruction from concrete bytes, using
            # Python's signed-byte decoder rather than the SMT substitution.
            for atom in post['spatial']:
                typ=atom['type'];size,align,lo,hi=(bits//8,bits//8,0,2**bits-1) if typ=='ptr' else PARAMS[typ]
                base=evaluate(atom['address'])
                if atom['kind']=='cell':elements=[(base,atom.get('value'))]
                else:elements=[(base+(atom.get('start',0)+i)*size,v) for i,v in enumerate(atom.get('values') or [])]
                for address,value in elements:
                    if isinstance(value,str) and value in post['exists'] and value not in witnesses:
                        if any(p not in left for p in range(address,address+size)):return 'INVALID'
                        if any(left[p] is None for p in range(address,address+size)):raise NotGround()
                        witnesses[value]=int.from_bytes(bytes(left[p] for p in range(address,address+size)),'big',signed=lo<0)
        if left is None:return 'VALID'
        right=heap(post,bits,witnesses)
    except (NotGround,KeyError):return 'NOT_APPLICABLE'
    if left is None:return 'VALID'
    if right is None:return 'INVALID'
    if not set(right)<=set(left):return 'INVALID'
    if vc['mode']=='exact' and set(left)!=set(right):return 'INVALID'
    if any(b is not None and left[p]!=b for p,b in right.items()):return 'INVALID'
    return 'VALID'
