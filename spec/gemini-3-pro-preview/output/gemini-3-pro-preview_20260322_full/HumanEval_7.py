from typing import List

def contains_substring(s: str, sub: str) -> bool:
    return sub in s

def FilterRel(sub: str, l: list, l_prime: list) -> bool:
    expected = [s for s in l if contains_substring(s, sub)]
    return expected == l_prime

def filter_by_substring_spec(strings: list, substring: str, result: list) -> bool:
    return FilterRel(substring, strings, result)

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
