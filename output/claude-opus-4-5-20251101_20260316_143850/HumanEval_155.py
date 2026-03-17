
def precondition(input):
    args = input
    if len(args) != 1:
        return False
    num = args[0]
    if not isinstance(num, int):
        return False
    if isinstance(num, bool):
        return False
    return True


def postcondition(input, output):
    args = input
    num = args[0]
    
    # Output should be a tuple of two non-negative integers
    if not isinstance(output, tuple):
        return False
    if len(output) != 2:
        return False
    even_count, odd_count = output
    if not isinstance(even_count, int) or not isinstance(odd_count, int):
        return False
    if isinstance(even_count, bool) or isinstance(odd_count, bool):
        return False
    if even_count < 0 or odd_count < 0:
        return False
    
    # Get the digits of the absolute value of num
    abs_num = abs(num)
    digits = str(abs_num)
    
    # Total count should match number of digits
    if even_count + odd_count != len(digits):
        return False
    
    # Verify the counts are correct
    actual_even = sum(1 for d in digits if int(d) % 2 == 0)
    actual_odd = sum(1 for d in digits if int(d) % 2 == 1)
    
    if even_count != actual_even or odd_count != actual_odd:
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
