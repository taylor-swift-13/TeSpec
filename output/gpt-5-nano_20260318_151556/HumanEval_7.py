from typing import List

def precondition(input):
    if not isinstance(input, tuple) or len(input) != 2:
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

def postcondition(input, output):
    if not isinstance(input, tuple) or len(input) != 2:
        return False
    strings, substring = input
    if not isinstance(strings, list) or not isinstance(substring, str):
        return False
    if not isinstance(output, list):
        return False
    expected = [s for s in strings if substring in s]
    if output != expected:
        return False
    return True

def _impl(strings: List[str], substring: str) -> List[str]:
    """
    Filter an input list of strings only for ones that contain given substring
    []
    ['abc', 'bacd', 'array']
    """
    return list(filter(lambda s: substring in s, strings))

def filter_by_substring(strings: List[str], substring: str) -> List[str]:
    _input = (strings, substring)
    assert precondition(_input)
    _output = _impl(strings, substring)
    assert postcondition(_input, _output)
    return _output
