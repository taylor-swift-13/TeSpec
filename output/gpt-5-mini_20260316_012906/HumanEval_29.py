from typing import List

def precondition(input):
    try:
        strings, prefix = input
    except Exception:
        return False
    if not isinstance(strings, list):
        return False
    if not isinstance(prefix, str):
        return False
    for s in strings:
        if not isinstance(s, str):
            return False
    return True

def postcondition(input, output):
    try:
        strings, prefix = input
    except Exception:
        return False
    # output must be a list of strings
    if not isinstance(output, list):
        return False
    for s in output:
        if not isinstance(s, str):
            return False
        if not s.startswith(prefix):
            return False
    # counts must match the expected filtered list (respect multiplicity)
    from collections import Counter
    expected = [s for s in strings if isinstance(s, str) and s.startswith(prefix)]
    return Counter(output) == Counter(expected)

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
