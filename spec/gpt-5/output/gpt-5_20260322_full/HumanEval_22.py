from typing import List, Any

def filter_integers_spec(values, res):
    expected = [v for v in values if type(v) is int]
    return expected == res

def _impl(values: List[Any]) -> List[int]:
    return list(filter(lambda x: type(x) == int, values))

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(filter_integers_spec(*input, output))

def filter_integers(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
