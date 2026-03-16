
def precondition(input):
    l, = input
    return isinstance(l, list)

def postcondition(input, output):
    l, = input
    if not isinstance(l, list) or not isinstance(output, list):
        return False
    if len(l) != len(output):
        return False
    for i in range(len(l)):
        if i % 2 == 1:
            if l[i] != output[i]:
                return False
        else:
            even_vals_l = [l[j] for j in range(len(l)) if j % 2 == 0]
            even_vals_out = [output[j] for j in range(len(output)) if j % 2 == 0]
            if sorted(even_vals_l) != sorted(even_vals_out):
                return False
            if even_vals_out != sorted(even_vals_out):
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
