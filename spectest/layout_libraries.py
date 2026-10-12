"""Explicitly select a computational address interpretation for logical libraries.

This is source re-elaboration, not a semantic-equivalence certificate. Compilation
and proof checking remain separate gates. No declaration or proof is removed.
"""

import hashlib
import json
from pathlib import Path
import re

from .core import JobError, _coq_dependency_code
from .layout import IDENTIFIER, generate_layout_source


_SCOPE = re.compile(r"\bLocal\s+Open\s+Scope\s+sac\s*\.")
_IMPORT = "\nRequire Import GeneratedLayout.\nImport GeneratedLayout.AddressNotations."


def elaborate_library(source: str) -> str:
    """Insert the selected interpretation at a unique existing notation boundary."""
    code = _coq_dependency_code(source)
    matches = list(_SCOPE.finditer(code))
    if len(matches) != 1:
        raise JobError("library requires exactly one Local Open Scope sac command")
    if re.search(r"\b(?:GeneratedLayout|LayoutAddress)\b", code):
        raise JobError("library already references a reserved layout module")
    end = matches[0].end()
    return source[:end] + _IMPORT + source[end:]


def prepare_layout_libraries(layout_path: Path, sources: list[Path], output: Path):
    """Stage explicitly selected modules without overwriting an existing bundle."""
    if not sources:
        raise JobError("at least one logical library is required")
    if output.exists():
        raise JobError("layout-library output must not exist")
    layout_bytes = layout_path.read_bytes()
    generated = generate_layout_source(json.loads(layout_bytes)).encode()
    address = Path(__file__).resolve().parents[1] / "runtime/tespec/LayoutAddress.v"
    files = {
        "target-layout.json": layout_bytes,
        "GeneratedLayout.v": generated,
        "LayoutAddress.v": address.read_bytes(),
    }
    records = []
    names = {"GeneratedLayout", "LayoutAddress"}
    for source in sources:
        module = source.stem
        if source.suffix != ".v" or not IDENTIFIER.fullmatch(module):
            raise JobError("expected a simple Rocq module filename ending in .v")
        if module in names:
            raise JobError("duplicate or reserved module name: " + module)
        names.add(module)
        original = source.read_bytes()
        transformed = elaborate_library(original.decode("utf-8")).encode()
        files[f"original/{source.name}"] = original
        files[source.name] = transformed
        records.append(
            {
                "module": module,
                "source": str(source.resolve()),
                "original_sha256": hashlib.sha256(original).hexdigest(),
                "transformed_sha256": hashlib.sha256(transformed).hexdigest(),
            }
        )
    manifest = {
        "schema": "tespec-layout-library-preparation/v1",
        "interpretation": "computational field layout; legacy equivalence not certified",
        "status": "PREPARED_UNCHECKED",
        "transformation": "insert layout imports after unique Local Open Scope sac",
        "modules": records,
        "files": {
            name: hashlib.sha256(data).hexdigest() for name, data in files.items()
        },
    }
    output.mkdir(parents=True, exist_ok=False)
    for name, data in files.items():
        destination = output / name
        destination.parent.mkdir(parents=True, exist_ok=True)
        destination.write_bytes(data)
    (output / "layout-libraries.json").write_text(json.dumps(manifest, indent=2) + "\n")
    return manifest
