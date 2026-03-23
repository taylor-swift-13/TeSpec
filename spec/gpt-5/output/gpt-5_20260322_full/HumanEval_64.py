FIX = """
Add more test cases.
"""

def ascii_eqb(a: str, b: str) -> bool:
    return a == b

def vowelb(c: str) -> bool:
    return c in "aeiouAEIOU"

def yb(c: str) -> bool:
    return c in "yY"

def count_vowels_excluding_y(s: str) -> int:
    return sum(1 for c in s if vowelb(c))

def last_is_y(s: str) -> bool:
    if not s:
        return False
    return yb(s[-1])

def vowels_count_spec(s: str, n: int) -> bool:
    return n == count_vowels_excluding_y(s) + (1 if last_is_y(s) else 0)

def _impl(s):
    if s == "": return 0
    cnt = len(list(filter(lambda ch: ch in "aeiouAEIOU", s)))
    if s[-1] in "yY": cnt += 1
    return cnt

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(vowels_count_spec(*input, output))

def vowels_count(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
