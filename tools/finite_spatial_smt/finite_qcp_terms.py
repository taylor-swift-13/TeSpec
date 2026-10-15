"""Exact reductions of finite QCP builtin lists and guarded integer quantifiers.

Unknown functions and unbounded/ambiguous quantified syntax are rejected. This is
not a general Coq interpreter or a user-defined predicate unfolding mechanism.
"""
import ast
import re
if __package__:
    from .finite_spatial_smt import Unsupported, Expressions, integer, boolean
else:
    from finite_spatial_smt import Unsupported, Expressions, integer, boolean
import z3


def numeral(text):
    value=z3.simplify(integer(Expressions().parse(text)))
    if not z3.is_int_value(value):raise Unsupported('nonconcrete_finite_bound')
    return value.as_long()


def reduce_term(text,lists=None):
    lists=lists or {}
    text=text.replace('&&',' and ').replace('||',' or ')
    text=re.sub(r'!(?!=)',' not ',text).strip()
    try:root=ast.parse(text,mode='eval')
    except SyntaxError as exc:raise Unsupported('finite_term_syntax:'+text[:100]) from exc

    class Reducer(ast.NodeTransformer):
        def visit_Name(self,node):
            if node.id in lists:
                return ast.List(elts=[ast.parse(v,mode='eval').body for v in lists[node.id]],ctx=ast.Load())
            return node

        def visit_Call(self,node):
            node=self.generic_visit(node)
            if node.keywords or not isinstance(node.func,ast.Name):raise Unsupported('unsupported_finite_function')
            name=node.func.id;args=node.args
            def tag():
                if not args or not isinstance(args[0],ast.Name) or args[0].id!='Z_1':
                    raise Unsupported('noninteger_list_type')
            def seq(x):
                if not isinstance(x,ast.List):raise Unsupported('nonfinite_list')
                return x.elts
            if name=='nil' and len(args)==1:tag();return ast.List(elts=[],ctx=ast.Load())
            if name=='cons' and len(args)==3:
                tag();tail=seq(args[2])
                if len(tail)>=512:raise Unsupported('list_budget')
                return ast.List(elts=[args[1]]+tail,ctx=ast.Load())
            if name=='repeat_Z' and len(args)==3:
                tag();n=max(0,numeral(ast.unparse(args[2])))
                if n>512:raise Unsupported('list_budget')
                return ast.List(elts=[args[1]]*n,ctx=ast.Load())
            if name=='app' and len(args)==3:
                tag();values=seq(args[1])+seq(args[2])
                if len(values)>512:raise Unsupported('list_budget')
                return ast.List(elts=values,ctx=ast.Load())
            if name=='Zlength' and len(args)==2:
                tag();return ast.Constant(len(seq(args[1])))
            if name=='Znth' and len(args)==4:
                tag();index=numeral(ast.unparse(args[1]));values=seq(args[2])
                return values[index] if 0<=index<len(values) else args[3]
            raise Unsupported('unsupported_finite_function:'+name)

        def visit_Subscript(self,node):
            node=self.generic_visit(node)
            if not isinstance(node.value,ast.List):raise Unsupported('nonfinite_list_index')
            index=numeral(ast.unparse(node.slice));values=node.value.elts
            # The printer omits a default value; don't guess out-of-range behavior.
            if not 0<=index<len(values):raise Unsupported('out_of_bounds_list_index')
            return values[index]

    try:root=ast.fix_missing_locations(Reducer().visit(root))
    except RecursionError as exc:raise Unsupported('finite_term_depth') from exc
    return root.body


def list_values(text,lists=None):
    root=reduce_term(text,lists)
    if not isinstance(root,ast.List):raise Unsupported('nonfinite_list')
    values=[]
    for element in root.elts:
        text=ast.unparse(element);v=z3.simplify(integer(Expressions().parse(text)))
        values.append(str(v.as_long()) if z3.is_int_value(v) else text)
    return values


def pure_terms(text,lists=None):
    m=re.fullmatch(r'forall\s+(\d+),\s*(.*)',text.strip(),re.S)
    if m:
        body=m[2]
        if body.count('->')!=1:raise Unsupported('unsupported_quantifier_shape')
        guard,consequence=body.split('->')
        # Explicit finite interval only; no inferred bounds or weakened guards.
        g=re.fullmatch(r'\s*(.+?)\s*<=\s*([A-Za-z_]\w*)\s*&&\s*\2\s*(<=|<)\s*(.+?)\s*',guard,re.S)
        if not g or not g[2].endswith('_'+m[1]):raise Unsupported('unsupported_quantifier_guard')
        binder_uses=set(re.findall(r'\b[A-Za-z_]\w*_'+m[1]+r'\b',body))
        if binder_uses!={g[2]}:raise Unsupported('ambiguous_quantifier_binder')
        lo=numeral(ast.unparse(reduce_term(g[1],lists)))
        hi=numeral(ast.unparse(reduce_term(g[4],lists)))+(g[3]=='<=')
        if hi-lo>128:raise Unsupported('quantifier_expansion_budget')
        answers=[]
        for i in range(lo,hi):
            instance=re.sub(r'\b'+re.escape(g[2])+r'\b',f'({i})',consequence)
            answers.extend(pure_terms(instance,lists))
        return answers
    root=reduce_term(text,lists);expression=ast.unparse(root)
    value=z3.simplify(boolean(Expressions().parse(expression)))
    if z3.is_true(value):return ['True']
    if z3.is_false(value):return ['False']
    return [expression]


def materialize_list_binders(names,pure,whole_text):
    lists={};new_names=list(names)
    for prop in pure:
        m=re.fullmatch(r'Zlength\(Z_1,\s*([A-Za-z_]\w*)\)\s*==\s*(.+)',prop.strip())
        if not m or m[1] not in names:continue
        n=numeral(m[2])
        if not 0<=n<=128:raise Unsupported('existential_list_length_budget')
        name=m[1]
        if name in lists:
            # Multiple constraints are retained; inconsistent lengths are handled
            # by the normalized pure equalities, not erased.
            continue
        values=[f'qcp_list_{name}_{i}' for i in range(n)]
        if any(re.search(r'\b'+re.escape(v)+r'\b',whole_text) for v in values):
            raise Unsupported('generated_binder_collision')
        lists[name]=values;new_names.remove(name);new_names.extend(values)
    return new_names,lists
