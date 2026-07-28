#!/usr/bin/env python3
from __future__ import annotations

import sys
import re
from pathlib import Path


REPLACEMENTS = {
    "src/preprocess.c": (
        ("(data->clause_cnt)*8", "(data->clause_cnt)*256"),
        ("data->clause_cnt*8", "data->clause_cnt*256"),
        ("8*(s->cl_size)", "256*(s->cl_size)"),
    ),
    "src/CDCL.c": (("m*8", "m*256"),),
    "src/smt_preprocess_proof.c": (
        ("(data->clause_cnt) * 2", "(data->clause_cnt) * 256"),
        ("data->clause_cnt * 2", "data->clause_cnt * 256"),
        ("2 * (s->cl_size)", "256 * (s->cl_size)"),
    ),
}


def main() -> int:
    if len(sys.argv) != 2:
        print("usage: patch-legacy-smt-capacity.py SMT_SOURCE", file=sys.stderr)
        return 2
    root = Path(sys.argv[1]).expanduser().resolve()
    for relative, replacements in REPLACEMENTS.items():
        path = root / relative
        text = path.read_text(encoding="utf-8")
        if relative == "src/smt_preprocess_proof.c":
            # Older versions of this script used plain substring replacement:
            # the legacy suffix ``* 2`` also matched the start of ``* 256`` on
            # every subsequent build and grew it into 25656..., eventually
            # causing absurd allocations.  Normalize those historical results
            # before applying the idempotent patch below.
            text = re.sub(
                r"(\(data->clause_cnt\)\s*\*\s*)2(?:56)+",
                r"\g<1>256",
                text,
            )
            text = re.sub(
                r"(data->clause_cnt\s*\*\s*)2(?:56)+",
                r"\g<1>256",
                text,
            )
        for old, new in replacements:
            old_pattern = re.escape(old) + r"(?!\d)"
            if re.search(old_pattern, text):
                text = re.sub(old_pattern, lambda _: new, text)
            elif new not in text:
                raise RuntimeError(
                    f"{path}: neither expected legacy nor patched text exists: {old}"
                )
        path.write_text(text, encoding="utf-8")
    print(f"Patched legacy SMT learned-clause capacity in {root}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
