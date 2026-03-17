
def precondition(inp):
    lst = inp[0]
    return isinstance(lst, list) and len(lst) > 0 and all(isinstance(x, int) for x in lst)

def postcondition(inp, out):
    lst = inp[0]
    return out == sum(x for i, x in enumerate(lst) if i % 2 == 1 and x % 2 == 0)

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
