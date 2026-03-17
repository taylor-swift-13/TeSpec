from typing import List

def precondition(input) -> bool:
    if len(input) != 2:
        return False
    strings, substring = input
    if not isinstance(strings, list):
        return False
    if not isinstance(substring, str):
        return False
    for s in strings:
        if not isinstance(s, str):
            return False
    return True


def postcondition(input, output) -> bool:
    strings, substring = input
    if not isinstance(output, list):
        return False
    for s in output:
        if not isinstance(s, str):
            return False
        if substring not in s:
            return False
    for s in strings:
        if substring in s:
            if s not in output:
                return False
    if len(output) > len(strings):
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
