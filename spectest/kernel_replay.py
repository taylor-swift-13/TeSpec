"""Controller-owned, in-process reuse of independently checked dependencies.

No report or agent-written receipt can populate this cache. Only the controller
adds a closure after a successful full replay and its final integrity checks.
Every new task module is explicitly checked even when dependencies are reused.
"""

from pathlib import Path
import hashlib
import re


def _digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def loaded_artifacts(log):
    paths = re.findall(r"(?m)^\[intern (.+\.vo) \.\.\.$", log)
    if not paths:
        return None
    result = [Path(path).resolve() for path in paths]
    if len(set(result)) != len(result):
        return None
    return result


def checked_modules(log):
    return set(re.findall(r"(?m)^Checking library: ([A-Za-z_][\w.]*)$", log))


class KernelReplayCache:
    def __init__(self):
        self._identity = None
        self._artifacts = {}
        self._origin = None

    def ready(self, identity):
        if self._identity != identity or not self._artifacts:
            return False
        try:
            return all(
                _digest(path) == value for path, value in self._artifacts.items()
            )
        except OSError:
            return False

    def _record_checked_closure(self, log, identity, fresh_modules, origin=None):
        artifacts = loaded_artifacts(log)
        # Full recursive replay checks one top-level library for each artifact.
        # An incomplete/unrecognized log never grants dependency reuse.
        if artifacts is None or len(checked_modules(log)) != len(artifacts):
            return False
        try:
            fresh = {Path(path).resolve() for path in fresh_modules}
            snapshot = {path: _digest(path) for path in artifacts if path not in fresh}
        except OSError:
            return False
        self._identity = identity
        self._artifacts = snapshot
        self._origin = origin
        return True

    def accepts_partial(self, log, identity, fresh_modules):
        """Check the complete loaded closure, including admitted dependencies."""
        artifacts = loaded_artifacts(log)
        if artifacts is None or not self.ready(identity):
            return None
        fresh = {Path(path).resolve(): module for path, module in fresh_modules.items()}
        checked = checked_modules(log)
        if not set(fresh).issubset(artifacts) or not set(fresh.values()).issubset(
            checked
        ):
            return None
        reused = 0
        try:
            for path in artifacts:
                if path in fresh:
                    continue
                if self._artifacts.get(path) != _digest(path):
                    return None
                reused += 1
        except OSError:
            return None
        result = {"checked_task_modules": len(fresh), "reused_dependencies": reused}
        if self._origin is not None:
            result["full_replay_origin"] = dict(self._origin)
        return result
