from typing import List

def precondition(input) -> bool:
    if len(input) != 1:
        return False
    strings = input[0]
    if not isinstance(strings, list):
        return False
    for s in strings:
        if not isinstance(s, str):
            return False
    return True


def postcondition(input, output) -> bool:
    if not isinstance(output, str):
        return False
    strings = input[0]
    if len(strings) == 0:
        return output == ''
    total_len = sum(len(s) for s in strings)
    if len(output) != total_len:
        return False
    return True

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
