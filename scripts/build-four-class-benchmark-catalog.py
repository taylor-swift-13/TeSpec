#!/usr/bin/env python3
"""Inventory and rank QCP functions for the four-class benchmark.

This script is deliberately a static catalog builder, not a label generator.
Its scores are used to obtain a diverse pool for manual curation; semantic
sound/complete labels still require checked ground-truth certificates.
"""

from __future__ import annotations

import argparse
import hashlib
import json
import re
from collections import Counter
from pathlib import Path
from typing import Any

PROJECT_ROOT = Path(__file__).resolve().parents[1]

DEFAULT_ROOTS = {
    "cav": Path("/home/yangfp/CAV/main/CAV-bench/input"),
    "cav_os_float": Path("/home/yangfp/CAV/OS/CAV-bench/input/xizi"),
    "qcp": PROJECT_ROOT / "runtime/qcip/QCP_examples",
    "qcip_output": Path("/home/yangfp/QCIP/OUTPUT"),
    "tespec": PROJECT_ROOT / "cases",
}

MIN_SELECTED_DIFFICULTY_SCORE = 30.0
NANO_REJECTIONS = PROJECT_ROOT / "benchmark/catalog/nano-rejected-bases.json"

CONTROL_WORDS = {
    "if",
    "for",
    "while",
    "switch",
    "return",
    "sizeof",
    "_Alignof",
}

EXCLUDED_PATH_PARTS = {
    "binarytree",
    "bst",
    "avl",
    "union_find",
    "graph",
    "alpha_equiv",
    "cnf_trans",
    "typeinfer",
    "/eval",
}


def strip_comments_and_literals(text: str) -> str:
    pattern = re.compile(
        r'"(?:\\.|[^"\\])*"|\'(?:\\.|[^\'\\])*\'|/\*.*?\*/|//[^\n]*',
        re.DOTALL,
    )
    return pattern.sub(lambda match: " " * len(match.group(0)), text)


def matching_brace(text: str, opening: int) -> int | None:
    depth = 0
    index = opening
    state = "code"
    while index < len(text):
        char = text[index]
        nxt = text[index + 1] if index + 1 < len(text) else ""
        if state == "code":
            if char == "/" and nxt == "*":
                state = "block"
                index += 2
                continue
            if char == "/" and nxt == "/":
                state = "line"
                index += 2
                continue
            if char == '"':
                state = "string"
            elif char == "'":
                state = "char"
            elif char == "{":
                depth += 1
            elif char == "}":
                depth -= 1
                if depth == 0:
                    return index
        elif state == "block":
            if char == "*" and nxt == "/":
                state = "code"
                index += 2
                continue
        elif state == "line":
            if char == "\n":
                state = "code"
        elif state in {"string", "char"}:
            if char == "\\":
                index += 2
                continue
            if (state == "string" and char == '"') or (state == "char" and char == "'"):
                state = "code"
        index += 1
    return None


def annotated_functions(text: str) -> list[dict[str, str]]:
    # QCP puts the function contract between the declarator and opening brace.
    # Scan contracts first instead of using a cross-line declarator regexp:
    # large generated C files otherwise cause pathological backtracking.
    contract_pattern = re.compile(r"/\*@.*?\*/", re.DOTALL)
    result: list[dict[str, str]] = []
    seen: set[tuple[str, int]] = set()
    for match in contract_pattern.finditer(text):
        spec = match.group(0)
        if "Require" not in spec and "Ensure" not in spec:
            continue
        opening = match.end()
        while opening < len(text) and text[opening].isspace():
            opening += 1
        if opening >= len(text) or text[opening] != "{":
            continue

        delimiter = max(
            text.rfind(";", 0, match.start()),
            text.rfind("}", 0, match.start()),
            text.rfind("{", 0, match.start()),
        )
        header = text[delimiter + 1 : match.start()].strip()
        close_paren = header.rfind(")")
        if close_paren < 0:
            continue
        depth = 0
        open_paren = None
        for index in range(close_paren, -1, -1):
            if header[index] == ")":
                depth += 1
            elif header[index] == "(":
                depth -= 1
                if depth == 0:
                    open_paren = index
                    break
        if open_paren is None:
            continue
        name_match = re.search(r"([A-Za-z_]\w*)\s*$", header[:open_paren])
        if name_match is None:
            continue
        name = name_match.group(1)
        if name in CONTROL_WORDS:
            continue
        closing = matching_brace(text, opening)
        if closing is None or (name, opening) in seen:
            continue
        seen.add((name, opening))
        result.append(
            {
                "name": name,
                "header": header,
                "spec": spec,
                "body": text[opening + 1 : closing],
            }
        )
    return result


def corpus_source_files(root: Path) -> list[Path]:
    return sorted(
        path
        for path in root.rglob("*.c")
        if ".spectest" not in path.parts and "failing_examples" not in path.parts
    )


def source_family(source: Path, corpus: str) -> str:
    if corpus == "cav":
        return source.stem
    if corpus == "qcip_output":
        parts = source.parts
        if "OUTPUT" in parts:
            return "/".join(parts[parts.index("OUTPUT") + 1 : -2])
    if corpus == "qcp":
        parts = source.parts
        if "QCP_examples" in parts:
            relative = parts[parts.index("QCP_examples") + 1 :]
            return "/".join(relative[:-1] + (source.stem,))
    return source.parent.name


def portable_source_path(source: Path) -> str:
    resolved = source.resolve()
    try:
        return resolved.relative_to(PROJECT_ROOT).as_posix()
    except ValueError:
        return str(resolved)


def features_for(
    source: Path,
    corpus: str,
    function: dict[str, str],
    file_functions: set[str],
    file_text: str,
) -> dict[str, Any]:
    name = function["name"]
    header = function["header"]
    spec = function["spec"]
    body = function["body"]
    code = strip_comments_and_literals(body)
    calls = [
        called
        for called in re.findall(r"\b([A-Za-z_]\w*)\s*\(", code)
        if called not in CONTROL_WORDS
    ]
    visible_calls = sorted(
        called for called in set(calls) if called in file_functions and called != name
    )
    external_calls = sorted(
        called
        for called in set(calls)
        if called not in file_functions
        and called
        not in {
            "assert",
            "malloc",
            "free",
            "memcpy",
            "memmove",
            "memset",
        }
    )
    loop_count = len(re.findall(r"\b(?:for|while)\s*\(", code))
    loop_count += len(re.findall(r"\bdo\b", code))
    branch_count = len(re.findall(r"\b(?:if|switch)\s*\(", code))
    branch_count += code.count("?")
    array_ops = len(re.findall(r"\[[^\]]+\]", code))
    field_ops = code.count("->") + len(re.findall(r"\.[A-Za-z_]\w*", code))
    pointer_signature = "*" in header
    heap = pointer_signature or array_ops > 0 or field_ops > 0
    native_float = bool(re.search(r"\b(?:float|double)\b", header + "\n" + body))
    float_model = native_float or bool(
        re.search(r"\bfloat(?:32|64)?\b", header + "\n" + body + "\n" + file_text)
    )
    path_lower = str(source).lower()
    linked_singly = bool(
        re.search(r"(?:^|[/_])(?:sll|single_link|glibc_slist)(?:[/_.]|$)", path_lower)
    )
    linked_doubly = bool(
        re.search(r"(?:^|[/_])(?:dll|double_link)(?:[/_.]|$)", path_lower)
    )
    structure = "struct " in file_text or field_ops > 0
    quantified = bool(re.search(r"\b(?:forall|exists)\b", spec))
    custom_coq = "Extern Coq" in file_text or "Import Coq" in file_text
    logical_list = bool(re.search(r"\blist\s+[A-Za-z_]", spec))
    spec_lines = spec.count("\n") + 1
    body_lines = sum(1 for line in body.splitlines() if line.strip())
    recursive = name in calls
    multi_call = len(visible_calls) > 0 or len(external_calls) > 0
    nested_control = loop_count >= 2 or (loop_count >= 1 and branch_count >= 2)
    score = (
        min(body_lines, 80) * 0.12
        + min(spec_lines, 80) * 0.08
        + loop_count * 3.0
        + branch_count * 1.25
        + min(array_ops, 12) * 0.6
        + min(field_ops, 12) * 0.7
        + len(visible_calls) * 4.0
        + len(external_calls) * 2.0
        + (5.0 if recursive else 0.0)
        + (4.0 if native_float else 0.0)
        + (3.0 if float_model and not native_float else 0.0)
        + (4.0 if heap else 0.0)
        + (4.0 if linked_singly else 0.0)
        + (5.0 if linked_doubly else 0.0)
        + (3.0 if structure else 0.0)
        + (4.0 if quantified else 0.0)
        + (3.0 if custom_coq else 0.0)
        + (2.0 if logical_list else 0.0)
        + (3.0 if nested_control else 0.0)
    )
    normalized_body = re.sub(
        r"\s+", "", strip_comments_and_literals(header + "\n" + body)
    )
    return {
        "id": f"{corpus}:{source_family(source, corpus)}:{name}",
        "corpus": corpus,
        "family": source_family(source, corpus),
        "source": portable_source_path(source),
        "function": name,
        "body_sha256": hashlib.sha256(normalized_body.encode()).hexdigest(),
        "difficulty_score": round(score, 3),
        "body_lines": body_lines,
        "spec_lines": spec_lines,
        "loops": loop_count,
        "branches": branch_count,
        "array_ops": array_ops,
        "field_ops": field_ops,
        "visible_calls": visible_calls,
        "external_calls": external_calls,
        "recursive": recursive,
        "multi_call": multi_call,
        "heap": heap,
        "native_float": native_float,
        "float_model": float_model,
        "singly_linked": linked_singly,
        "doubly_linked": linked_doubly,
        "structure": structure,
        "quantified": quantified,
        "custom_coq": custom_coq,
        "logical_list": logical_list,
        "nested_control": nested_control,
    }


def excluded(entry: dict[str, Any]) -> bool:
    lowered = (entry["source"] + "/" + entry["function"]).lower()
    return any(part in lowered for part in EXCLUDED_PATH_PARTS)


def curate(
    entries: list[dict[str, Any]],
    size: int,
    rejected_ids: set[str] | None = None,
    rejected_body_hashes: set[str] | None = None,
) -> list[dict[str, Any]]:
    # Exact body duplicates occur in QCP's human/LLM mirrors. Prefer the
    # engineering/output copy, then the LLM benchmark, then CAV.
    priority = {
        "qcip_output": 0,
        "qcp": 1,
        "tespec": 2,
        "cav_os_float": 3,
        "cav": 4,
    }
    unique: dict[str, dict[str, Any]] = {}
    rejected_ids = rejected_ids or set()
    rejected_body_hashes = rejected_body_hashes or set()
    for entry in sorted(
        entries,
        key=lambda item: (
            priority[item["corpus"]],
            -item["difficulty_score"],
            item["source"],
            item["function"],
        ),
    ):
        if (
            excluded(entry)
            or entry["id"] in rejected_ids
            or entry["body_sha256"] in rejected_body_hashes
        ):
            continue
        unique.setdefault(entry["body_sha256"], entry)
    pool = [
        entry
        for entry in unique.values()
        if entry["difficulty_score"] >= MIN_SELECTED_DIFFICULTY_SCORE
    ]

    selected: list[dict[str, Any]] = []
    selected_ids: set[str] = set()
    family_counts: Counter[str] = Counter()

    def ensure_matching(predicate: Any, target: int, max_per_family: int = 2) -> None:
        candidates = sorted(
            (entry for entry in pool if predicate(entry)),
            key=lambda item: (-item["difficulty_score"], item["id"]),
        )
        present = sum(bool(predicate(entry)) for entry in selected)
        if present >= target:
            return
        for entry in candidates:
            if entry["id"] in selected_ids:
                continue
            key = f"{entry['corpus']}:{entry['family']}"
            if family_counts[key] >= max_per_family:
                continue
            selected.append(entry)
            selected_ids.add(entry["id"])
            family_counts[key] += 1
            present += 1
            if present >= target:
                return

    # Hard strata requested for the study. Categories overlap. Native floating
    # point is not a quota: the bundled QCIP examples are tutorial-scale and
    # must not displace substantially harder heap/relational candidates.
    ensure_matching(lambda item: item["multi_call"], 30, max_per_family=2)
    ensure_matching(lambda item: item["doubly_linked"], 8, max_per_family=2)
    ensure_matching(lambda item: item["singly_linked"], 14, max_per_family=2)
    ensure_matching(
        lambda item: item["heap"] and item["nested_control"], 22, max_per_family=1
    )
    ensure_matching(
        lambda item: item["quantified"] or item["custom_coq"],
        45,
        max_per_family=1,
    )
    ensure_matching(
        lambda item: item["corpus"] in {"qcp", "qcip_output"},
        55,
        max_per_family=2,
    )
    ensure_matching(lambda item: True, size, max_per_family=1)
    return sorted(
        selected[:size],
        key=lambda item: (item["corpus"], item["family"], item["function"]),
    )


def summarize(entries: list[dict[str, Any]]) -> dict[str, Any]:
    boolean_features = [
        "multi_call",
        "heap",
        "native_float",
        "float_model",
        "singly_linked",
        "doubly_linked",
        "structure",
        "quantified",
        "custom_coq",
        "logical_list",
        "nested_control",
    ]
    return {
        "task_count": len(entries),
        "source_family_count": len(
            {(entry["corpus"], entry["family"]) for entry in entries}
        ),
        "by_corpus": dict(Counter(entry["corpus"] for entry in entries)),
        "features": {
            feature: sum(bool(entry[feature]) for entry in entries)
            for feature in boolean_features
        },
        "median_difficulty_score": (
            sorted(entry["difficulty_score"] for entry in entries)[len(entries) // 2]
            if entries
            else 0
        ),
    }


def write_markdown(report: dict[str, Any], target: Path) -> None:
    selected = report["selected"]
    lines = [
        "# Four-class benchmark program shortlist",
        "",
        "> Status: static shortlist. A program enters the released benchmark only",
        "> after its reference semantics, candidate labels, and witnesses have",
        "> passed the semantic audit described in `../DESIGN.zh-CN.md`.",
        "",
        "## Summary",
        "",
        f"- Target functions: {selected['task_count']}",
        f"- Source families: {selected['source_family_count']}",
        f"- Multi-call targets: {selected['features']['multi_call']}",
        f"- Native `float`/`double` targets: {selected['features']['native_float']}",
        f"- Float-model targets: {selected['features']['float_model']}",
        f"- Heap targets: {selected['features']['heap']}",
        f"- Singly linked targets: {selected['features']['singly_linked']}",
        f"- Doubly linked targets: {selected['features']['doubly_linked']}",
        f"- Quantified specifications: {selected['features']['quantified']}",
        "",
        "## Programs",
        "",
        "| # | Corpus | Family | Target | Score | Main features | Source |",
        "|---:|---|---|---|---:|---|---|",
    ]
    for index, entry in enumerate(report["tasks"], 1):
        flags = [
            label
            for key, label in (
                ("native_float", "float"),
                ("multi_call", "calls"),
                ("heap", "heap"),
                ("singly_linked", "sll"),
                ("doubly_linked", "dll"),
                ("structure", "struct"),
                ("nested_control", "nested-control"),
                ("quantified", "quantifiers"),
                ("custom_coq", "Coq"),
            )
            if entry[key]
        ]
        lines.append(
            "| "
            + " | ".join(
                (
                    str(index),
                    entry["corpus"],
                    entry["family"].replace("|", "\\|"),
                    f"`{entry['function']}`",
                    f"{entry['difficulty_score']:.2f}",
                    ", ".join(flags),
                    f"`{entry['source']}`",
                )
            )
            + " |"
        )
    target.parent.mkdir(parents=True, exist_ok=True)
    target.write_text("\n".join(lines) + "\n", encoding="utf-8")


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--size", type=int, default=100)
    parser.add_argument(
        "--output",
        type=Path,
        default=PROJECT_ROOT / "benchmark/catalog/selected-programs.json",
    )
    args = parser.parse_args()

    entries: list[dict[str, Any]] = []
    parse_failures: list[str] = []
    for corpus, root in DEFAULT_ROOTS.items():
        for source in corpus_source_files(root):
            try:
                text = source.read_text(encoding="utf-8", errors="replace")
            except OSError:
                parse_failures.append(str(source))
                continue
            functions = annotated_functions(text)
            if not functions:
                continue
            names = {function["name"] for function in functions}
            entries.extend(
                features_for(source, corpus, function, names, text)
                for function in functions
            )

    rejected_payload = json.loads(NANO_REJECTIONS.read_text(encoding="utf-8"))
    rejected_ids = {item["base_id"] for item in rejected_payload.get("rejections", [])}
    rejected_body_hashes = {
        entry["body_sha256"] for entry in entries if entry["id"] in rejected_ids
    }
    selected = curate(entries, args.size, rejected_ids, rejected_body_hashes)
    report = {
        "schema": "tespec-four-class-program-catalog/v1",
        "selection_status": "static-shortlist-requires-semantic-audit",
        "selection_policy": {
            "requested_size": args.size,
            "excluded_shapes": sorted(EXCLUDED_PATH_PARTS),
            "nano_rejected_base_ids": sorted(rejected_ids),
            "nano_rejected_body_sha256": sorted(rejected_body_hashes),
            "notes": [
                "A task is one annotated target function; source families stay together when splitting.",
                "Exact normalized-body duplicates are removed.",
                f"Every selected base has static difficulty score >= {MIN_SELECTED_DIFFICULTY_SCORE:g}.",
                "Scores select difficult/diverse subjects but do not establish ground truth.",
                "Feature coverage never overrides the minimum difficulty floor.",
                "A base solved by the frozen gpt-5-nano gate and every exact implementation duplicate are excluded before selection.",
            ],
        },
        "inventory": summarize(entries),
        "selected": summarize(selected),
        "parse_failure_count": len(parse_failures),
        "parse_failures": parse_failures,
        "tasks": selected,
    }
    target = args.output.resolve()
    target.parent.mkdir(parents=True, exist_ok=True)
    target.write_text(
        json.dumps(report, ensure_ascii=False, indent=2) + "\n",
        encoding="utf-8",
    )
    markdown_target = target.with_suffix(".md")
    write_markdown(report, markdown_target)
    print(json.dumps(report["selected"], ensure_ascii=False, indent=2))
    print(f"catalog: {target}")
    print(f"catalog markdown: {markdown_target}")
    return 0 if len(selected) == args.size else 1


if __name__ == "__main__":
    raise SystemExit(main())
