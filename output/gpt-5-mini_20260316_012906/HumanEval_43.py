
def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
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
        return False
    l = input[0]
    # compute whether there exist two distinct indices i != j with l[i] + l[j] == 0
    counts = {}
    for x in l:
        counts[x] = counts.get(x, 0) + 1
    found = False
    for x, cnt in counts.items():
        if x == 0:
            if cnt >= 2:
                found = True
                break
        else:
            if -x in counts:
                found = True
                break
    return isinstance(output, bool) and output == found

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
