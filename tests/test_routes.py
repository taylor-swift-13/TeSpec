import argparse
import copy
import json
from pathlib import Path
import tempfile
import unittest
from unittest.mock import patch

from spectest.errors import JobError
from spectest.routes import compare, native_cases, proof_costs


class IndependentRoutesTests(unittest.TestCase):
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
                input=path,
                from_native=True,
                parallel=True,
                route="both",
                replay_only=True,
                proof_cache=None,
                switch="qcp-8.20",
                agent_timeout=12,
                check_timeout=30,
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
