def is_whitespace(a: str) -> bool:
    if len(a) != 1:
        return False
    n = ord(a)
    return n in (9, 10, 11, 12, 13, 32)

def all_whitespace(s: str) -> bool:
    return all(is_whitespace(c) for c in s)

def begins_non_ws(s: str) -> bool:
    if not s:
        return False
    return not is_whitespace(s[0])

def ends_non_ws(s: str) -> bool:
    if not s:
        return False
    return not is_whitespace(s[-1])

def strip_rel(s: str, t: str) -> bool:
    stripped = s
    while stripped and is_whitespace(stripped[0]):
        stripped = stripped[1:]
    while stripped and is_whitespace(stripped[-1]):
        stripped = stripped[:-1]
    return stripped == t

def replace_rel(s1: str, s2: str) -> bool:
    return s1.replace('?', '.').replace('!', '.') == s2

def no_dot(s: str) -> bool:
    return '.' not in s

dot_str = "."

def intercalate_dot(parts: list) -> str:
    if not parts:
        return ""
    return ".".join(parts)

def split_on_dot(parts: list, s: str) -> bool:
    return s == intercalate_dot(parts) and all(no_dot(p) for p in parts)

def boredom_on_part(p: str) -> bool:
    stripped = p
    while stripped and is_whitespace(stripped[0]):
        stripped = stripped[1:]
    while stripped and is_whitespace(stripped[-1]):
        stripped = stripped[:-1]
    return stripped.startswith("I ")

def count_sat(parts: list, n: int) -> bool:
    count = sum(1 for p in parts if boredom_on_part(p))
    return count == n

def is_bored_spec(S: str, count: int) -> bool:
    S1 = S.replace('?', '.').replace('!', '.')
    parts = S1.split('.')
    return count_sat(parts, count)

def _impl(S):
    sentences = map(lambda x: x.strip(), ((S.replace("?", ".")).replace("!", ".")).split("."))
    return len([s for s in sentences if s.startswith("I ")])

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(is_bored_spec(*input, output))

def is_bored(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
