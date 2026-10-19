#!/usr/bin/env python3
"""Differential regression of post-execution VC scheduling and early errors."""
from pathlib import Path
import sys
sys.path.insert(0, str(Path(__file__).resolve().parents[2]))
from tools.benchmark import regress_inline_vc_storage as differential
from tools.benchmark import regress_instance_branch_evaluation as controls

loop_fixtures = differential.fixtures

def fixtures(iterations):
    yield from loop_fixtures(iterations)
    yield from controls.fixtures(iterations)
    pre = "int sample(int n) /*@ Require 0 <= n && n <= 4096 && emp Ensure __return == n && emp */ "
    rows = [
        ("error-after-safety", 3, "ERROR", pre + "{ int x=n+1; int *p=0; return *p; }"),
        ("error-after-invalid-assertion", 3, "ERROR", pre + "{ /*@ Assert n == 99 && emp */ int *p=0; return *p; }"),
    ]
    for name,n,expected,source in rows:
        for mode in ("entry-exit", "all-boundaries"):
            # Existing verdict contract: an established INVALID VC gives FAIL
            # even if a later instruction errors (spectest.verdict.conjoin).
            wanted = ("FAIL" if name == "error-after-invalid-assertion"
                      and mode == "all-boundaries" else expected)
            yield {"id": name+"-"+mode, "n":n, "strategy":"inline",
                   "mode":mode, "expected":wanted, "source":source+"\n"}

if __name__ == "__main__":
    differential.fixtures = fixtures
    raise SystemExit(differential.main())
