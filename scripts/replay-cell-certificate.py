#!/usr/bin/env python3
"""Compatibility entry point for the original paired-cell certificate."""

from pathlib import Path
import runpy
import sys

ROOT = Path(__file__).resolve().parents[1]
sys.argv[1:1] = ["--case", str(ROOT / "benchmark/comparison/certificates/cell")]
runpy.run_path(str(ROOT / "scripts/replay-certificate-case.py"), run_name="__main__")
