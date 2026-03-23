def lex_le(s1: str, s2: str) -> bool:
    return s1 <= s2

def string_le(s1: str, s2: str) -> bool:
    if len(s1) < len(s2):
        return True
    elif len(s1) > len(s2):
        return False
    else:
        return lex_le(s1, s2)

def has_even_length(s: str) -> bool:
    return len(s) % 2 == 0

def insert_by(le, x: str, l: list) -> list:
    for i, h in enumerate(l):
        if le(x, h):
            return l[:i] + [x] + l[i:]
    return l + [x]

def sort_by(le, l: list) -> list:
    res = []
    for x in reversed(l):
        res = insert_by(le, x, res)
    return res

def list_sort_impl(lst_in: list) -> list:
    filtered = [s for s in lst_in if has_even_length(s)]
    return sort_by(string_le, filtered)

def _orig_problem_149_pre(input: list) -> bool:
    return True

def _orig_problem_149_spec(input: list, output: list) -> bool:
    return output == list_sort_impl(input)

def problem_149_pre(lst):
    return bool(_orig_problem_149_pre(lst))

def problem_149_spec(lst, output):
    return bool(_orig_problem_149_spec(lst, output))
