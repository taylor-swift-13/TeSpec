
def precondition(inp):
    return len(inp) == 1 and isinstance(inp[0], int)

def postcondition(inp, out):
    num = inp[0]
    if not (isinstance(out, tuple) and len(out) == 2):
        return False
    if not (isinstance(out[0], int) and isinstance(out[1], int)):
        return False
    if out[0] < 0 or out[1] < 0:
        return False
    return out[0] + out[1] == len(str(abs(num)))

def _impl(num):
    """Given an integer. return a tuple that has the number of even and odd digits respectively.

    Example:
       even_odd_count(-12) ==> (1, 1)
       even_odd_count(123) ==> (1, 2)"""
    even, odd = 0, 0
    for ch in str(num):
        if ch in "02468": even += 1
        if ch in "13579": odd += 1
    return even, odd

def even_odd_count(num):
    _input = (num,)
    assert precondition(_input)
    _output = _impl(num)
    assert postcondition(_input, _output)
    return _output
