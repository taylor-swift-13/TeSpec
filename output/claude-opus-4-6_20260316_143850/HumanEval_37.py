
def precondition(input):
    (l,) = input
    if not isinstance(l, list):
        return False
    return True


def postcondition(input, output):
    (l,) = input
    if not isinstance(output, list):
        return False
    if len(output) != len(l):
        return False
    # Odd indices should be identical to the original list
    for i in range(1, len(l), 2):
        if output[i] != l[i]:
            return False
    # Even indices should contain the same elements as the even indices of l, but sorted
    even_values_input = [l[i] for i in range(0, len(l), 2)]
    even_values_output = [output[i] for i in range(0, len(output), 2)]
    if sorted(even_values_input) != even_values_output:
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
