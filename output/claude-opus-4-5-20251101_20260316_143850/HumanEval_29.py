from typing import List

def precondition(input) -> bool:
    if len(input) != 2:
        return False
    strings, prefix = input
    if not isinstance(strings, list):
        return False
    if not all(isinstance(s, str) for s in strings):
        return False
    if not isinstance(prefix, str):
        return False
    return True

def postcondition(input, output) -> bool:
    strings, prefix = input
    if not isinstance(output, list):
        return False
    if not all(isinstance(s, str) for s in output):
        return False
    # All output strings must start with the prefix
    if not all(s.startswith(prefix) for s in output):
        return False
    # All output strings must be from the input list
    if not all(s in strings for s in output):
        return False
    # All strings from input that start with prefix must be in output
    expected = [s for s in strings if s.startswith(prefix)]
    if len(output) != len(expected):
        return False
    # Check that output preserves order from input
    output_idx = 0
    for s in strings:
        if s.startswith(prefix):
            if output_idx >= len(output) or output[output_idx] != s:
                return False
            output_idx += 1
    return True

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
