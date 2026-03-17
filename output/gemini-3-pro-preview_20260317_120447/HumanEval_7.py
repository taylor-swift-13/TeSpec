from typing import List

def precondition(input_args):
    if not isinstance(input_args, tuple) or len(input_args) != 2:
        return False
    strings, substring = input_args
    if not isinstance(strings, list):
        return False
    if not all(isinstance(s, str) for s in strings):
        return False
    if not isinstance(substring, str):
        return False
    return True

def postcondition(input_args, output):
    if not isinstance(output, list):
        return False
    if not all(isinstance(s, str) for s in output):
        return False
    strings, substring = input_args
    expected = [s for s in strings if substring in s]
    return output == expected

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
