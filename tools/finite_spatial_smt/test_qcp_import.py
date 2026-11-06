"""Checked QCP import boundaries; no program execution or proof generation."""
import copy
import unittest

from finite_spatial_smt import check, Unsupported
from qcp_import import import_record, LOCAL_SEMANTICS
from finite_qcp_terms import list_values, pure_terms, materialize_list_binders


LAYOUT = {
    'architecture_bits': 32,
    'byte_order': 'big',
    'memory_rules': 'naive_C_Rules',
    'field_address_semantics': 'base-plus-byte-offset/v1',
}


def assertion(spatial='', local='', pure='', exists=''):
    binder = 'EX ' + exists + '\n' if exists else ''
    return binder + f'PROP[{pure}]\nLOCAL[{local}]\nSEP[{spatial}]\n'


def record(pre, post, kind='entailment', bits=32):
    layout = dict(LAYOUT)
    if bits == 64:
        layout.update(architecture_bits=64, memory_rules='naive_C_Rules64')
    return {'layout': layout, 'vc': {'kind': kind, 'path': pre, 'goal': post}}


def finite_list(values):
    tail = 'nil(Z_1)'
    for value in reversed(values):
        tail = f'cons(Z_1, {value}, {tail})'
    return tail


class CheckModeTests(unittest.TestCase):
    def test_return_default_preserved(self):
        q = record(assertion('store(4096,7,signed int)'), assertion(), kind='return')
        self.assertEqual(check(import_record(q))['status'], 'INVALID')

    def test_entailment_never_guesses_mode(self):
        q = record(assertion(), assertion())
        for kwargs in ({}, {'check_mode': 'frame'}, {'check_mode': 'guess'}):
            with self.subTest(kwargs=kwargs), self.assertRaises(Unsupported):
                import_record(q, **kwargs)

    def test_entailment_explicit_exact_preserves_remainder(self):
        q = record(assertion('store(4096,7,signed int)'), assertion())
        self.assertEqual(check(import_record(q, check_mode='exact'))['status'], 'INVALID')

    def test_explicit_mode_does_not_enable_unknown_boundary_kinds(self):
        for kind in ('call', 'precondition', 'assert', None):
            for mode in ('exact', 'frame'):
                with self.subTest(kind=kind, mode=mode), self.assertRaises(Unsupported):
                    import_record(record(assertion(), assertion(), kind=kind), check_mode=mode)

    def test_nonreturn_families_require_correct_explicit_mode(self):
        modes = {'entailment': 'exact', 'which_implies': 'exact',
                 'partial_solve': 'frame', 'safety': 'frame'}
        for kind, expected in modes.items():
            for mode in (None, 'exact', 'frame', 'guess'):
                if mode == expected:
                    continue
                with self.subTest(kind=kind, mode=mode), self.assertRaises(Unsupported):
                    import_record(record(assertion(), assertion(), kind=kind), check_mode=mode)

    def test_which_implies_exact_preserves_owned_remainder(self):
        pre = assertion('store(4096,7,signed int)')
        for post, expected in ((pre, 'VALID'), (assertion(), 'INVALID')):
            with self.subTest(expected=expected):
                original = record(pre, post, kind='which_implies')
                saved = copy.deepcopy(original)
                q = import_record(original, check_mode='exact')
                self.assertEqual(q['mode'], 'exact')
                self.assertEqual(check(q)['status'], expected)
                self.assertEqual(original, saved)

    def test_partial_solve_frames_remainder_but_checks_requested_resource(self):
        pre = assertion('store(4096,7,signed int);store(4100,9,signed int)')
        for post, expected in (
            (assertion('store(4096,7,signed int)'), 'VALID'),
            (assertion('store(4096,8,signed int)'), 'INVALID'),
            (assertion('store(4104,7,signed int)'), 'INVALID'),
        ):
            with self.subTest(post=post):
                original = record(pre, post, kind='partial_solve')
                saved = copy.deepcopy(original)
                q = import_record(original, check_mode='frame')
                self.assertEqual(q['mode'], 'frame')
                self.assertEqual(len(q['pre'][0]['spatial']), 2)
                self.assertEqual(check(q)['status'], expected)
                self.assertEqual(original, saved)

    def test_pure_safety_checks_proposition_without_requiring_empty_heap(self):
        pre = assertion('store(4096,7,signed int)', pure='x == 7')
        for pure, expected in (('x > 0', 'VALID'), ('x < 0', 'INVALID')):
            with self.subTest(pure=pure):
                q = import_record(record(pre, assertion(pure=pure), kind='safety'),
                                  check_mode='frame')
                self.assertEqual(q['mode'], 'frame')
                self.assertEqual(len(q['pre'][0]['spatial']), 1)
                self.assertEqual(q['post'][0]['spatial'], [])
                self.assertEqual(check(q)['status'], expected)

    def test_safety_never_discards_local_or_spatial_target_terms(self):
        pre = assertion('store(4096,7,signed int)', local='Temp p p_addr')
        for post in (assertion('store(4096,7,signed int)'),
                     assertion(local='Temp p p_addr'),
                     assertion(pure='True') + assertion('Dll(4096)')):
            with self.subTest(post=post), self.assertRaisesRegex(Unsupported, 'safety_goal_not_pure'):
                import_record(record(pre, post, kind='safety'), check_mode='frame',
                              local_semantics=LOCAL_SEMANTICS)

    def test_pure_safety_does_not_ignore_unsupported_antecedent(self):
        with self.assertRaisesRegex(Unsupported, 'unsupported_spatial_predicate:Dll'):
            import_record(record(assertion('Dll(4096)'), assertion(pure='True'), kind='safety'),
                          check_mode='frame')

    def test_return_cannot_be_weakened_to_frame(self):
        with self.assertRaises(Unsupported):
            import_record(record(assertion(), assertion(), kind='return'), check_mode='frame')

    def test_unknown_local_semantics_rejected_even_if_empty(self):
        with self.assertRaises(Unsupported):
            import_record(record(assertion(), assertion()), check_mode='exact', local_semantics='guess')


class NativeTruepGoalTests(unittest.TestCase):
    def imported(self, pre, post):
        return import_record(record(pre, post), check_mode='exact')

    def test_nullary_truep_accepts_only_an_owned_subheap(self):
        pre = assertion('store(4096,7,signed int);store(4100,9,signed int)')
        for goal, expected in (
            ('store(4096,7,signed int);naive_C_Rules.truep', 'VALID'),
            ('naive_C_Rules.truep;store(4096,8,signed int)', 'INVALID'),
            ('store(4104,7,signed int);naive_C_Rules.truep', 'INVALID'),
        ):
            with self.subTest(goal=goal):
                original = record(pre, assertion(goal))
                saved = copy.deepcopy(original)
                query = import_record(original, check_mode='exact')
                self.assertEqual(query['mode'], 'frame')
                self.assertEqual(len(query['pre'][0]['spatial']), 2)
                self.assertEqual(len(query['post'][0]['spatial']), 1)
                self.assertEqual(check(query)['status'], expected)
                self.assertEqual(original, saved)

    def test_truep_uses_the_selected_memory_model(self):
        pre = assertion('store(4096,7,signed int)')
        for bits, model in ((32, 'naive_C_Rules'), (64, 'naive_C_Rules64')):
            with self.subTest(bits=bits, model=model):
                q = record(pre, assertion(model + '.truep'), bits=bits)
                q['layout']['memory_rules'] = model
                self.assertEqual(check(import_record(q, check_mode='exact'))['status'], 'VALID')
        q = record(pre, assertion('naive_C_Rules.truep'))
        q['layout']['memory_rules'] = 'user_Rules'
        with self.assertRaisesRegex(Unsupported, 'truep_memory_profile_not_established'):
            import_record(q, check_mode='exact')

    def test_nonexistent_32_bit_model_alias_is_rejected(self):
        q = record(assertion('store(4096,7,signed int)'),
                   assertion('naive_C_Rules32.truep'))
        q['layout']['memory_rules'] = 'naive_C_Rules32'
        with self.assertRaisesRegex(Unsupported, 'truep_memory_profile_not_established'):
            import_record(q, check_mode='exact')

    def test_truep_alone_accepts_remainder_but_keeps_pure_goal(self):
        pre = assertion('store(4096,7,signed int)', pure='v == 7')
        for pure, expected in (('v == 7', 'VALID'), ('v == 8', 'INVALID')):
            with self.subTest(pure=pure):
                query = self.imported(pre, assertion('naive_C_Rules.truep', pure=pure))
                self.assertEqual(check(query)['status'], expected)

    def test_frame_goal_keeps_existential_value_constraints(self):
        pre = assertion('store(4096,7,signed int);store(4100,9,signed int)')
        for pure, expected in (('w == 7', 'VALID'), ('w == 8', 'INVALID')):
            with self.subTest(pure=pure):
                post = assertion('store(4096,w,signed int);naive_C_Rules.truep',
                                 pure=pure, exists='w')
                self.assertEqual(check(self.imported(pre, post))['status'], expected)

    def test_all_framed_alternatives_preserve_disjunction(self):
        pre = assertion('store(4096,7,signed int);store(4100,9,signed int)')
        post = assertion('store(4096,8,signed int);naive_C_Rules.truep')
        post += assertion('store(4096,7,signed int);naive_C_Rules.truep')
        self.assertEqual(check(self.imported(pre, post))['status'], 'VALID')

    def test_mixed_exact_frame_alternatives_are_not_weakened(self):
        pre = assertion('store(4096,7,signed int);store(4100,9,signed int)')
        post = assertion('store(4096,8,signed int);naive_C_Rules.truep')
        post += assertion('store(4096,7,signed int)')
        with self.assertRaisesRegex(Unsupported, 'mixed_exact_and_frame_consequents'):
            self.imported(pre, post)

    def test_source_truep_never_becomes_a_finite_empty_heap(self):
        for source in ('naive_C_Rules.truep', 'store(4096,7,signed int);naive_C_Rules.truep'):
            with self.subTest(source=source), self.assertRaisesRegex(
                    Unsupported, 'antecedent_truep_not_supported'):
                self.imported(assertion(source), assertion())

    def test_truep_requires_exact_nullary_qualified_native_constant(self):
        for term in ('TT', 'TT()', 'truep', 'truep()', 'user.truep()',
                     'CRules.truep', 'naive_C_Rules64.truep',
                     'naive_C_Rules.truep()', 'naive_C_Rules.truep(7)', 'naive_C_Rules.truep{Z_1}',
                     'naive_C_Rules.truep{Z_1}(7)', 'opaque(naive_C_Rules.truep)',
                     'store(4096,naive_C_Rules.truep,signed int)'):
            with self.subTest(term=term), self.assertRaises(Unsupported):
                self.imported(assertion(), assertion(term))

    def test_truep_in_pure_or_local_is_not_a_spatial_frame(self):
        for post in (assertion(pure='naive_C_Rules.truep'),
                     assertion(pure='!naive_C_Rules.truep'),
                     assertion(local='Temp p naive_C_Rules.truep')):
            with self.subTest(post=post), self.assertRaisesRegex(
                    Unsupported, 'truep_not_top_level_goal_sep'):
                self.imported(assertion(), post)


class NativePrintCompatibilityTests(unittest.TestCase):
    def test_new_and_old_integer_list_printing_match(self):
        old = 'cons(Z_1, INT_MAX, cons(Z_1, (- 1), nil(Z_1)))'
        new = 'cons{Z_1}(INT_MAX, cons{Z_1}((- 1), nil{Z_1}))'
        self.assertEqual(list_values(new), list_values(old))
        pre = assertion('IntArray.full(4096,2,' + new + ')')
        post = assertion('IntArray.full(4096,2,' + old + ')')
        self.assertEqual(check(import_record(record(pre, post), check_mode='exact'))['status'], 'VALID')

    def test_new_builtin_list_operations(self):
        self.assertEqual(list_values('app{Z_1}(cons{Z_1}(1,nil{Z_1}),repeat_Z{Z_1}(2,2))'),
                         ['1','2','2'])
        self.assertEqual(pure_terms('Zlength{Z_1}(cons{Z_1}(7,nil{Z_1})) == 1'), ['True'])
        self.assertEqual(pure_terms('Znth{Z_1}(0,cons{Z_1}(7,nil{Z_1}),0) == 7'), ['True'])
        names, lists = materialize_list_binders(['xs'], ['Zlength{Z_1}(xs) == 2'], '')
        self.assertEqual(len(names), 2)
        self.assertEqual(len(lists['xs']), 2)

    def test_generic_syntax_does_not_expand_other_types_or_user_functions(self):
        for term in ('nil{T_1}', 'cons{T_1}(1,nil{T_1})', 'zeros{Z_1}(2)',
                     'user.cons{Z_1}(1,nil{Z_1})'):
            with self.subTest(term=term), self.assertRaises(Unsupported):
                list_values(term)

    def test_three_argument_pointer_offset_uses_checked_type_size(self):
        for ctype, size in (('signed char',1), ('signed short',2), ('signed int',4),
                            ('signed long long',8)):
            with self.subTest(ctype=ctype):
                pre = assertion(f'store({4096+2*size},7,{ctype})')
                post = assertion(f'store(pointer_offset(4096,2,{ctype}),7,{ctype})')
                original = record(pre, post)
                saved = copy.deepcopy(original)
                q = import_record(original, check_mode='exact')
                self.assertEqual(check(q)['status'], 'VALID')
                self.assertEqual(original, saved)

    def test_pointer_pointee_width_tracks_32_and_64_bit_layouts(self):
        for bits, size in ((32,4),(64,8)):
            with self.subTest(bits=bits):
                pre = assertion(f'store({4096+size},7,signed int *)')
                post = assertion('store(pointer_offset(4096,1,signed int *),7,signed int *)')
                q = import_record(record(pre, post, bits=bits), check_mode='exact')
                self.assertEqual(check(q)['status'], 'VALID')

    def test_erased_PTR_storage_type_uses_target_pointer_width(self):
        for bits, size in ((32,4),(64,8)):
            with self.subTest(bits=bits):
                pre = assertion(f'store({4096+size},7,PTR)')
                post = assertion('store(pointer_offset(4096,1,PTR),7,PTR)')
                q = import_record(record(pre,post,bits=bits),check_mode='exact')
                self.assertEqual(q['pre'][0]['spatial'][0]['type'], 'ptr')
                self.assertEqual(q['post'][0]['spatial'][0]['address'], str(4096+size))
                self.assertEqual(check(q)['status'], 'VALID')

    def test_pointer_offset_legacy_stride_must_match_type(self):
        pre = assertion('store(4100,7,signed int)')
        post = assertion('store(pointer_offset(4096,1,4,signed int),7,signed int)')
        self.assertEqual(check(import_record(record(pre,post),check_mode='exact'))['status'], 'VALID')
        with self.assertRaisesRegex(Unsupported, 'pointer_offset_stride_type_mismatch'):
            import_record(record(pre,post.replace(',4,signed int)',',8,signed int)')),
                          check_mode='exact')

    def test_nested_pointer_offsets_and_pure_occurrences(self):
        pre = assertion('store(4104,7,signed int)', pure='x == 4104')
        post = assertion('store(pointer_offset(pointer_offset(4096,1,signed int),1,signed int),7,signed int)',
                         pure='x == pointer_offset(4096,2,signed int)')
        self.assertEqual(check(import_record(record(pre,post),check_mode='exact'))['status'], 'VALID')

    def test_unknown_pointer_offset_types_and_layout_are_not_guessed(self):
        pre = assertion('store(4100,7,signed int)')
        post = assertion('store(pointer_offset(4096,1,opaque_type),7,signed int)')
        with self.assertRaisesRegex(Unsupported, 'unknown_qcp_type'):
            import_record(record(pre,post),check_mode='exact')
        q = record(pre,post.replace('opaque_type','signed int'))
        q['layout'].pop('architecture_bits')
        with self.assertRaisesRegex(Unsupported, 'pointer_offset_layout_not_established'):
            import_record(q,check_mode='exact')


class NativeBinderScopeTests(unittest.TestCase):
    def test_shared_source_binder_is_not_refuted_as_unrelated_goal_variable(self):
        q = record(assertion(pure='x == 7', exists='x'), assertion(pure='x == 7'))
        with self.assertRaisesRegex(Unsupported, 'native_shared_existential_requires_scope_mapping:x'):
            import_record(q, check_mode='exact')

    def test_independent_target_binder_shadow_is_supported(self):
        text = assertion(pure='x == 7', exists='x')
        q = import_record(record(text, text), check_mode='exact')
        self.assertEqual(check(q)['status'], 'VALID')

    def test_target_shadow_in_one_alternative_does_not_cover_another(self):
        pre = assertion(pure='x == 7', exists='x')
        post = assertion(pure='x == 7', exists='x') + assertion(pure='x == 7')
        with self.assertRaisesRegex(Unsupported, 'native_shared_existential_requires_scope_mapping:x'):
            import_record(record(pre, post), check_mode='exact')

    def test_scope_check_uses_whole_identifiers(self):
        q = record(assertion(pure='x == 7', exists='x'), assertion(pure='xx == 7'))
        self.assertEqual(check(import_record(q, check_mode='exact'))['status'], 'INVALID')


class LocalEnvironmentTests(unittest.TestCase):
    def imported(self, pre, post):
        return import_record(record(pre, post), check_mode='exact', local_semantics=LOCAL_SEMANTICS)

    def test_requires_explicit_same_environment_protocol(self):
        text = assertion(local='Temp p p_addr')
        with self.assertRaises(Unsupported):
            import_record(record(text, text), check_mode='exact')

    def test_all_environment_bindings_preserved_as_pure_equalities(self):
        pre = assertion('store(p_addr,7,signed int)', 'Temp p p_addr; Temp unused unused_addr')
        post = assertion('store(p_addr,7,signed int)', 'Temp p p_addr')
        original = record(pre, post)
        saved = copy.deepcopy(original)
        q = import_record(original, check_mode='exact', local_semantics=LOCAL_SEMANTICS)
        self.assertEqual(original, saved)
        self.assertEqual(q['pre'][0]['pure'], [
            'qcp_local_env_p == (p_addr)',
            'qcp_local_env_unused == (unused_addr)',
        ])
        self.assertEqual(q['post'][0]['pure'], ['qcp_local_env_p == (p_addr)'])
        result = check(q)
        self.assertEqual(result['status'], 'VALID', result)
        self.assertFalse(result['vacuous'])

    def test_local_metadata_does_not_discard_owned_heap(self):
        q = self.imported(assertion('store(p_addr,7,signed int)', 'Temp p p_addr'),
                          assertion(local='Temp p p_addr'))
        self.assertEqual(check(q)['status'], 'INVALID')

    def test_unused_left_local_does_not_hide_counterexample(self):
        q = self.imported(assertion('store(p_addr,7,signed int)', 'Temp p p_addr; Temp extra q'),
                          assertion('store(p_addr,8,signed int)', 'Temp p p_addr'))
        result = check(q)
        self.assertEqual(result['status'], 'INVALID', result)
        self.assertIn('qcp_local_env_extra', result['countermodel']['variables'])

    def test_reordered_locals_and_parentheses(self):
        q = self.imported(assertion(local='Temp p (p_addr); Temp q q_addr'),
                          assertion(local='Temp q q_addr; Temp p p_addr'))
        self.assertEqual(check(q)['status'], 'VALID')

    def test_consequent_new_local_not_guessed(self):
        with self.assertRaisesRegex(Unsupported, 'new_consequent_local'):
            self.imported(assertion(local='Temp p p_addr'), assertion(local='Temp q p_addr'))

    def test_changed_local_binding_not_guessed(self):
        with self.assertRaisesRegex(Unsupported, 'changed_consequent_local'):
            self.imported(assertion(local='Temp p p_addr'), assertion(local='Temp p other_addr'))

    def test_pure_equalities_do_not_bypass_binding_check(self):
        with self.assertRaisesRegex(Unsupported, 'changed_consequent_local'):
            self.imported(assertion(local='Temp p p_addr', pure='p_addr == q_addr'),
                          assertion(local='Temp p q_addr'))

    def test_duplicate_names_shadowing_rejected_on_either_side(self):
        plain = assertion(local='Temp p p_addr')
        duplicate = assertion(local='Temp p p_addr; Temp p p_addr')
        for pre, post in ((plain, duplicate), (duplicate, plain)):
            with self.subTest(pre=pre), self.assertRaisesRegex(Unsupported, 'ambiguous_local_name'):
                self.imported(pre, post)

    def test_existential_address_rejected_on_either_side(self):
        plain = assertion(local='Temp p p_addr')
        bound = assertion(local='Temp p p_addr', exists='p_addr')
        for pre, post in ((plain, bound), (bound, plain)):
            with self.subTest(pre=pre), self.assertRaisesRegex(Unsupported, 'existential_local_binding'):
                self.imported(pre, post)

    def test_bound_variable_inside_arithmetic_rejected(self):
        with self.assertRaisesRegex(Unsupported, 'existential_local_binding'):
            self.imported(assertion(local='Temp p base + offset', exists='offset'),
                          assertion(local='Temp p base + offset'))

    def test_existential_local_is_checked_before_arithmetic_simplification(self):
        with self.assertRaisesRegex(Unsupported, 'existential_local_binding'):
            self.imported(assertion(local='Temp p offset - offset', exists='offset'),
                          assertion(local='Temp p 0'))

    def test_generated_environment_symbol_collision_rejected(self):
        for field in ('local', 'pure', 'exists', 'spatial'):
            args = dict(local='Temp p p_addr')
            args.update({
                'local': {'local': 'Temp p qcp_local_env_p'},
                'pure': {'pure': 'qcp_local_env_p == 0'},
                'exists': {'exists': 'qcp_local_env_p'},
                'spatial': {'spatial': 'store(qcp_local_env_p,7,signed int)'},
            }[field])
            with self.subTest(field=field), self.assertRaisesRegex(Unsupported, 'local_environment_symbol_collision'):
                self.imported(assertion(**args), assertion())

    def test_unsupported_local_forms_rejected(self):
        for local in ('Var p p_addr', 'Temp p opaque(p_addr)', 'Temp p True', 'Temp p', 'Temp p p_addr;'):
            with self.subTest(local=local), self.assertRaises(Unsupported):
                self.imported(assertion(local=local), assertion())

    def test_all_antecedent_alternatives_must_match(self):
        pre = assertion(local='Temp p p_addr') + assertion(local='Temp p other_addr')
        with self.assertRaisesRegex(Unsupported, 'changed_consequent_local'):
            self.imported(pre, assertion(local='Temp p p_addr'))

    def test_local_alternatives_retain_pure_constraints(self):
        pre = assertion(local='Temp p p_addr', pure='x == 1') + assertion(local='Temp p p_addr', pure='x == 2')
        post = assertion(local='Temp p p_addr', pure='x == 1')
        self.assertEqual(check(self.imported(pre, post))['status'], 'INVALID')


class MissingIndexTests(unittest.TestCase):
    def query(self, index=1, lo=0, hi=3, values=(3,7,11), value=7,
              module='IntArray', ctype='signed int', size=4):
        seq = finite_list(values)
        pre = assertion(f'{module}.seg(base,{lo},{hi},{seq})', pure='base == 4096')
        post = assertion(
            f'store(pointer_offset(base,{index},{size},{ctype}),{value},{ctype});'
            f'{module}.missing_i(base,{index},{lo},{hi},{seq})')
        return record(pre, post)

    def test_general_finite_array_extraction(self):
        q = import_record(self.query(), check_mode='exact')
        out = check(q)
        self.assertEqual(out['status'], 'VALID', out)
        self.assertFalse(out['vacuous'])

    def test_wrong_selected_value_rejected(self):
        self.assertEqual(check(import_record(self.query(value=9), check_mode='exact'))['status'], 'INVALID')

    def test_missing_predicate_does_not_own_removed_cell(self):
        q = self.query()
        q['vc']['goal'] = assertion('IntArray.missing_i(base,1,0,3,' + finite_list([3,7,11]) + ')')
        self.assertEqual(check(import_record(q, check_mode='exact'))['status'], 'INVALID')

    def test_missing_index_not_assumed_at_zero(self):
        q = self.query(index=2, value=11)
        self.assertEqual(check(import_record(q, check_mode='exact'))['status'], 'VALID')

    def test_missing_index_nonzero_negative_lower_bound(self):
        q = self.query(index=-1, lo=-2, hi=1, value=7)
        self.assertEqual(check(import_record(q, check_mode='exact'))['status'], 'VALID')

    def test_singleton_missing_array_is_emp(self):
        q = self.query(index=5, lo=5, hi=6, values=[13], value=13)
        self.assertEqual(check(import_record(q, check_mode='exact'))['status'], 'VALID')

    def test_symbolic_index_not_guessed(self):
        with self.assertRaises(Unsupported):
            import_record(self.query(index='i'), check_mode='exact')

    def test_symbolic_bounds_not_guessed(self):
        for key in ('lo', 'hi'):
            with self.subTest(key=key), self.assertRaises(Unsupported):
                import_record(self.query(**{key: 'bound'}), check_mode='exact')

    def test_out_of_range_index_not_full_array(self):
        for index in (-1, 3, 100):
            with self.subTest(index=index), self.assertRaisesRegex(Unsupported, 'missing_index_out_of_range'):
                import_record(self.query(index=index), check_mode='exact')

    def test_empty_missing_array_not_emp(self):
        text = assertion('IntArray.missing_i(base,0,0,0,nil(Z_1))')
        with self.assertRaisesRegex(Unsupported, 'missing_index_out_of_range'):
            import_record(record(assertion(), text), check_mode='exact')

    def test_wrong_complete_list_length_rejected(self):
        text = assertion('IntArray.missing_i(base,0,0,3,' + finite_list([3,7]) + ')')
        with self.assertRaisesRegex(Unsupported, 'array_length_mismatch'):
            import_record(record(assertion(), text), check_mode='exact')

    def test_unknown_array_module_not_unfolded(self):
        with self.assertRaises(Unsupported):
            import_record(self.query(module='UserArray'), check_mode='exact')

    def test_duplicate_selected_cell_remains_invalid(self):
        q = self.query()
        q['vc']['goal'] = q['vc']['goal'].replace('SEP[', 'SEP[store(base,3,signed int);')
        self.assertEqual(check(import_record(q, check_mode='exact'))['status'], 'INVALID')

    def test_ptr_array_64bit_stride_not_assumed(self):
        q = self.query(module='PtrArray', ctype='int *')
        q['layout'].update(architecture_bits=64, memory_rules='naive_C_Rules64')
        with self.assertRaisesRegex(Unsupported, 'pointer_array_stride_not_established'):
            import_record(q, check_mode='exact')

    def test_pointer_cell_64bit_still_supported(self):
        text = assertion('store(4096,4096,int *)')
        q = import_record(record(text, text, bits=64), check_mode='exact')
        self.assertEqual(check(q)['status'], 'VALID')


# All existing built-in finite array families, varied lower bounds and extracted
# positions. The oracle here is the defining full-list split into one cell and
# two unchanged slices, rather than a benchmark/program-specific pattern.
for module, ctype, size in [
    ('CharArray','signed char',1), ('UCharArray','unsigned char',1),
    ('ShortArray','signed short',2), ('UShortArray','unsigned short',2),
    ('IntArray','signed int',4), ('UIntArray','unsigned int',4),
    ('Int64Array','signed I64',8), ('UInt64Array','unsigned I64',8),
    ('PtrArray','int *',4),
]:
    for lo in (-2, 0, 3):
        for offset, value in enumerate((3,7,11)):
            def test(self,module=module,ctype=ctype,size=size,lo=lo,offset=offset,value=value):
                q = self.query(index=lo+offset, lo=lo, hi=lo+3, value=value,
                               module=module, ctype=ctype, size=size)
                out = check(import_record(q, check_mode='exact'))
                self.assertEqual(out['status'], 'VALID', out)
                self.assertFalse(out['vacuous'])
            setattr(MissingIndexTests, f'test_family_{module}_lo{lo}_offset{offset}', test)


if __name__ == '__main__':
    unittest.main()
