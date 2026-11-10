"""Historical evidence remains hash-bound when the current executor changes."""
import hashlib
import json
from pathlib import Path
import subprocess
import sys
import tempfile
import unittest

sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "tools/benchmark"))
from historical_binary import BINARY, REGISTRY, historical_binary
from validate_canonical_group import ref


class HistoricalBinaryAuditTests(unittest.TestCase):
    def setUp(self):
        self.temporary = tempfile.TemporaryDirectory()
        self.addCleanup(self.temporary.cleanup)
        self.root = Path(self.temporary.name)
        self.raw = b"historical executor fixture\x00\xff\r\n"
        self.digest = hashlib.sha256(self.raw).hexdigest()
        self.binary = self.root / BINARY
        self.binary.parent.mkdir()
        self.binary.write_bytes(self.raw)
        self.git("init", "-q")
        self.git("add", BINARY)
        self.git("-c", "user.name=Audit test", "-c", "user.email=audit@example.invalid",
                 "-c", "commit.gpgsign=false", "commit", "-qm", "fixture")
        self.commit = self.git("rev-parse", "HEAD").decode().strip()
        self.entry = {"path": BINARY, "sha256": self.digest,
                      "git_commit": self.commit, "git_path": BINARY}
        (self.root / REGISTRY).parent.mkdir(parents=True)
        self.registry([self.entry])

    def git(self, *args):
        return subprocess.check_output(["git", "-C", str(self.root), *args], stderr=subprocess.PIPE)

    def registry(self, entries):
        (self.root / REGISTRY).write_text(json.dumps({
            "schema": "tespec-historical-toolchain-artifacts/v1", "binaries": entries}))

    def reference(self):
        return ref(self.root, {"path": BINARY, "sha256": self.digest})

    def test_current_matching_binary_needs_no_historical_registry(self):
        (self.root / REGISTRY).unlink()
        self.assertEqual(self.reference(), self.binary)

    def test_updated_binary_uses_exact_pinned_bytes_without_execution(self):
        self.binary.write_bytes(b"updated executor")
        recovered = self.reference()
        self.assertEqual(recovered.read_bytes(), self.raw)
        self.assertFalse(recovered.is_relative_to(self.root))
        self.assertEqual(recovered.stat().st_mode & 0o111, 0)
        self.assertEqual(self.binary.read_bytes(), b"updated executor")

    def test_missing_current_binary_can_be_audited(self):
        self.binary.unlink()
        self.assertEqual(self.reference().read_bytes(), self.raw)

    def test_unregistered_or_ambiguous_digest_is_rejected(self):
        self.binary.write_bytes(b"new")
        for entries in ([], [self.entry, self.entry]):
            with self.subTest(entries=len(entries)):
                self.registry(entries)
                with self.assertRaises(ValueError):
                    self.reference()

    def test_wrong_commit_path_and_blob_digest_are_rejected(self):
        self.binary.write_bytes(b"new")
        for mutation in ({"git_commit": "HEAD"}, {"git_commit": "f" * 40},
                         {"git_path": "other"}, {"sha256": "0" * 64}):
            with self.subTest(mutation=mutation):
                self.registry([{**self.entry, **mutation}])
                with self.assertRaises(ValueError):
                    historical_binary(self.root, BINARY, mutation.get("sha256", self.digest))

    def test_symlink_blob_is_not_accepted_as_an_executor(self):
        self.binary.unlink()
        self.binary.symlink_to("missing-target")
        self.git("add", BINARY)
        self.git("-c", "user.name=Audit test", "-c", "user.email=audit@example.invalid",
                 "-c", "commit.gpgsign=false", "commit", "-qm", "symlink")
        digest = hashlib.sha256(b"missing-target").hexdigest()
        self.registry([{**self.entry, "git_commit": self.git("rev-parse", "HEAD").decode().strip(),
                        "sha256": digest}])
        with self.assertRaises(ValueError):
            historical_binary(self.root, BINARY, digest)

    def test_changed_temporary_copy_is_rejected_on_reuse(self):
        self.binary.write_bytes(b"new")
        recovered = self.reference()
        recovered.write_bytes(b"corrupted")
        with self.assertRaises(ValueError):
            self.reference()

    def test_other_artifacts_never_fall_back_to_git(self):
        source = self.root / "source.c"
        source.write_text("changed")
        with self.assertRaises(ValueError):
            ref(self.root, {"path": "source.c", "sha256": self.digest})
        with self.assertRaises(ValueError):
            historical_binary(self.root, "source.c", self.digest)


if __name__ == "__main__":
    unittest.main()
