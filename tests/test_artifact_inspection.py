"""Artifact provenance must be checked before any archive member is written."""

import hashlib
import io
import json
from pathlib import Path
import subprocess
import sys
import tarfile
import tempfile
import unittest

SCRIPT = Path(__file__).resolve().parents[1] / "scripts/inspect-oci-artifact.py"


class ArtifactInspectionTests(unittest.TestCase):
    def inspect(self, members, *, checksum=None):
        temp = tempfile.TemporaryDirectory()
        self.addCleanup(temp.cleanup)
        root = Path(temp.name)
        archive = root / "image.tar.gz"
        with tarfile.open(archive, "w:gz") as stream:
            for name, data in members:
                info = tarfile.TarInfo(name)
                info.size = len(data)
                stream.addfile(info, io.BytesIO(data))
        out = root / "output"
        result = subprocess.run(
            [
                sys.executable,
                str(SCRIPT),
                str(archive),
                "--md5",
                checksum or hashlib.md5(archive.read_bytes()).hexdigest(),
                "--output",
                str(out),
            ],
            capture_output=True,
            text=True,
            timeout=10,
        )
        return result, out

    def test_valid_blob_is_checked_and_reported(self):
        blob = b"container metadata"
        digest = hashlib.sha256(blob).hexdigest()
        result, out = self.inspect(
            [
                ("blobs/sha256/" + digest, blob),
                ("index.json", b"{}"),
                ("repositories", b"{}"),
            ]
        )
        self.assertEqual(result.returncode, 0, result.stderr)
        report = json.loads((out / "inspection.json").read_text())
        self.assertEqual(report["entries"][0]["sha256"], digest)
        self.assertEqual(report["repositories"], {})

    def test_bad_archive_digest_prevents_extraction(self):
        result, out = self.inspect([("index.json", b"{}")], checksum="0" * 32)
        self.assertNotEqual(result.returncode, 0)
        self.assertFalse(out.exists())

    def test_path_escape_and_false_blob_identity_are_rejected(self):
        for name in ("../escape", "blobs/sha256/" + "0" * 64):
            with self.subTest(name=name):
                result, out = self.inspect([(name, b"bad")])
                self.assertNotEqual(result.returncode, 0)
                self.assertFalse((out / "inspection.json").exists())
                self.assertFalse((out.parent / "escape").exists())
