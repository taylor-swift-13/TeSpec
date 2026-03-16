from typing import List

def precondition(input):
    strings, substring = input
    return isinstance(strings, list) and all(isinstance(s, str) for s in strings) and isinstance(substring, str)

def postcondition(input, output):
    strings, substring = input
    if not isinstance(output, list):
        return False
    if not all(isinstance(s, str) for s in output):
        return False
    for s in output:
        if s not in strings:
            return False
        if substring not in s:
            return False
    for s in strings:
        if substring in s and s not in output:
            return False
    return True

def _impl(strings: List[str], substring: str) -> List[str]:
    """Filter an input list of strings only for ones that contain given substring
    []
    ['abc', 'bacd', 'array']"""
    return list(filter(lambda s: substring in s, strings))

def filter_by_substring(strings: List[str], substring: str) -> List[str]:
    _input = (strings, substring)
    assert precondition(_input)
    _output = _impl(strings, substring)
    assert postcondition(_input, _output)
    return _output
