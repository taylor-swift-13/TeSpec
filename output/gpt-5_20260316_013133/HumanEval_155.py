
def precondition(input):
    return (
        isinstance(input, tuple)
        and len(input) == 1
        and isinstance(input[0], int)
    )

def postcondition(input, output):
    if not precondition(input):
        return True
    num = input[0]
    if not isinstance(output, tuple) or len(output) != 2:
        return False
    even_count, odd_count = output
    if not (isinstance(even_count, int) and isinstance(odd_count, int)):
        return False
    if even_count < 0 or odd_count < 0:
        return False
    digits_str = str(abs(num))
    computed_even = sum(1 for ch in digits_str if int(ch) % 2 == 0)
    computed_odd = len(digits_str) - computed_even
    return even_count == computed_even and odd_count == computed_odd

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
