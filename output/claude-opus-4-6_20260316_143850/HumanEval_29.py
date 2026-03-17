from typing import List

def precondition(input):
    try:
        strings, prefix = input
        if not isinstance(strings, list):
            return False
        if not all(isinstance(s, str) for s in strings):
            return False
        if not isinstance(prefix, str):
            return False
        return True
    except Exception:
        return False


def postcondition(input, output):
    try:
        strings, prefix = input
        if not isinstance(output, list):
            return False
        # Every element in output must start with the prefix
        if not all(isinstance(s, str) and s.startswith(prefix) for s in output):
            return False
        # Every element in output must come from the input list
        # Check that output is a subsequence of strings filtered by prefix
        expected = [s for s in strings if s.startswith(prefix)]
        if output != expected:
            return False
        return True
    except Exception:
        return False

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
