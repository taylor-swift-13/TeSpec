
def precondition(input):
    if len(input) != 1:
        return False
    lst = input[0]
    if not isinstance(lst, list):
        return False
    if len(lst) == 0:
        return False
    for item in lst:
        if not isinstance(item, int):
            return False
        if isinstance(item, bool):
            return False
    return True

def postcondition(input, output):
    if not isinstance(output, int):
        return False
    lst = input[0]
    expected = 0
    for i in range(len(lst)):
        if i % 2 == 1 and lst[i] % 2 == 0:
            expected += lst[i]
    return output == expected

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
