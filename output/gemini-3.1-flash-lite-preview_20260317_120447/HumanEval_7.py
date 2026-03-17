from typing import List

def precondition(input):
    strings, substring = input
    return isinstance(strings, list) and all(isinstance(s, str) for s in strings) and isinstance(substring, str)

def postcondition(input, output):
    strings, substring = input
    return isinstance(output, list) and all(substring in s for s in output) and all(s in strings for s in output) and all(s in output for s in strings if substring in s)

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
