
def precondition(input_args):
    if not isinstance(input_args, tuple) or len(input_args) != 1:
        return False
    l = input_args[0]
    return isinstance(l, list) and all(isinstance(x, int) for x in l)

def postcondition(input_args, output):
    l = input_args[0]
    if not isinstance(output, bool):
        return False
    
    found = False
    n = len(l)
    for i in range(n):
        for j in range(i + 1, n):
            if l[i] + l[j] == 0:
                found = True
                break
        if found:
            break
            
    return output == found

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
