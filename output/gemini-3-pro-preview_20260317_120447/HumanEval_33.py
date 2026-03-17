
def precondition(input):
    return isinstance(input[0], list)

def postcondition(input, output):
    l = input[0]
    if not isinstance(output, list) or len(l) != len(output):
        return False
    for i in range(len(l)):
        if i % 3 != 0:
            if output[i] != l[i]:
                return False
    l_div_3 = [l[i] for i in range(len(l)) if i % 3 == 0]
    out_div_3 = [output[i] for i in range(len(output)) if i % 3 == 0]
    try:
        return out_div_3 == sorted(l_div_3)
    except:
        return False

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
