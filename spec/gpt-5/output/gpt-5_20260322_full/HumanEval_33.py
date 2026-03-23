def third_indices(l):
    return [i for i in range(len(l)) if i % 3 == 0]

def third_elems(l):
    indices = third_indices(l)
    return [l[i] for i in indices]

def sort_third_spec(l, l_prime):
    if len(l) != len(l_prime):
        return False
    
    s_prime = sorted(third_elems(l))
    
    for i in range(len(l)):
        if i % 3 != 0:
            if l_prime[i] != l[i]:
                return False
                
    indices = third_indices(l)
    for k in range(len(indices)):
        if l_prime[indices[k]] != s_prime[k]:
            return False
            
    return True

def _impl(l: list):
    third = [l[i] for i in range(len(l)) if i % 3 == 0]
    third.sort()
    return [third[i // 3] if i % 3 == 0 else l[i] for i in range(len(l))]

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(sort_third_spec(*input, output))

def sort_third(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
