
def precondition(input):
    l = input[0]
    if not isinstance(l, list):
        return False
    if not all(isinstance(x, int) for x in l):
        return False
    return True

def postcondition(input, output):
    l = input[0]
    if not isinstance(output, bool):
        return False
    # Check correctness: there exist two distinct indices i, j with l[i] + l[j] == 0
    expected = False
    for i in range(len(l)):
        for j in range(i + 1, len(l)):
            if l[i] + l[j] == 0:
                expected = True
                break
        if expected:
            break
    return output == expected

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
