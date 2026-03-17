from typing import List

def precondition(input) -> bool:
    if len(input) != 2:
        return False
    strings, prefix = input
    if not isinstance(strings, list):
        return False
    if not isinstance(prefix, str):
        return False
    for s in strings:
        if not isinstance(s, str):
            return False
    return True


def postcondition(input, output) -> bool:
    strings, prefix = input
    if not isinstance(output, list):
        return False
    for s in output:
        if not isinstance(s, str):
            return False
        if not s.startswith(prefix):
            return False
    for s in strings:
        if s.startswith(prefix) and s not in output:
            return False
    if len(output) > len(strings):
        return False
    return True

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
