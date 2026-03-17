
def precondition(input):
    if len(input) != 1:
        return False
    num = input[0]
    if not isinstance(num, int):
        return False
    return True


def postcondition(input, output):
    if not isinstance(output, tuple):
        return False
    if len(output) != 2:
        return False
    if not isinstance(output[0], int) or not isinstance(output[1], int):
        return False
    if output[0] < 0 or output[1] < 0:
        return False
    num = input[0]
    digits = str(abs(num))
    total_digits = len(digits)
    if output[0] + output[1] != total_digits:
        return False
    return True

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
