def strlen_spec(s: str, result: int) -> bool:
    """
    Returns True if the provided result matches the length of the string s.
    This corresponds to the Coq specification: result = String.length s.
    """
    return result == len(s)

def _impl(string: str) -> int:
    return len(string)

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(strlen_spec(*input, output))

def strlen(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
