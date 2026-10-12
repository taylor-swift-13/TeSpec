#!/usr/bin/env python3
"""Run a command in an unpacked artifact with its image environment/entrypoint.

Uses bubblewrap and an external root filesystem; it does not require a Docker
service. Records this runtime difference explicitly for artifact reproduction.
"""

import argparse
import importlib.util
import json
import os
from pathlib import Path
import platform
import shutil

ROOT = Path(__file__).resolve().parents[1]
spec = importlib.util.spec_from_file_location(
    "comparison", ROOT / "scripts/run-comparison-smoke.py"
)
comparison = importlib.util.module_from_spec(spec)
spec.loader.exec_module(comparison)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--bundle", type=Path, required=True)
    parser.add_argument("--image-config", type=Path, required=True)
    parser.add_argument("--output", type=Path, required=True)
    parser.add_argument("--timeout", type=float, default=900)
    parser.add_argument(
        "--cpus", type=int, help="limit visible CPUs by inherited affinity"
    )
    parser.add_argument("command", nargs=argparse.REMAINDER)
    args = parser.parse_args()
    command = args.command[1:] if args.command[:1] == ["--"] else args.command
    if not command or args.timeout <= 0:
        parser.error("provide a command and positive timeout")
    available_cpus = sorted(os.sched_getaffinity(0))
    if args.cpus is not None:
        if not 1 <= args.cpus <= len(available_cpus):
            parser.error("cpus must fit the available affinity set")
        os.sched_setaffinity(0, available_cpus[: args.cpus])
    rootfs = args.bundle.resolve() / "rootfs"
    if not (rootfs / "bin/sh").exists():
        parser.error("bundle rootfs is incomplete")
    out = args.output.resolve()
    if out.exists() and any(out.iterdir()):
        parser.error("output must be empty")
    out.mkdir(parents=True, exist_ok=True)
    config = json.loads(args.image_config.read_text())["config"]
    if config.get("User") not in (None, "", "root", "0"):
        parser.error("this artifact runner currently requires a root image user")
    bwrap = shutil.which("bwrap")
    if not bwrap:
        parser.error("bubblewrap is unavailable")
    invocation = [
        bwrap,
        "--unshare-user",
        "--uid",
        "0",
        "--gid",
        "0",
        "--unshare-pid",
        "--die-with-parent",
        "--bind",
        str(rootfs),
        "/",
        "--proc",
        "/proc",
        "--dev",
        "/dev",
        "--clearenv",
        "--setenv",
        "HOME",
        "/root",
    ]
    for item in config.get("Env", []):
        key, value = item.split("=", 1)
        invocation += ["--setenv", key, value]
    invocation += ["--chdir", config.get("WorkingDir") or "/", "--"]
    invocation += config.get("Entrypoint") or []
    invocation += command
    report = {
        "runtime": "rootless OCI filesystem in bubblewrap; host kernel; not Docker",
        "host": platform.platform(),
        "available_cpus": available_cpus,
        "execution_cpus": sorted(os.sched_getaffinity(0)),
        "image_config_sha256": comparison.sha(args.image_config),
        "bubblewrap_sha256": comparison.sha(Path(bwrap)),
        "command": command,
        "driver_sha256": comparison.sha(Path(__file__)),
    }
    shutil.copy2(__file__, out / "executed-driver.py")
    (out / "request.json").write_text(json.dumps(report, indent=2) + "\n")
    result = comparison.run(invocation, out, "execution", timeout=args.timeout)
    report["result"] = result
    (out / "report.json").write_text(json.dumps(report, indent=2) + "\n")
    print(json.dumps(report, indent=2))
    return 0 if result["returncode"] == 0 else 1


if __name__ == "__main__":
    raise SystemExit(main())
