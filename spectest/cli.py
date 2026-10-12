from __future__ import annotations

import argparse
import json
import subprocess
import sys
from pathlib import Path

from .core import (
    attach_spec_to_source,
    bundled_qcip_root,
    bundled_qcp_binary,
    check_vc_proof,
    _write_vc_manifest,
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
    parser.add_argument(
        "source",
        type=Path,
        help="C implementation, optionally already containing its QCP spec",
    )
    parser.add_argument(
        "--function",
        help="target function name; omit it to catalog every full spec in the file",
    )
    parser.add_argument(
        "--spec",
        help="named spec to analyze when the function has multiple full specs",
    )
    parser.add_argument(
        "--spec-file",
        type=Path,
        help="separate QCP spec body to attach to --function before analysis",
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
        if args.spec_file is not None:
            if args.function is None:
                raise JobError("--spec-file requires --function")
            source = attach_spec_to_source(
                source,
                read_source_text(args.spec_file.expanduser().resolve()),
                args.function,
            )
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
    parser.add_argument(
        "source",
        type=Path,
        help="C implementation, optionally already containing its QCP spec",
    )
    parser.add_argument("--function", required=True, help="target function name")
    parser.add_argument("--spec", help="named spec when the function has several")
    parser.add_argument(
        "--spec-file",
        type=Path,
        help="separate QCP spec body to attach before execution",
    )
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
    parser.add_argument(
        "--execution-mode",
        choices=("expand", "no-expand"),
        default="expand",
        help="execute loops/calls in both modes; no-expand also checks intermediate boundaries",
    )
    parser.add_argument(
        "--annotation-policy", choices=("ignore", "check-preserve", "qcp")
    )
    parser.add_argument(
        "--instance-trace",
        action="store_true",
        help="record current logical formulas and memory in executor JSON",
    )
    parser.add_argument("--qcip-root", type=Path, default=bundled_qcip_root())
    parser.add_argument(
        "--architecture-bits",
        type=int,
        choices=(32, 64),
        default=32,
        help="target width; requires a matching executor build and proof runtime",
    )
    parser.add_argument(
        "--qcp-binary",
        type=Path,
        default=bundled_qcp_binary(),
    )
    parser.add_argument(
        "--loop-unroll-limit",
        type=int,
        default=None,
        help="concrete loop bound (default: 64 in expand mode)",
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
                "architecture_bits": args.architecture_bits,
                "loop_unroll_limit": args.loop_unroll_limit,
                "execution_mode": args.execution_mode,
                "annotation_policy": args.annotation_policy,
                "instance_trace": args.instance_trace,
                "call_depth_limit": args.call_depth_limit,
                "include_dirs": args.include_dir,
                "timeout_seconds": args.timeout,
            },
        }
        job["qcp"]["loop_unroll_limit"] = (
            args.loop_unroll_limit if args.loop_unroll_limit is not None else 64
        )
        if args.spec_file is not None:
            job["spec_file"] = str(args.spec_file.expanduser().resolve())
        if args.spec is not None:
            job["spec"] = args.spec
        job_path = output_dir / "artifacts" / "job.json"
        job_path.parent.mkdir(parents=True, exist_ok=True)
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


def _prepare_proof_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        prog="qcp-spectest prepare-proof",
        description="Create a hash-pinned manifest for generated QCP proof files.",
    )
    parser.add_argument("vc_dir", type=Path, help="directory containing generated VCs")
    parser.add_argument("generated_source", type=Path, help="source copied into vc_dir")
    parser.add_argument(
        "original_source", type=Path, help="original source with Coq imports"
    )
    parser.add_argument("--function", required=True)
    parser.add_argument("--case-id", required=True)
    parser.add_argument("--qcip-root", type=Path, default=bundled_qcip_root())
    parser.add_argument(
        "--dependency-source", help="alternate source text for dependency discovery"
    )
    parser.add_argument("--compact", action="store_true")
    return parser


def _run_prepare_proof(argv: list[str]) -> int:
    args = _prepare_proof_parser().parse_args(argv)
    try:
        manifest = _write_vc_manifest(
            args.vc_dir.expanduser().resolve(),
            args.generated_source.expanduser().resolve(),
            args.original_source.expanduser().resolve(),
            args.qcip_root.expanduser().resolve(),
            args.function,
            args.case_id,
            args.dependency_source,
        )
    except (JobError, OSError, ValueError) as error:
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
    print(json.dumps(manifest, ensure_ascii=False, indent=None if args.compact else 2))
    return 0 if not manifest["missing_files"] else 1


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


def _run_certificate_command(command: str, argv: list[str]) -> int:
    from .certificates import check_certificate, prepare_certificate
    from .run_certificates import check_run_certificates, prepare_run_certificates

    whole_run = command in {"prepare-run-certificates", "check-run-certificates"}
    prepare = command.startswith("prepare-")
    parser = argparse.ArgumentParser(prog="qcp-spectest " + command)
    parser.add_argument(
        "input", type=Path, metavar="input" if whole_run else "manifest"
    )
    if prepare:
        parser.add_argument("--output", type=Path, required=True)
        if whole_run:
            parser.add_argument(
                "--refute-vc", action="append", default=[], metavar="CASE_ID=PROOF_NAME",
                help="prove the negation of an original path VC in this case",
            )
            parser.add_argument(
                "--refute-precondition",
                action="append",
                default=[],
                metavar="CASE_ID",
                help="prove the negation of this case's unique unresolved Require SAT VC",
            )
        else:
            parser.add_argument(
                "--only", action="append", metavar="PROOF_NAME",
                help="check only these original VCs; retain other obligations unresolved",
            )
            parser.add_argument(
                "--refute",
                help="prove the negation of one original VC",
            )
    else:
        parser.add_argument(
            "--manifest-sha256",
            required=True,
            help="digest recorded by the controller at preparation",
        )
        parser.add_argument("--switch", default="qcp-8.20")
        parser.add_argument("--timeout", type=float, default=120)
    args = parser.parse_args(argv)
    try:
        if prepare:
            operation = prepare_run_certificates if whole_run else prepare_certificate
            refute_vcs = {}
            if whole_run:
                for item in args.refute_vc:
                    case, separator, target = item.partition("=")
                    if not separator or not case or not target or case in refute_vcs:
                        raise JobError("--refute-vc expects one CASE_ID=PROOF_NAME per case")
                    refute_vcs[case] = target
            options = (
                {"refute_preconditions": set(args.refute_precondition), "refute_vcs": refute_vcs}
                if whole_run
                else {"refute": args.refute, "only": set(args.only) if args.only else None}
            )
            result = operation(args.input, args.output, **options)
        else:
            operation = check_run_certificates if whole_run else check_certificate
            result = operation(
                args.input,
                args.manifest_sha256,
                switch=args.switch,
                timeout=args.timeout,
            )
    except (JobError, OSError, ValueError, KeyError) as error:
        print(json.dumps({"status": "ERROR", "error": str(error)}), file=sys.stderr)
        return 2
    print(json.dumps(result, ensure_ascii=False, indent=2))
    if whole_run:
        return (
            0 if prepare or all(c["status"] == "PASS" for c in result["results"]) else 1
        )
    return (
        0
        if result.get("status", "PASS") == "PASS"
        or result.get("proof_status") == "VALID"
        else 1
    )


def main(argv: list[str] | None = None) -> int:
    argv = list(sys.argv[1:] if argv is None else argv)
    if argv in (["--help"], ["-h"]):
        parser = argparse.ArgumentParser(
            prog="qcp-spectest",
            usage="%(prog)s COMMAND [OPTIONS]",
            description="Instance checking of QCP specifications and C programs.",
            formatter_class=argparse.RawDescriptionHelpFormatter,
            epilog=(
                "Commands:\n"
                "  analyze                   Analyze specs and create a binds template\n"
                "  run                       Test a source file with binds\n"
                "  check                     Replay a saved job\n"
                "  prepare-run-certificates  Prepare all proof tasks from a report\n"
                "  check-run-certificates    Check the complete run certificate\n"
                "  prepare-certificate       Prepare one VC group's certificate\n"
                "  check-certificate         Check one VC group's certificate\n"
                "  prepare-proof             Collect an existing VC manifest\n"
                "  check-proof               Check an existing residual proof\n\n"
                "Use COMMAND --help for options. A bare job.json remains accepted."
            ),
        )
        parser.print_help()
        return 0
    if argv and argv[0] in {
        "prepare-run-certificates",
        "check-run-certificates",
        "prepare-certificate",
        "check-certificate",
    }:
        return _run_certificate_command(argv[0], argv[1:])
    if argv and argv[0] == "analyze":
        return _run_analyze(argv[1:])
    if argv and argv[0] == "run":
        return _run_source(argv[1:])
    if argv and argv[0] == "check-proof":
        return _run_proof(argv[1:])
    if argv and argv[0] == "prepare-proof":
        return _run_prepare_proof(argv[1:])
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
