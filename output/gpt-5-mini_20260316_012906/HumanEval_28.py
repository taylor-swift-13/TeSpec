from typing import List

from collections.abc import Sequence

def precondition(input):
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    seq = input[0]
    if isinstance(seq, (str, bytes)):
        return False
    if not isinstance(seq, Sequence):
        return False
    for item in seq:
        if not isinstance(item, str):
            return False
    return True

def postcondition(input, output):
    if not isinstance(output, str):
        return False
    if not precondition(input):
        return False
    seq = input[0]
    try:
        expected = "".join(seq)
    except Exception:
        return False
    return output == expected

def _impl(strings: List[str]) -> str:
    """Concatenate list of strings into a single string
    ''
    'abc'"""
    return "".join(strings)

def concatenate(strings: List[str]) -> str:
    _input = (strings,)
    assert precondition(_input)
    _output = _impl(strings)
    assert postcondition(_input, _output)
    return _output
