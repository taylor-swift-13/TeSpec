
def precondition(input):
    l, = input
    return isinstance(l, list) and all(isinstance(x, int) for x in l)

def postcondition(input, output):
    l, = input
    if not isinstance(output, bool):
        return False
    if not precondition(input):
        return False
    if output:
        for i in range(len(l)):
            for j in range(len(l)):
                if i != j and l[i] + l[j] == 0:
                    return True
        return False
    else:
        for i in range(len(l)):
            for j in range(len(l)):
                if i != j and l[i] + l[j] == 0:
                    return False
        return True

def _impl(l):
    """pairs_sum_to_zero takes a list of integers as an input.
    it returns True if there are two distinct elements in the list that
    sum to zero, and False otherwise.
    False
    False
    False
    True
    False"""
    for i in range(len(l)):
        for j in range(len(l)):
            if i != j and l[i] + l[j] == 0:
                return True
    return False

def pairs_sum_to_zero(l):
    _input = (l,)
    assert precondition(_input)
    _output = _impl(l)
    assert postcondition(_input, _output)
    return _output
