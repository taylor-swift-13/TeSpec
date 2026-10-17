"""Checked QCP import boundaries; no program execution or proof generation."""
import copy
import unittest

from finite_spatial_smt import check, Unsupported
from qcp_import import import_record, LOCAL_SEMANTICS


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

    def test_exact_does_not_enable_other_boundary_kinds(self):
        for kind in ('call', 'safety', 'precondition', 'assert', None):
            with self.subTest(kind=kind), self.assertRaises(Unsupported):
                import_record(record(assertion(), assertion(), kind=kind), check_mode='exact')

    def test_return_cannot_be_weakened_to_frame(self):
        with self.assertRaises(Unsupported):
            import_record(record(assertion(), assertion(), kind='return'), check_mode='frame')

    def test_unknown_local_semantics_rejected_even_if_empty(self):
        with self.assertRaises(Unsupported):
            import_record(record(assertion(), assertion()), check_mode='exact', local_semantics='guess')


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
