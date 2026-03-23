def next_smallest_spec(lst, res):
    if res is None:
        return len(set(lst)) <= 1
    else:
        z = res
        if z not in lst:
            return False
        
        if not lst:
            return False
            
        m = min(lst)
        if not (m < z):
            return False
            
        for x in lst:
            if m < x:
                if not (z <= x):
                    return False
                    
        return True

def _impl(lst):
    if len(lst) <= 1: return None
    sorted_list = sorted(lst)
    for x in sorted_list:
        if x != sorted_list[0]:
            return x

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(next_smallest_spec(*input, output))

def next_smallest(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
