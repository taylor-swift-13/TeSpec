
def precondition(input):
    num = input[0]
    return isinstance(num, int)

def postcondition(input, output):
    num = input[0]
    if not isinstance(output, tuple) or len(output) != 2:
        return False
    even_count, odd_count = output
    if not (isinstance(even_count, int) and isinstance(odd_count, int)):
        return False
    if even_count < 0 or odd_count < 0:
        return False
    if num == 0:
        return even_count == 1 and odd_count == 0
    digits = str(abs(num))
    total_digits = len(digits)
    return even_count + odd_count == total_digits

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
