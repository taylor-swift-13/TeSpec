#!/usr/bin/env python3
"""Paired C control-flow regression using the existing exact VC/trace comparator.

Run with --baseline-binary OLD --candidate-binary NEW --ignore-storage-metric
branch_evaluation --output benchmark/results/vc-storage-regressions/FRESH.
The inherited output root intentionally keeps the original comparator's safety
check. Both binaries must agree with independently specified expected outcomes.
"""
from pathlib import Path
import sys

sys.path.insert(0, str(Path(__file__).resolve().parents[2]))
from tools.benchmark import regress_inline_vc_storage as differential


def fixtures(_iterations):
    pre = "int sample(int n) /*@ Require 0 <= n && n <= 4096 && emp Ensure __return == n && emp */ "
    rows = [
        ("zero-trip", 0, "PASS", pre + "{ int i=0; while(i<n) i++; return i; }"),
        ("do-while", 3, "PASS", pre + "{ int i=0; do { i++; } while(i<n); return i; }"),
        ("for-continue", 3, "PASS", pre + "{ int c=0; for(int i=0;i<6;i++) { if(i%2==0) continue; c++; } return c; }"),
        ("short-circuit-null", 0, "PASS", pre + "{ int *p=0; if(n==0 || *p) return n; return 1; }"),
        ("short-circuit-effects", 3, "PASS", "int bump(int *p) /*@ With v Require 0 <= v && v < 10 && data_at(p, int, v) Ensure __return == v+1 && data_at(p, int, v+1) */ { *p=*p+1; return *p; } " + pre + "{ int i=0; int j=0; while(i<n && bump(&j)<4) i++; return j; }"),
        ("conditional-null", 3, "PASS", pre + "{ int *p=0; return n>0 ? n : *p; }"),
        ("switch-fixed", 3, "PASS", pre + "{ switch(n) { case 0: return 0; case 3: return 3; default: return n; } }"),
        ("unsigned-wrap", 0, "PASS", pre + "{ unsigned int v=4294967295U; v++; if(v==0) return 0; return 1; }"),
        ("negative-loop", 0, "PASS", pre + "{ int i=-3; while(i<0) i++; return i; }"),
        ("pointer-alias", 3, "PASS", pre + "{ int a=n; int *p=&a; if(p==&a) return *p; return 0; }"),
        ("bad-selected-branch", 3, "FAIL", pre + "{ if(n<5) return n+1; return n; }"),
        ("nonterminating-limit", 3, "UNKNOWN", pre + "{ while(n>0) {} return n; }"),
    ]
    for name, n, expected, source in rows:
        for mode in ("entry-exit", "all-boundaries"):
            yield {"id": name + "-" + mode, "n": n, "strategy": "inline",
                   "mode": mode, "expected": expected, "source": source + "\n"}


if __name__ == "__main__":
    differential.fixtures = fixtures
    raise SystemExit(differential.main())
