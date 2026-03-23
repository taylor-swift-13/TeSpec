def is_uppercase_vowel_bool(c):
    return c in ['A', 'E', 'I', 'O', 'U']

def count_upper_impl(s):
    count = 0
    for i in range(len(s)):
        if i % 2 == 0 and is_uppercase_vowel_bool(s[i]):
            count += 1
    return count

def problem_98_pre(s):
    return True

def problem_98_spec(s, output):
    return output == count_upper_impl(s)

def _impl(s):
    cnt = 0
    for i in range(0, len(s), 2):
        if s[i] in "AEIOU":
            cnt += 1
    return cnt

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_98_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_98_spec(*input, output))

def count_upper(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
