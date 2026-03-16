
def precondition(inp):
    if not isinstance(inp, tuple):
        return False
    if len(inp) != 1:
        return False
    l = inp[0]
    if not isinstance(l, list):
        return False
    for x in l:
        if not isinstance(x, int):
            return False
    return True

def postcondition(inp, out):
    # If precondition does not hold, we do not enforce the postcondition here.
    if not precondition(inp):
        return True
    if not isinstance(out, bool):
        return False
    l = inp[0]
    n = len(l)
    found = False
    for i in range(n):
        for j in range(i+1, n):
            for k in range(j+1, n):
                if l[i] + l[j] + l[k] == 0:
                    found = True
                    break
            if found:
                break
        if found:
            break
    return out is found

def _impl(l: list):
    """triples_sum_to_zero takes a list of integers as an input.
    it returns True if there are three distinct elements in the list that
    sum to zero, and False otherwise.

    False
    True
    False
    True
    False"""
    for i in range(len(l)):
        for j in range(len(l)):
            for k in range(len(l)):
                if i != j and i != k and j != k and l[i] + l[j] + l[k] == 0:
                    return True
    return False

def triples_sum_to_zero(l: list):
    _input = (l,)
    assert precondition(_input)
    _output = _impl(l)
    assert postcondition(_input, _output)
    return _output
