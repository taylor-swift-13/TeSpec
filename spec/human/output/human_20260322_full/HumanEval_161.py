def is_lower_alpha(a: str) -> bool:
    return 'a' <= a <= 'z'

def is_upper_alpha(a: str) -> bool:
    return 'A' <= a <= 'Z'

def is_letter_dec(a: str) -> bool:
    return is_lower_alpha(a) or is_upper_alpha(a)

def my_uppercase(a: str) -> str:
    if is_lower_alpha(a):
        return chr(ord(a) - 32)
    return a

def my_lowercase(a: str) -> str:
    if is_upper_alpha(a):
        return chr(ord(a) + 32)
    return a

def change_case(a: str) -> str:
    if is_lower_alpha(a):
        return my_uppercase(a)
    elif is_upper_alpha(a):
        return my_lowercase(a)
    else:
        return a

def contains_letter_dec(s: list) -> bool:
    for h in s:
        if is_letter_dec(h):
            return True
    return False

def solve_impl(s: str) -> str:
    l = list(s)
    if contains_letter_dec(l):
        return "".join(map(change_case, l))
    else:
        return "".join(reversed(l))

def problem_161_pre(s: str) -> bool:
    return True

def problem_161_spec(s: str, s_prime: str) -> bool:
    return s_prime == solve_impl(s)

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
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_161_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_161_spec(*input, output))

def solve(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
