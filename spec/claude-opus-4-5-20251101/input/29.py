def starts_with(prefix: str, s: str) -> bool:
    return s.startswith(prefix)

def _orig_filter_by_prefix_spec(strings: list, prefix: str, output: list) -> bool:
    expected = [s for s in strings if starts_with(prefix, s)]
    return output == expected

def filter_by_prefix_spec(strings, prefix, output):
    return bool(_orig_filter_by_prefix_spec(strings, prefix, output))
