def is_upper_vowel(c: str) -> bool:
    return c in ("A", "E", "I", "O", "U")

def string_to_list(s: str) -> list:
    return list(s)

def count_upper_vowels_even_indices_aux(l: list, idx: int) -> int:
    if not l:
        return 0
    c = l[0]
    rest = l[1:]
    count_rest = count_upper_vowels_even_indices_aux(rest, idx + 1)
    if idx % 2 == 0:
        if is_upper_vowel(c):
            return 1 + count_rest
        else:
            return count_rest
    else:
        return count_rest

def count_upper_vowels_even_indices(l: list) -> int:
    return count_upper_vowels_even_indices_aux(l, 0)

def count_upper_spec(s: str, result: int) -> bool:
    return result == count_upper_vowels_even_indices(string_to_list(s))

def _impl(s):
    cnt = 0
    for i in range(0, len(s), 2):
        if s[i] in "AEIOU":
            cnt += 1
    return cnt

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(count_upper_spec(*input, output))

def count_upper(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
