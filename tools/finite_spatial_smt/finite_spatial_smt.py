"""Standalone finite spatial VC encoder. No executor or proof-driver integration.

Semantic profile: QCP naive_C_Rules32/64, big endian, finite symbolic heaps.
Heap bytes are quotiented by Byte.eqm; undef_store accepts initialized bytes too.
This is a tested implementation, NOT a kernel-certified translation.
"""
from __future__ import annotations

import ast
from dataclasses import dataclass
import json
import re
import time
from typing import Any

import z3


class Unsupported(ValueError):
    """Input is outside the explicitly supported semantic fragment."""


@dataclass(frozen=True)
class TypeInfo:
    size: int
    alignment: int
    lower: int
    upper: int


def type_info(name: str, bits: int) -> TypeInfo:
    table = {
        'i8': (1, 1, -128, 127), 'u8': (1, 1, 0, 255),
        'bool': (1, 1, 0, 1),
        'i16': (2, 2, -(2**15), 2**15-1), 'u16': (2, 2, 0, 2**16-1),
        'i32': (4, 4, -(2**31), 2**31-1), 'u32': (4, 4, 0, 2**32-1),
        # QCP isvalidptr_int64/128 use alignment FOUR, even under Arch64.
        'i64': (8, 4, -(2**63), 2**63-1), 'u64': (8, 4, 0, 2**64-1),
        'i128': (16, 4, -(2**127), 2**127-1), 'u128': (16, 4, 0, 2**128-1),
        'ptr': (bits//8, bits//8, 0, 2**bits-1),
    }
    if not isinstance(name,str) or name not in table:
        raise Unsupported(f'unsupported_cell_type:{name}')
    return TypeInfo(*table[name])


CONSTANTS = {
    'INT_MIN': -(2**31), 'INT_MAX': 2**31-1, 'UINT_MAX': 2**32-1,
    'SHRT_MIN': -(2**15), 'SHRT_MAX': 2**15-1, 'USHRT_MAX': 2**16-1,
    'SCHAR_MIN': -128, 'SCHAR_MAX': 127, 'UCHAR_MAX': 255,
    'LLONG_MIN': -(2**63), 'LLONG_MAX': 2**63-1, 'ULLONG_MAX': 2**64-1,
}


class Expressions:
    """Strict arithmetic parser: never eval(), never drop unknown expressions."""
    def __init__(self):
        self.variables: dict[str, z3.ArithRef] = {}

    def parse(self, source: Any, bound=None):
        bound = bound or {}
        if type(source) is bool:
            return z3.BoolVal(source)
        if type(source) is int:
            return z3.IntVal(source)
        if not isinstance(source, str) or len(source) > 16384:
            raise Unsupported('invalid_expression')
        source = source.replace('&&', ' and ').replace('||', ' or ')
        source = re.sub(r'!(?!=)', ' not ', source).strip()
        try:
            root = ast.parse(source, mode='eval').body
        except (SyntaxError, RecursionError) as exc:
            raise Unsupported(f'expression_syntax:{source[:100]}') from exc

        def visit(n):
            if isinstance(n, ast.Constant):
                if type(n.value) is bool: return z3.BoolVal(n.value)
                if type(n.value) is int: return z3.IntVal(n.value)
            elif isinstance(n, ast.Name):
                if n.id in bound: return bound[n.id]
                if n.id in CONSTANTS: return z3.IntVal(CONSTANTS[n.id])
                if n.id in {'true', 'True'}: return z3.BoolVal(True)
                if n.id in {'false', 'False'}: return z3.BoolVal(False)
                if n.id.startswith('__fsm_'): raise Unsupported('reserved_identifier')
                if n.id not in self.variables: self.variables[n.id] = z3.Int('var::'+n.id)
                return self.variables[n.id]
            elif isinstance(n, ast.UnaryOp):
                v = visit(n.operand)
                if isinstance(n.op, ast.Not): return z3.Not(boolean(v))
                v = integer(v)
                if isinstance(n.op, ast.USub): return -v
                if isinstance(n.op, ast.UAdd): return v
            elif isinstance(n, ast.BinOp):
                a,b = integer(visit(n.left)),integer(visit(n.right))
                if isinstance(n.op, ast.Add): return a+b
                if isinstance(n.op, ast.Sub): return a-b
                if isinstance(n.op, ast.Mult): return a*b
                # Positive literal divisors: Z.div/mod and SMT Int div/mod agree.
                if isinstance(n.op, (ast.FloorDiv, ast.Mod)):
                    divisor = z3.simplify(b)
                    if not z3.is_int_value(divisor) or divisor.as_long() <= 0:
                        raise Unsupported('nonpositive_or_symbolic_divisor')
                    return a/b if isinstance(n.op,ast.FloorDiv) else a%b
            elif isinstance(n, ast.BoolOp):
                vs=[boolean(visit(v)) for v in n.values]
                return z3.And(*vs) if isinstance(n.op,ast.And) else z3.Or(*vs)
            elif isinstance(n, ast.Compare):
                left=visit(n.left); parts=[]
                for op,right_node in zip(n.ops,n.comparators):
                    right=visit(right_node)
                    if left.sort()!=right.sort(): raise Unsupported('comparison_sort_mismatch')
                    if isinstance(op,ast.Eq): parts.append(left==right)
                    elif isinstance(op,ast.NotEq): parts.append(left!=right)
                    else:
                        a,b=integer(left),integer(right)
                        if isinstance(op,ast.Lt): parts.append(a<b)
                        elif isinstance(op,ast.LtE): parts.append(a<=b)
                        elif isinstance(op,ast.Gt): parts.append(a>b)
                        elif isinstance(op,ast.GtE): parts.append(a>=b)
                        else: raise Unsupported('unsupported_comparison')
                    left=right
                return z3.And(*parts)
            raise Unsupported(f'unsupported_expression_node:{type(n).__name__}')
        return visit(root)


def integer(v):
    if not z3.is_int(v): raise Unsupported('integer_expression_required')
    return v


def boolean(v):
    if not z3.is_bool(v): raise Unsupported('boolean_expression_required')
    return v


def keys(obj, allowed, required=()):
    if not isinstance(obj,dict): raise Unsupported('object_required')
    extra=set(obj)-set(allowed)
    missing=set(required)-set(obj)
    if extra or missing: raise Unsupported(f'schema_fields:extra={sorted(extra)},missing={sorted(missing)}')


@dataclass
class Encoding:
    pre: z3.BoolRef
    post: z3.BoolRef
    query: z3.BoolRef
    owned: z3.ArrayRef
    initialized: z3.ArrayRef
    memory: z3.ArrayRef
    variables: dict
    witnesses: dict
    pre_addresses: list
    mode: str

    def smt2(self, timeout_ms=5000):
        s=z3.Solver();s.set(timeout=timeout_ms);s.add(self.query)
        return s.to_smt2()


def encode(vc: dict, *, max_bytes=512, max_alternatives=64, eliminate_value_witnesses=True) -> Encoding:
    keys(vc, {'schema','layout','mode','pre','post'}, {'layout','mode','pre','post'})
    if vc.get('schema','finite-spatial-vc/v1')!='finite-spatial-vc/v1':
        raise Unsupported('unsupported_schema')
    layout=vc['layout']
    keys(layout, {'architecture_bits','byte_order','memory_rules'},
         {'architecture_bits','byte_order','memory_rules'})
    bits=layout['architecture_bits']
    if type(bits) is not int or bits not in (32,64): raise Unsupported('unsupported_architecture')
    expected={'naive_C_Rules','naive_C_Rules32'} if bits==32 else {'naive_C_Rules64'}
    if layout['memory_rules'] not in expected or layout['byte_order']!='big':
        raise Unsupported('unsupported_memory_profile')
    if vc['mode'] not in ('exact','frame'): raise Unsupported('explicit_check_mode_required')
    if not isinstance(vc['pre'],list) or not isinstance(vc['post'],list):
        raise Unsupported('assertion_alternatives_required')
    if len(vc['pre'])+len(vc['post'])>max_alternatives: raise Unsupported('alternative_budget')
    expressions=Expressions()
    D=z3.Array('__fsm_owned',z3.IntSort(),z3.BoolSort())
    I=z3.Array('__fsm_initialized',z3.IntSort(),z3.BoolSort())
    M=z3.Array('__fsm_memory',z3.IntSort(),z3.IntSort())
    witnesses={};pre_addresses=[]

    def assertion(a, label, frame=False, consequent=False):
        keys(a, {'exists','pure','spatial'}, {'spatial'})
        names=a.get('exists',[])
        if not isinstance(names,list) or any(not isinstance(n,str) or not re.fullmatch(r'[A-Za-z_]\w*',n) or n in CONSTANTS or n.startswith('__fsm_') for n in names) or len(set(names))!=len(names):
            raise Unsupported('invalid_existential_binders')
        bound={n:z3.Int('__fsm_'+label+'::'+n) for n in names}
        if not consequent: witnesses.update({label+'::'+n:v for n,v in bound.items()})
        parse=lambda x: integer(expressions.parse(x,bound))
        pure=a.get('pure',[])
        if not isinstance(pure,list) or not isinstance(a['spatial'],list): raise Unsupported('assertion_lists_required')
        conditions=[boolean(expressions.parse(p,bound)) for p in pure]
        addresses=[];value_witnesses={}

        def cell(address,typ,value):
            t=type_info(typ,bits);p=parse(address)
            if len(addresses)+t.size>max_bytes: raise Unsupported('byte_budget')
            conditions.extend([p>=0,p+t.size-1<=2**bits-1,p%t.alignment==0])
            v=None if value is None else parse(value)
            if v is not None: conditions.extend([v>=t.lower,v<=t.upper])
            for offset in range(t.size):
                addr=p+offset;addresses.append(addr)
                b=z3.Select(M,addr)
                # Canonical byte representatives; no constraints on unowned bytes.
                conditions.extend([b>=0,b<256])
                if v is not None:
                    byte=(v/(256**(t.size-offset-1)))%256
                    conditions.extend([z3.Select(I,addr),b==byte])
            if consequent and eliminate_value_witnesses and v is not None:
                # An initialized typed cell determines a UNIQUE in-range value.
                # Eliminate only value binders whose address has no local binder;
                # address witnesses/cyclic dependencies retain their quantifiers.
                from z3.z3util import get_vars
                address_vars=get_vars(p)
                if not any(any(x.eq(y) for y in bound.values()) for x in address_vars):
                    for name,w in bound.items():
                        if v.eq(w) and name not in value_witnesses:
                            unsigned=sum(z3.Select(M,p+j)*256**(t.size-j-1) for j in range(t.size))
                            decoded=z3.If(unsigned>=2**(8*t.size-1),unsigned-2**(8*t.size),unsigned) if t.lower<0 else unsigned
                            value_witnesses[name]=decoded

        for atom in a['spatial']:
            if not isinstance(atom,dict): raise Unsupported('spatial_atom_required')
            kind=atom.get('kind')
            if kind=='cell':
                keys(atom,{'kind','address','type','value'},{'address','type'})
                cell(atom['address'],atom['type'],atom.get('value'))
            elif kind=='array':
                keys(atom,{'kind','address','type','values','length','start'}, {'address','type','length'})
                n=atom['length'];start=atom.get('start',0)
                if type(n) is not int or type(start) is not int or n<0: raise Unsupported('concrete_nonnegative_array_length_required')
                t=type_info(atom['type'],bits)
                if n*t.size+len(addresses)>max_bytes: raise Unsupported('byte_budget')
                values=atom.get('values')
                if values is not None and (not isinstance(values,list) or len(values)!=n):
                    raise Unsupported('array_length_mismatch')
                # Base expression is validated even for an empty array.
                parse(atom['address'])
                for i in range(n):
                    cell(f"({atom['address']}) + {(start+i)*t.size}",atom['type'],None if values is None else values[i])
            else: raise Unsupported(f'unsupported_spatial_predicate:{kind}')
        if len(addresses)>1: conditions.append(z3.Distinct(*addresses))
        if frame:
            conditions.extend(z3.Select(D,p) for p in addresses)
        else:
            footprint=z3.K(z3.IntSort(),False)
            for p in addresses: footprint=z3.Store(footprint,p,True)
            conditions.append(D==footprint)
        formula=z3.And(*conditions)
        if value_witnesses:
            formula=z3.substitute(formula,*[(bound[n],v) for n,v in value_witnesses.items()])
        remaining=[w for n,w in bound.items() if n not in value_witnesses]
        if consequent and remaining: formula=z3.Exists(remaining,formula)
        if not consequent: pre_addresses.extend(addresses)
        return formula

    pre=z3.Or(*[assertion(a,f'pre{i}') for i,a in enumerate(vc['pre'])])
    post=z3.Or(*[assertion(a,f'post{i}',vc['mode']=='frame',True) for i,a in enumerate(vc['post'])])
    return Encoding(pre,post,z3.And(pre,z3.Not(post)),D,I,M,expressions.variables,witnesses,pre_addresses,vc['mode'])


def check(vc: dict, *, timeout_ms=5000, max_bytes=512, include_smt=False) -> dict:
    start=time.monotonic()
    result={'status':'UNKNOWN','certificate':'NOT_CHECKED','scope':'spatial_vc_only'}
    try:
        enc=encode(vc,max_bytes=max_bytes)
    except Unsupported as exc:
        result.update(reason=str(exc),supported=False,wall_seconds=time.monotonic()-start)
        return result
    result['supported']=True
    if include_smt: result['smt2']=enc.smt2(timeout_ms)
    s=z3.Solver();s.set(timeout=max(1,timeout_ms));s.add(z3.simplify(enc.query))
    answer=s.check();result['solver_result']=str(answer)
    if answer==z3.unsat:
        result.update(status='VALID',reason='counterexample_query_unsat')
        consistency=z3.Solver();consistency.set(timeout=max(1,timeout_ms));consistency.add(enc.pre)
        pre_answer=consistency.check()
        result['antecedent_satisfiability']=str(pre_answer)
        result['vacuous']=pre_answer==z3.unsat
    elif answer==z3.sat:
        model=s.model()
        def number(v): return model.eval(v,model_completion=True).as_long()
        addresses=sorted({number(p) for p in enc.pre_addresses
                          if z3.is_true(model.eval(z3.Select(enc.owned,p),model_completion=True))})
        heap=[{'address':p,'initialized':z3.is_true(model.eval(z3.Select(enc.initialized,p),model_completion=True)),
               'byte':number(z3.Select(enc.memory,p))} for p in addresses]
        result.update(status='INVALID',reason='counterexample_query_sat',
                      antecedent_satisfiability='sat',vacuous=False,
                      countermodel={'variables':{n:number(v) for n,v in enc.variables.items()},
                                    'pre_witnesses':{n:number(v) for n,v in enc.witnesses.items()},'heap':heap})
    else: result['reason']='solver_unknown:'+s.reason_unknown()
    result['wall_seconds']=time.monotonic()-start
    return result


def main():
    import argparse
    from pathlib import Path
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument('vc',type=Path);p.add_argument('--timeout-ms',type=int,default=5000)
    p.add_argument('--smt2',type=Path);p.add_argument('--output',type=Path)
    args=p.parse_args()
    result=check(json.loads(args.vc.read_text()),timeout_ms=args.timeout_ms,include_smt=bool(args.smt2))
    smt=result.pop('smt2',None)
    if smt is not None: args.smt2.write_text(smt)
    text=json.dumps(result,indent=2)+'\n'
    if args.output: args.output.write_text(text)
    else: print(text,end='')


if __name__=='__main__': main()
