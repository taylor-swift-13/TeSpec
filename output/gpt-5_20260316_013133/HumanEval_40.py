
def precondition(input):
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    l = input[0]
    if not isinstance(l, list):
        return False
    for x in l:
        if not isinstance(x, int):
            return False
    return True

def postcondition(input, output):
    if not precondition(input):
        return True
    if not isinstance(output, bool):
        return False
    l = input[0]
    n = len(l)
    exists = False
    for i in range(n):
        for j in range(i + 1, n):
            s2 = l[i] + l[j]
            for k in range(j + 1, n):
                if s2 + l[k] == 0:
                    exists = True
                    break
            if exists:
                break
        if exists:
            break
    return output == exists

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
