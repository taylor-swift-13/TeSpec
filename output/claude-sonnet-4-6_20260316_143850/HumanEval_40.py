
def precondition(args):
    if len(args) != 1:
        return False
    l = args[0]
    if not isinstance(l, list):
        return False
    for item in l:
        if not isinstance(item, int):
            return False
    return True

def postcondition(args, output):
    if not isinstance(output, bool):
        return False
    l = args[0]
    if output:
        # Verify there exist three distinct indices with elements summing to zero
        n = len(l)
        found = False
        for i in range(n):
            for j in range(i + 1, n):
                for k in range(j + 1, n):
                    if l[i] + l[j] + l[k] == 0:
                        found = True
        return found
    else:
        # Verify no three distinct elements sum to zero
        n = len(l)
        for i in range(n):
            for j in range(i + 1, n):
                for k in range(j + 1, n):
                    if l[i] + l[j] + l[k] == 0:
                        return False
        return True

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
