#!/usr/bin/env python3
"""Legacy command-line entry point for the packaged proof controller."""
from pathlib import Path
import sys

sys.path.insert(0, str(Path(__file__).resolve().parents[3]))
from spectest.proof_controller import main  # noqa: E402

if __name__ == "__main__":
    raise SystemExit(main())
