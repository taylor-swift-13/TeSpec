def problem_110_pre(lst1, lst2):
    return len(lst1) > 0 and len(lst2) > 0

def problem_110_spec(lst1, lst2, result):
    odds_in_lst1 = len([x for x in lst1 if x % 2 != 0])
    evens_in_lst2 = len([x for x in lst2 if x % 2 == 0])
    
    if odds_in_lst1 <= evens_in_lst2:
        return result == "YES"
    else:
        return result == "NO"

def _impl(lst1, lst2):
    cnt_odd = len(list(filter(lambda x: x % 2 == 1, lst1)))
    cnt_even = len(list(filter(lambda x: x % 2 == 0, lst2)))
    return "YES" if cnt_odd <= cnt_even else "NO"

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_110_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_110_spec(*input, output))

def exchange(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
