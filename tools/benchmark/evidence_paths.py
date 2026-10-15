"""Resolve immutable historical evidence paths after repository directory renames."""
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2]
LEGACY_ROOTS=(Path('/home/yangfp/teSpec-benchmark-tespec'),)
def evidence_path(value):
    path=Path(value)
    if not path.is_absolute():
        candidate=ROOT/path
    else:
        candidate=None
        for base in (ROOT,*LEGACY_ROOTS):
            try:
                candidate=ROOT/path.relative_to(base)
                break
            except ValueError:
                continue
        if candidate is None:
            raise ValueError(f'Evidence is outside the current or recorded repository roots: {value}')
    if not candidate.resolve().is_relative_to(ROOT.resolve()):
        raise ValueError(f'Evidence path escapes repository: {value}')
    return candidate
