
def precondition(args):
    lst = args[0]
    if not isinstance(lst, list):
        return False
    if len(lst) == 0:
        return False
    for item in lst:
        if not isinstance(item, int):
            return False
    return True

def postcondition(args, result):
    lst = args[0]
    if not isinstance(result, int):
        return False
    expected = 0
    for i, val in enumerate(lst):
        if i % 2 == 1 and val % 2 == 0:
            expected += val
    return result == expected

def _impl(lst):
    """Given a non-empty list of integers lst. add the even elements that are at odd indices..


    Examples:
        add([4, 2, 6, 7]) ==> 2"""
    s = 0
    for i in range(1, len(lst), 2):
        if lst[i] % 2 == 0:
            s += lst[i]
    return s

def add(lst):
    _input = (lst,)
    assert precondition(_input)
    _output = _impl(lst)
    assert postcondition(_input, _output)
    return _output
