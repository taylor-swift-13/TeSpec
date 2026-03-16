
def precondition(input) -> bool:
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    l = input[0]
    if not isinstance(l, list):
        return False
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    if not isinstance(output, list):
        return False
    l = input[0]
    if not isinstance(l, list):
        return False
    if len(output) != len(l):
        return False

    evens = sorted([l[i] for i in range(len(l)) if i % 2 == 0])
    k = 0
    for i in range(len(l)):
        if i % 2 == 0:
            if output[i] != evens[k]:
                return False
            k += 1
        else:
            if output[i] != l[i]:
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
