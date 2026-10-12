#!/usr/bin/env python3
"""Verify a published artifact archive and unpack only its OCI container metadata/blobs.

Does not extract layers into a root filesystem or execute image contents.
"""

import argparse
import hashlib
import json
from pathlib import Path
import re
import tarfile
import time


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("archive", type=Path)
    parser.add_argument("--md5", required=True)
    parser.add_argument("--output", type=Path, required=True)
    parser.add_argument("--wait-pid", type=int)
    args = parser.parse_args()
    out = args.output.resolve()
    if out.exists() and any(out.iterdir()):
        parser.error("output must be empty")
    if args.wait_pid:
        process = Path(f"/proc/{args.wait_pid}/cmdline")
        while process.exists():
            try:
                command = process.read_bytes()
            except FileNotFoundError:
                break
            if (
                b"curl" not in command
                or str(args.archive.resolve()).encode() not in command
            ):
                raise RuntimeError("waited process no longer matches the download")
            time.sleep(10)
    md5, sha256 = hashlib.md5(), hashlib.sha256()
    with args.archive.open("rb") as stream:
        while chunk := stream.read(1024 * 1024):
            md5.update(chunk)
            sha256.update(chunk)
    if md5.hexdigest() != args.md5:
        raise ValueError("published archive checksum mismatch")
    out.mkdir(parents=True, exist_ok=True)
    entries = []
    seen = set()
    with tarfile.open(args.archive, "r|gz") as archive:
        for member in archive:
            name = member.name.removeprefix("./").rstrip("/")
            if member.isdir() and name in {"blobs", "blobs/sha256"}:
                continue
            allowed = name in {
                "index.json",
                "manifest.json",
                "oci-layout",
                "repositories",
            } or re.fullmatch(r"blobs/sha256/[0-9a-f]{64}", name)
            if not member.isfile() or not allowed or name in seen:
                raise ValueError("unexpected or duplicate OCI archive member: " + name)
            seen.add(name)
            target = out / name
            target.parent.mkdir(parents=True, exist_ok=True)
            digest = hashlib.sha256()
            with archive.extractfile(member) as source, target.open("wb") as dest:
                while chunk := source.read(1024 * 1024):
                    digest.update(chunk)
                    dest.write(chunk)
            if name.startswith("blobs/") and digest.hexdigest() != target.name:
                raise ValueError("OCI blob digest mismatch: " + name)
            entries.append(
                {"file": name, "bytes": member.size, "sha256": digest.hexdigest()}
            )
    report = {
        "archive_md5": md5.hexdigest(),
        "archive_sha256": sha256.hexdigest(),
        "entries": entries,
    }
    for name in ["index.json", "manifest.json", "oci-layout", "repositories"]:
        if (out / name).exists():
            report[name] = json.loads((out / name).read_text())
    (out / "inspection.json").write_text(json.dumps(report, indent=2) + "\n")
    print(
        json.dumps(
            {
                "status": "VERIFIED",
                "entries": len(entries),
                "archive_sha256": sha256.hexdigest(),
            }
        )
    )


if __name__ == "__main__":
    main()
