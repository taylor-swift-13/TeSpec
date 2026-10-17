"""A new toolchain must never relabel a cached old measurement."""

import copy
import unittest
from tools.benchmark.cn_result_reuse import (
    ResultReuseError,
    assert_resume_compatible,
    assert_fulminate_reuse_compatible,
)


def identity():
    return {
        "cn_build": {
            "source_revision": "revision-a",
            "runtime_tree_sha256": "runtime-a",
        },
        "cn_sha256": "cn-a",
        "input_files_sha256": {"source.c": "source-a"},
        "executor_sha256": "executor-a",
        "build": {"source_sha256": "executor-source-a"},
        "driver_sha256": "driver-a",
        "compiler_wrapper_sha256": "wrapper-a",
        "evaluation_source_snapshot": {
            "source_files_sha256": {"spectest/run.py": "source-a"},
            "python_version": "3.12.0",
            "z3_solver_installed_version": "4.13.0",
            "recorded_utc": "old-time",
            "git_revision": "old-commit",
        },
    }


class ReuseTests(unittest.TestCase):
    def setUp(self):
        self.current = identity()
        self.previous = {"toolchain": copy.deepcopy(self.current)}

    def reject_both(self, field):
        for check in (assert_resume_compatible, assert_fulminate_reuse_compatible):
            with self.subTest(check=check.__name__):
                with self.assertRaises(ResultReuseError) as caught:
                    check(self.previous, self.current)
                self.assertIn(field, str(caught.exception))
                self.assertIn("new run_id", str(caught.exception))

    def test_historical_report_without_build_is_rejected(self):
        del self.previous["toolchain"]["cn_build"]
        self.reject_both("cn_build")

    def test_cn_change_is_rejected(self):
        self.current["cn_sha256"] = "cn-b"
        self.reject_both("cn_sha256")

    def test_runtime_change_is_rejected(self):
        self.current["cn_build"]["runtime_tree_sha256"] = "runtime-b"
        self.reject_both("cn_build")

    def test_wrapper_or_driver_change_is_rejected(self):
        for field in ("compiler_wrapper_sha256", "driver_sha256", "input_files_sha256"):
            with self.subTest(field=field):
                self.current = identity()
                self.current[field] = "changed"
                self.reject_both(field)

    def test_missing_current_identity_is_rejected(self):
        del self.current["cn_sha256"]
        self.reject_both("current toolchain missing cn_sha256")

    def test_null_build_is_rejected(self):
        self.previous["toolchain"]["cn_build"] = None
        self.reject_both("cn_build")

    def test_resume_checks_all_tespec_identity_fields(self):
        for field in ("executor_sha256", "build"):
            current = identity()
            current[field] = "changed"
            with self.assertRaisesRegex(ResultReuseError, field):
                assert_resume_compatible(self.previous, current)
        for field in (
            "source_files_sha256",
            "python_version",
            "z3_solver_installed_version",
        ):
            current = identity()
            current["evaluation_source_snapshot"][field] = "changed"
            with self.assertRaisesRegex(ResultReuseError, field):
                assert_resume_compatible(self.previous, current)

    def test_missing_nested_identity_is_rejected(self):
        del self.previous["toolchain"]["evaluation_source_snapshot"][
            "source_files_sha256"
        ]
        with self.assertRaisesRegex(ResultReuseError, "source_files_sha256"):
            assert_resume_compatible(self.previous, self.current)

    def test_reporting_metadata_change_is_compatible(self):
        self.current["evaluation_source_snapshot"].update(
            recorded_utc="new-time", git_revision="new-commit"
        )
        self.current["recorded_utc"] = "new-time"
        before = copy.deepcopy((self.previous, self.current))
        assert_resume_compatible(self.previous, self.current)
        assert_fulminate_reuse_compatible(self.previous, self.current)
        self.assertEqual(before, (self.previous, self.current))

    def test_fulminate_does_not_depend_on_tespec_only_changes(self):
        self.current["executor_sha256"] = "executor-b"
        assert_fulminate_reuse_compatible(self.previous, self.current)

    def test_malformed_old_report_is_rejected(self):
        self.previous = None
        self.reject_both("previous report missing")


if __name__ == "__main__":
    unittest.main()
