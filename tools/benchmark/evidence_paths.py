"""Resolve immutable historical evidence paths after repository directory renames."""
from pathlib import Path
import json
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


def same_bindings_allow_explicit_empty_values(old_row, new_row):
    """Only normalize an absent values object to {}; preserve all actual bindings."""
    if old_row.get('binds_sha256') == new_row.get('binds_sha256'):
        return True
    old_path=ROOT/old_row['binds'];new_path=ROOT/new_row['binds']
    from test_read_variants import sha
    assert sha(old_path)==old_row['binds_sha256'] and sha(new_path)==new_row['binds_sha256']
    old=json.loads(old_path.read_text());new=json.loads(new_path.read_text())
    def normalized(rows):
        assert isinstance(rows,list)
        result=[]
        for row in rows:
            row=dict(row);row.setdefault('values',{});result.append(row)
        return result
    return normalized(old)==normalized(new)
