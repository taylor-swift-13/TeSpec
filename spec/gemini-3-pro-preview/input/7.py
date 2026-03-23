def contains_substring(s: str, sub: str) -> bool:
    return sub in s

def FilterRel(sub: str, l: list, l_prime: list) -> bool:
    expected = [s for s in l if contains_substring(s, sub)]
    return expected == l_prime

def _orig_filter_by_substring_spec(strings: list, substring: str, output: list) -> bool:
    return FilterRel(substring, strings, output)

def filter_by_substring_spec(strings, substring, output):
    return bool(_orig_filter_by_substring_spec(strings, substring, output))
