from typing import List

def contains_substring(substring, s):
    return substring in s

def filtered(P, l, l_prime):
    # filtered is an inductive relation defining the behavior of a filter function.
    # It holds if l_prime is the list of elements in l for which P is true, preserving order.
    expected = [x for x in l if P(x)]
    return expected == l_prime

def filter_by_substring_spec(strings, substring, res):
    # Checks if 'res' is the result of filtering 'strings' to keep only those containing 'substring'.
    return filtered(lambda s: contains_substring(substring, s), strings, res)

def _impl(strings: List[str], substring: str) -> List[str]:
    return list(filter(lambda s: substring in s, strings))

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(filter_by_substring_spec(*input, output))

def filter_by_substring(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
