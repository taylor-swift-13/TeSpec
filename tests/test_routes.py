import argparse
import copy
import json
import io
from pathlib import Path
import tempfile
import unittest
from unittest.mock import patch

from spectest.errors import JobError
from spectest.routes import (
    compare,
    native_cases,
    proof_costs,
    read_itp_config,
    routes_cli,
)


class IndependentRoutesTests(unittest.TestCase):
    def test_cli_default_and_job_or_native_report(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            config = root / "itp.json"
            config.write_text('{"check_timeout": 42}')
            common = ["--output-dir", str(root / "out")]
            with (
                patch(
                    "spectest.routes.compare",
                    return_value={
                        "eligible_executions": 0,
                        "conflicts": [],
                        "routes": {},
                    },
                ) as worker,
                patch("sys.stdout", new_callable=io.StringIO),
            ):
                self.assertEqual(routes_cli(["job.json", *common]), 0)
                (args,) = worker.call_args.args
                self.assertEqual(
                    (args.route, args.job, args.native_report),
                    ("auto", Path("job.json"), None),
                )
                self.assertEqual(
                    routes_cli(
                        [
                            "--native-report",
                            "report.json",
                            "--route",
                            "both",
                            "--itp-config",
                            str(config),
                            "--itp-replay-only",
                            *common,
                        ]
                    ),
                    0,
                )
                (args,) = worker.call_args.args
                self.assertEqual(
                    (args.route, args.job, args.native_report),
                    ("both", None, Path("report.json")),
                )
                self.assertTrue(args.itp_replay_only)
                self.assertEqual(
                    args.itp_config,
                    {"switch": "qcp-8.20", "agent_timeout": 900, "check_timeout": 42},
                )
            for invalid in (
                [],
                ["job.json", "--native-report", "report.json"],
                ["job.json", "--parallel"],
            ):
                with (
                    self.subTest(invalid=invalid),
                    self.assertRaises(SystemExit),
                    patch("sys.stderr", new_callable=io.StringIO),
                ):
                    routes_cli([*invalid, *common])

    def test_invalid_itp_settings_are_rejected(self):
        with tempfile.TemporaryDirectory() as tmp:
            path = Path(tmp) / "settings.json"
            for fields in (
                [],
                {"switch": ""},
                {"agent_timeout": True},
                {"check_timeout": -1},
                {"typo": 1},
            ):
                with self.subTest(fields=fields), self.assertRaises(JobError):
                    path.write_text(json.dumps(fields))
                    read_itp_config(path)

    def test_refined_reports_cannot_feed_the_other_route(self):
        raw = {
            "schema": "qcp-spectest-report/v1",
            "results": [{"id": "x", "status": "UNKNOWN"}],
        }
        for field in ("auto_route", "spatial_smt", "automatic_status"):
            case = copy.deepcopy(raw)
            case["results"][0][field] = {}
            with self.assertRaises(JobError):
                native_cases(case)
        for fields in (
            {"proof_completion": {}},
            {"vc_policy": {"spatial_smt": {"enabled": True}}},
        ):
            with self.assertRaises(JobError):
                native_cases(raw | fields)

    def test_both_workers_receive_only_original_and_share_no_verdict(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            stdout = root / "raw.json"
            stdout.write_text("{}")
            manifest = root / "vc.json"
            manifest.write_text("{}")
            cases = [
                {
                    "id": "pending",
                    "status": "UNKNOWN",
                    "stdout": str(stdout),
                    "vc": {"manifest": str(manifest), "files": {}},
                },
                {"id": "known", "status": "FAIL"},
            ]
            path = root / "native.json"
            path.write_text(
                json.dumps({"schema": "qcp-spectest-report/v1", "results": cases})
            )
            source = path.read_bytes()
            args = argparse.Namespace(
                output_dir=root / "comparison",
                native_report=path,
                route="both",
                itp_replay_only=True,
                proof_cache=None,
                itp_config={
                    "switch": "qcp-8.20",
                    "agent_timeout": 12,
                    "check_timeout": 30,
                },
                spatial_smt_timeout_ms=10,
            )

            def worker(command, meter):
                route = meter.name
                self.assertIn(str(path), command)
                self.assertEqual(path.read_bytes(), source)
                sub = args.output_dir / route
                results = copy.deepcopy(cases)
                if route == "auto":
                    results[0]["status"] = "PASS"
                    branch = {"results": results}
                else:
                    self.assertEqual(
                        command[command.index("--only-case") + 1], "pending"
                    )
                    sub = sub / "proof"
                    branch = {
                        "results": results,
                        "proof_completion": {
                            "agent": {
                                "tokens": 0,
                                "agent_invocations": 0,
                                "wall_seconds": 0,
                                "attempts": [],
                            }
                        },
                    }
                sub.mkdir(parents=True)
                (sub / "report.json").write_text(json.dumps(branch))
                return {
                    "exit_code": 0,
                    "wall_seconds": 0.1,
                    "max_process_rss_kib": 9000,
                }

            with (
                patch("spectest.routes.route_case_ids", return_value={"pending"}),
                patch("spectest.routes.measure", side_effect=worker),
            ):
                result = compare(args)
            self.assertEqual(result["paired_outcomes"], {"PASS/UNKNOWN": 1})
            self.assertEqual(result["cases"][1]["auto_status"], "NOT_RUN")
            self.assertEqual(result["cases"][1]["itp_status"], "NOT_RUN")
            self.assertEqual(result["native_executions"], 2)

    def test_checker_costs_include_failed_attempts_and_count_kernel_separately(self):
        agent = {
            "attempts": [
                {
                    "check": {
                        "stages": [
                            {
                                "stage": label,
                                "wall_seconds": wall,
                                "resources": {"max_process_rss_kib": rss},
                            }
                            for label, wall, rss in seq
                        ]
                    }
                }
                for seq in [
                    [("compile_Candidate.v", 2, 10)],
                    [("compile_Candidate.v", 3, 11), ("kernel_replay", 4, 12)],
                ]
            ]
        }
        costs = proof_costs(agent)
        self.assertEqual(
            costs["coq"], {"wall_seconds": 5, "max_process_rss_kib": 11, "steps": 2}
        )
        self.assertEqual(costs["kernel"]["wall_seconds"], 4)
