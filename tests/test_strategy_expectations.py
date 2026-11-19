"""Execution strategies have explicit expectations independent of spatial SMT."""
import sys
from pathlib import Path
import unittest
sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "tools/benchmark"))
from evaluation_expectations import expected


class StrategyExpectationTests(unittest.TestCase):
    def test_only_tespec_strategy_changes(self):
        row = {"expected": "PASS", "expected_by_execution_strategy": {"inline": "PASS", "modular": "FAIL"}}
        for mode in ("off", "on"):
            self.assertEqual(expected(row, "tespec_" + mode, "inline"), "PASS")
            self.assertEqual(expected(row, "tespec_" + mode, "modular"), "FAIL")
        self.assertEqual(expected(row, "fulminate_test", "modular"), "PASS")

    def test_legacy_expectations_still_default_to_inline(self):
        row = {"plan_case": {"expected": "PASS", "expected_by_tool": {"tespec_on": "ERROR"}}}
        self.assertEqual(expected(row, "tespec_on"), "ERROR")
        self.assertEqual(expected(row, "tespec_off", "modular"), "PASS")

    def test_invalid_override_is_rejected(self):
        with self.assertRaises(ValueError):
            expected({"expected": "PASS", "expected_by_execution_strategy": {"modular": "UNKNOWN"}}, "tespec_on", "modular")


class StrategyRegressionGuardTests(unittest.TestCase):
    def test_changed_oracle_never_masks_execution_regression(self):
        from tools.finite_spatial_smt.regress_completed_groups import strategy_comparison
        for kind in ["INVOCATION_FAILED", "PRECONDITION_REGRESSION", "EXECUTION_REGRESSION"]:
            before = {"kind": kind, "ok": False}
            self.assertEqual(strategy_comparison(before, {"status": "FAIL"}, "FAIL", True), before)

    def test_completed_expected_negative_can_match(self):
        from tools.finite_spatial_smt.regress_completed_groups import strategy_comparison
        self.assertTrue(strategy_comparison({"kind": "DECISION_REGRESSION"}, {"status": "FAIL"}, "FAIL", True)["ok"])

class CrashOracleTests(unittest.TestCase):
    def test_current_plan_projects_the_reviewed_fault_only_onto_matching_cases(self):
        from current_test_plan import load_current_plan
        path = Path(__file__).resolve().parents[1] / 'benchmark/programs/read/evaluation-plan.json'
        plan, overlay_sha = load_current_plan(path)
        self.assertEqual(len(overlay_sha), 64)
        crashes = [c for pair in plan['pairings'] for c in pair['cases']
                   if c.get('expected_crash_fault_code')]
        from collections import Counter
        self.assertEqual(Counter(c['expected_crash_fault_code'] for c in crashes),
                         {'missing_read_permission': 7, 'invalid_safety_vc': 1})
        for c in crashes:
            for strategy in ('inline', 'modular'):
                for mode in ('off', 'on'):
                    self.assertEqual(expected(c, 'tespec_'+mode, strategy), 'CRASH')
            self.assertEqual(expected(c, 'fulminate_test'), 'FAIL')

    def test_tool_errors_cannot_match_crash_even_if_the_text_mentions_permission(self):
        from current_test_plan import matches_crash
        from evaluation_expectations import matches
        from tempfile import TemporaryDirectory
        import json
        case = {'expected':'CRASH', 'expected_crash_fault_code':'missing_read_permission'}
        result = {'status':'CRASH', 'reason':'missing_read_permission',
                  'executor_error':{'fault_code':'missing_read_permission'},
                  'execution_completed':False, 'scope':'execution','precondition_result':'SAT',
                  'returncode':1, 'test_result':'UNKNOWN','phases':{'precondition':'SAT'},'vc_results':[]}
        with TemporaryDirectory() as directory:
            report = Path(directory) / 'report.json'
            for changes,ok in [({},True),({'status':'ERROR'},False),
                               ({'precondition_result':'UNKNOWN'},False),
                               ({'executor_error':{'Main Error Message':'missing permission'}},False),
                               ({'reason':'missing_write_permission'},False),
                               ({'limit_reason':'inline_loop_bound'},False),
                               ({'execution_completed':True},False),({'returncode':137},False),
                               ({'vc_results':[{'kind':'return','status':'INVALID'}]},False),
                               ({'vc_results':[{'kind':'return','status':'INVALID'}],'test_result':'FAIL'},True),
                               ({'vc_results':[{'kind':'return','status':'VALID'}],'test_result':'FAIL'},False),
                               ({'vc_results':[{'kind':'return','status':'UNKNOWN'}],'test_result':'PASS'},False)]:
                with self.subTest(changes=changes):
                    row = dict(result, **changes)
                    report.write_text(json.dumps({'results':[row]}))
                    self.assertEqual(matches(case,'tespec_off',measurement={'status':'CRASH','report':str(report)}),ok)
        self.assertFalse(matches({'expected':'ERROR'},'tespec_off',measurement={'status':'ERROR'}))
        self.assertFalse(matches_crash(result, 'invalid_safety_vc'))

    def test_arithmetic_crash_requires_an_invalid_safety_vc(self):
        from current_test_plan import matches_crash
        from tools.finite_spatial_smt.regress_completed_groups import strategy_comparison
        common = {'status':'CRASH','reason':'invalid_safety_vc','scope':'execution',
                  'precondition_result':'SAT','test_result':'FAIL','returncode':0,
                  'execution_completed':True,'executor_error':None,'phases':{'precondition':'SAT','safety':'FAIL'}}
        for kind,status,ok in [('safety','INVALID',True),('safety','UNKNOWN',False),('return','INVALID',False)]:
            current = common | {'vc_results':[{'kind':kind,'status':status}]}
            self.assertEqual(matches_crash(current, 'invalid_safety_vc'),ok)
            self.assertEqual(strategy_comparison({'ok':False,'kind':'DECISION_REGRESSION'},
                                                 current,'CRASH',True,'invalid_safety_vc')['ok'],ok)

    def test_partial_or_conflicting_safety_report_is_unscored(self):
        from current_test_plan import matches_crash
        case = {'status':'CRASH','reason':'invalid_safety_vc','scope':'execution',
                'precondition_result':'SAT','test_result':'FAIL','returncode':0,
                'execution_completed':True,'executor_error':None,'phases':{'precondition':'SAT','safety':'FAIL'},
                'vc_results':[{'kind':'safety','status':'INVALID'}]}
        for changes in ({'execution_completed':False},{'executor_error':{'message':'tool error'}},
                        {'limit_reason':'inline_loop_bound'}, {'returncode':1}):
            self.assertFalse(matches_crash(case | changes, 'invalid_safety_vc'))
        for k in ('phases', 'vc_results', 'execution_completed', 'returncode','executor_error'):
            self.assertFalse(matches_crash({n:v for n,v in case.items() if n!=k}, 'invalid_safety_vc'))

    def test_new_guarded_error_never_scores_even_with_old_permission_wording(self):
        from tempfile import TemporaryDirectory
        from evaluation_expectations import matches
        from current_test_plan import load_current_plan
        import json
        guard='cannot read memory through this pointer'
        case={'expected':'ERROR','expected_executor_error_contains':guard}
        with TemporaryDirectory() as d:
            plan=Path(d)/'evaluation-plan.json'
            plan.write_text(json.dumps({'pairings':[{'cases':[case]}]}))
            with self.assertRaises(ValueError):
                load_current_plan(plan)
            report=Path(d)/'report.json'
            report.write_text(json.dumps({'results':[{'status':'ERROR','reason':'qcp_execution_error',
                               'precondition_result':'SAT','executor_error':{'message':guard}}]}))
            self.assertFalse(matches(case,'tespec_off',measurement={'status':'ERROR','report':str(report)}))

    def test_new_batch_freezes_both_inputs_in_a_fresh_directory(self):
        from tempfile import TemporaryDirectory
        from test_group_variants import freeze_test_plan
        from current_test_plan import sha256
        with TemporaryDirectory() as d:
            root=Path(d)
            plan=root/'evaluation-plan.json'
            oracle=root/'tespec-fault-oracle.json'
            plan.write_bytes(b'{}\n')
            oracle.write_bytes(b'{}')
            out=root/'results'/'fresh'
            snapshot=freeze_test_plan(out,plan,sha256(oracle),False)
            self.assertEqual(snapshot.read_bytes(),plan.read_bytes())
            self.assertEqual((out/'tespec-fault-oracle.executed.json').read_bytes(),oracle.read_bytes())
            self.assertEqual(freeze_test_plan(out,plan,sha256(oracle),True),snapshot)
