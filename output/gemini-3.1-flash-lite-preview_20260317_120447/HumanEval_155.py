
def precondition(input):
    num = input[0]
    return isinstance(num, int)

def postcondition(input, output):
    num = abs(input[0])
    s = str(num)
    evens = sum(1 for d in s if int(d) % 2 == 0)
    odds = sum(1 for d in s if int(d) % 2 != 0)
    return isinstance(output, tuple) and len(output) == 2 and output == (evens, odds)

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
