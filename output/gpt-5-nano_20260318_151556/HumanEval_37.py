
def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    l = input[0]
    if not isinstance(l, list):
        return False
    return True

def postcondition(input, output):
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    l = input[0]
    if not isinstance(l, list):
        return False
    if not isinstance(output, list):
        return False
    if len(output) != len(l):
        return False

    evens = [l[i] for i in range(0, len(l), 2)]
    try:
        sorted_evens = sorted(evens)
    except Exception:
        return False

    idx = 0
    for i in range(0, len(l), 2):
        if output[i] != sorted_evens[idx]:
            return False
        idx += 1

    for i in range(1, len(l), 2):
        if output[i] != l[i]:
            return False

    return True

def _impl(l: list):
    """
    This function takes a list l and returns a list l' such that
    l' is identical to l in the odd indicies, while its values at the even indicies are equal
    to the values of the even indicies of l, but sorted.
    [1, 2, 3]
    [3, 6, 5, 4]
    """
    even = [l[i] for i in range(len(l)) if i % 2 == 0]
    even.sort()
    return [even[i // 2] if i % 2 == 0 else l[i] for i in range(len(l))]

def sort_even(l: list):
    _input = (l,)
    assert precondition(_input)
    _output = _impl(l)
    assert postcondition(_input, _output)
    return _output
