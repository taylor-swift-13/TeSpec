def unique_spec(l, res):
    is_sorted = all(res[i] <= res[i+1] for i in range(len(res) - 1))
    no_dup = len(res) == len(set(res))
    same_elements = set(res) == set(l)
    return is_sorted and no_dup and same_elements

def _impl(l: list):
    return sorted(set(l))

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(unique_spec(*input, output))

def unique(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
