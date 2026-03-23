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

def _orig_problem_93_pre(s_in: str) -> bool:
    for c in s_in:
        n = ord(c)
        if not (65 <= n <= 90 or 97 <= n <= 122 or n == 32):
            return False
    return True

def _orig_problem_93_spec(s_in: str, s_out: str) -> bool:
    if len(s_in) != len(s_out):
        return False
    for (c_in, c_out) in zip(s_in, s_out):
        if not encode_char_spec(c_in, c_out):
            return False
    return True

def problem_93_pre(message):
    return bool(_orig_problem_93_pre(message))

def problem_93_spec(message, output):
    return bool(_orig_problem_93_spec(message, output))
