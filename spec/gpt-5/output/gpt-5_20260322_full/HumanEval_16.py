def ascii_lower(a: str) -> str:
    n = ord(a)
    if 65 <= n <= 90:
        return chr(n + 32)
    return a

def list_of_string(s: str) -> list:
    return list(s)

def count_distinct_characters_spec(s: str, n: int) -> bool:
    L = [ascii_lower(x) for x in list_of_string(s)]
    U = set(L)
    return len(U) == n

def _impl(string: str) -> int:
    return len(set(string.lower()))

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(count_distinct_characters_spec(*input, output))

def count_distinct_characters(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
