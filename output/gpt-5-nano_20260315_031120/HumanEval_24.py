
def precondition(input):
    # input should be a tuple with one integer argument n > 1
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    n = input[0]
    return isinstance(n, int) and n > 1

def postcondition(input, output):
    # output should be the largest proper divisor of n (1 <= output < n, and n % output == 0)
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    n = input[0]
    if not isinstance(n, int) or n <= 1:
        return False
    if not isinstance(output, int):
        return False
    if output < 1 or output >= n:
        return False
    if n % output != 0:
        return False
    # Ensure there is no divisor larger than output but smaller than n
    for d in range(output + 1, n):
        if n % d == 0:
            return False
    return True

def _impl(n: int) -> int:
    """For a given number n, find the largest number that divides n evenly, smaller than n
    5"""
    for i in range(2, n):
        if n % i == 0: return n // i
    return 1

def largest_divisor(n: int) -> int:
    _input = (n,)
    assert precondition(_input)
    _output = _impl(n)
    assert postcondition(_input, _output)
    return _output
