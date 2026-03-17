
def precondition(inp):
    l = inp[0]
    return isinstance(l, list) and all(isinstance(x, int) for x in l)

def postcondition(inp, out):
    l = inp[0]
    if not isinstance(out, bool):
        return False
    
    n = len(l)
    has_triple = False
    if n >= 3:
        s_l = sorted(l)
        for i in range(n - 2):
            left = i + 1
            right = n - 1
            while left < right:
                total = s_l[i] + s_l[left] + s_l[right]
                if total == 0:
                    has_triple = True
                    break
                elif total < 0:
                    left += 1
                else:
                    right -= 1
            if has_triple:
                break
                
    return out == has_triple

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
