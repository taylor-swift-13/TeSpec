def starts_with(prefix: str, s: str) -> bool:
    return s.startswith(prefix)

def filter_by_prefix_spec(strings: list, prefix: str, result: list) -> bool:
    expected = [s for s in strings if starts_with(prefix, s)]
    return result == expected
