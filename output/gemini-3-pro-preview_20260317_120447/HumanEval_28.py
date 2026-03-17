from typing import List

def precondition(input) -> bool:
    return (
        isinstance(input, tuple) and
        len(input) == 1 and
        isinstance(input[0], list) and
        all(isinstance(s, str) for s in input[0])
    )

def postcondition(input, output) -> bool:
    return (
        isinstance(output, str) and
        len(output) == sum(len(s) for s in input[0])
    )

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
