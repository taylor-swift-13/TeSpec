from typing import List

def precondition(input):
    if len(input) != 2:
        return False
    strings, substring = input
    if not isinstance(strings, list):
        return False
    if not all(isinstance(s, str) for s in strings):
        return False
    if not isinstance(substring, str):
        return False
    return True

def postcondition(input, output):
    strings, substring = input
    if not isinstance(output, list):
        return False
    if not all(isinstance(s, str) for s in output):
        return False
    # All output strings must contain the substring
    if not all(substring in s for s in output):
        return False
    # All output strings must be from the input list
    if not all(s in strings for s in output):
        return False
    # All strings from input that contain substring must be in output
    expected = [s for s in strings if substring in s]
    if len(output) != len(expected):
        return False
    # Check that output preserves order and matches expected
    if output != expected:
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
