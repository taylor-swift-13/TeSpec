def char_in_string(c, s):
    return c in s

def same_chars_spec(s0, s1, result):
    return result == (set(s0) == set(s1))

def _impl(s0: str, s1: str):
    return set(s0) == set(s1)

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(same_chars_spec(*input, output))

def same_chars(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
