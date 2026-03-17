
def precondition(args):
    l = args[0]
    if not isinstance(l, list):
        return False
    if not all(isinstance(x, int) for x in l):
        return False
    return True

def postcondition(args, output):
    l = args[0]
    if not isinstance(output, bool):
        return False
    
    seen = set()
    has_pair = False
    for x in l:
        if -x in seen:
            has_pair = True
            break
        seen.add(x)
        
    return output == has_pair

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
