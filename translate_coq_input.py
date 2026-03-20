#!/usr/bin/env python3
import argparse
import ast
import re
import textwrap
from pathlib import Path

from config import LLMConfig
from llm import OpenAILLM


MODEL_API_KEYS = {
    "gpt": "sk-afVplv2oRlR8SnMlC3K0ndGKOIsaBN5O3zxrD1B7zWzgNWGA",
    "deepseek": "sk-afVplv2oRlR8SnMlC3K0ndGKOIsaBN5O3zxrD1B7zWzgNWGA",
    "claude": "sk-531Gm6lDz4TntanpSd8Pp8BYzUNGqQ90XukBrw4Xxo1eI4SQ",
    "gemini": "sk-uTP4bW0qlJ927dODSZ81Ww5QsspvYE2pGRXynvPjf66lXjkS",
}


def resolve_api_key(model_name: str) -> str:
    lowered = model_name.lower()
    for prefix, key in MODEL_API_KEYS.items():
        if lowered.startswith(prefix):
            return key
    raise ValueError(f"No API key mapping configured for model {model_name!r}")


def list_coq_inputs(spec_root: Path, input_model: str) -> list[Path]:
    input_dir = spec_root / input_model / "input"
    if not input_dir.exists():
        raise FileNotFoundError(f"Missing input directory: {input_dir}")
    return sorted(input_dir.glob("*.v"), key=lambda path: int(path.stem))


def parse_index_selector(files: list[Path], indices: list[int] | None) -> list[Path]:
    if not indices:
        return files
    selected = []
    wanted = {str(idx) for idx in indices}
    for path in files:
        if path.stem in wanted:
            selected.append(path)
    missing = sorted(wanted - {path.stem for path in selected}, key=int)
    if missing:
        raise FileNotFoundError(f"Missing input files for indices: {', '.join(missing)}")
    return selected


def strip_code_fences(text: str) -> str:
    text = text.strip()
    if text.startswith("```") and text.endswith("```"):
        lines = text.splitlines()
        if len(lines) >= 3:
            text = "\n".join(lines[1:-1]).strip()
    return text


def validate_python_module(code: str) -> None:
    ast.parse(code)


def build_prompt(coq_source: str, stem: str) -> str:
    return textwrap.dedent(
        f"""
        Translate the following Coq input spec into executable Python.

        Requirements:
        1. Output only valid Python code.
        2. Preserve every top-level function/spec name exactly.
        3. Translate logical propositions into Python boolean-returning functions.
        4. Keep helper functions executable in Python.
        5. Do not add markdown fences or explanations.
        6. Use ASCII only.
        7. For any Coq definition named *_spec, generate a Python function with the same arguments that returns bool.
        8. Keep the argument order unchanged.
        9. Encode Coq logical connectives exactly with Python boolean logic as closely as possible.
        10. If a Coq relation is inductive, translate it into an executable boolean predicate or recognizer with the same name.
        11. If a Coq definition is named *_pre, generate a Python function with the same arguments that returns bool.
        12. Keep all non-spec, non-pre helper functions available for later calls from *_pre and *_spec.

        File index: {stem}

        Coq input:
        {coq_source}
        """
    ).strip()


def translate_one(llm: OpenAILLM, input_path: Path, output_path: Path) -> None:
    coq_source = input_path.read_text(encoding="utf-8")
    prompt = build_prompt(coq_source, input_path.stem)
    response = llm.generate_response(prompt)
    code = strip_code_fences(response)
    validate_python_module(code)
    output_path.write_text(code.rstrip() + "\n", encoding="utf-8")


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--spec-root", default="spec")
    parser.add_argument("--model", default="gemini-3-pro-preview")
    parser.add_argument("--api-model", default="gemini-3-pro-preview")
    parser.add_argument("--idx", nargs="+", type=int)
    parser.add_argument("--base-url", default="https://yunwu.ai/v1")
    args = parser.parse_args()

    spec_root = Path(args.spec_root)
    files = parse_index_selector(list_coq_inputs(spec_root, args.model), args.idx)

    cfg = LLMConfig()
    cfg.use_api_model = True
    cfg.api_model = args.api_model
    cfg.api_key = resolve_api_key(args.api_model)
    cfg.base_url = args.base_url
    cfg.api_temperature = 0.0
    llm = OpenAILLM(cfg)

    for input_path in files:
        output_path = input_path.with_suffix(".py")
        translate_one(llm, input_path, output_path)
        print(f"Translated {input_path} -> {output_path}")


if __name__ == "__main__":
    main()
