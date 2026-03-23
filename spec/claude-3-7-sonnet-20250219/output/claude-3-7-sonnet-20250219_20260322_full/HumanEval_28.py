from typing import List

from typing import List

def concatenate_spec(strings: List[str], result: str) -> bool:
    """
    Checks if the result string is the concatenation of the list of strings.
    Equivalent to Coq's String.concat "" strings.
    """
    return result == "".join(strings)

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
