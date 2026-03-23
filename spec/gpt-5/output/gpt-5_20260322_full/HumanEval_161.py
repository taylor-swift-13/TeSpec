def ascii_code(c: str) -> int:
    return ord(c)

def is_upper(c: str) -> bool:
    n = ascii_code(c)
    return 65 <= n <= 90

def is_lower(c: str) -> bool:
    n = ascii_code(c)
    return 97 <= n <= 122

def is_alpha(c: str) -> bool:
    return is_upper(c) or is_lower(c)

def swapcase_char(c: str) -> str:
    n = ascii_code(c)
    if is_lower(c):
        return chr(n - 32)
    elif is_upper(c):
        return chr(n + 32)
    else:
        return c

def string_map(f, s: str) -> str:
    return "".join(f(c) for c in s)

def has_letter(s: str) -> bool:
    return any(is_alpha(c) for c in s)

def string_rev_aux(s: str, acc: str) -> str:
    return s[::-1] + acc

def string_rev(s: str) -> str:
    return string_rev_aux(s, "")

def solve_spec(s: str, r: str) -> bool:
    if has_letter(s):
        return r == string_map(swapcase_char, s)
    else:
        return r == string_rev(s)

def _impl(s):
    ans, has_letter = "", False
    for ch in s:
        if ch.isalpha():
            has_letter = True
            ans += ch.swapcase()
        else:
            ans += ch
    return ans if has_letter else s[::-1]

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(solve_spec(*input, output))

def solve(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
