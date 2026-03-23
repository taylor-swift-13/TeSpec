def InStr(a: str, s: str) -> bool:
    return a in s

def same_char_sets(s0: str, s1: str) -> bool:
    return set(s0) == set(s1)

def same_chars_spec(s0: str, s1: str, res: bool) -> bool:
    return res == same_char_sets(s0, s1)

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
