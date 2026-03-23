def string_append(s1: str, s2: str) -> str:
    return s1 + s2

def string_in(s1: str, s2: str) -> bool:
    return s1 in s2

def string_eq(s1: str, s2: str) -> bool:
    return s1 == s2

def string_length(s: str) -> int:
    return len(s)

def _orig_cycpattern_check_spec(a: str, b: str, output: bool) -> bool:
    expected = False
    if string_eq(b, ''):
        expected = True
    elif string_eq(a, b):
        expected = True
    else:
        for i in range(string_length(b)):
            shifted = string_append(b[i:], b[:i])
            if string_in(shifted, a):
                expected = True
                break
    return output == expected

def cycpattern_check_spec(a, b, output):
    return bool(_orig_cycpattern_check_spec(a, b, output))
