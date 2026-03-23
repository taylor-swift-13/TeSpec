from typing import List

def starts_with(prefix: str, s: str) -> bool:
    """
    Checks if the string 's' starts with the given 'prefix'.
    Matches the logic of the Coq Fixpoint starts_with.
    """
    if not prefix:
        return True
    if not s:
        return False
    if prefix[0] == s[0]:
        return starts_with(prefix[1:], s[1:])
    else:
        return False

def filter_by_prefix_spec(strings: list, prefix: str, result: list) -> bool:
    """
    Returns True if 'result' is exactly the list of strings from 'strings' 
     that start with 'prefix', matching the Coq filter_by_prefix_spec.
    """
    expected = [s for s in strings if starts_with(prefix, s)]
    return result == expected

def _impl(strings: List[str], prefix: str) -> List[str]:
    return list(filter(lambda x: x.startswith(prefix), strings))

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(filter_by_prefix_spec(*input, output))

def filter_by_prefix(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
