from typing import List

def precondition(input):
    strings, prefix = input
    return isinstance(strings, list) and all(isinstance(s, str) for s in strings) and isinstance(prefix, str)

def postcondition(input, output):
    strings, prefix = input
    return isinstance(output, list) and all(s.startswith(prefix) for s in output) and all(s in strings for s in output)

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
