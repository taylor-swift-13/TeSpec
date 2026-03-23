FIX = """
Add more test cases.
"""

def is_standard_vowel(c: str) -> bool:
    return c in ("a", "e", "i", "o", "u", "A", "E", "I", "O", "U")

def count_standard_vowels(s: str) -> int:
    return sum(1 for c in s if is_standard_vowel(c))

def is_y(c: str) -> bool:
    return c in ("y", "Y")

def last_char_is_y(s: str) -> bool:
    if len(s) == 0:
        return False
    return is_y(s[-1])

def vowels_count_spec(s: str, cnt: int) -> bool:
    return cnt == count_standard_vowels(s) + (1 if last_char_is_y(s) else 0)

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
