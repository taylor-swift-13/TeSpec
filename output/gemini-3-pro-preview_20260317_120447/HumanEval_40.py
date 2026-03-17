
def precondition(input_args):
    l = input_args[0]
    return isinstance(l, list) and all(isinstance(x, int) for x in l)

def postcondition(input_args, output):
    l = input_args[0]
    if not isinstance(output, bool):
        return False
    
    n = len(l)
    found = False
    for i in range(n):
        for j in range(i + 1, n):
            for k in range(j + 1, n):
                if l[i] + l[j] + l[k] == 0:
                    found = True
                    break
            if found: break
        if found: break
        
    return output == found

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
