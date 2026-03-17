from typing import List

def precondition(inputs: tuple) -> bool:
    if len(inputs) != 2:
        return False
    strings, prefix = inputs
    if not isinstance(strings, list):
        return False
    if not all(isinstance(s, str) for s in strings):
        return False
    if not isinstance(prefix, str):
        return False
    return True

def postcondition(inputs: tuple, output: list) -> bool:
    if len(inputs) != 2:
        return False
    strings, prefix = inputs
    if not isinstance(output, list):
        return False
    return output == [s for s in strings if s.startswith(prefix)]

def _impl(strings: List[str], prefix: str) -> List[str]:
    """Filter an input list of strings only for ones that start with a given prefix.
    []
    ['abc', 'array']"""
    return list(filter(lambda x: x.startswith(prefix), strings))

def filter_by_prefix(strings: List[str], prefix: str) -> List[str]:
    _input = (strings, prefix)
    assert precondition(_input)
    _output = _impl(strings, prefix)
    assert postcondition(_input, _output)
    return _output
