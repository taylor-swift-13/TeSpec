def is_vowel(c: str) -> bool:
    return c in ['a', 'e', 'i', 'o', 'u', 'A', 'E', 'I', 'O', 'U']

def filter_string(f, s: str) -> str:
    return "".join(c for c in s if f(c))

def problem_51_pre(input: str) -> bool:
    return True

def problem_51_spec(input: str, output: str) -> bool:
    expected = filter_string(lambda c: not is_vowel(c), input)
    return output == expected

def _impl(text):
    return "".join(list(filter(lambda ch: ch not in "aeiouAEIOU", text)))

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_51_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_51_spec(*input, output))

def remove_vowels(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
