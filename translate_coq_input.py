#!/usr/bin/env python3
import argparse
import ast
import json
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


def extract_json_object(text: str) -> dict:
    text = strip_code_fences(text)
    try:
        return json.loads(text)
    except json.JSONDecodeError:
        match = re.search(r"\{.*\}", text, re.DOTALL)
        if not match:
            raise
        return json.loads(match.group(0))


def build_prompt(coq_source: str, stem: str) -> str:
    return textwrap.dedent(
        f"""
        Produce executable Python code from the following Coq spec.

        Goal:
        The Python code does not need to be formally equivalent to the Coq code.
        The only requirement is: for all concrete inputs, the Python code must return the same result or judgment as the Coq code/spec.

        Requirements:
        1. Output only valid Python code.
        2. Preserve every top-level function/spec name exactly.
        3. Keep helper functions executable in Python.
        4. For any Coq definition named *_spec, generate a Python function with the same arguments that returns bool.
        5. For any Coq definition named *_pre, generate a Python function with the same arguments that returns bool.
        6. Keep the argument order unchanged.
        7. Use ASCII only.
        8. Focus on executable behavior on concrete inputs, not on proof structure.
        9. If some Coq construct cannot be naturally represented in executable Python, ignore the non-executable part and preserve the concrete input-output behavior as well as possible.
        10. For forall / exists / Prop-style logic, implement executable checks that make the Python code return the same result as the Coq code/spec on concrete inputs whenever possible.
        11. Do not try to preserve proof terms, proof obligations, or full formal semantics.
        12. The highest priority is: same result as Coq on all concrete inputs.

        File index: {stem}

        Coq input:
        {coq_source}
        """
    ).strip()


def build_repair_prompt(coq_source: str, python_source: str, stem: str, reasons: list[str]) -> str:
    reason_block = "\n".join(f"- {reason}" for reason in reasons) if reasons else "- No reasons provided."
    return textwrap.dedent(
        f"""
        Revise the Python code so that it agrees with the Coq code/spec on concrete inputs.

        Goal:
        Do not aim for full formal equivalence.
        The only requirement is: for all concrete inputs, the revised Python code should return the same result or judgment as the Coq code/spec.

        Requirements:
        1. Output only valid Python code.
        2. Preserve every top-level function/spec name exactly.
        3. Keep helper functions executable in Python.
        4. For any Coq definition named *_spec, generate a Python function with the same arguments that returns bool.
        5. For any Coq definition named *_pre, generate a Python function with the same arguments that returns bool.
        6. Use the feedback below to fix concrete behavioral mismatches.
        7. If some Coq construct cannot be naturally represented in executable Python, ignore the non-executable part and prioritize matching the concrete result on inputs.
        8. Do not add markdown fences or explanations.
        9. Use ASCII only.
        10. The highest priority is: same result as Coq on all concrete inputs.

        File index: {stem}

        Coq input:
        {coq_source}

        Current Python translation:
        {python_source}

        Reported non-equivalence reasons:
        {reason_block}
        """
    ).strip()


def build_equivalence_prompt(coq_source: str, python_source: str, stem: str) -> str:
    return textwrap.dedent(
        f"""
        You are checking whether the Python code agrees with the Coq code/spec on concrete inputs.

        Important:
        Do not require full formal equivalence.
        Do not reject the Python code merely because it does not preserve Coq proof structure, Prop structure, or quantifier structure exactly.
        The only question is whether, for all concrete inputs, the Python code is likely to return the same result or judgment as the Coq code/spec.

        Output only a JSON object with this exact schema:
        {{"equivalent": true_or_false, "reason": "short natural language explanation"}}

        Requirements:
        1. equivalent = true if the Python code is likely to return the same result as the Coq code/spec on all concrete inputs.
        2. equivalent = false only if there is a likely mismatch in concrete behavior or returned judgment.
        3. Ignore non-executable Coq semantics that Python cannot naturally express, unless they would change the concrete result.
        4. Focus on whether *_pre, *_spec, and helper definitions produce the same concrete results as Coq.
        5. If you output false, the reason must explain the likely concrete mismatch in natural language.
        6. If you output true, keep the reason brief.
        7. Do not output markdown fences or any extra text.

        File index: {stem}

        Coq input:
        {coq_source}

        Python translation:
        {python_source}
        """
    ).strip()


def make_llm(api_model: str, base_url: str, temperature: float) -> OpenAILLM:
    cfg = LLMConfig()
    cfg.use_api_model = True
    cfg.api_model = api_model
    cfg.api_key = resolve_api_key(api_model)
    cfg.base_url = base_url
    cfg.api_temperature = temperature
    return OpenAILLM(cfg)


def generate_translation_code(llm: OpenAILLM, prompt: str) -> str:
    response = llm.generate_response(prompt)
    code = strip_code_fences(response)
    validate_python_module(code)
    return code.rstrip() + "\n"


def try_validate_python_module(code: str) -> tuple[bool, str | None]:
    try:
        validate_python_module(code)
        return True, None
    except SyntaxError as exc:
        return False, f"{exc.__class__.__name__}: {exc}"


def translate_one(llm: OpenAILLM, input_path: Path, output_path: Path) -> None:
    coq_source = input_path.read_text(encoding="utf-8")
    prompt = build_prompt(coq_source, input_path.stem)
    response = llm.generate_response(prompt)
    code = strip_code_fences(response).rstrip() + "\n"
    output_path.write_text(code, encoding="utf-8")


def repair_translation(
    llm: OpenAILLM,
    input_path: Path,
    output_path: Path,
    reasons: list[str],
) -> None:
    coq_source = input_path.read_text(encoding="utf-8")
    current_python = output_path.read_text(encoding="utf-8")
    prompt = build_repair_prompt(coq_source, current_python, input_path.stem, reasons)
    response = llm.generate_response(prompt)
    code = strip_code_fences(response).rstrip() + "\n"
    output_path.write_text(code, encoding="utf-8")


def judge_equivalence_once(api_model: str, base_url: str, coq_source: str, python_source: str, stem: str) -> dict:
    llm = make_llm(api_model, base_url, temperature=0.2)
    response = llm.generate_response(build_equivalence_prompt(coq_source, python_source, stem))
    parsed = extract_json_object(response)
    equivalent = bool(parsed.get("equivalent", False))
    reason = str(parsed.get("reason", "")).strip()
    if not equivalent and not reason:
        reason = "Model marked the translation as not equivalent but did not provide a reason."
    return {
        "equivalent": equivalent,
        "reason": reason,
        "raw_response": response,
    }


def validate_translation_votes(
    input_path: Path,
    output_path: Path,
    judge_models: list[str],
    judge_repeats: int,
    base_url: str,
) -> dict:
    coq_source = input_path.read_text(encoding="utf-8")
    python_source = output_path.read_text(encoding="utf-8")
    votes = []
    per_model = {}

    for judge_model in judge_models:
        model_votes = []
        for repeat in range(1, judge_repeats + 1):
            result = judge_equivalence_once(judge_model, base_url, coq_source, python_source, input_path.stem)
            vote = {
                "judge_model": judge_model,
                "round": repeat,
                "equivalent": result["equivalent"],
                "reason": result["reason"],
            }
            votes.append(vote)
            model_votes.append(vote)
        yes_votes = sum(1 for item in model_votes if item["equivalent"])
        no_votes = len(model_votes) - yes_votes
        per_model[judge_model] = {
            "equivalent_votes": yes_votes,
            "not_equivalent_votes": no_votes,
            "majority_equivalent": yes_votes > no_votes,
            "reasons_if_not_equivalent": [item["reason"] for item in model_votes if not item["equivalent"]],
        }

    total_yes = sum(1 for item in votes if item["equivalent"])
    total_no = len(votes) - total_yes
    return {
        "source_v_file": str(input_path),
        "translated_py_file": str(output_path),
        "judge_models": judge_models,
        "judge_repeats": judge_repeats,
        "votes": votes,
        "per_model_summary": per_model,
        "overall_equivalent_votes": total_yes,
        "overall_not_equivalent_votes": total_no,
        "overall_majority_equivalent": total_yes > total_no,
        "non_equivalence_reasons": [item["reason"] for item in votes if not item["equivalent"]],
    }


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--spec-root", default="spec")
    parser.add_argument("--model", default="gemini-3-pro-preview")
    parser.add_argument("--api-model", default="gemini-3-pro-preview")
    parser.add_argument("--idx", nargs="+", type=int)
    parser.add_argument("--base-url", default="https://yunwu.ai/v1")
    parser.add_argument(
        "--judge-models",
        nargs="+",
        default=["gemini-3-pro-preview", "claude-opus-4-5-20251101", "gpt-5"],
    )
    parser.add_argument("--judge-repeats", type=int, default=3)
    parser.add_argument("--max-iterations", type=int, dest="max_iterations")
    parser.add_argument("--skip-equivalence-check", action="store_true")
    args = parser.parse_args()

    if args.max_iterations is None:
        args.max_iterations = 2

    spec_root = Path(args.spec_root)
    files = parse_index_selector(list_coq_inputs(spec_root, args.model), args.idx)

    llm = make_llm(args.api_model, args.base_url, temperature=0.0)

    for input_path in files:
        output_path = input_path.with_suffix(".py")
        translate_one(llm, input_path, output_path)
        print(f"Translated {input_path} -> {output_path}")
        if args.skip_equivalence_check:
            continue
        report = None
        for repair_round in range(0, args.max_iterations + 1):
            python_source = output_path.read_text(encoding="utf-8")
            syntax_ok, syntax_error = try_validate_python_module(python_source)
            if not syntax_ok:
                report = {
                    "source_v_file": str(input_path),
                    "translated_py_file": str(output_path),
                    "judge_models": args.judge_models,
                    "judge_repeats": args.judge_repeats,
                    "repair_round": repair_round,
                    "syntax_ok": False,
                    "syntax_error": syntax_error,
                    "overall_majority_equivalent": False,
                    "overall_equivalent_votes": 0,
                    "overall_not_equivalent_votes": 0,
                    "non_equivalence_reasons": [syntax_error],
                    "votes": [],
                    "per_model_summary": {},
                }
                if repair_round == args.max_iterations:
                    break
                repair_translation(llm, input_path, output_path, [syntax_error])
                print(f"Repaired syntax for {output_path} after round {repair_round}: {syntax_error}")
                continue
            report = validate_translation_votes(
                input_path=input_path,
                output_path=output_path,
                judge_models=args.judge_models,
                judge_repeats=args.judge_repeats,
                base_url=args.base_url,
            )
            report["repair_round"] = repair_round
            report["syntax_ok"] = True
            if report["overall_majority_equivalent"]:
                break
            if repair_round == args.max_iterations:
                break
            reasons = report["non_equivalence_reasons"]
            if not reasons:
                reasons = ["The judges found the translation not equivalent, but did not provide detailed reasons."]
            repair_translation(llm, input_path, output_path, reasons)
            print(
                f"Repaired {output_path} after round {repair_round}: "
                f"{report['overall_equivalent_votes']} eq / {report['overall_not_equivalent_votes']} neq"
            )
        report_path = input_path.with_suffix(".equiv.json")
        report_path.write_text(json.dumps(report, ensure_ascii=True, indent=2) + "\n", encoding="utf-8")
        print(
            f"Validated {output_path} with votes: "
            f"{report['overall_equivalent_votes']} eq / {report['overall_not_equivalent_votes']} neq"
        )
        print(f"Wrote {report_path}")


if __name__ == "__main__":
    main()
