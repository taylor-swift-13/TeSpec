
def precondition(input):
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    n = input[0]
    return isinstance(n, int)

def postcondition(input, output):
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    if not isinstance(output, tuple) or len(output) != 2:
        return False
    n = input[0]
    if not isinstance(n, int):
        return False

    m = abs(n)
    if m == 0:
        expected = (1, 0)
    else:
        even = 0
        odd = 0
        while m:
            d = m % 10
            if d % 2 == 0:
                even += 1
            else:
                odd += 1
            m //= 10
        expected = (even, odd)

    return output == expected

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
