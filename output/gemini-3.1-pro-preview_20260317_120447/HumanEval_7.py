from typing import List

def precondition(inp) -> bool:
    try:
        strings, substring = inp
        if not isinstance(strings, list):
            return False
        if not all(isinstance(s, str) for s in strings):
            return False
        if not isinstance(substring, str):
            return False
        return True
    except Exception:
        return False

def postcondition(inp, out) -> bool:
    try:
        strings, substring = inp
        if not isinstance(out, list):
            return False
        return out == [s for s in strings if substring in s]
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
