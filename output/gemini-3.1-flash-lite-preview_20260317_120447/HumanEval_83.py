
def precondition(input):
    n = input[0]
    return isinstance(n, int) and n >= 1

def postcondition(input, output):
    n = input[0]
    if n == 1:
        return output == 1
    
    total_n_digit = 9 * (10**(n - 1))
    not_start_or_end_with_1 = 8 * (10**(n - 2)) * 8
    expected = total_n_digit - not_start_or_end_with_1
    
    return output == expected

def _impl(n):
    """Given a positive integer n, return the count of the numbers of n-digit
    positive integers that start or end with 1."""
    if n == 1: return 1
    return 18 * 10 ** (n - 2)

def starts_one_ends(n):
    _input = (n,)
    assert precondition(_input)
    _output = _impl(n)
    assert postcondition(_input, _output)
    return _output
