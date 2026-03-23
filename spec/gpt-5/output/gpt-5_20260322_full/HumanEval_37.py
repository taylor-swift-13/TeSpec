def evens_list(l):
    return l[::2]

def sort_even_spec(l, l_prime):
    if len(l) != len(l_prime):
        return False
    
    es = sorted(evens_list(l))
    
    for i in range(len(l)):
        if i % 2 == 0:
            if l_prime[i] != es[i // 2]:
                return False
        else:
            if l_prime[i] != l[i]:
                return False
                
    return True

def _impl(l: list):
    even = [l[i] for i in range(len(l)) if i % 2 == 0]
    even.sort()
    return [even[i // 2] if i % 2 == 0 else l[i] for i in range(len(l))]

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(sort_even_spec(*input, output))

def sort_even(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
