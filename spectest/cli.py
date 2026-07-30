from __future__ import annotations

import argparse
import json
import subprocess
import sys
from pathlib import Path

from .core import (
    bundled_qcip_root,
    bundled_qcp_binary,
    check_vc_proof,
    JobError,
    analyze_catalog,
    analyze_source,
    read_source_text,
    run_job,
    source_with_local_includes,
)


def _check_parser(prog: str = "qcp-spectest") -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        prog=prog,
        description="Check a QCP-annotated implementation under concrete logic bindings.",
    )
    parser.add_argument(
        "job", type=Path, help="JSON job containing spec+impl and binds"
    )
    parser.add_argument(
        "--output-dir",
        type=Path,
        help="override the job's artifact/report directory",
    )
    parser.add_argument(
        "--compact",
        action="store_true",
        help="print compact JSON instead of indented JSON",
    )
    return parser


def _analyze_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        prog="qcp-spectest analyze",
        description="Analyze a QCP function spec and generate a binds template.",
    )
    parser.add_argument("source", type=Path, help="C file containing spec+impl")
    parser.add_argument(
        "--function",
        help="target function name; omit it to catalog every full spec in the file",
    )
    parser.add_argument(
        "--spec",
        help="named spec to analyze when the function has multiple full specs",
    )
    parser.add_argument(
        "--write-binds",
        type=Path,
        help="also write the generated binds array to this JSON file",
    )
    parser.add_argument(
        "-I",
        "--include-dir",
        action="append",
        type=Path,
        default=[],
        help="local include root used to discover Extern Coq signatures",
    )
    parser.add_argument("--compact", action="store_true")
    return parser


def _run_analyze(argv: list[str]) -> int:
    args = _analyze_parser().parse_args(argv)
    try:
        source_path = args.source.expanduser().resolve()
        source = read_source_text(source_path)
        include_dirs = tuple(item.expanduser().resolve() for item in args.include_dir)
        signature_source = source_with_local_includes(
            source_path, include_dirs, primary_source=source
        )
        if args.spec is not None and args.function is None:
            raise JobError("--spec requires --function")
        analysis = (
            analyze_source(
                source,
                args.function,
                args.spec,
                signature_source=signature_source,
            )
            if args.function is not None
            else analyze_catalog(source, signature_source=signature_source)
        )
        if args.write_binds is not None:
            if args.function is None:
                raise JobError("--write-binds requires --function")
            target = args.write_binds.expanduser().resolve()
            target.parent.mkdir(parents=True, exist_ok=True)
            target.write_text(
                json.dumps(analysis["binds_template"], ensure_ascii=False, indent=2)
                + "\n",
                encoding="utf-8",
            )
    except (JobError, OSError) as error:
        print(
            json.dumps(
                {
                    "schema": "qcp-spectest-error/v1",
                    "status": "ERROR",
                    "error": str(error),
                },
                ensure_ascii=False,
                indent=None if args.compact else 2,
            ),
            file=sys.stderr,
        )
        return 2
    print(
        json.dumps(
            analysis,
            ensure_ascii=False,
            indent=None if args.compact else 2,
        )
    )
    return 0 if analysis["supported"] else 1


def _run_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        prog="qcp-spectest run",
        description="Check a source file using a human- or model-written binds file.",
    )
    parser.add_argument("source", type=Path, help="C file containing spec+impl")
    parser.add_argument("--function", required=True, help="target function name")
    parser.add_argument("--spec", help="named spec when the function has several")
    parser.add_argument(
        "--binds",
        required=True,
        type=Path,
        help="JSON array of bind cases, or an object containing a binds array",
    )
    parser.add_argument(
        "--output-dir",
        type=Path,
        help="artifact directory (default: .spectest/<source>-<function>)",
    )
    parser.add_argument("--qcip-root", type=Path, default=bundled_qcip_root())
    parser.add_argument(
        "--qcp-binary",
        type=Path,
        default=bundled_qcp_binary(),
    )
    parser.add_argument(
        "--loop-unroll-limit",
        type=int,
        default=64,
        help="concrete loop bound (default: 64)",
    )
    parser.add_argument(
        "--call-depth-limit",
        type=int,
        default=64,
        help="concrete call/recursion depth bound (default: 64)",
    )
    parser.add_argument(
        "--timeout", type=float, default=30, help="QCP timeout per bind"
    )
    parser.add_argument(
        "-I",
        "--include-dir",
        action="append",
        default=[],
        help="extra include directory, absolute or relative to qcip-root",
    )
    parser.add_argument("--compact", action="store_true")
    return parser


def _run_source(argv: list[str]) -> int:
    args = _run_parser().parse_args(argv)
    try:
        source = args.source.expanduser().resolve()
        binds_path = args.binds.expanduser().resolve()
        payload = json.loads(binds_path.read_text(encoding="utf-8"))
        binds = payload.get("binds") if isinstance(payload, dict) else payload
        if not isinstance(binds, list):
            raise JobError(
                "binds file must be a JSON array or an object with a binds array"
            )
        output_dir = (
            args.output_dir.expanduser().resolve()
            if args.output_dir is not None
            else (Path.cwd() / ".spectest" / f"{source.stem}-{args.function}").resolve()
        )
        output_dir.mkdir(parents=True, exist_ok=True)
        job = {
            "source": str(source),
            "function": args.function,
            "binds": binds,
            "output_dir": str(output_dir),
            "qcp": {
                "qcip_root": str(args.qcip_root.expanduser().resolve()),
                "binary": str(args.qcp_binary.expanduser().resolve()),
                "loop_unroll_limit": args.loop_unroll_limit,
                "call_depth_limit": args.call_depth_limit,
                "include_dirs": args.include_dir,
                "timeout_seconds": args.timeout,
            },
        }
        if args.spec is not None:
            job["spec"] = args.spec
        job_path = output_dir / "job.json"
        job_path.write_text(
            json.dumps(job, ensure_ascii=False, indent=2) + "\n",
            encoding="utf-8",
        )
        report = run_job(job_path, output_dir)
    except (JobError, OSError, json.JSONDecodeError) as error:
        print(
            json.dumps(
                {
                    "schema": "qcp-spectest-error/v1",
                    "status": "ERROR",
                    "error": str(error),
                },
                ensure_ascii=False,
                indent=None if args.compact else 2,
            ),
            file=sys.stderr,
        )
        return 2
    print(
        json.dumps(
            report,
            ensure_ascii=False,
            indent=None if args.compact else 2,
        )
    )
    summary = report["summary"]
    return 0 if summary["PASS"] == summary["total"] else 1


def _proof_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        prog="qcp-spectest check-proof",
        description="Validate a filled residual proof using Coq 8.20.",
    )
    parser.add_argument("manifest", type=Path, help="VC manifest.json")
    parser.add_argument(
        "--timeout", type=float, default=120, help="timeout per Coq file"
    )
    parser.add_argument("--compact", action="store_true")
    return parser


def _run_proof(argv: list[str]) -> int:
    args = _proof_parser().parse_args(argv)
    try:
        report = check_vc_proof(args.manifest, timeout_seconds=args.timeout)
    except (JobError, OSError, subprocess.SubprocessError) as error:
        print(
            json.dumps(
                {
                    "schema": "qcp-spectest-error/v1",
                    "status": "ERROR",
                    "error": str(error),
                },
                ensure_ascii=False,
                indent=None if args.compact else 2,
            ),
            file=sys.stderr,
        )
        return 2
    print(
        json.dumps(
            report,
            ensure_ascii=False,
            indent=None if args.compact else 2,
        )
    )
    return 0 if report["status"] == "PASS" else 1


def main(argv: list[str] | None = None) -> int:
    argv = list(sys.argv[1:] if argv is None else argv)
    if argv and argv[0] == "analyze":
        return _run_analyze(argv[1:])
    if argv and argv[0] == "run":
        return _run_source(argv[1:])
    if argv and argv[0] == "check-proof":
        return _run_proof(argv[1:])
    if argv and argv[0] == "check":
        argv = argv[1:]
    args = _check_parser("qcp-spectest check").parse_args(argv)
    try:
        report = run_job(args.job, args.output_dir)
    except JobError as error:
        print(
            json.dumps(
                {
                    "schema": "qcp-spectest-error/v1",
                    "status": "ERROR",
                    "error": str(error),
                },
                ensure_ascii=False,
                indent=None if args.compact else 2,
            ),
            file=sys.stderr,
        )
        return 2

    print(
        json.dumps(
            report,
            ensure_ascii=False,
            indent=None if args.compact else 2,
        )
    )
    summary = report["summary"]
    return 0 if summary["PASS"] == summary["total"] else 1
