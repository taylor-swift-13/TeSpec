from typing import List

def precondition(inputs: tuple) -> bool:
    if len(inputs) != 1:
        return False
    strings = inputs[0]
    if not isinstance(strings, list):
        return False
    return all(isinstance(s, str) for s in strings)

def postcondition(inputs: tuple, output: str) -> bool:
    strings = inputs[0]
    if not isinstance(output, str):
        return False
    return output == "".join(strings)

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
