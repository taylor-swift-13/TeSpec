def extract_thirds(l, i):
    res = []
    for j, x in enumerate(l):
        if (i + j) % 3 == 0:
            res.append(x)
    return res

def sort_third_spec(l, res):
    if len(res) != len(l):
        return False
        
    for i in range(len(l)):
        if i % 3 != 0:
            if res[i] != l[i]:
                return False
                
    ext_res = extract_thirds(res, 0)
    ext_l = extract_thirds(l, 0)
    
    if sorted(ext_res) != sorted(ext_l):
        return False
        
    if ext_res != sorted(ext_res):
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
