import hashlib
from pathlib import Path
from subprocess import CompletedProcess
import tempfile
import unittest
from unittest.mock import patch

from tools.benchmark import organize_tespec_routes as routes


class BenchmarkRouteInputTests(unittest.TestCase):
    def setUp(self):
        temp = tempfile.TemporaryDirectory()
        self.addCleanup(temp.cleanup)
        self.root = Path(temp.name)
        base = self.root / "benchmark/programs/group"
        base.mkdir(parents=True)
        self.original = base / "original.c"
        self.fixture = base / "input.c"
        source = "struct S { int x; };\nint sample(struct S s) /*@ Require emp Ensure emp */ { return s.x; }\n"
        self.original.write_text(source)
        prefix = "Require s.x == 3 && "
        self.fixture.write_text(source.replace("Require ", prefix))
        self.metadata = {
            "path": str(self.fixture.relative_to(self.root)),
            "sha256": routes.fingerprint(self.fixture),
            "original_source_sha256": routes.fingerprint(self.original),
            "original_require_offset": source.index("Require "),
            "inserted_require_prefix": prefix,
            "scope": "CONCRETE_AGGREGATE_FIELD_ENTRY_BINDING",
            "parameter": "s", "struct_type": "S", "field_bindings": {"x": 3},
        }
        self.case = {
            "id": "sample_3", "value": {"x": 3}, "expected": "PASS",
            "binds": {"args": {"s": {"symbolic": True}}, "values": {}},
        }
        self.plan = {"function": "sample", "pairings": [
            {"qcp_variant": "v", "cn_variant": "c", "cases": [self.case]}
        ]}
        variant = base / "variants/v/manifest.json"
        routes.save(variant, {"files": {"qcp": {
            "path": str(self.original.relative_to(self.root)),
            "sha256": routes.fingerprint(self.original), "include_dirs": [],
        }}})
        routes.save(base / "manifest.json", {"variants": [
            {"id": "v", "manifest": str(variant.relative_to(self.root))}
        ]})
        self.plan_file = base / "evaluation-plan.json"
        self.results = self.root / "benchmark/results"
        patches = patch.multiple(routes, ROOT=self.root, RESULTS=self.results, BINARY=self.original)
        patches.start()
        self.addCleanup(patches.stop)

    def tasks(self):
        routes.save(self.plan_file, self.plan)
        return routes.inputs("group")[0]

    def test_fixture_selection_invalidates_original_archive(self):
        tasks = self.tasks()
        key = ("v", "sample_3", "inline")
        original_source = tasks[key][0][1]
        self.assertEqual(self.root / original_source["path"], self.original)
        archive = self.results / "group/residual-routes/comparison.json"
        routes.save(archive, {
            "native_binary_sha256": routes.fingerprint(routes.BINARY),
            "input_matrix_sha256": routes.matrix_hash({k: v[0] for k, v in tasks.items()}),
            "auto_implementation_sha256": {},
            "executions": [{"variant": v, "input": c, "strategy": s} for v, c, s in tasks],
        })
        self.assertEqual(routes.archived_routes("group", tasks)[0], archive)

        self.case["qcp_input_fixture"] = self.metadata
        tasks = self.tasks()
        for detail in tasks.values():
            source = detail[0][1]
            self.assertEqual(self.root / source["path"], self.fixture)
            self.assertEqual(source["sha256"], routes.fingerprint(self.fixture))
            self.assertEqual(source["original_source_sha256"], original_source["sha256"])
        self.assertEqual(routes.archived_routes("group", tasks), (None, {}))

    def test_retry_reuses_only_rows_bound_to_the_selected_fixture(self):
        key = ("v", "sample_3", "inline")
        bare = self.tasks()[key]
        (_, source, bind, expectation), _, fault = bare
        row = {"source_sha256": source["sha256"], "input_sha256": routes.digest(bind),
               "expected": expectation, "expected_fault_code": fault}
        self.assertTrue(routes.reusable_row(row, bare))
        self.case["qcp_input_fixture"] = self.metadata
        selected = self.tasks()[key]
        self.assertFalse(routes.reusable_row(row, selected))
        row.update(source_sha256=self.metadata["sha256"],
                   original_source_sha256=self.metadata["original_source_sha256"],
                   qcp_input_fixture_path=self.metadata["path"])
        self.assertFalse(routes.reusable_row(row, selected))
        row["executed_source_sha256"] = routes.fingerprint(self.fixture)
        self.assertTrue(routes.reusable_row(row, selected))

    def test_invalid_fixture_is_rejected(self):
        for field in ("sha256", "original_source_sha256"):
            with self.subTest(field=field):
                self.case["qcp_input_fixture"] = dict(self.metadata, **{field: "0" * 64})
                with self.assertRaises(ValueError):
                    self.tasks()
        self.fixture.write_text(self.fixture.read_text().replace("return s.x;", "return 0;"))
        self.case["qcp_input_fixture"] = dict(self.metadata, sha256=routes.fingerprint(self.fixture))
        with self.assertRaises(ValueError):
            self.tasks()

    def test_launch_failure_has_no_executed_hash(self):
        self.case["qcp_input_fixture"] = self.metadata
        key = ("v", "sample_3", "inline")
        task = (key, self.tasks()[key])

        def launch_failed(command, **kwargs):
            out = Path(command[command.index("--output-dir") + 1])
            routes.save(out / "native/report.json", {
                "provenance": {"source_sha256": self.metadata["sha256"]},
                "results": [{"generated_source": str(self.fixture), "status": "ERROR"}],
            })
            return CompletedProcess(command, 1, "", "executor could not be started")

        with patch.object(routes.subprocess, "run", side_effect=launch_failed):
            row = routes.run_one(task)
        self.assertEqual(row["effective_status"], "ERROR")
        self.assertIsNone(row["executed_source_sha256"])

    def test_native_error_records_the_file_actually_executed(self):
        self.case["qcp_input_fixture"] = self.metadata
        key = ("v", "sample_3", "inline")
        task = (key, self.tasks()[key])
        generated_bytes = b"/* native specialization */\n" + self.fixture.read_bytes()
        reported_digest = None

        def native(command, **kwargs):
            job = routes.read(Path(command[command.index("routes") + 1]))
            self.assertEqual(Path(job["source"]), self.fixture)
            out = Path(command[command.index("--output-dir") + 1])
            generated = out / "native/artifacts" / key[1] / "input.c"
            generated.parent.mkdir(parents=True)
            generated.write_bytes(generated_bytes)
            routes.save(out / "native/report.json", {
                "provenance": {"source_sha256": self.metadata["sha256"]},
                "results": [{
                    "id": key[1], "generated_source": str(generated),
                    "command": [str(routes.BINARY), f"--input-file={generated}"],
                    "generated_source_sha256": reported_digest or routes.fingerprint(generated),
                    "status": "ERROR",
                }],
            })
            routes.save(out / "routes.json", {
                "cases": [{"eligible": False, "auto_status": "NOT_RUN", "native_status": "ERROR"}],
                "routes": {}, "native_report_sha256": routes.fingerprint(out / "native/report.json"),
                "native_cost": {},
            })
            return CompletedProcess(command, 0, "", "")

        with patch.object(routes.subprocess, "run", side_effect=native):
            row = routes.run_one(task)
        self.assertEqual(row["effective_status"], "ERROR")
        self.assertEqual(row["executed_source_sha256"], hashlib.sha256(generated_bytes).hexdigest())
        self.assertNotEqual(row["executed_source_sha256"], self.metadata["sha256"])
        reported_digest = self.metadata["sha256"]
        with patch.object(routes.subprocess, "run", side_effect=native), self.assertRaises(ValueError):
            routes.run_one(task)
