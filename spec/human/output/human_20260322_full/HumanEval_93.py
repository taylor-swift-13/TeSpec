def is_vowel(c: str) -> bool:
    return c in "aeiouAEIOU"

def swap_case(c: str) -> str:
    n = ord(c)
    if 65 <= n <= 90:
        return chr(n + 32)
    elif 97 <= n <= 122:
        return chr(n - 32)
    else:
        return c

def replace_vowel(c: str) -> str:
    mapping = {
        'a': 'c', 'e': 'g', 'i': 'k', 'o': 'q', 'u': 'w',
        'A': 'C', 'E': 'G', 'I': 'K', 'O': 'Q', 'U': 'W'
    }
    return mapping.get(c, c)

def encode_char_spec(c_in: str, c_out: str) -> bool:
    c_swapped = swap_case(c_in)
    if is_vowel(c_in):
        expected = replace_vowel(c_swapped)
    else:
        expected = c_swapped
    return c_out == expected

def problem_93_pre(s_in: str) -> bool:
    for c in s_in:
        n = ord(c)
        if not ((65 <= n <= 90) or (97 <= n <= 122) or n == 32):
            return False
    return True

def problem_93_spec(s_in: str, s_out: str) -> bool:
    if len(s_in) != len(s_out):
        return False
    for c_in, c_out in zip(s_in, s_out):
        if not encode_char_spec(c_in, c_out):
            return False
    return True

def _impl(message):
    def switch_case(ch):
        if ord("A") <= ord(ch) <= ord("Z"):
            return chr(ord(ch) + 32)
        elif ord("a") <= ord(ch) <= ord("z"):
            return chr(ord(ch) - 32)
        else:
            return ch
    def vowel_change(ch):
        return ch if ch not in "aeiouAEIOU" else chr(ord(ch) + 2)
    m = "".join(map(switch_case, message))
    return "".join(map(vowel_change, m))

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_93_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_93_spec(*input, output))

def encode(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
