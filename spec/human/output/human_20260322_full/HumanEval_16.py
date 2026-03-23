def is_upper(a: str) -> bool:
    n = ord(a)
    return 65 <= n <= 90

def lower(a: str) -> str:
    if is_upper(a):
        return chr(ord(a) + 32)
    return a

def problem_16_pre(s: str) -> bool:
    return True

def problem_16_spec(s: str, output: int) -> bool:
    D = set()
    for char in s:
        D.add(lower(char))
    return output == len(D)

def _impl(string: str) -> int:
    return len(set(string.lower()))

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_16_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_16_spec(*input, output))

def count_distinct_characters(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
