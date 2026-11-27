from __future__ import annotations

import json
import os
import subprocess
from pathlib import Path
import tempfile
import sys
import time
import unittest
from unittest.mock import patch

from spectest.certificates import (
    _benchmark_resource_slot,
    _idle_kernel_lease,
    _second_candidate_has_headroom,
    _reserved_job_memory_kib,
    _uncompiled_runtime_modules,
    assumption_audit_from_output,
    assumptions_from_output,
    check_candidate_commands,
    check_certificate,
    check_dependency_namespace,
    digest,
    goal_interface,
    prepare_certificate,
    strip_comments,
)
from spectest.core import JobError
from spectest.kernel_replay import KernelReplayCache

ROOT = Path(__file__).resolve().parents[1]


class CertificateInputTests(unittest.TestCase):
    def test_parallel_candidate_requires_active_capped_first_candidate_and_free_memory(self):
        limit = 4 * 1024**3
        with tempfile.TemporaryDirectory() as directory:
            slots = Path(directory)
            (slots / "candidate-0.lock").write_text("100")
            proc = slots / "proc"
            meminfo = proc / "meminfo"
            child = proc / "101"
            for parent, children in (("100", "101"), ("101", "")):
                task = proc / parent / "task" / parent
                task.mkdir(parents=True)
                (task / "children").write_text(children)
                (proc / parent / "comm").write_text("python" if parent == "100" else "coqc")
            (child / "cmdline").write_bytes(b"coqc\0/job/Candidate.v\0")
            (child / "status").write_text("RssAnon: 1048576 kB")
            (proc / "locks").write_text("")
            (child / "limits").write_text(f"Max address space {limit} {limit} bytes")
            meminfo.write_text("MemAvailable: 14680064 kB\nSwapFree: 3145728 kB")
            with patch("spectest.certificates.Path", side_effect=lambda raw: slots / raw.lstrip("/")):
                self.assertTrue(_second_candidate_has_headroom(slots, limit))
                meminfo.write_text("MemAvailable: 8388608 kB\nSwapFree: 3145728 kB")
                self.assertFalse(_second_candidate_has_headroom(slots, limit))
                meminfo.write_text("MemAvailable: 14680064 kB\nSwapFree: 3145728 kB")
                (child / "limits").write_text("Max address space unlimited unlimited bytes")
                self.assertFalse(_second_candidate_has_headroom(slots, limit))

    def test_reserved_memory_credits_only_locked_local_jobs_and_anon_pages(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            proc = root / "proc"
            node = proc / "201"
            thread = node / "task/201"
            thread.mkdir(parents=True)
            (thread / "children").write_text("")
            (node / "comm").write_text("coqchk")
            (node / "status").write_text("VmRSS: 700000 kB\nRssAnon: 500000 kB")
            slot = root / "kernel-0.lock"
            slot.touch()
            st = slot.stat()
            identity = f"{os.major(st.st_dev):x}:{os.minor(st.st_dev):x}:{st.st_ino}"
            (proc / "locks").write_text(f"1: FLOCK ADVISORY WRITE 201 {identity} 0 EOF")
            with patch("spectest.certificates.Path", return_value=proc):
                self.assertEqual(_reserved_job_memory_kib(root), 500000)
                (node / "comm").write_text("other")
                self.assertEqual(_reserved_job_memory_kib(root), 0)
                (node / "comm").write_text("coqchk")
                (proc / "locks").write_text(f"1: -> FLOCK ADVISORY WRITE 201 {identity} 0 EOF")
                self.assertEqual(_reserved_job_memory_kib(root), 0)

    def test_idle_kernel_lease_respects_current_holders_and_queued_admission(self):
        import fcntl
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            for name in ("kernel-admission.lock", "kernel-0.lock", "kernel-1.lock"):
                with (root / name).open("a") as holder:
                    fcntl.flock(holder, fcntl.LOCK_EX)
                    self.assertEqual(_idle_kernel_lease(root), [])
            active = _idle_kernel_lease(root)
            self.assertEqual(len(active), 2)
            self.assertEqual(_idle_kernel_lease(root), [])
            for handle in active:
                handle.close()
            with (root / "kernel-0.lock").open("a") as next_kernel:
                fcntl.flock(next_kernel, fcntl.LOCK_EX | fcntl.LOCK_NB)

    def test_idle_kernel_releases_first_lock_if_second_file_fails(self):
        import fcntl
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            (root / "kernel-1.lock").mkdir()
            with self.assertRaises(IsADirectoryError):
                _idle_kernel_lease(root)
            with (root / "kernel-0.lock").open("a") as contender:
                fcntl.flock(contender, fcntl.LOCK_EX | fcntl.LOCK_NB)

    def test_bounded_job_retains_kernel_lane_if_checker_is_terminated(self):
        import fcntl
        from textwrap import dedent
        with tempfile.TemporaryDirectory() as directory:
            folder = Path(directory)
            script = dedent("""
                import os, subprocess, sys
                from pathlib import Path
                from spectest.certificates import _benchmark_resource_slot
                d = Path(sys.argv[1])
                passed = []
                with _benchmark_resource_slot("kernel_replay", job_fds=passed):
                    job = subprocess.Popen(
                        ["/usr/bin/time", "-o", str(d / "time"), "/usr/bin/timeout", "5",
                         sys.executable, "-c", "import time; time.sleep(1.0)"],
                        start_new_session=True, pass_fds=tuple(passed))
                    (d / "started").write_text(str(job.pid))
                    job.wait()
            """)
            checker = subprocess.Popen([sys.executable, "-c", script, directory], cwd=ROOT,
                                       env={**os.environ, "TESPEC_ITP_RESOURCE_DIR": directory})
            try:
                deadline = time.monotonic() + 4
                while not (folder / "started").exists() and time.monotonic() < deadline:
                    time.sleep(0.01)
                self.assertTrue((folder / "started").is_file())
                checker.kill()
                checker.wait(timeout=2)
                with (folder / "kernel-0.lock").open("a") as contender:
                    with self.assertRaises(BlockingIOError):
                        fcntl.flock(contender, fcntl.LOCK_EX | fcntl.LOCK_NB)
                    deadline = time.monotonic() + 4
                    while True:
                        try:
                            fcntl.flock(contender, fcntl.LOCK_EX | fcntl.LOCK_NB)
                            break
                        except BlockingIOError:
                            if time.monotonic() >= deadline:
                                self.fail("lane still held after the bounded job ended")
                            time.sleep(0.02)
                self.assertGreater((folder / "time").stat().st_size, 0)
            finally:
                if checker.poll() is None:
                    checker.kill()
                    checker.wait()

    def test_benchmark_candidate_capacity_cannot_exceed_memory_budget(self):
        with tempfile.TemporaryDirectory() as directory, patch.dict(os.environ, {
            "TESPEC_ITP_RESOURCE_DIR": directory, "TESPEC_ITP_CANDIDATE_SLOTS": "3"
        }), self.assertRaisesRegex(JobError, "resource-slot count"):
            with _benchmark_resource_slot("compile_Candidate.v"):
                self.fail("third candidate slot acquired")

    def test_task_dependencies_cannot_shadow_controller_modules(self):
        with tempfile.TemporaryDirectory() as directory:
            _, runtime = self.prepare_fixture(Path(directory))
            for module in (
                "Goal",
                "Candidate",
                "Coverage",
                "Assumptions",
                "AssumptionIdentities.Helper",
            ):
                with (
                    self.subTest(module=module),
                    self.assertRaisesRegex(JobError, "shadows"),
                ):
                    check_dependency_namespace(module, runtime)
            check_dependency_namespace("Domain.Candidate", runtime)

    def test_import_module_name_is_not_an_axiom_declaration(self):
        check_candidate_commands("From AUXLib Require Import Axioms ListLib.")
        check_candidate_commands("Require Import AUXLib.Axioms.")
        with self.assertRaisesRegex(JobError, "forbidden"):
            check_candidate_commands("Require Import AUXLib.Axioms. Axiom bad : False.")

    def test_complete_interface_including_nonresidual_goals(self):
        source = """Definition pre := True.
Definition ret := True.
Module Type VC_Correct.
(* automatic (* nested *) proof *) Axiom proof_of_pre : pre.
Axiom proof_of_ret : ret.
End VC_Correct.
"""
        self.assertEqual(
            goal_interface(source), [("proof_of_pre", "pre"), ("proof_of_ret", "ret")]
        )

    def test_unrecognized_interface_is_rejected_not_truncated(self):
        source = "Module Type VC_Correct. Axiom proof_of_x : x. Parameter omitted : False. End VC_Correct."
        with self.assertRaises(JobError):
            goal_interface(source)

    def test_nested_comments_and_strings(self):
        self.assertRegex(
            strip_comments('"(*still string*)" (* (* hidden *) *) True').strip(),
            r'^"\(\*still string\*\)"\s+True$',
        )
        self.assertEqual(strip_comments("Axiom(**)bad : False."), "Axiom bad : False.")

    def test_multiline_assumption_names(self):
        self.assertEqual(
            assumptions_from_output(
                "Axioms:\nClassical_Prop.classic\n : forall P, P \\/ ~P\nBad.proof : False\n"
            ),
            {"Classical_Prop.classic", "Bad.proof"},
        )

    def test_import_warning_is_not_an_assumption_but_axiom_named_warning_is(self):
        self.assertEqual(
            assumptions_from_output(
                "Warning: import masks a name\nAxioms:\nWarning : False\n"
            ),
            {"Warning"},
        )
        self.assertEqual(
            assumptions_from_output(
                "Warning: import masks a name\nClosed under the global context\n"
            ),
            set(),
        )

    def test_all_printed_axiom_names_are_preserved(self):
        observed, unsupported = assumption_audit_from_output(
            "Axioms:\nUnsafe.α : False\nUnsafe.bad' : False\n"
            "Classical_Prop.classic : forall P : Prop, P \/ ~ P\n")
        self.assertEqual(observed, {"Unsafe.α", "Unsafe.bad'", "Classical_Prop.classic"})
        self.assertEqual(unsupported, [])

    def test_kernel_flags_and_unknown_records_cannot_hide_beside_allowed_axiom(self):
        for entry in ("Unsafe.loop is assumed to be guarded.",
                      "Unsafe.bad is assumed to be positive.",
                      "Unsafe.type relies on an unsafe hierarchy.",
                      "Unsafe.ind relies on definitional UIP.",
                      "a new unrecognized axiom entry"):
            with self.subTest(entry=entry):
                observed, unsupported = assumption_audit_from_output(
                    "Axioms:\n" + entry + "\nClassical_Prop.classic : forall P, P \/ ~ P\n")
                self.assertEqual(observed, {"Classical_Prop.classic"})
                self.assertEqual(unsupported, [entry])

    def test_unapproved_theory_flags_are_retained(self):
        for entry in ("Set is impredicative",
                      "Rewrite rules are allowed (subject reduction might be broken)",
                      "Type hierarchy is collapsed (logic is inconsistent)"):
            with self.subTest(entry=entry):
                _, unsupported = assumption_audit_from_output(
                    "Axioms:\nClassical_Prop.classic : forall P, P \/ ~ P\nTheory:\n" + entry)
                self.assertEqual(unsupported, ["Theory: " + entry])

    def prepare_fixture(self, root, layout=None):
        vc = root / "original"
        vc.mkdir()
        goal = vc / "input_goal.v"
        goal.write_text(
            "Definition entry := True.\nModule Type VC_Correct.\nAxiom proof_of_entry : entry.\nEnd VC_Correct.\n"
        )
        runtime = root / "runtime" / "SeparationLogic"
        runtime.mkdir(parents=True)
        (runtime / "_CoqProject").write_text("")
        # A compiled dependency is independently pinned, even with unchanged source.
        (runtime / "Lib.vo").write_bytes(b"compiled library version 1")
        original = vc / "manifest.json"
        original.write_text(
            json.dumps(
                {
                    "schema": "qcp-spectest-vc-manifest/v1",
                    "files": {"goal": str(goal)},
                    "immutable_sha256": {"goal": digest(goal)},
                    "qcip_root": str(runtime.parent),
                    "coq_dependencies": [],
                    "target_layout": layout,
                }
            )
        )
        result = prepare_certificate(original, root / "certificate")
        return result, runtime

    def test_source_only_modules_use_pinned_mapping_and_import_order(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            _, runtime = self.prepare_fixture(root)
            (runtime / "_CoqProject").write_text("-R examples SimpleC.EE\n")
            folder = runtime / "examples/Domain"
            folder.mkdir(parents=True)
            base, outer = folder / "Base.v", folder / "Outer.v"
            base.write_text("Definition base := True.")
            outer.write_text("Require Import SimpleC.EE.Domain.Base. Definition outer := base.")
            pinned = root / "original/manifest.json"
            info = json.loads(pinned.read_text())
            deps = [{"module": "SimpleC.EE.Domain." + p.stem, "source": str(p),
                     "sha256": digest(p), "compiled": None} for p in (outer, base)]
            info["runtime_dependencies"] = deps
            pinned.write_text(json.dumps(info))
            bundle = {"original_manifest": str(pinned), "original_manifest_sha256": digest(pinned)}
            units = _uncompiled_runtime_modules(bundle, runtime, root / "stage")
            self.assertEqual(list(units), ["SimpleC.EE.Domain.Base", "SimpleC.EE.Domain.Outer"])
            self.assertEqual(units[deps[0]["module"]].read_bytes(), outer.read_bytes())
            self.assertFalse(base.with_suffix(".vo").exists())
            deps[0]["source"] = str(base)
            pinned.write_text(json.dumps(info))
            with self.assertRaisesRegex(JobError, "original VC manifest changed"):
                _uncompiled_runtime_modules(bundle, runtime, root / "other")
            bundle["original_manifest_sha256"] = digest(pinned)
            with self.assertRaisesRegex(JobError, "wrong runtime module source"):
                _uncompiled_runtime_modules(bundle, runtime, root / "other")
            deps[0]["source"] = str(outer)
            deps[0]["sha256"] = "0" * 64
            pinned.write_text(json.dumps(info))
            bundle["original_manifest_sha256"] = digest(pinned)
            with self.assertRaisesRegex(JobError, "hash mismatch"):
                _uncompiled_runtime_modules(bundle, runtime, root / "other")

    def test_portable_compiled_only_bundle_keeps_working_after_producer_is_archived(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            prepared, runtime = self.prepare_fixture(root)
            bundle = json.loads(Path(prepared["manifest"]).read_text())
            Path(bundle["original_manifest"]).unlink()
            self.assertEqual(_uncompiled_runtime_modules(bundle, runtime, root / "stage"), {})
            del bundle["source_only_runtime_dependencies"]
            self.assertEqual(_uncompiled_runtime_modules(bundle, runtime, root / "stage"), {})

    def test_generated_modules_are_staged_from_original_manifest(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            self.prepare_fixture(root)
            original = root / "original/manifest.json"
            source = root / "original/input_def.v"
            source.write_text("Definition cell_size := 8.")
            info = json.loads(original.read_text())
            dep = {"module": "input_def", "staged": str(source), "sha256": digest(source)}
            info["generated_coq_dependencies"] = [dep]
            original.write_text(json.dumps(info))
            result = prepare_certificate(original, root / "new")
            bundle = json.loads(Path(result["manifest"]).read_text())
            staged, = bundle["dependencies"]
            self.assertTrue(staged["generated"])
            self.assertEqual((root / "new" / staged["file"]).read_bytes(), source.read_bytes())
            info["coq_dependencies"] = [dep]
            original.write_text(json.dumps(info))
            with self.assertRaisesRegex(JobError, "duplicate"):
                prepare_certificate(original, root / "duplicate")

    def test_benchmark_candidate_limit_is_enforced_and_remains_unknown(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            request, _ = self.prepare_fixture(root)
            opam = root / "opam"
            opam.write_text(
                "#!/usr/bin/env python3\nimport resource,sys\n"
                "if '--version' in sys.argv: print('version 8.20')\n"
                "elif sys.argv[-1].endswith('Candidate.v'):\n"
                " assert resource.getrlimit(resource.RLIMIT_AS)[0] == 100000000\n"
                " try: bytearray(110000000)\n"
                " except MemoryError: print('cannot allocate memory'); sys.exit(2)\n"
            )
            opam.chmod(0o755)
            with patch.dict(os.environ, {"PATH": str(root) + os.pathsep + os.environ["PATH"],
                            "TESPEC_ITP_RESOURCE_DIR": str(root),
                            "TESPEC_ITP_CANDIDATE_ADDRESS_SPACE_BYTES": "100000000"}):
                audit = check_certificate(Path(request["manifest"]), request["manifest_sha256"])
            self.assertEqual(audit["status"], "UNKNOWN")
            stage = audit["stages"][-1]
            self.assertEqual(stage["stage"], "compile_Candidate.v")
            self.assertEqual(stage["exit_code"], 2)
            self.assertEqual(stage["address_space_limit_bytes"], 100000000)
            self.assertEqual(stage["resource_failure"], "candidate_allocation_failed")
            self.assertIn("/usr/bin/prlimit", stage["measured_command"])
            self.assertGreater(stage["resources"]["max_process_rss_kib"], 0)

    def test_timeout_keeps_measured_process_peak(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            request, _ = self.prepare_fixture(root)
            opam = root / "opam"
            opam.write_text("#!/usr/bin/env python3\nimport time\nmemory = bytearray(20000000)\ntime.sleep(10)\n")
            opam.chmod(0o755)
            with patch.dict(os.environ, {"PATH": str(root) + os.pathsep + os.environ["PATH"]}):
                audit = check_certificate(Path(request["manifest"]), request["manifest_sha256"], timeout=0.5)
            stage, = audit["stages"]
            self.assertEqual(stage["exit_code"], "TIMEOUT")
            self.assertGreater(stage["resources"]["max_process_rss_kib"], 16000)

    def test_target_layout_is_frozen_with_certificate_inputs(self):
        layout = {
            "schema": "sac-target-layout/v1",
            "architecture_bits": 64,
            "aggregates": [{"id": 7, "fields": [{"id": 9, "offset": 8}]}],
        }
        with tempfile.TemporaryDirectory() as directory:
            result, _ = self.prepare_fixture(Path(directory), layout)
            path = Path(result["manifest"])
            bundle = json.loads(path.read_text())
            self.assertEqual(bundle["target_layout"], layout)
            bundle["target_layout"]["aggregates"][0]["fields"][0]["offset"] = 4
            path.write_text(json.dumps(bundle))
            with self.assertRaisesRegex(JobError, "controller digest"):
                check_certificate(path, result["manifest_sha256"])

    def test_rejected_cached_source_has_measured_precheck_before_any_compiler(self):
        with tempfile.TemporaryDirectory() as directory:
            request, _ = self.prepare_fixture(Path(directory))
            Path(request["editable"]).write_text("Axiom forbidden : False.")
            audit = check_certificate(
                Path(request["manifest"]), request["manifest_sha256"], measure_candidate_precheck=True
            )
            self.assertEqual(audit["status"], "UNKNOWN")
            self.assertEqual(audit["reason"], "candidate_source_precheck_failed_or_timeout")
            [precheck] = audit["stages"]
            self.assertEqual(precheck["stage"], "candidate_precheck")
            self.assertGreater(precheck["wall_seconds"], 0)
            self.assertGreater(precheck["resources"]["max_process_rss_kib"], 0)
            self.assertIn("candidate contains forbidden command", Path(precheck["log"]).read_text())


    def test_changed_manifest_rejected_against_controller_digest(self):
        with tempfile.TemporaryDirectory() as directory:
            result, _ = self.prepare_fixture(Path(directory))
            manifest = Path(result["manifest"])
            manifest.write_text(manifest.read_text() + " ")
            with self.assertRaisesRegex(JobError, "controller digest"):
                check_certificate(manifest, result["manifest_sha256"])

    def test_changed_goal_rejected_before_proof_compilation(self):
        with tempfile.TemporaryDirectory() as directory:
            result, _ = self.prepare_fixture(Path(directory))
            manifest = Path(result["manifest"])
            (manifest.parent / "Goal.v").write_text("Definition entry := True.")
            with self.assertRaisesRegex(JobError, "immutable"):
                check_certificate(manifest, result["manifest_sha256"])

    def test_changed_compiled_runtime_rejected(self):
        with tempfile.TemporaryDirectory() as directory:
            result, runtime = self.prepare_fixture(Path(directory))
            (runtime / "Lib.vo").write_bytes(b"replaced library")
            with self.assertRaisesRegex(JobError, "runtime changed"):
                check_certificate(Path(result["manifest"]), result["manifest_sha256"])

    def test_admitted_candidate_rejected(self):
        with tempfile.TemporaryDirectory() as directory:
            result, _ = self.prepare_fixture(Path(directory))
            manifest = Path(result["manifest"])
            candidate = manifest.parent / "Candidate.v"
            candidate.write_text(candidate.read_text().replace("Abort.", "Admitted."))
            stale = manifest.parent / "certificate-report.json"
            stale.write_text('{"status":"PASS"}')
            with self.assertRaisesRegex(JobError, "forbidden"):
                check_certificate(manifest, result["manifest_sha256"])
            self.assertFalse(stale.exists())


@unittest.skipUnless(
    os.environ.get("TESPEC_COQ_INTEGRATION") == "1",
    "set TESPEC_COQ_INTEGRATION=1 for real kernel checks",
)
class CertificateKernelTests(unittest.TestCase):
    def check_fixture(
        self, proposition, proof, dependencies=None, refute=None, kernel_cache=None, runtime_modules=(), timeout=120
    ):
        with tempfile.TemporaryDirectory(prefix="tespec-certificate-kernel-") as temp:
            root = Path(temp)
            goal = root / "input_goal.v"
            goal.write_text(
                "".join(f"Require Import {name}.\n" for name, _ in runtime_modules)
                + f"Definition required : Prop := {proposition}.\nModule Type VC_Correct.\nAxiom proof_of_required : required.\nEnd VC_Correct.\n"
            )
            original = root / "original.json"
            deps = []
            for module, text in (dependencies or {}).items():
                source = root / (module + ".v")
                source.write_text(text)
                deps.append(
                    {"module": module, "staged": str(source), "sha256": digest(source)}
                )
            original.write_text(
                json.dumps(
                    {
                        "schema": "qcp-spectest-vc-manifest/v1",
                        "files": {"goal": str(goal)},
                        "immutable_sha256": {"goal": digest(goal)},
                        "qcip_root": str(ROOT / "runtime/qcip"),
                        "coq_dependencies": deps,
                        "runtime_dependencies": [{"module": name, "source": str(path),
                            "sha256": digest(path), "compiled": None} for name, path in runtime_modules],
                    }
                )
            )
            prepared = prepare_certificate(original, root / "bundle", refute=refute)
            candidate = Path(prepared["editable"])
            candidate.write_text(proof)
            report = check_certificate(
                Path(prepared["manifest"]),
                prepared["manifest_sha256"],
                kernel_cache=kernel_cache, timeout=timeout,
            )
            saved = Path(prepared["manifest"]).parent / "certificate-report.json"
            self.assertEqual(json.loads(saved.read_text()), report)
            return report

    def test_source_only_runtime_checked_through_independent_kernel(self):
        source = ROOT / "runtime/qcip/SeparationLogic/examples/QCP_demos_human/sll_lib.v"
        module = "SimpleC.EE.QCP_demos_human.sll_lib"
        before = source.with_suffix(".vo").exists()
        report = self.check_fixture(
            "sll = sll",
            "Require Import Goal. Module Proofs. Lemma proof_of_required : Goal.required. "
            "Proof. reflexivity. Qed. End Proofs.",
            runtime_modules=[(module, source)], timeout=600,
        )
        self.assertEqual(report["status"], "PASS", report)
        self.assertEqual(report["compiled_runtime_sources"][module]["source_sha256"], digest(source))
        self.assertEqual(report["stages"][-1]["stage"], "kernel_replay")
        self.assertEqual(source.with_suffix(".vo").exists(), before)

    def test_evidence_deleted_after_kernel_check_produces_unknown_report(self):
        real_popen = subprocess.Popen
        for relative in ("Candidate.v", "manifest.json", "Goal.v", "dependencies/Extra.v"):
            with self.subTest(file=relative):
                deleted = []
                def launch(*args, **kwargs):
                    process = real_popen(*args, **kwargs)
                    if "coqchk" in args[0]:
                        original_wait = process.wait
                        def finish_and_delete(*wait_args, **wait_kwargs):
                            code = original_wait(*wait_args, **wait_kwargs)
                            if code == 0 and not deleted:
                                target = Path(kwargs["cwd"]) / relative
                                target.unlink()
                                deleted.append(str(target))
                            return code
                        process.wait = finish_and_delete
                    return process
                with patch("spectest.certificates.subprocess.Popen", side_effect=launch):
                    report = self.check_fixture(
                        "True", "Require Import Goal. Module Proofs. "
                        "Lemma proof_of_required : Goal.required. Proof. exact I. Qed. End Proofs.",
                        {"Extra": "Definition unused : nat := 0.\n"})
                self.assertEqual(report["status"], "UNKNOWN", report)
                self.assertEqual(report["reason"], "evidence_unavailable_during_check")
                self.assertEqual(report["unavailable_evidence"], deleted[0])
                self.assertEqual(report["stages"][-1]["stage"], "kernel_replay")
                self.assertEqual(report["stages"][-1]["exit_code"], 0)

    def test_checked_reuse_still_checks_a_changed_proof(self):
        cache = KernelReplayCache()
        first = self.check_fixture(
            "True",
            "Require Import Goal. Module Proofs. Lemma proof_of_required : Goal.required. Proof. exact I. Qed. End Proofs.",
            kernel_cache=cache,
        )
        self.assertEqual(first["status"], "PASS", first)
        self.assertEqual(first["kernel_replay_mode"], "full", first)
        second = self.check_fixture(
            "True",
            "Require Import Goal. Module Proofs. Lemma proof_of_required : Goal.required. Proof. exact (id I). Qed. End Proofs.",
            kernel_cache=cache,
        )
        self.assertEqual(second["status"], "PASS", second)
        self.assertEqual(
            second["kernel_replay_mode"], "checked-dependency-reuse", second
        )
        self.assertEqual(second["kernel_dependency_reuse"]["checked_task_modules"], 3)
        self.assertEqual(
            second["kernel_dependency_reuse"]["full_replay_origin"]["manifest_sha256"],
            first["manifest_sha256"],
        )
        wrong = self.check_fixture(
            "False",
            "Require Import Goal. Module Proofs. Lemma proof_of_required : True. Proof. exact I. Qed. End Proofs.",
            kernel_cache=cache,
        )
        self.assertEqual(wrong["status"], "UNKNOWN", wrong)
        self.assertEqual(wrong["reason"], "coq_compile_failed_or_timeout", wrong)

    def test_new_library_import_falls_back_to_full_replay(self):
        cache = KernelReplayCache()
        proof = "Require Import Goal. Module Proofs. Lemma proof_of_required : Goal.required. Proof. exact I. Qed. End Proofs."
        self.assertEqual(
            self.check_fixture("True", proof, kernel_cache=cache)["status"], "PASS"
        )
        result = self.check_fixture(
            "True", "Require Import Coq.Arith.PeanoNat. " + proof, kernel_cache=cache
        )
        self.assertEqual(result["status"], "PASS", result)
        self.assertEqual(result["kernel_replay_mode"], "full", result)
        self.assertIn(
            "kernel_replay_full_fallback", [s["stage"] for s in result["stages"]]
        )

    def test_true_goal_accepted_with_independent_replay(self):
        report = self.check_fixture(
            "True",
            "Require Import Goal. Module Proofs. Lemma proof_of_required : Goal.required. Proof. exact I. Qed. End Proofs.",
        )
        self.assertEqual(report["status"], "PASS", report)
        self.assertEqual(report["assumptions"], [])
        self.assertEqual(report["stages"][-1]["stage"], "kernel_replay")

    def test_refutation_does_not_claim_execution_failure(self):
        report = self.check_fixture(
            "False",
            "Require Import Goal. Module Proofs. Lemma proof_of_required : ~ Goal.required. Proof. intro H. exact H. Qed. End Proofs.",
            refute="proof_of_required",
        )
        self.assertEqual(report["status"], "UNKNOWN", report)
        self.assertEqual(report["proof_status"], "VALID")
        self.assertEqual(report["polarity"], "negative")
        self.assertEqual(report["execution_counterexample"], "NOT_ESTABLISHED")

    def test_positive_proof_cannot_satisfy_refutation_request(self):
        report = self.check_fixture(
            "True",
            "Require Import Goal. Module Proofs. Lemma proof_of_required : Goal.required. Proof. exact I. Qed. End Proofs.",
            refute="proof_of_required",
        )
        self.assertEqual(report["status"], "UNKNOWN", report)
        self.assertEqual(report["stages"][-1]["stage"], "compile_Coverage.v")

    def test_weakened_statement_fails_original_interface(self):
        report = self.check_fixture(
            "False",
            "Require Import Goal. Module Proofs. Lemma proof_of_required : True. Proof. exact I. Qed. End Proofs.",
        )
        self.assertEqual(report["status"], "UNKNOWN")
        self.assertEqual(report["stages"][-1]["stage"], "compile_Coverage.v")

    def test_missing_goal_fails_original_interface(self):
        report = self.check_fixture(
            "True", "Require Import Goal. Module Proofs. End Proofs."
        )
        self.assertEqual(report["status"], "UNKNOWN")
        self.assertEqual(report["stages"][-1]["stage"], "compile_Coverage.v")

    def test_unicode_or_primed_axiom_is_not_hidden_by_allowed_classic(self):
        for name in ("α", "bad'"):
            with self.subTest(name=name):
                report = self.check_fixture(
                    "False", "Require Import Goal Unsafe. Module Proofs. "
                    "Lemma proof_of_required : Goal.required. Proof. exact bogus. Qed. End Proofs.",
                    {"Unsafe": "Require Import Coq.Logic.Classical_Prop.\n"
                     + f"Axiom {name} : False.\nLemma bogus : False.\n"
                     + f"Proof. destruct (classic True); exact {name}. Qed.\n"})
                self.assertEqual(report["status"], "UNKNOWN", report)
                self.assertEqual(report["reason"], "unapproved_transitive_assumptions")
                self.assertTrue(any(item.endswith(name) for item in report["unexpected_assumptions"]))

    def test_unchecked_guardedness_is_not_hidden_by_allowed_classic(self):
        report = self.check_fixture(
            "False", "Require Import Goal Unsafe. Module Proofs. "
            "Lemma proof_of_required : Goal.required. Proof. exact bogus. Qed. End Proofs.",
            {"Unsafe": "Require Import Coq.Logic.Classical_Prop.\nUnset Guard Checking.\n"
             "Fixpoint loop (n:nat) : False := loop n.\nLemma bogus : False.\n"
             "Proof. destruct (classic True); exact (loop 0). Qed.\n"})
        self.assertEqual(report["status"], "UNKNOWN", report)
        self.assertEqual(report["reason"], "unsupported_assumption_records")
        self.assertTrue(any("assumed to be guarded" in item
                            for item in report["unsupported_assumption_records"]))
        self.assertEqual(report["stages"][-1]["stage"], "compile_Assumptions.v")

    def test_trusted_classic_still_passes_complete_kernel_check(self):
        report = self.check_fixture(
            "forall P : Prop, P \/ ~ P",
            "Require Import Goal Coq.Logic.Classical_Prop. Module Proofs. "
            "Lemma proof_of_required : Goal.required. Proof. exact classic. Qed. End Proofs.")
        self.assertEqual(report["status"], "PASS", report)
        self.assertEqual(report["assumptions"], ["Classical_Prop.classic"])
        self.assertEqual(report["unsupported_assumption_records"], [])
        self.assertEqual(report["stages"][-1]["stage"], "kernel_replay")

    def test_imported_axiom_is_not_a_certificate(self):
        report = self.check_fixture(
            "False",
            "Require Import Goal SpecAxiom. Module Proofs. Lemma proof_of_required : Goal.required. Proof. exact unsound. Qed. End Proofs.",
            {"SpecAxiom": "Axiom unsound : False.\n"},
        )
        self.assertEqual(report["status"], "UNKNOWN")
        self.assertEqual(report["reason"], "unapproved_transitive_assumptions")
        self.assertTrue(report["unexpected_assumptions"])

    def test_task_axiom_cannot_impersonate_runtime_short_name(self):
        report = self.check_fixture(
            "False",
            "Require Import Goal. Require CNotation. Module Proofs. Lemma proof_of_required : Goal.required. Proof. exact CNotation.eval_addr_expr. Qed. End Proofs.",
            {"CNotation": "Axiom eval_addr_expr : False.\n"},
        )
        self.assertEqual(report["status"], "UNKNOWN")
        self.assertEqual(report["reason"], "assumption_identity_mismatch")

    def test_existing_runtime_address_axioms_cannot_certify_false(self):
        # This uses only declarations already present in the bundled runtime.
        # Kernel compilation alone cannot detect inconsistent imported axioms.
        report = self.check_fixture(
            "False",
            """Require Import Goal Coq.ZArith.ZArith Coq.Strings.String.
From SimpleC.SL Require Import CNotation SeparationLogic.
Import naive_C_Rules.
Local Open Scope Z_scope.
Local Open Scope string_scope.
Module Proofs.
Lemma proof_of_required : Goal.required.
Proof.
  unfold Goal.required.
  pose (R := RE_add_pi (RE_const 0 FET_int) 0).
  assert (eval_addr_expr (RE_addr_of (LE_arrow_field
    (RE_const (eval_addr_expr R) FET_int) "field")) =
    eval_addr_expr (RE_addr_of (LE_arrow_field R "field"))) as H.
  { apply eval_addr_expr_congr. apply RE_addr_of_congr.
    apply LE_arrow_field_congr; [apply eval_addr | reflexivity]. }
  apply addr_of_arrow_field_inv in H.
  unfold R in H. discriminate H.
Qed.
End Proofs.
""",
        )
        self.assertEqual(report["status"], "UNKNOWN", report)
        self.assertEqual(report["reason"], "unapproved_transitive_assumptions")
        self.assertIn(
            "CNotation.addr_of_arrow_field_inv", report["unexpected_assumptions"]
        )
        self.assertEqual(report["stages"][-1]["stage"], "compile_Assumptions.v")

    def test_task_dependency_cannot_shadow_runtime_namespace(self):
        with self.assertRaisesRegex(JobError, "shadows"):
            self.check_fixture("True", "", {"SimpleC": "Axiom bad : False.\n"})


if __name__ == "__main__":
    unittest.main()
