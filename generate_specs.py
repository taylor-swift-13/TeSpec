#!/usr/bin/env python3
import argparse
import ast
from datetime import datetime
import json
import re
import textwrap
from pathlib import Path


API_MODEL_DEFAULT = None
API_KEY_DEFAULT = None
BASE_URL_DEFAULT = None
MAX_TOKENS_DEFAULT = 2048


def parse_range(range_expr: str):
    if ":" not in range_expr:
        raise ValueError("Range must use the form a:b")
    start_text, end_text = range_expr.split(":", 1)
    if not start_text or not end_text:
        raise ValueError("Range must use the form a:b")
    start = int(start_text)
    end = int(end_text)
    if start < 0 or end < start:
        raise ValueError("Range must satisfy 0 <= a <= b")
    return start, end


def select_indices(total: int, range_expr: str | None, explicit_indices: list[int] | None):
    if range_expr and explicit_indices:
        raise ValueError("Use either --range or --idx, not both")
    if explicit_indices:
        seen = set()
        ordered = []
        for idx in explicit_indices:
            if idx < 0 or idx >= total:
                raise IndexError(f"Index out of range: {idx}")
            if idx not in seen:
                seen.add(idx)
                ordered.append(idx)
        return ordered
    if range_expr:
        start, end = parse_range(range_expr)
        if end > total:
            raise IndexError(f"Range end {end} exceeds dataset size {total}")
        return list(range(start, end))
    return list(range(total))


def sanitize_path_component(text: str):
    sanitized = re.sub(r"[^A-Za-z0-9._-]+", "_", text.strip())
    sanitized = sanitized.strip("._-")
    return sanitized or "default"


def build_output_dirs(input_root: Path, output_root: Path, model_name: str):
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    run_name = f"{sanitize_path_component(model_name)}_{timestamp}"
    out_input = input_root / run_name
    out_output = output_root / run_name
    out_input.mkdir(parents=True, exist_ok=False)
    out_output.mkdir(parents=True, exist_ok=False)
    return out_input, out_output


def extract_prompt_info(prompt: str):
    mod = ast.parse(prompt)
    func = next(node for node in mod.body if isinstance(node, ast.FunctionDef))
    doc = ast.get_docstring(func) or ""
    doc_lines = [ln for ln in doc.splitlines() if not ln.strip().startswith(">>>")]
    doc = "\n".join(doc_lines).strip()

    import_lines = []
    for line in prompt.splitlines():
        if line.startswith("import ") or line.startswith("from "):
            import_lines.append(line)
    import_block = "\n".join(import_lines).strip()

    def_sig_line = None
    for line in prompt.splitlines():
        if line.strip().startswith("def "):
            def_sig_line = line.strip()
            break
    if not def_sig_line:
        raise ValueError("Function signature not found in prompt")

    args = func.args
    pos_args = [a.arg for a in (args.posonlyargs + args.args)]
    kwonly_args = [a.arg for a in args.kwonlyargs]
    vararg = args.vararg.arg if args.vararg else None
    kwarg = args.kwarg.arg if args.kwarg else None

    annotations = {}
    for a in args.posonlyargs + args.args + args.kwonlyargs:
        if a.annotation is not None:
            annotations[a.arg] = ast.get_source_segment(prompt, a.annotation) or ""
    if args.vararg and args.vararg.annotation is not None:
        annotations[vararg] = ast.get_source_segment(prompt, args.vararg.annotation) or ""
    if args.kwarg and args.kwarg.annotation is not None:
        annotations[kwarg] = ast.get_source_segment(prompt, args.kwarg.annotation) or ""

    return {
        "func_name": func.name,
        "doc": doc,
        "import_block": import_block,
        "def_sig_line": def_sig_line,
        "pos_args": pos_args,
        "kwonly_args": kwonly_args,
        "vararg": vararg,
        "kwarg": kwarg,
        "annotations": annotations,
    }


def describe_signature_nl(info):
    parts = []
    all_pos = info["pos_args"]
    if all_pos:
        items = []
        for name in all_pos:
            ann = info["annotations"].get(name, "")
            if ann:
                items.append(f"{name} ({ann})")
            else:
                items.append(name)
        parts.append("The function takes positional arguments: " + ", ".join(items) + ".")
    if info["vararg"]:
        name = info["vararg"]
        ann = info["annotations"].get(name, "")
        if ann:
            parts.append(f"It also accepts variadic positional arguments *{name} ({ann}).")
        else:
            parts.append(f"It also accepts variadic positional arguments *{name}.")
    if info["kwonly_args"]:
        items = []
        for name in info["kwonly_args"]:
            ann = info["annotations"].get(name, "")
            if ann:
                items.append(f"{name} ({ann})")
            else:
                items.append(name)
        parts.append("It has keyword-only arguments: " + ", ".join(items) + ".")
    if info["kwarg"]:
        name = info["kwarg"]
        ann = info["annotations"].get(name, "")
        if ann:
            parts.append(f"It also accepts variadic keyword arguments **{name} ({ann}).")
        else:
            parts.append(f"It also accepts variadic keyword arguments **{name}.")
    return " ".join(parts).strip()


def _strip_code_fences(text: str) -> str:
    text = text.strip()
    if text.startswith("```") and text.endswith("```"):
        lines = text.splitlines()
        if len(lines) >= 3:
            lines = lines[1:-1]
        text = "\n".join(lines).strip()
    return text


def _coerce_message_content_to_text(content) -> str:
    if content is None:
        return ""
    if isinstance(content, str):
        return content
    if isinstance(content, list):
        parts = []
        for item in content:
            if isinstance(item, str):
                if item:
                    parts.append(item)
                continue
            if isinstance(item, dict):
                if item.get("type") == "text":
                    txt = item.get("text", "")
                    if isinstance(txt, str) and txt:
                        parts.append(txt)
                continue
            item_type = getattr(item, "type", "")
            if item_type == "text":
                txt = getattr(item, "text", "")
                if isinstance(txt, str) and txt:
                    parts.append(txt)
        return "\n".join(parts).strip()
    return str(content)


def call_llm(description: str, api_model: str | None, api_key: str | None, base_url: str | None):
    system = (
        "You write Python contracts. Output only Python code with two functions: "
        "precondition(input) -> bool and postcondition(input, output) -> bool. "
        "No extra text. Use ASCII only."
    )
    user = (
        "Write precondition and postcondition for the function described below. "
        "The input to precondition/postcondition is a tuple of positional arguments in order. "
        "Be conservative and avoid over-restricting.\n\nDescription:\n"
        + description
    )

    try:
        from config import LLMConfig
        from llm import OpenAILLM
    except Exception as exc:
        raise RuntimeError("Failed to import local llm.py or config.py") from exc

    cfg = LLMConfig()
    cfg.use_api_model = True
    if api_model:
        cfg.api_model = api_model
    if api_key:
        cfg.api_key = api_key
    if base_url:
        cfg.base_url = base_url
    cfg.api_temperature = 0.0

    llm = OpenAILLM(cfg)
    content = llm.generate_response(system + "\n\n" + user)
    content = _strip_code_fences(content)
    if "def precondition" not in content or "def postcondition" not in content:
        snippet = content[:200].replace("\n", "\\n")
        raise ValueError(
            "Model output missing required functions. "
            f"First 200 chars: {snippet}"
        )
    return content.strip() + "\n"


def render_function(def_sig_line: str, doc: str, body: str):
    lines = [def_sig_line]
    if doc:
        doc_block = '"""' + doc.replace('"""', '"""') + '"""'
        lines.append(textwrap.indent(doc_block, "    "))
    body = textwrap.dedent(body).strip("\n")
    if body:
        lines.append(textwrap.indent(body, "    "))
    else:
        lines.append("    pass")
    return "\n".join(lines) + "\n"


def build_input_tuple(info):
    names = info["pos_args"]
    if info["vararg"]:
        names = names + [info["vararg"]]
    if not names:
        return "()"
    if len(names) == 1:
        return f"({names[0]},)"
    return "(" + ", ".join(names) + ")"


def build_impl_call(info):
    parts = []
    for name in info["pos_args"]:
        parts.append(name)
    if info["vararg"]:
        parts.append("*" + info["vararg"])
    for name in info["kwonly_args"]:
        parts.append(f"{name}={name}")
    if info["kwarg"]:
        parts.append("**" + info["kwarg"])
    return "_impl(" + ", ".join(parts) + ")"


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--input-jsonl", default="HumanEvalPlus.jsonl")
    ap.add_argument("--out-input-root", default="input")
    ap.add_argument("--out-output-root", default="output")
    ap.add_argument("--range")
    ap.add_argument("--idx", nargs="+", type=int)
    ap.add_argument("--api-model", default=API_MODEL_DEFAULT)
    ap.add_argument("--api-key", default=API_KEY_DEFAULT)
    ap.add_argument("--base-url", default=BASE_URL_DEFAULT)
    args = ap.parse_args()

    in_path = Path(args.input_jsonl)
    with in_path.open() as f:
        lines = f.readlines()

    try:
        from config import LLMConfig
    except Exception as exc:
        raise RuntimeError("Failed to import local config.py") from exc

    indices = select_indices(len(lines), args.range, args.idx)
    cfg = LLMConfig()
    model_name = args.api_model or cfg.api_model
    out_input, out_output = build_output_dirs(
        Path(args.out_input_root),
        Path(args.out_output_root),
        model_name,
    )
    for idx in indices:
        item = json.loads(lines[idx])
        task_id = item["task_id"].replace("/", "_")
        prompt = item["prompt"]
        canonical = item["canonical_solution"]

        info = extract_prompt_info(prompt)
        nl_sig = describe_signature_nl(info)
        description = (info["doc"] + "\n\n" + nl_sig).strip()

        spec = call_llm(description, args.api_model, args.api_key, args.base_url)

        def_sig_line = info["def_sig_line"]
        func_name = info["func_name"]
        impl_sig = re.sub(r"def\s+" + re.escape(func_name) + r"\b", "def _impl", def_sig_line)

        input_code = []
        if info["import_block"]:
            input_code.append(info["import_block"])
        input_code.append("")
        input_code.append(render_function(def_sig_line, info["doc"], canonical))

        output_code = []
        if info["import_block"]:
            output_code.append(info["import_block"])
        output_code.append("")
        output_code.append(spec.strip())
        output_code.append("")
        output_code.append(render_function(impl_sig, info["doc"], canonical))

        input_tuple = build_input_tuple(info)
        impl_call = build_impl_call(info)
        wrapper = [def_sig_line]
        wrapper.append(f"    _input = {input_tuple}")
        wrapper.append("    assert precondition(_input)")
        wrapper.append(f"    _output = {impl_call}")
        wrapper.append("    assert postcondition(_input, _output)")
        wrapper.append("    return _output")
        output_code.append("\n".join(wrapper) + "\n")

        (out_input / f"{task_id}.py").write_text("\n".join(input_code), encoding="utf-8")
        (out_output / f"{task_id}.py").write_text("\n".join(output_code), encoding="utf-8")

    print(f"Generated {len(indices)} specs")
    print(f"Input dir: {out_input}")
    print(f"Output dir: {out_output}")


if __name__ == "__main__":
    main()
