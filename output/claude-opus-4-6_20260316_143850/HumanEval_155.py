
def precondition(input):
    num = input[0]
    return isinstance(num, int) and not isinstance(num, bool)

def postcondition(input, output):
    num = input[0]
    if not isinstance(output, tuple):
        return False
    if len(output) != 2:
        return False
    even_count, odd_count = output
    if not isinstance(even_count, int) or not isinstance(odd_count, int):
        return False
    if even_count < 0 or odd_count < 0:
        return False
    digits = str(abs(num))
    total_digits = len(digits)
    if even_count + odd_count != total_digits:
        return False
    actual_even = sum(1 for d in digits if int(d) % 2 == 0)
    actual_odd = sum(1 for d in digits if int(d) % 2 == 1)
    return even_count == actual_even and odd_count == actual_odd

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
