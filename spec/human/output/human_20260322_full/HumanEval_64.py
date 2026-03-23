FIX = """
Add more test cases.
"""

def is_vowel_char(c: str) -> bool:
    return c in "aeiouAEIOU"

def is_y(c: str) -> bool:
    return c in "yY"

def vowels_count_func(s: str) -> int:
    if s == "":
        return 0
    c = s[0]
    s_prime = s[1:]
    rest = vowels_count_func(s_prime)
    if is_vowel_char(c):
        return 1 + rest
    else:
        if is_y(c) and s_prime == "":
            return 1 + rest
        else:
            return rest

def vowels_count_impl(s: str) -> int:
    return vowels_count_func(s)

def problem_64_pre(s: str) -> bool:
    return True

def problem_64_spec(s: str, output: int) -> bool:
    return output == vowels_count_impl(s)

def _impl(s):
    if s == "": return 0
    cnt = len(list(filter(lambda ch: ch in "aeiouAEIOU", s)))
    if s[-1] in "yY": cnt += 1
    return cnt

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_64_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_64_spec(*input, output))

def vowels_count(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
