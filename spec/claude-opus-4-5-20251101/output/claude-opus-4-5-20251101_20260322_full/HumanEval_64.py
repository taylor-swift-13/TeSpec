FIX = """
Add more test cases.
"""

def is_vowel(ch: str) -> bool:
    return ch in "aeiouAEIOU"

def is_y(ch: str) -> bool:
    return ch in "yY"

def string_to_list(s: str) -> list:
    return list(s)

def count_vowels_in_list(l: list) -> int:
    return sum(1 for c in l if is_vowel(c))

def last_char(s: str):
    if not s:
        return None
    return s[-1]

def ends_with_y(s: str) -> bool:
    c = last_char(s)
    if c is None:
        return False
    return is_y(c)

def vowels_count_spec(s: str, result: int) -> bool:
    base_count = count_vowels_in_list(string_to_list(s))
    y_bonus = 1 if ends_with_y(s) else 0
    return result == base_count + y_bonus

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
