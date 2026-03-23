def nat_to_string(n):
    return str(n)

def string_sequence_spec(n, result):
    expected = " ".join(map(nat_to_string, range(n + 1)))
    return result == expected

def _impl(n: int) -> str:
    return " ".join(map(str, range(n + 1)))

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(string_sequence_spec(*input, output))

def string_sequence(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
