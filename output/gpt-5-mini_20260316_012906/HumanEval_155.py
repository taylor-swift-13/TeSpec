
def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    num = input[0]
    # must be an integer (but not a boolean)
    if not isinstance(num, int):
        return False
    if isinstance(num, bool):
        return False
    return True

def postcondition(input, output):
    if not precondition(input):
        return False
    if not isinstance(output, tuple):
        return False
    if len(output) != 2:
        return False
    even_cnt, odd_cnt = output
    # counts must be non-negative integers (not booleans)
    if not isinstance(even_cnt, int) or isinstance(even_cnt, bool):
        return False
    if not isinstance(odd_cnt, int) or isinstance(odd_cnt, bool):
        return False
    if even_cnt < 0 or odd_cnt < 0:
        return False
    num = input[0]
    s = str(abs(num))
    if not s.isdigit():
        return False
    expected_even = 0
    expected_odd = 0
    for ch in s:
        d = ord(ch) - 48
        if d % 2 == 0:
            expected_even += 1
        else:
            expected_odd += 1
    return even_cnt == expected_even and odd_cnt == expected_odd

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
