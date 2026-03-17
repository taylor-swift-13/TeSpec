
def precondition(input):
    args = input
    if len(args) != 1:
        return False
    l = args[0]
    if not isinstance(l, list):
        return False
    # Elements should be comparable (numbers or similar types)
    for item in l:
        if not isinstance(item, (int, float)):
            return False
    return True

def postcondition(input, output):
    l = input[0]
    if not isinstance(output, bool):
        return False
    
    if len(l) <= 1:
        # A list with 0 or 1 elements is trivially monotonic
        return output == True
    
    # Check if monotonically increasing (each element >= previous)
    increasing = all(l[i] <= l[i+1] for i in range(len(l) - 1))
    # Check if monotonically decreasing (each element <= previous)
    decreasing = all(l[i] >= l[i+1] for i in range(len(l) - 1))
    
    expected = increasing or decreasing
    return output == expected

def _impl(l: list):
    """Return True is list elements are monotonically increasing or decreasing.
    True
    False
    True"""
    inc, dec = True, True
    for i in range(len(l) - 1):
        if l[i] > l[i + 1]: inc = False
        if l[i] < l[i + 1]: dec = False
    return inc or dec

def monotonic(l: list):
    _input = (l,)
    assert precondition(_input)
    _output = _impl(l)
    assert postcondition(_input, _output)
    return _output
