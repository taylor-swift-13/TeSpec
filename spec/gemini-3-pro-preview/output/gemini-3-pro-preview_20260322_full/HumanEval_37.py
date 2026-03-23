def get_evens(l):
    res = []
    for i in range(len(l)):
        if i % 2 == 0:
            res.append(l[i])
    return res

def sort_even_spec(l, res):
    if len(l) != len(res):
        return False
    
    for i in range(len(l)):
        if i % 2 == 1:
            if l[i] != res[i]:
                return False
                
    evens_l = get_evens(l)
    evens_res = get_evens(res)
    
    if sorted(evens_l) != sorted(evens_res):
        return False
        
    if evens_res != sorted(evens_res):
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
