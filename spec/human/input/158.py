def string_le(s1: str, s2: str) -> bool:
    return s1 <= s2

def string_contains(c: str, s: str) -> bool:
    return c in s

def count_unique_chars(s: str) -> int:
    return len(set(s))

def _orig_problem_158_pre(words: list) -> bool:
    return len(words) > 0

def _orig_problem_158_spec(words: list, output: str) -> bool:
    if output not in words:
        return False
    c_res = count_unique_chars(output)
    for w in words:
        c_w = count_unique_chars(w)
        if not (c_res > c_w or (c_res == c_w and string_le(output, w))):
            return False
    return True

def problem_158_pre(words):
    return bool(_orig_problem_158_pre(words))

def problem_158_spec(words, output):
    return bool(_orig_problem_158_spec(words, output))
