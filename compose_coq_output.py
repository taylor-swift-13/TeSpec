#!/usr/bin/env python3
import argparse
import ast
import json
import textwrap
from datetime import datetime
from pathlib import Path


def list_translated_inputs(spec_root: Path, model_name: str) -> list[Path]:
    input_dir = spec_root / model_name / "input"
    if not input_dir.exists():
        raise FileNotFoundError(f"Missing input directory: {input_dir}")
    return sorted((path for path in input_dir.glob("*.py") if path.stem.isdigit()), key=lambda path: int(path.stem))


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
        raise FileNotFoundError(f"Missing translated files for indices: {', '.join(missing)}")
    return selected


def sanitize_path_component(text: str) -> str:
    return "".join(ch if ch.isalnum() or ch in "._-" else "_" for ch in text).strip("._-") or "default"


def resolve_output_dir(spec_root: Path, model_name: str, output_subdir: str, run_name: str | None) -> Path:
    base_dir = spec_root / model_name / output_subdir
    base_dir.mkdir(parents=True, exist_ok=True)
    if run_name is None:
        timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
        run_name = f"{sanitize_path_component(model_name)}_{timestamp}"
    output_dir = base_dir / run_name
    output_dir.mkdir(parents=True, exist_ok=True)
    return output_dir


def discover_contract_names(module_path: Path) -> tuple[str | None, str]:
    tree = ast.parse(module_path.read_text(encoding="utf-8"))
    pre_name = None
    spec_name = None
    for node in tree.body:
        if not isinstance(node, ast.FunctionDef):
            continue
        if node.name.endswith("_pre"):
            pre_name = node.name
        if node.name.endswith("_spec"):
            spec_name = node.name
    if spec_name is None:
        raise ValueError(f"Missing *_spec function in {module_path}")
    return pre_name, spec_name


def load_task_meta(jsonl_path: Path) -> list[dict]:
    return [json.loads(line) for line in jsonl_path.read_text(encoding="utf-8").splitlines()]


def extract_impl_support(task_meta: dict) -> tuple[str, str]:
    prompt = task_meta["prompt"]
    entry_point = task_meta["entry_point"]
    tree = ast.parse(prompt)
    import_blocks = []
    helper_blocks = []
    signature_block = None

    for node in tree.body:
        seg = ast.get_source_segment(prompt, node)
        if not seg:
            continue
        if isinstance(node, (ast.Import, ast.ImportFrom)):
            import_blocks.append(seg)
            continue
        if isinstance(node, ast.FunctionDef) and node.name == entry_point:
            signature_block = seg
            continue
        helper_blocks.append(seg)

    if signature_block is None:
        raise ValueError(f"Entry point {entry_point!r} not found in prompt")

    fn_tree = ast.parse(signature_block)
    fn_node = next(node for node in fn_tree.body if isinstance(node, ast.FunctionDef))
    fn_node.name = "_impl"
    fn_node.body = ast.parse("pass").body
    impl_sig = ast.unparse(fn_node).split("pass", 1)[0].rstrip()

    body_lines = task_meta["canonical_solution"].splitlines()
    body = "\n".join(line.rstrip() for line in body_lines if line.strip())
    if not body.strip():
        raise ValueError(f"Missing canonical_solution for {entry_point}")
    impl_block = impl_sig + "\n" + textwrap.indent(textwrap.dedent(body).rstrip(), "    ")

    prefix_parts = []
    if import_blocks:
        prefix_parts.append("\n".join(import_blocks))
    if helper_blocks:
        prefix_parts.append("\n\n".join(helper_blocks))
    prefix = "\n\n".join(part for part in prefix_parts if part.strip())
    return prefix, impl_block


def build_output_source(source: str, pre_name: str | None, spec_name: str, entry_point: str, prefix: str, impl_block: str) -> str:
    source = source.rstrip()

    if pre_name is None:
        pre_block = textwrap.dedent(
            """
            def precondition(input) -> bool:
                return True
            """
        ).strip()
    else:
        pre_block = textwrap.dedent(
            f"""
            def precondition(input) -> bool:
                if not isinstance(input, tuple):
                    input = tuple(input)
                return bool({pre_name}(*input))
            """
        ).strip()

    post_block = textwrap.dedent(
        f"""
        def postcondition(input, output) -> bool:
            if not isinstance(input, tuple):
                input = tuple(input)
            return bool({spec_name}(*input, output))
        """
    ).strip()

    wrapper_block = textwrap.dedent(
        f"""
        def {entry_point}(*args):
            _input = tuple(args)
            assert precondition(_input)
            _output = _impl(*args)
            assert postcondition(_input, _output)
            return _output
        """
    ).strip()

    parts = []
    if prefix.strip():
        parts.append(prefix.strip())
    parts.append(source)
    parts.append(impl_block.strip())
    parts.append(pre_block)
    parts.append(post_block)
    parts.append(wrapper_block)
    return "\n\n".join(parts) + "\n"


def compose_one(input_path: Path, output_path: Path, task_meta: dict) -> None:
    pre_name, spec_name = discover_contract_names(input_path)
    source = input_path.read_text(encoding="utf-8")
    prefix, impl_block = extract_impl_support(task_meta)
    output_source = build_output_source(source, pre_name, spec_name, task_meta["entry_point"], prefix, impl_block)
    ast.parse(output_source)
    output_path.write_text(output_source, encoding="utf-8")


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--spec-root", default="spec")
    parser.add_argument("--model", default="gemini-3-pro-preview")
    parser.add_argument("--idx", nargs="+", type=int)
    parser.add_argument("--output-subdir", default="output")
    parser.add_argument("--run-name")
    parser.add_argument("--input-jsonl", default="HumanEvalPlus.jsonl")
    args = parser.parse_args()

    spec_root = Path(args.spec_root)
    files = parse_index_selector(list_translated_inputs(spec_root, args.model), args.idx)
    output_dir = resolve_output_dir(spec_root, args.model, args.output_subdir, args.run_name)
    tasks = load_task_meta(Path(args.input_jsonl))

    for input_path in files:
        output_path = output_dir / f"HumanEval_{input_path.stem}.py"
        task_meta = tasks[int(input_path.stem)]
        compose_one(input_path, output_path, task_meta)
        print(f"Composed {output_path}")


if __name__ == "__main__":
    main()
