"""Unit and differential tests only: never execute a C program or teSpec."""
import copy
import itertools
import random
import unittest
from unittest.mock import patch
import z3
from finite_spatial_smt import check, encode, Unsupported, Expressions
from qcp_import import assertions, import_record
from finite_qcp_terms import list_values, pure_terms
from concrete_oracle import judge as ground_judge


LAYOUT={'architecture_bits':32,'byte_order':'big','memory_rules':'naive_C_Rules'}
def cell(p=4096,v=7,t='i32'):return {'kind':'cell','address':p,'type':t,'value':v}
def a(*cells,pure=(),exists=()):return {'spatial':list(cells),'pure':list(pure),'exists':list(exists)}
def vc(pre,post,mode='exact',bits=32):
    layout=dict(LAYOUT)
    if bits==64:layout.update(architecture_bits=64,memory_rules='naive_C_Rules64')
    return {'layout':layout,'mode':mode,'pre':[pre],'post':[post]}
def array(p,values,t='i32',start=0):return {'kind':'array','address':p,'type':t,'values':values,'length':len(values),'start':start}


class SemanticTests(unittest.TestCase):
    def expect(self,query,status):
        out=check(query)
        self.assertEqual(out['status'],status,out)
        return out

    def test_emp_identity(self):self.expect(vc(a(),a()),'VALID')
    def test_owned_to_emp_exact(self):self.expect(vc(a(cell()),a()),'INVALID')
    def test_owned_to_emp_frame(self):self.expect(vc(a(cell()),a(),mode='frame'),'VALID')
    def test_emp_to_owned(self):self.expect(vc(a(),a(cell())),'INVALID')
    def test_signed_char_unsigned_equivalence(self):self.expect(vc(a(cell(v=-1,t='i8')),a(cell(v=255,t='u8'))),'VALID')
    def test_int_unsigned_equivalence(self):self.expect(vc(a(cell(v=-1)),a(cell(v=2**32-1,t='u32'))),'VALID')
    def test_ptr_uint32_equivalence(self):self.expect(vc(a(cell(v=4096,t='ptr')),a(cell(v=4096,t='u32'))),'VALID')
    def test_ptr_uint64_equivalence(self):self.expect(vc(a(cell(v=2**40,t='ptr')),a(cell(v=2**40,t='u64')),bits=64),'VALID')
    def test_big_endian_bytes(self):self.expect(vc(a(cell(v=0x01020304)),a(*[cell(4096+i,i+1,'u8') for i in range(4)])),'VALID')
    def test_little_endian_bytes_rejected(self):self.expect(vc(a(cell(v=0x01020304)),a(*[cell(4096+i,4-i,'u8') for i in range(4)])),'INVALID')
    def test_signed_bytes_reassemble(self):self.expect(vc(a(*[cell(4096+i,-1,'i8') for i in range(4)]),a(cell(v=-1))),'VALID')
    def test_initialized_entails_undef(self):self.expect(vc(a(cell()),a(cell(v=None))),'VALID')
    def test_undef_does_not_entail_initialized(self):self.expect(vc(a(cell(v=None)),a(cell())),'INVALID')
    def test_undef_identity(self):self.expect(vc(a(cell(v=None)),a(cell(v=None))),'VALID')
    def test_undef_allows_mixed_initialization(self):self.expect(vc(a(cell(4096,None,'u8'),cell(4097,2,'u8')),a(cell(4096,None,'u16'))),'VALID')
    def test_undef_exists_value_not_valid(self):self.expect(vc(a(cell(v=None)),a(cell(v='w'),exists=['w'])),'INVALID')
    def test_exists_value(self):self.expect(vc(a(cell()),a(cell(v='w'),exists=['w'])),'VALID')
    def test_exists_wrong_constraint(self):self.expect(vc(a(cell()),a(cell(v='w'),exists=['w'],pure=['w == 8'])),'INVALID')
    def test_exists_address(self):self.expect(vc(a(cell()),a(cell(p='w'),exists=['w'])),'VALID')
    def test_exists_shadowing(self):self.expect(vc(a(cell(v='w'),pure=['w == 7']),a(cell(v='w'),exists=['w'])),'VALID')
    def test_post_binder_does_not_bind_global(self):self.expect(vc(a(cell(v='w'),pure=['w == 7']),a(cell(v='z'),exists=['w'],pure=['w == 8','z == 7'])),'INVALID')
    def test_antecedent_exists(self):self.expect(vc(a(cell(v='v'),exists=['v']),a(cell(v=None))),'VALID')
    def test_antecedent_exists_counterexample(self):self.expect(vc(a(cell(v='v'),exists=['v']),a(cell(v=0))),'INVALID')
    def test_pre_post_same_name_different_scope(self):self.expect(vc(a(cell(v='w'),exists=['w']),a(cell(v='w'),exists=['w'])),'VALID')
    def test_exists_shared_witness_two_cells(self):self.expect(vc(a(cell(v=7),cell(4100,8)),a(cell(v='w'),cell(4100,'w'),exists=['w'])),'INVALID')
    def test_alternatives_disjunction(self):
        q=vc(a(cell(v='v'),pure=['v == 0 or v == 1']),a(cell(v=0)))
        q['post'].append(a(cell(v=1)));self.expect(q,'VALID')
    def test_alternative_existential_scopes(self):
        q=vc(a(cell(v=1)),a(cell(v='w'),exists=['w'],pure=['w == 0']))
        q['post'].append(a(cell(v='w'),exists=['w'],pure=['w == 1']));self.expect(q,'VALID')
    def test_one_bad_pre_alternative(self):
        q=vc(a(cell(v=0)),a(cell(v=0)));q['pre'].append(a(cell(v=1)));self.expect(q,'INVALID')
    def test_empty_post_alternatives_false(self):
        q=vc(a(),a());q['post']=[];self.expect(q,'INVALID')
    def test_empty_pre_alternatives_false(self):
        q=vc(a(),a());q['pre']=[];self.expect(q,'VALID')
    def test_duplicate_cells_unsat_pre(self):self.expect(vc(a(cell(),cell()),a(pure=['False'])),'VALID')
    def test_duplicate_cells_unsat_post(self):self.expect(vc(a(cell()),a(cell(),cell())),'INVALID')
    def test_partial_overlap(self):self.expect(vc(a(cell(),cell(4098,0,'u16')),a(pure=['False'])),'VALID')
    def test_adjacent_cells(self):self.expect(vc(a(cell(),cell(4100,9)),a(cell(4100,9),cell())),'VALID')
    def test_possible_alias_needs_constraint(self):self.expect(vc(a(cell(p='p')),a(cell(p='q'))),'INVALID')
    def test_entailed_alias(self):self.expect(vc(a(cell(p='p'),pure=['p == q']),a(cell(p='q'))),'VALID')
    def test_symbolic_separation_implies_distinct(self):self.expect(vc(a(cell(p='p'),cell(p='q')),a(cell(p='p'),cell(p='q'),pure=['p != q'])),'VALID')
    def test_symbolic_partial_overlap_excluded(self):self.expect(vc(a(cell(p='p'),cell(p='q',t='u16'),pure=['q == p + 2']),a(pure=['False'])),'VALID')
    def test_frame_subset(self):self.expect(vc(a(cell(),cell(4100,9)),a(cell()),mode='frame'),'VALID')
    def test_exact_subset(self):self.expect(vc(a(cell(),cell(4100,9)),a(cell())),'INVALID')
    def test_frame_cannot_invent(self):self.expect(vc(a(cell()),a(cell(4100)),mode='frame'),'INVALID')
    def test_frame_cannot_duplicate(self):self.expect(vc(a(cell()),a(cell(),cell()),mode='frame'),'INVALID')
    def test_frame_preserves_pure_obligation(self):self.expect(vc(a(cell()),a(pure=['False']),mode='frame'),'INVALID')
    def test_zero_address_allowed_by_qcp_store(self):self.expect(vc(a(cell(p=0)),a()),'INVALID')
    def test_negative_address_vacuous(self):self.expect(vc(a(cell(p=-4)),a(pure=['False'])),'VALID')
    def test_unaligned_int_vacuous(self):self.expect(vc(a(cell(p=4097)),a(pure=['False'])),'VALID')
    def test_outside_address_space_vacuous(self):self.expect(vc(a(cell(p=2**32)),a(pure=['False'])),'VALID')
    def test_last_valid_int_address(self):self.expect(vc(a(cell(p=2**32-4)),a()),'INVALID')
    def test_i64_alignment_four(self):self.expect(vc(a(cell(p=4100,t='i64')),a()),'INVALID')
    def test_ptr64_alignment_eight(self):self.expect(vc(a(cell(p=4100,t='ptr')),a(pure=['False']),bits=64),'VALID')
    def test_out_of_range_value_vacuous(self):self.expect(vc(a(cell(v=2**31)),a(pure=['False'])),'VALID')
    def test_c_division_not_silently_Z_division(self):self.expect(vc(a(pure=['x / 2 == 1']),a()),'UNKNOWN')
    def test_Z_division_negative_numerator(self):self.expect(vc(a(pure=['(-3) // 2 == -2']),a()),'VALID')
    def test_Z_modulo_negative_numerator(self):self.expect(vc(a(pure=['(-3) % 2 == 1']),a()),'VALID')
    def test_zero_divisor_unsupported(self):self.expect(vc(a(pure=['x // 0 == 0']),a()),'UNKNOWN')
    def test_negative_divisor_unsupported(self):self.expect(vc(a(pure=['x // -2 == 0']),a()),'UNKNOWN')
    def test_boolean_integer_mix_rejected(self):self.expect(vc(a(pure=['True + 1 == 2']),a()),'UNKNOWN')
    def test_impure_call_rejected(self):self.expect(vc(a(pure=['__import__("os") == 1']),a()),'UNKNOWN')
    def test_unknown_function_not_uninterpreted(self):self.expect(vc(a(pure=['opaque(7) == 0']),a()),'UNKNOWN')
    def test_unknown_spatial_not_dropped_even_false_goal(self):self.expect(vc(a({'kind':'sll'}),a(pure=['False'])),'UNKNOWN')
    def test_unknown_goal_not_dropped_even_false_pure(self):self.expect(vc(a(),a({'kind':'sll'},pure=['False'])),'UNKNOWN')
    def test_unknown_field_rejected(self):
        q=vc(a(),a());q['pre'][0]['hidden_assumptions']=[];self.expect(q,'UNKNOWN')
    def test_unknown_layout_rejected(self):
        q=vc(a(),a());q['layout']['memory_rules']='custom';self.expect(q,'UNKNOWN')
    def test_mismatched_architecture_rejected(self):
        q=vc(a(),a());q['layout']['architecture_bits']=64;self.expect(q,'UNKNOWN')
    def test_little_endian_profile_rejected(self):
        q=vc(a(),a());q['layout']['byte_order']='little';self.expect(q,'UNKNOWN')
    def test_no_default_mode(self):
        q=vc(a(),a());del q['mode'];self.expect(q,'UNKNOWN')
    def test_unknown_mode(self):self.expect(vc(a(),a(),mode='guess'),'UNKNOWN')
    def test_byte_budget(self):self.assertEqual(check(vc(a(array(4096,list(range(129)))),a()),max_bytes=512)['reason'],'byte_budget')
    def test_array_length_mismatch(self):
        atom=array(4096,[1]);atom['length']=2;self.expect(vc(a(atom),a()),'UNKNOWN')
    def test_negative_array_length(self):
        atom=array(4096,[]);atom['length']=-1;self.expect(vc(a(atom),a()),'UNKNOWN')
    def test_symbolic_array_length(self):
        atom=array(4096,[]);atom['length']='n';self.expect(vc(a(atom),a()),'UNKNOWN')
    def test_empty_array_has_no_base_validity_requirement(self):self.expect(vc(a(array(-10,[])),a()),'VALID')
    def test_array_segment(self):self.expect(vc(a(array(4096,[2,3],start=2)),a(cell(4104,2),cell(4108,3))),'VALID')
    def test_array_as_cells(self):self.expect(vc(a(array(4096,[1,2,3])),a(cell(4096,1),cell(4100,2),cell(4104,3))),'VALID')
    def test_array_overlap(self):self.expect(vc(a(array(4096,[1,2]),cell(4100,2)),a(pure=['False'])),'VALID')
    def test_undef_array(self):
        ar={'kind':'array','address':4096,'type':'i32','length':2}
        self.expect(vc(a(array(4096,[1,2])),a(ar)),'VALID')
        self.expect(vc(a(ar),a(array(4096,[1,2]))),'INVALID')
    def test_smtlib_roundtrip(self):
        q=vc(a(cell()),a());out=check(q,include_smt=True)
        s=z3.Solver();s.from_string(out['smt2']);self.assertEqual(s.check(),z3.sat)
    def test_countermodel_nonempty(self):
        out=self.expect(vc(a(cell()),a()),'INVALID')
        self.assertEqual([b['address'] for b in out['countermodel']['heap']],list(range(4096,4100)))
        self.assertEqual([b['byte'] for b in out['countermodel']['heap']],[0,0,0,7])
    def test_countermodel_undef_can_be_uninitialized(self):
        out=self.expect(vc(a(cell(v=None)),a(cell())),'INVALID')
        self.assertTrue(any(not b['initialized'] or b['byte']!=v for b,v in zip(out['countermodel']['heap'],[0,0,0,7])))
    def test_timeout_never_valid(self):
        with patch('finite_spatial_smt.z3.Solver') as solver:
            solver.return_value.check.return_value=z3.unknown
            solver.return_value.reason_unknown.return_value='timeout'
            out=self.expect(vc(a(),a()),'UNKNOWN')
            self.assertEqual(out['reason'],'solver_unknown:timeout')


class ImportTests(unittest.TestCase):
    def test_cells(self):
        got=assertions('PROP[]\nLOCAL[]\nSEP[store(4096, (- 1), signed int)]')
        self.assertEqual(got[0]['spatial'][0]['type'],'i32')
    def test_frame_kind_not_guessed(self):
        row={'layout':dict(LAYOUT,field_address_semantics='base-plus-byte-offset/v1'),'vc':{'kind':'call'}}
        with self.assertRaises(Unsupported):import_record(row)
    def test_nonempty_locals_rejected(self):
        with self.assertRaises(Unsupported):assertions('PROP[]\nLOCAL[Temp p 4096]\nSEP[]')
    def test_trailing_text_rejected(self):
        with self.assertRaises(Unsupported):assertions('PROP[]\nLOCAL[]\nSEP[]\nBAD')
    def test_quantifier_not_erased(self):
        with self.assertRaises(Unsupported):assertions('PROP[forall 3, x_3 > 0]\nLOCAL[]\nSEP[]')
    def test_arrays_and_repeat(self):
        got=assertions('PROP[]\nLOCAL[]\nSEP[CharArray.full (4096, 2, repeat_Z(Z_1, (- 1), 2))]')
        self.assertEqual(got[0]['spatial'][0]['values'],['-1','-1'])
    def test_list_cons(self):
        got=assertions('PROP[]\nLOCAL[]\nSEP[IntArray.full (4096, 2, cons(Z_1, 1, cons(Z_1, 2, nil(Z_1))))]')
        self.assertEqual(got[0]['spatial'][0]['values'],['1','2'])
    def test_unknown_zeros_not_assumed(self):
        with self.assertRaises(Unsupported):assertions('PROP[]\nLOCAL[]\nSEP[IntArray.full (4096, 2, zeros(2))]')
    def test_pointer_offset(self):
        got=assertions('PROP[]\nLOCAL[]\nSEP[store(pointer_offset(4096, 1, 4, signed int), 7, signed int)]')
        self.assertEqual(check(vc(got[0],a(cell(4100,7))))['status'],'VALID')
    def test_disjunctive_goal(self):
        text='PROP[]\nLOCAL[]\nSEP[]\n\nEX w\nPROP[w == 0]\nLOCAL[]\nSEP[]\n'
        self.assertEqual(len(assertions(text)),2)
    def test_prop_false(self):self.assertEqual(assertions('PROP[prop_false]\nLOCAL[]\nSEP[]')[0]['pure'],['False'])
    def test_array_length_mismatch_not_silently_truncated(self):
        with self.assertRaises(Unsupported):assertions('PROP[]\nLOCAL[]\nSEP[IntArray.full(4096, 1, nil(Z_1))]')


class FiniteTermsTests(unittest.TestCase):
    def test_guarded_forall(self):
        self.assertEqual(pure_terms('forall 3, 0 <= i_3 && i_3 < 2 -> cons(Z_1, 1, cons(Z_1, 1, nil(Z_1)))[i_3] == 1'),['True','True'])
    def test_guarded_forall_inclusive(self):
        self.assertEqual(pure_terms('forall 3, 0 <= i_3 && i_3 <= 1 -> i_3 < 1'),['True','False'])
    def test_guarded_empty_interval(self):self.assertEqual(pure_terms('forall 3, 0 <= i_3 && i_3 < 0 -> i_3 < 0'),[])
    def test_guarded_negative_interval(self):self.assertEqual(pure_terms('forall 3, -2 <= i_3 && i_3 < 0 -> i_3 < 0'),['True','True'])
    def test_unbounded_forall_rejected(self):
        with self.assertRaises(Unsupported):pure_terms('forall 3, i_3 >= 0 -> i_3 > 0')
    def test_mismatched_bound_identifier_rejected(self):
        with self.assertRaises(Unsupported):pure_terms('forall 3, 0 <= i_4 && i_4 < 2 -> i_4 == 0')
    def test_ambiguous_identifier_rejected(self):
        with self.assertRaises(Unsupported):pure_terms('forall 3, 0 <= i_3 && i_3 < 2 -> j_3 == 0')
    def test_multiple_implications_rejected(self):
        with self.assertRaises(Unsupported):pure_terms('forall 3, 0 <= i_3 && i_3 < 2 -> i_3 == 0 -> True')
    def test_symbolic_bound_rejected(self):
        with self.assertRaises(Unsupported):pure_terms('forall 3, 0 <= i_3 && i_3 < n -> i_3 == 0')
    def test_quantifier_budget(self):
        with self.assertRaises(Unsupported):pure_terms('forall 3, 0 <= i_3 && i_3 < 1000 -> True')
    def test_Zlength(self):self.assertEqual(pure_terms('Zlength(Z_1, cons(Z_1, 2, nil(Z_1))) == 1'),['True'])
    def test_Znth_default(self):self.assertEqual(pure_terms('Znth(Z_1, -1, cons(Z_1, 7, nil(Z_1)), 8) == 8'),['True'])
    def test_Znth(self):self.assertEqual(pure_terms('Znth(Z_1, 0, cons(Z_1, 7, nil(Z_1)), 8) == 7'),['True'])
    def test_app(self):self.assertEqual(list_values('app(Z_1, cons(Z_1, 1, nil(Z_1)), cons(Z_1, 2, nil(Z_1)))'),['1','2'])
    def test_repeat_negative(self):self.assertEqual(list_values('repeat_Z(Z_1, 2, -1)'),[])
    def test_noninteger_list_type(self):
        with self.assertRaises(Unsupported):list_values('nil(T_1)')
    def test_printed_index_out_of_bounds(self):
        with self.assertRaises(Unsupported):pure_terms('cons(Z_1, 7, nil(Z_1))[2] == 7')
    def test_no_custom_function_by_name(self):
        with self.assertRaises(Unsupported):list_values('zeros(4)')
    def test_existential_list_materialization(self):
        post=assertions('EX lr_9\nPROP[Zlength(Z_1, lr_9) == 2; forall 3, 0 <= i_3 && i_3 < 2 -> lr_9[i_3] == 7]\nLOCAL[]\nSEP[IntArray.full(4096, 2, lr_9)]')[0]
        self.assertEqual(len(post['exists']),2)
        self.assertEqual(check(vc(a(array(4096,[7,7])),post))['status'],'VALID')
        self.assertEqual(check(vc(a(array(4096,[7,8])),post))['status'],'INVALID')
        self.assertEqual(ground_judge(vc(a(array(4096,[7,7])),post)),'VALID')
        self.assertEqual(ground_judge(vc(a(array(4096,[7,8])),post)),'INVALID')
    def test_existential_list_conflicting_lengths(self):
        post=assertions('EX lr_9\nPROP[Zlength(Z_1, lr_9) == 1; Zlength(Z_1, lr_9) == 2]\nLOCAL[]\nSEP[IntArray.full(4096, 1, lr_9)]')[0]
        self.assertEqual(check(vc(a(array(4096,[7])),post))['status'],'INVALID')
    def test_existential_list_name_collision(self):
        with self.assertRaises(Unsupported):assertions('EX lr_9\nPROP[Zlength(Z_1, lr_9) == 1; qcp_list_lr_9_0 == 2]\nLOCAL[]\nSEP[IntArray.full(4096, 1, lr_9)]')
    def test_no_unconstrained_list_length_guess(self):
        with self.assertRaises(Unsupported):assertions('EX lr_9\nPROP[]\nLOCAL[]\nSEP[IntArray.full(4096, 1, lr_9)]')


class WitnessEliminationTests(unittest.TestCase):pass
for typ,value in [('i8',-1),('u8',255),('i16',-32768),('u16',65535),('i32',-2147483648),('u32',4294967295)]:
    for constraint in ('True','w == 0','w < 0','w >= 0'):
        def test(self,typ=typ,value=value,constraint=constraint):
            query=vc(a(cell(v=value,t=typ)),a(cell(v='w',t=typ),exists=['w'],pure=[constraint]))
            outcomes=[]
            for eliminate in (False,True):
                enc=encode(query,eliminate_value_witnesses=eliminate)
                solver=z3.Solver();solver.set(timeout=5000);solver.add(enc.query);outcomes.append(solver.check())
            self.assertNotIn(z3.unknown,outcomes);self.assertEqual(outcomes[0],outcomes[1])
        setattr(WitnessEliminationTests,'test_'+typ+'_'+str(len([n for n in vars(WitnessEliminationTests) if n.startswith('test_')])),test)


class OracleTests(unittest.TestCase):
    def test_named_integer_constants(self):self.assertEqual(ground_judge(vc(a(cell(v=2147483647)),a(cell(v='w'),exists=['w'],pure=['w == INT_MAX']))),'VALID')
    def test_signed_witness_reconstruction(self):self.assertEqual(ground_judge(vc(a(cell(v=-1)),a(cell(v='w'),exists=['w'],pure=['w < 0']))),'VALID')
    def test_signed_witness_refutation(self):self.assertEqual(ground_judge(vc(a(cell(v=-1)),a(cell(v='w'),exists=['w'],pure=['w >= 0']))),'INVALID')
    def test_shared_witness(self):self.assertEqual(ground_judge(vc(a(cell(v=7),cell(4100,8)),a(cell(v='w'),cell(4100,'w'),exists=['w']))),'INVALID')
    def test_missing_cell(self):self.assertEqual(ground_judge(vc(a(),a(cell(v='w'),exists=['w']))),'INVALID')
    def test_undef_not_guessed(self):self.assertEqual(ground_judge(vc(a(cell(v=None)),a(cell(v='w'),exists=['w']))),'NOT_APPLICABLE')
    def test_address_witness_not_guessed(self):self.assertEqual(ground_judge(vc(a(cell()),a(cell(p='w'),exists=['w']))),'NOT_APPLICABLE')
    def test_unused_witness_not_guessed(self):self.assertEqual(ground_judge(vc(a(),a(exists=['w']))),'NOT_APPLICABLE')


# An independent concrete heap interpreter. No Z3, no encode/type_info helpers.
# None denotes arbitrary (possibly noninitialized) owned byte; ints are fixed bytes.
ORACLE_TYPES={'i8':(1,1,-128,127),'u8':(1,1,0,255),'bool':(1,1,0,1),
 'i16':(2,2,-32768,32767),'u16':(2,2,0,65535),
 'i32':(4,4,-2147483648,2147483647),'u32':(4,4,0,4294967295),
 'i64':(8,4,-2**63,2**63-1),'u64':(8,4,0,2**64-1),
 'i128':(16,4,-2**127,2**127-1),'u128':(16,4,0,2**128-1)}


def concrete_heap(atoms):
    heap={}
    for atom in atoms:
        size,align,lo,hi=ORACLE_TYPES[atom['type']]
        p=atom['address'];v=atom.get('value')
        if p<0 or p+size>2**32 or p%align or v is not None and not lo<=v<=hi:return None
        raw=[None]*size if v is None else list((v%(1<<(8*size))).to_bytes(size,'big'))
        for addr,byte in zip(range(p,p+size),raw):
            if addr in heap:return None
            heap[addr]=byte
    return heap


def oracle(pre,post,mode):
    left,right=concrete_heap(pre),concrete_heap(post)
    if left is None:return 'VALID'  # Unsatisfiable antecedent, no execution claim.
    if right is None:return 'INVALID'
    if not set(right)<=set(left):return 'INVALID'
    if mode=='exact' and set(left)!=set(right):return 'INVALID'
    for addr,value in right.items():
        if value is not None and left[addr]!=value:return 'INVALID'
    return 'VALID'


class BoundaryMatrix(unittest.TestCase):pass
for typ,(size,align,low,high) in ORACLE_TYPES.items():
    for index,value in enumerate(sorted({low,high,0,1,-1,low-1,high+1})):
        for delta in (0,1):
            def test(self,typ=typ,value=value,delta=delta):
                pre=[cell(4096,value,typ)];post=[cell(4096,value+delta,typ)]
                self.assertEqual(check(vc(a(*pre),a(*post)))['status'],oracle(pre,post,'exact'))
            setattr(BoundaryMatrix,f'test_{typ}_value_{index}_delta_{delta}',test)


class DifferentialMatrix(unittest.TestCase):pass
rng=random.Random(20261015)
for i in range(1800):
    typ=rng.choice(list(ORACLE_TYPES));size,alignment,low,high=ORACLE_TYPES[typ]
    pre=[cell(4096+j*16,rng.choice([None,low,high,0,1]),typ) for j in range(rng.randrange(1,5))]
    post=copy.deepcopy(pre);mutation=i%9;mode='frame' if i%2 else 'exact'
    if mutation==0:post.pop()
    elif mutation==1:post.append(cell(4208,0,typ))
    elif mutation==2:post[0]['value']=rng.choice([low,high,0,1])
    elif mutation==3:post[0]['value']=None
    elif mutation==4:post[0]['address']+=rng.choice([1,alignment,16])
    elif mutation==5:post.reverse()
    elif mutation==6:post.append(copy.deepcopy(post[0]))
    elif mutation==7:
        # An independently constructed equivalent byte decomposition.
        heap=concrete_heap(pre)
        post=[cell(p,b,'u8') for p,b in heap.items()] if heap is not None else post
    else:pre.append(copy.deepcopy(pre[0]))
    expected=oracle(pre,post,mode)
    def test(self,pre=pre,post=post,mode=mode,expected=expected):
        result=check(vc(a(*pre),a(*post),mode))
        self.assertEqual(result['status'],expected,{'pre':pre,'post':post,'mode':mode,'result':result})
    setattr(DifferentialMatrix,f'test_seed20261015_{i:04d}_{expected.lower()}',test)


class SymbolicDifferentialMatrix(unittest.TestCase):pass
for i in range(180):
    srng=random.Random(81000+i)
    # Complete enumeration of bounded logical variables, not bounded SMT solving.
    pre_template=[cell('p','x','i8')]
    if i%3:pre_template.append(cell('q','y','i8'))
    post_template=copy.deepcopy(pre_template)
    op=i%6
    if op==0:post_template=[]
    elif op==1:post_template[0]['address']='q'
    elif op==2:post_template[0]['value']='y'
    elif op==3:post_template.reverse()
    elif op==4:post_template[0]['value']=None
    else:post_template.append(cell('q','x','i8'))
    mode='frame' if i%2 else 'exact'
    addresses=sorted(srng.sample(range(4),2));values=sorted(srng.sample(range(-2,3),2))
    pure=[f'({n} == {choices[0]} or {n} == {choices[1]})' for n,choices in [('p',addresses),('q',addresses),('x',values),('y',values)]]
    expected='VALID'
    for p,q,x,y in itertools.product(addresses,addresses,values,values):
        env=dict(p=p,q=q,x=x,y=y)
        def instantiate(atoms):
            return [cell(env[c['address']],env[c['value']] if c['value'] is not None else None,c['type']) for c in atoms]
        if oracle(instantiate(pre_template),instantiate(post_template),mode)=='INVALID':expected='INVALID';break
    def test(self,pre=pre_template,post=post_template,pure=pure,mode=mode,expected=expected):
        result=check(vc(a(*pre,pure=pure),a(*post),mode))
        self.assertEqual(result['status'],expected,result)
    setattr(SymbolicDifferentialMatrix,f'test_exhaustive_domain_{i:03d}_{expected.lower()}',test)


if __name__=='__main__':unittest.main()
