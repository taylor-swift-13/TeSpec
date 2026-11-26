#!/usr/bin/env python3
"""Rebuild and measure dll_remove's instrumented CN tests from the group plan."""
import argparse
import hashlib
import json
from pathlib import Path
import subprocess
import time

from cn_toolchain import CN, ENV, ROOT, installed_identity


GROUP = ROOT / "benchmark/programs/dll_remove"
SHARED = ROOT / "benchmark/programs/Dbl_Linked_List__singleton/compat/cn-5.2"
UPSTREAM = ROOT / "arxiv/fulminate-cn/src/examples/Dbl_Linked_List"
COMPILER = GROUP / "compat/fulminate/gcc-with-pair-runtime.sh"


def read(path):
    return json.loads(path.read_bytes())


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def save(path, data):
    path.write_text(json.dumps(data, ensure_ascii=False, separators=(",", ":")) + "\n")


def measured(command, work, label, mid):
    before = time.monotonic()
    timing = work / (label + ".time.json")
    stdout, stderr = (work / (label + ext) for ext in (".stdout", ".stderr"))
    with stdout.open("wb") as out, stderr.open("wb") as err:
        proc = subprocess.run(["/usr/bin/time", "-q", "-f",
                               '{"max_process_rss_kib":%M,"user_seconds":%U,"system_seconds":%S}',
                               "-o", str(timing), "timeout", "--kill-after=5", "90", *command],
                              cwd=work, env=ENV, stdout=out, stderr=err)
    elapsed = time.monotonic() - before
    usage = read(timing)
    return {"id": mid, "tool": "fulminate", "stage": label, "exit_code": proc.returncode,
            "wall_seconds": elapsed, "max_process_rss_kib": usage["max_process_rss_kib"],
            "tokens": 0, "command": command, "stdout_sha256": sha(stdout),
            "stderr_sha256": sha(stderr), "time_sha256": sha(timing), "resources": usage}


def executable(folder):
    products = []
    for path in folder.rglob("*"):
        if path.is_file() and path.stat().st_mode & 0o111:
            with path.open("rb") as stream:
                if stream.read(4) == b"\x7fELF":
                    products.append(path)
    if len(products) != 1:
        raise RuntimeError("Expected one generated executable in " + str(folder))
    return products[0]


def observed_contract(generated):
    [unit] = generated.glob("*.exec.c")
    code = unit.read_text()
    function = code.split("struct node_and_int *remove(struct node *n)", 1)[1].split("int main(void)", 1)[0]
    return {
        "unit_sha256": sha(unit),
        "calls_dll_pre": "Dll_at(n_cn, PRE, 0)" in function,
        "calls_dll_post": "Dll_at(ret_cn->node, POST, 0)" in function,
        "checks_removed_payload": "cn_integer_equality(ret_cn->data, del_cn->data)" in function,
    }


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", type=Path, required=True)
    parser.add_argument("--case")
    parser.add_argument("--variant")
    args = parser.parse_args()
    out = args.output.resolve()
    out.mkdir(parents=True, exist_ok=True)
    if any(out.iterdir()):
        parser.error("output directory must be empty")
    installed_identity()
    plan_path = GROUP / "evaluation-plan.json"
    plan = read(plan_path)
    sources = {v["id"]: read(ROOT / v["manifest"])["files"]["cn"]
               for v in read(GROUP / "manifest.json")["variants"] if v["id"].startswith("cn_original:")}
    results, measurements = [], []
    for pairing in plan["pairings"]:
        vid = pairing["cn_variant"]
        if args.variant and args.variant != vid:
            continue
        source = ROOT / sources[vid]["path"]
        if sha(source) != sources[vid]["sha256"]:
            raise ValueError("Source differs from variant metadata")
        for case in pairing["cases"]:
            ident = case["id"]
            if args.case and args.case != ident:
                continue
            folder = out / (vid.split(":", 1)[1] + "-" + ident)
            folder.mkdir()
            generated = folder / "generated"
            generated.mkdir()
            subject = folder / "input.cn.c"
            body = ("int main(void) { " + case["cn_body"] + " return 0; }\n")
            subject.write_bytes(source.read_bytes() + b"\n" + body.encode())
            command = [str(CN), "instrument", "--run", "--cc=" + str(COMPILER),
                       "--output-dir=" + str(generated), "-I" + str(SHARED / "Dbl_Linked_List"),
                       "-I" + str(UPSTREAM), str(subject)]
            key = "fulminate/" + vid.split(":", 1)[1] + "/" + ident
            pipeline = measured(command, folder, "pipeline", key + "/pipeline")
            row = {"variant": vid, "qcp_variant": pairing["qcp_variant"], "case_id": ident,
                   "source_sha256": sha(source), "harness_sha256": sha(subject),
                   "expected": case.get("expected_by_tool", {}).get("fulminate_test", case["expected"]),
                   "contract_checked": vid == plan["primary_cn_variant"], "driver_semantic_oracle": True,
                   "pipeline": pipeline["id"], "status": "ERROR", "test": None}
            measurements.append(pipeline)
            if pipeline["exit_code"] == 0:
                observations = observed_contract(generated)
                if any(observations[k] != row["contract_checked"] for k in
                       ("calls_dll_pre", "calls_dll_post", "checks_removed_payload")):
                    raise ValueError("Generated function instrumentation disagrees with source contract")
                row["instrumentation"] = observations
                binary = executable(generated)
                test = measured([str(binary)], folder, "test", key + "/test")
                measurements.append(test)
                row.update(status="PASS" if test["exit_code"] == 0 else "FAIL",
                           test=test["id"], binary_sha256=sha(binary))
            results.append(row)
            save(out / "receipts.json", {"rows": results, "measurements": measurements, "plan_sha256": sha(plan_path)})
            print(vid, ident, row["status"], flush=True)
            if pipeline["exit_code"] != 0:
                return 1
    if not results:
        parser.error("no matching inputs")
    return 0 if all(r["status"] == r["expected"] for r in results) else 1


if __name__ == "__main__":
    raise SystemExit(main())
