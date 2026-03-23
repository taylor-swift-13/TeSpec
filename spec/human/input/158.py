def string_le(s1: str, s2: str) -> bool:
    return s1 <= s2

def string_contains(c: str, s: str) -> bool:
    return c in s

def count_unique_chars(s: str) -> int:
    return len(set(s))

def problem_158_pre(words: list) -> bool:
    return len(words) > 0

def problem_158_spec(words: list, result: str) -> bool:
    if result not in words:
        return False
    
    c_res = count_unique_chars(result)
    for w in words:
        c_w = count_unique_chars(w)
        if not (c_res > c_w or (c_res == c_w and string_le(result, w))):
            return False
            
    return True
