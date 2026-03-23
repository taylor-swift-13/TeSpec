from typing import List

def filter_by_prefix_spec(strings, pref, result):
    return result == [s for s in strings if s.startswith(pref)]

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
