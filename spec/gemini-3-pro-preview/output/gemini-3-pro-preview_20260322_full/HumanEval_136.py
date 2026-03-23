def largest_smallest_integers_spec(lst, result):
    neg_res, pos_res = result
    
    # Check specification for the largest negative integer
    if neg_res is not None:
        if neg_res not in lst:
            return False
        if neg_res >= 0:
            return False
        for x in lst:
            if x < 0 and x > neg_res:
                return False
    else:
        for x in lst:
            if x < 0:
                return False
                
    # Check specification for the smallest positive integer
    if pos_res is not None:
        if pos_res not in lst:
            return False
        if pos_res <= 0:
            return False
        for x in lst:
            if x > 0 and x < pos_res:
                return False
    else:
        for x in lst:
            if x > 0:
                return False
                
    return True

def _impl(lst):
    neg = list(filter(lambda x: x < 0, lst))
    pos = list(filter(lambda x: x > 0, lst))
    return None if neg == [] else max(neg), None if pos == [] else min(pos)

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(largest_smallest_integers_spec(*input, output))

def largest_smallest_integers(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
