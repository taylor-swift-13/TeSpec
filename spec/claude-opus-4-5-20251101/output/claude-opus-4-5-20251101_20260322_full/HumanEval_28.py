from typing import List

def concatenate(strings):
    """
    Concatenates a list of strings into a single string.
    Equivalent to the Coq Fixpoint concatenate.
    """
    result = ""
    for s in strings:
        result += s
    return result

def concatenate_spec(strings, result):
    """
    Returns True if the result is equal to the concatenation of the strings.
    Equivalent to the Coq Definition concatenate_spec.
    """
    return result == concatenate(strings)

def _impl(strings: List[str]) -> str:
    return "".join(strings)

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(concatenate_spec(*input, output))

def concatenate(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
