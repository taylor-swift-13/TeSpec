"""Resolve and verify the installed CN/Fulminate experimental toolchain."""

from pathlib import Path
import hashlib
import json
import os
import shutil

ROOT = Path(__file__).resolve().parents[2]
LOCK_PATH = Path(__file__).with_name("cn-toolchain.json")
LOCK = json.loads(LOCK_PATH.read_text())
SWITCH = Path(os.environ.get("OPAMROOT", str(Path.home() / ".opam"))) / LOCK["switch"]
CN = SWITCH / "bin/cn"
ENV = dict(os.environ)
locked_tool_dirs = []
for executable in LOCK["fingerprint"]["executables"].values():
    directory = str(Path(executable["path"]).parent)
    if directory not in locked_tool_dirs:
        locked_tool_dirs.append(directory)
ENV["OPAM_SWITCH_PREFIX"] = str(SWITCH)
ENV["PATH"] = os.pathsep.join(
    [str(SWITCH / "bin"), *locked_tool_dirs, ENV.get("PATH", os.defpath)]
)


def sha(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def runtime_files():
    return {
        path.relative_to(SWITCH).as_posix(): sha(path)
        for relative in LOCK["runtime_roots"]
        for path in sorted((SWITCH / relative).rglob("*"))
        if path.is_file()
    }


def installed_identity():
    """Fail before measurements if the installed build differs from its lock."""
    expected = LOCK["fingerprint"]
    runtime = runtime_files()
    actual = dict(expected)
    actual["cn_sha256"] = sha(CN)
    actual["runtime_tree_sha256"] = hashlib.sha256(
        json.dumps(runtime, sort_keys=True).encode()
    ).hexdigest()
    actual["opam_switch_state_sha256"] = sha(SWITCH / ".opam-switch/switch-state")
    actual["executables"] = {}
    for name in expected["executables"]:
        path = shutil.which(name, path=ENV["PATH"])
        if path is None:
            raise RuntimeError("Missing experimental tool: " + name)
        actual["executables"][name] = {
            "path": str(Path(path).resolve()),
            "sha256": sha(path),
        }
    if actual != expected:
        changed = [key for key in expected if actual[key] != expected[key]]
        raise RuntimeError(
            "CN/Fulminate installation differs from cn-toolchain.json: "
            + ", ".join(changed)
            + ". Rebuild, validate and record the toolchain before starting a new batch."
        )
    return actual
