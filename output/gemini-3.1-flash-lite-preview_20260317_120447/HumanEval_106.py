
def precondition(input):
    n = input[0]
    return isinstance(n, int) and n >= 0

def postcondition(input, output):
    n = input[0]
    if not isinstance(output, list) or len(output) != n:
        return False
    
    import math
    for i_minus_1, val in enumerate(output):
        i = i_minus_1 + 1
        if i % 2 == 0:
            if val != math.factorial(i):
                return False
        else:
            if val != sum(range(1, i + 1)):
                return False
    return True

def _impl(n):
    """Implement the function f that takes n as a parameter,
    and returns a list of size n, such that the value of the element at index i is the factorial of i if i is even
    or the sum of numbers from 1 to i otherwise.
    i starts from 1.
    the factorial of i is the multiplication of the numbers from 1 to i (1 * 2 * ... * i).
    Example:
    f(5) == [1, 2, 6, 24, 15]"""
    if n == 0: return []
    if n == 1: return [1]
    if n == 2: return [1, 2]

    ans = [1, 2]
    for i in range(3, n + 1):
        if i % 2 == 1:
            ans.append(ans[-2] + (i - 1) + i)
        else:
            ans.append(ans[-2] * (i - 1) * i)
    return ans

def f(n):
    _input = (n,)
    assert precondition(_input)
    _output = _impl(n)
    assert postcondition(_input, _output)
    return _output
