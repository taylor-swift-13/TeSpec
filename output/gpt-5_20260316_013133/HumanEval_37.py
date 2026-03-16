
def precondition(input):
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    l = input[0]
    if not isinstance(l, list):
        return False
    try:
        sorted(l[::2])
    except Exception:
        return False
    return True

def postcondition(input, output):
    if not precondition(input):
        return True
    l = input[0]
    if not isinstance(output, list):
        return False
    if len(output) != len(l):
        return False
    if output[1::2] != l[1::2]:
        return False
    try:
        expected_evens = sorted(l[::2])
    except Exception:
        return False
    if output[::2] != expected_evens:
        return False
    return True

def _impl(l: list):
    """This function takes a list l and returns a list l' such that
    l' is identical to l in the odd indicies, while its values at the even indicies are equal
    to the values of the even indicies of l, but sorted.
    [1, 2, 3]
    [3, 6, 5, 4]"""
    even = [l[i] for i in range(len(l)) if i % 2 == 0]
    even.sort()
    return [even[i // 2] if i % 2 == 0 else l[i] for i in range(len(l))]

def sort_even(l: list):
    _input = (l,)
    assert precondition(_input)
    _output = _impl(l)
    assert postcondition(_input, _output)
    return _output
