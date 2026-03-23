from typing import List, Any

class VInt:
    def __init__(self, v):
        self.v = v
        
    def __eq__(self, other):
        if isinstance(other, VInt):
            return self.v == other.v
        return False

class VOther:
    def __eq__(self, other):
        return isinstance(other, VOther)

def filter_integers_model(l):
    res = []
    for item in l:
        if isinstance(item, VInt):
            res.append(item.v)
    return res

def filter_integers_spec(values, result):
    return result == filter_integers_model(values)

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
