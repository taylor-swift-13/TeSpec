
def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    num = input[0]
    if not isinstance(num, int):
        return False
    return True

def postcondition(input, output):
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    if not isinstance(input[0], int):
        return False
    if not isinstance(output, tuple) or len(output) != 2:
        return False
    even_count, odd_count = output
    if not isinstance(even_count, int) or not isinstance(odd_count, int):
        return False

    n = abs(input[0])
    s = str(n)
    even_expected = sum(1 for ch in s if int(ch) % 2 == 0)
    odd_expected = len(s) - even_expected
    return even_expected == even_count and odd_expected == odd_count

def _impl(num):
    """
    Given an integer. return a tuple that has the number of even and odd digits respectively.

    Example:
       even_odd_count(-12) ==> (1, 1)
       even_odd_count(123) ==> (1, 2)
    """
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
