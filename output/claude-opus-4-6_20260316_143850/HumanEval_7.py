from typing import List

def precondition(input):
    try:
        strings, substring = input
        if not isinstance(strings, list):
            return False
        if not isinstance(substring, str):
            return False
        if not all(isinstance(s, str) for s in strings):
            return False
        return True
    except Exception:
        return False


def postcondition(input, output):
    try:
        strings, substring = input
        if not isinstance(output, list):
            return False
        if not all(isinstance(s, str) for s in output):
            return False
        # Every element in output must be from the original list and contain the substring
        if not all(s in strings for s in output):
            return False
        if not all(substring in s for s in output):
            return False
        # Every element in the original list that contains the substring must be in output
        expected = [s for s in strings if substring in s]
        if output != expected:
            return False
        return True
    except Exception:
        return False

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
