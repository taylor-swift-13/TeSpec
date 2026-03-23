def is_vowel(c: str) -> bool:
    if len(c) != 1:
        return False
    return c in "aeiouAEIOU"

def is_alpha(c: str) -> bool:
    if len(c) != 1:
        return False
    n = ord(c)
    return (65 <= n <= 90) or (97 <= n <= 122)

def is_consonant(c: str) -> bool:
    return is_alpha(c) and not is_vowel(c)

def problem_118_pre(word: str) -> bool:
    for ch in word:
        n = ord(ch)
        if not ((65 <= n <= 90) or (97 <= n <= 122)):
            return False
    return True

def problem_118_spec(word: str, result: str) -> bool:
    expected = ""
    for i in range(len(word) - 2, 0, -1):
        c_prev = word[i - 1]
        c_curr = word[i]
        c_next = word[i + 1]
        if is_consonant(c_prev) and is_vowel(c_curr) and is_consonant(c_next):
            expected = c_curr
            break
    return result == expected

def _impl(word):
    def is_vowel(ch: str) -> bool:
        return ch in "aeiouAEIOU"
    for i in range(len(word) - 2, 0, -1):
        if is_vowel(word[i]) and not is_vowel(word[i-1]) and not is_vowel(word[i+1]):
            return word[i]
    return ""

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_118_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_118_spec(*input, output))

def get_closest_vowel(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
