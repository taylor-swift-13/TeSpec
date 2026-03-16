from typing import List

def precondition(input):
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    seq = input[0]
    if not isinstance(seq, (list, tuple)):
        return False
    try:
        for s in seq:
            if not isinstance(s, str):
                return False
    except Exception:
        return False
    return True

def postcondition(input, output):
    if not isinstance(output, str):
        return False
    if not precondition(input):
        return True
    try:
        expected = ''.join(input[0])
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
