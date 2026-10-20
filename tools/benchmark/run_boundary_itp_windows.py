"""Windows metered model + WSL Coq controller, one task per native execution."""
import argparse
from concurrent.futures import ThreadPoolExecutor
import json
import os
from pathlib import Path
import subprocess
import sys
import threading
import time

p = argparse.ArgumentParser(description=__doc__)
p.add_argument("--task-root", type=Path, required=True)
p.add_argument("--workers", type=int, default=2)
a = p.parse_args()
root = a.task_root.resolve()
repo = "/home/yangfp/teSpec"
repo_unc = Path(chr(92) * 2 + "wsl.localhost" + chr(92) + "Ubuntu-22.04" + chr(92) + "home" + chr(92) + "yangfp" + chr(92) + "teSpec")
artifact = repo_unc / "benchmark/results/array_load/20261020-boundary-itp"
root_wsl = "/mnt/" + root.drive[0].lower() + str(root)[2:].replace(chr(92), "/")
meter = repo_unc / "tools/benchmark/meter_itp_model_windows.py"
lock = threading.Lock()
state = {"status": "RUNNING", "workers": a.workers, "started_epoch": time.time(), "executions": {}}

def update(i, **values):
    with lock:
        state["executions"].setdefault(str(i), {}).update(values)
        (root / "controller-status.json").write_text(json.dumps(state, indent=2), encoding="utf-8")

def invoke(cmd, folder):
    folder.mkdir(parents=True, exist_ok=True)
    with (folder / "stdout.log").open("wb") as out, (folder / "stderr.log").open("wb") as err:
        result = subprocess.run([str(x) for x in cmd], stdout=out, stderr=err, creationflags=subprocess.CREATE_NO_WINDOW)
    return result.returncode

def run(i):
    task = root / ("execution-%02d" % i)
    initial = (task / "prompt.txt").read_text(encoding="utf-8")
    for attempt in range(1, 4):
        update(i, stage="MODEL", attempt=attempt)
        code = invoke([sys.executable, meter, "--task-dir", task, "--attempt", str(attempt)], task / "controller" / ("model-%d" % attempt))
        if code:
            update(i, stage="MODEL_FAILED", attempt=attempt)
            return False
        update(i, stage="COQ", attempt=attempt)
        code = invoke(["wsl.exe", "-d", "Ubuntu-22.04", "-u", "yangfp", "--", "python3", "-B",
            repo + "/tools/benchmark/boundary_execution_itp.py", "compile", "--task-root", root_wsl,
            "--execution", str(i), "--attempt", str(attempt)], task / "controller" / ("coq-%d" % attempt))
        folder = artifact / task.name / ("attempt-%d" % attempt)
        receipt = json.loads((folder / "receipt.json").read_text()) if (folder / "receipt.json").exists() else None
        if not code and receipt and receipt["status"] == "KERNEL_CHECKED":
            update(i, stage="KERNEL_CHECKED", attempt=attempt, final_status=receipt["final_status"])
            return True
        errors = []
        if receipt:
            for measurement in receipt.get("compilation", []):
                if measurement["exit_code"]:
                    errors.append((repo_unc / measurement["stderr"]).read_text(encoding="utf-8", errors="replace")[-7000:])
            errors.append("Controller status: " + receipt["status"])
        errors.append((task / "controller" / ("coq-%d" % attempt) / "stderr.log").read_text(encoding="utf-8", errors="replace")[-5000:])
        (task / "prompt.txt").write_text(initial + "\n\nREPAIR CURRENT Candidate.v. Previous actual compiler/audit errors:\n" + "\n".join(errors) +
            "\nCurrent Candidate:\n" + (task / "Candidate.v").read_text(encoding="utf-8"), encoding="utf-8")
        update(i, stage="REPAIR_PENDING", attempt=attempt)
    update(i, stage="ATTEMPTS_EXHAUSTED")
    return False

assert 1 <= a.workers <= 3
count = len(list(root.glob("execution-*/binding.json")))
with ThreadPoolExecutor(max_workers=a.workers) as pool:
    results = list(pool.map(run, range(count)))
state.update(status="COMPLETE" if all(results) else "INCOMPLETE", successful=sum(results), executions_total=count, finished_epoch=time.time())
(root / "controller-status.json").write_text(json.dumps(state, indent=2), encoding="utf-8")
print(json.dumps(state), flush=True)
raise SystemExit(0 if all(results) else 1)
