
def precondition(input):
    l = input[0]
    return isinstance(l, list)

def postcondition(input, output):
    l = input[0]
    l_prime = output
    if not isinstance(l_prime, list) or len(l_prime) != len(l):
        return False
    
    even_indices_l = [l[i] for i in range(0, len(l), 2)]
    even_indices_l_prime = [l_prime[i] for i in range(0, len(l), 2)]
    
    if sorted(even_indices_l) != even_indices_l_prime:
        return False
        
    for i in range(1, len(l), 2):
        if l[i] != l_prime[i]:
            return False
            
    return True

def _impl(l: list):
    """This function takes a list l and returns a list l' such that
    l' is identical to l in the odd indicies, while its values at the even indicies are equal
    to the values of the even indicies of l, but sorted.
    [1, 2, 3]
    [3, 6, 5, 4]"""
    even = [l[i] for i in range(len(l)) if i % 2 == 0]
    even.sort()
    return [even[i // 2] if i % 2 == 0 else l[i] for i in range(len(l))]

def sort_even(l: list):
    _input = (l,)
    assert precondition(_input)
    _output = _impl(l)
    assert postcondition(_input, _output)
    return _output
