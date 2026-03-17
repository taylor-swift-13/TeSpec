
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
    # Check that non-divisible-by-three indices are unchanged
    for i in range(len(l)):
        if i % 3 != 0:
            if output[i] != l[i]:
                return False
    # Check that divisible-by-three indices contain the same elements as in l, but sorted
    div3_original = [l[i] for i in range(0, len(l), 3)]
    div3_output = [output[i] for i in range(0, len(output), 3)]
    if div3_output != sorted(div3_original):
        return False
    return True

def _impl(l: list):
    """This function takes a list l and returns a list l' such that
    l' is identical to l in the indicies that are not divisible by three, while its values at the indicies that are divisible by three are equal
    to the values of the corresponding indicies of l, but sorted.
    [1, 2, 3]
    [2, 6, 3, 4, 8, 9, 5]"""
    third = [l[i] for i in range(len(l)) if i % 3 == 0]
    third.sort()
    return [third[i // 3] if i % 3 == 0 else l[i] for i in range(len(l))]

def sort_third(l: list):
    _input = (l,)
    assert precondition(_input)
    _output = _impl(l)
    assert postcondition(_input, _output)
    return _output
