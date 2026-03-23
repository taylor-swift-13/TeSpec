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
    ws = {9, 10, 11, 12, 13, 32}
    start = 0
    while start < len(s) and ord(s[start]) in ws:
        start += 1
    end = len(s)
    while end > start and ord(s[end - 1]) in ws:
        end -= 1
    return s[start:end] == t

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
    ws = {9, 10, 11, 12, 13, 32}
    start = 0
    while start < len(p) and ord(p[start]) in ws:
        start += 1
    end = len(p)
    while end > start and ord(p[end - 1]) in ws:
        end -= 1
    t = p[start:end]
    return strip_rel(p, t) and t.startswith("I ")

def count_sat(parts: list, n: int) -> bool:
    count = sum(1 for p in parts if boredom_on_part(p))
    return count == n

def is_bored_spec(S: str, count: int) -> bool:
    S1 = S.replace('?', '.').replace('!', '.')
    parts = S1.split('.')
    return replace_rel(S, S1) and split_on_dot(parts, S1) and count_sat(parts, count)
