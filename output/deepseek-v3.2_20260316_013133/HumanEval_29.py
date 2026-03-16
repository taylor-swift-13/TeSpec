from typing import List

def precondition(input):
    strings, prefix = input
    return isinstance(strings, list) and all(isinstance(s, str) for s in strings) and isinstance(prefix, str)

def postcondition(input, output):
    strings, prefix = input
    if not isinstance(output, list):
        return False
    if not all(isinstance(s, str) for s in output):
        return False
    for s in output:
        if not s.startswith(prefix):
            return False
    for s in strings:
        if s.startswith(prefix) and s not in output:
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
