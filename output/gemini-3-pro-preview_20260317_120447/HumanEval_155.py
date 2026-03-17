
def precondition(input_args: tuple) -> bool:
    return len(input_args) == 1 and isinstance(input_args[0], int)

def postcondition(input_args: tuple, output: tuple) -> bool:
    if not (isinstance(output, tuple) and len(output) == 2):
        return False
    if not (isinstance(output[0], int) and isinstance(output[1], int)):
        return False
    if output[0] < 0 or output[1] < 0:
        return False
    
    num = input_args[0]
    digits = [int(d) for d in str(abs(num))]
    expected_even = sum(1 for d in digits if d % 2 == 0)
    expected_odd = sum(1 for d in digits if d % 2 != 0)
    
    return output == (expected_even, expected_odd)

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
