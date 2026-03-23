def problem_74_pre(lst1, lst2):
    return True

def problem_74_spec(lst1, lst2, output):
    sum1 = sum(len(s) for s in lst1)
    sum2 = sum(len(s) for s in lst2)
    
    if sum1 <= sum2:
        return output == lst1
    else:
        return output == lst2

def _impl(lst1, lst2):
    c1, c2 = sum(map(lambda s: len(s), lst1)), sum(map(lambda s: len(s), lst2))
    return lst1 if c1 <= c2 else lst2

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_74_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_74_spec(*input, output))

def total_match(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
