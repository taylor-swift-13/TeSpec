from pathlib import Path
import tempfile
import unittest

from spectest.kernel_replay import KernelReplayCache, loaded_artifacts


def trace(paths, modules):
    return "".join(f"[intern {path} ...\n done]\n" for path in paths) + "".join(
        f"Checking library: {module}\n" for module in modules
    )


class KernelReplayCacheTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name)
        self.lib = self.root / "Shared.vo"
        self.goal = self.root / "Goal.vo"
        self.lib.write_bytes(b"shared-checked-artifact")
        self.goal.write_bytes(b"first-task")
        self.identity = ("switch", "version", "checker-digest")
        self.cache = KernelReplayCache()
        self.fresh = {self.goal: "Goal"}
        self.full = trace([self.lib, self.goal], ["Shared", "Goal"])

    def seed(self):
        self.assertTrue(
            self.cache._record_checked_closure(self.full, self.identity, self.fresh)
        )

    def test_empty_or_incomplete_log_grants_no_reuse(self):
        self.assertFalse(self.cache.ready(self.identity))
        self.assertIsNone(loaded_artifacts(""))
        incomplete = trace([self.lib, self.goal], ["Goal"])
        self.assertFalse(
            self.cache._record_checked_closure(incomplete, self.identity, self.fresh)
        )

    def test_changed_task_is_checked_again_and_not_cached(self):
        self.seed()
        self.goal.write_bytes(b"new-task")
        self.assertTrue(self.cache.ready(self.identity))
        result = self.cache.accepts_partial(
            trace([self.lib, self.goal], ["Goal"]), self.identity, self.fresh
        )
        self.assertEqual(result, {"checked_task_modules": 1, "reused_dependencies": 1})

    def test_changed_checked_dependency_invalidates_reuse(self):
        self.seed()
        self.lib.write_bytes(b"replacement")
        self.assertFalse(self.cache.ready(self.identity))
        self.assertIsNone(
            self.cache.accepts_partial(self.full, self.identity, self.fresh)
        )

    def test_missing_checked_dependency_invalidates_reuse(self):
        self.seed()
        self.lib.unlink()
        self.assertFalse(self.cache.ready(self.identity))

    def test_new_import_is_not_admitted_on_cache_authority(self):
        self.seed()
        other = self.root / "New.vo"
        other.write_bytes(b"not previously checked")
        log = trace([self.lib, other, self.goal], ["Goal"])
        self.assertIsNone(self.cache.accepts_partial(log, self.identity, self.fresh))

    def test_omitted_fresh_kernel_check_is_rejected(self):
        self.seed()
        log = trace([self.lib, self.goal], ["Shared"])
        self.assertIsNone(self.cache.accepts_partial(log, self.identity, self.fresh))

    def test_checker_identity_is_part_of_reuse(self):
        self.seed()
        self.assertFalse(self.cache.ready((*self.identity[:-1], "other-checker")))

    def test_duplicate_artifact_log_is_rejected(self):
        self.assertIsNone(loaded_artifacts(trace([self.lib, self.lib], ["Shared"])))
