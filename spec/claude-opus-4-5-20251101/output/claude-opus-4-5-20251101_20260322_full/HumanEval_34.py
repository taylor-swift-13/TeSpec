def is_sorted(l):
    return all(l[i] <= l[i+1] for i in range(len(l)-1))

def no_duplicates(l):
    return len(set(l)) == len(l)

def all_elements_from(result, original):
    return set(result) == set(original)

def unique_spec(l, result):
    return is_sorted(result) and no_duplicates(result) and all_elements_from(result, l)

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
