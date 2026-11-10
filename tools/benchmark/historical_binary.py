"""Resolve explicitly pinned historical executor bytes for evidence audits only.

Never runs the recovered binary, searches history, fetches objects, or changes a
recorded digest. Temporary bytes live outside the repository until process exit.
"""
from __future__ import annotations

import hashlib
import json
import os
from pathlib import Path
import re
import subprocess
import sys
import tempfile

BINARY = "bin/tespec-symexec"
REGISTRY = "benchmark/results/toolchain-artifacts.json"
_temporary = None
_resolved = {}


def _need(condition, message):
    if not condition:
        raise ValueError(message)


def _sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def historical_binary(root, relative, expected):
    """Return exact, non-executable historical bytes, or fail closed."""
    global _temporary
    root = Path(root).resolve()
    _need(relative == BINARY, "Historical lookup is restricted to the executor binary")
    _need(isinstance(expected, str) and re.fullmatch(r"[0-9a-f]{64}", expected),
          "Malformed historical binary SHA-256")
    registry = (root / REGISTRY).resolve()
    _need(registry.is_relative_to(root) and registry.is_file(),
          "Missing historical binary registry")
    data = json.loads(registry.read_bytes())
    _need(data.get("schema") == "tespec-historical-toolchain-artifacts/v1" and
          isinstance(data.get("binaries"), list), "Malformed historical binary registry")
    matches = [entry for entry in data["binaries"] if
               isinstance(entry, dict) and entry.get("path") == relative and
               entry.get("sha256") == expected]
    _need(len(matches) == 1, "Historical binary digest is not uniquely registered")
    entry = matches[0]
    commit = entry.get("git_commit")
    _need(isinstance(commit, str) and re.fullmatch(r"[0-9a-f]{40}", commit),
          "Historical binary requires a full immutable Git commit")
    _need(entry.get("git_path") == BINARY, "Historical Git path differs from binary path")
    key = (str(root), commit, expected)
    if key not in _resolved:
        git_env = dict(os.environ, GIT_NO_LAZY_FETCH="1", GIT_TERMINAL_PROMPT="0")
        def git(*args):
            result = subprocess.run(["git", "--no-replace-objects", "-C", str(root), *args],
                                    capture_output=True, check=False, env=git_env)
            _need(result.returncode == 0, "Pinned historical Git object is unavailable")
            return result.stdout
        _need(git("cat-file", "-t", commit).strip() == b"commit",
              "Historical revision is not a commit")
        tree = git("ls-tree", "-z", commit, "--", BINARY).split(b"\0")
        _need(len(tree) == 2 and tree[1] == b"", "Historical binary tree entry is ambiguous")
        metadata, name = tree[0].split(b"\t", 1)
        mode, kind, object_id = metadata.split()
        _need(mode in (b"100644", b"100755") and kind == b"blob" and name == BINARY.encode(),
              "Historical binary must be a regular Git blob")
        raw = git("cat-file", "blob", object_id.decode("ascii"))
        _need(hashlib.sha256(raw).hexdigest() == expected,
              "Pinned historical binary hash mismatch")
        if _temporary is None:
            _temporary = tempfile.TemporaryDirectory(prefix="tespec-historical-audit-")
        with tempfile.NamedTemporaryFile(dir=_temporary.name, suffix=".bin", delete=False) as stream:
            stream.write(raw)
            path = Path(stream.name)
        path.chmod(0o600)
        _resolved[key] = path
        print(f"Historical binary bytes audited: {commit}:{BINARY} sha256={expected}; not executed.",
              file=sys.stderr)
    path = _resolved[key]
    _need(path.is_file() and _sha(path) == expected, "Historical binary temporary bytes changed")
    return path
