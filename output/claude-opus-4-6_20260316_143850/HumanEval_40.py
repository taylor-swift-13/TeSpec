
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
    if output:
        # There must exist three distinct indices i, j, k such that l[i] + l[j] + l[k] == 0
        found = False
        for i in range(len(l)):
            for j in range(i + 1, len(l)):
                for k in range(j + 1, len(l)):
                    if l[i] + l[j] + l[k] == 0:
                        found = True
                        break
                if found:
                    break
            if found:
                break
        if not found:
            return False
    else:
        # There must be no three distinct indices that sum to zero
        for i in range(len(l)):
            for j in range(i + 1, len(l)):
                for k in range(j + 1, len(l)):
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
