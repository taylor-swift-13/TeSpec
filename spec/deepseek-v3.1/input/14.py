def all_prefixes_spec(s: str, prefixes: list) -> bool:
    expected = [s[:i+1] for i in range(len(s))]
    return prefixes == expected
