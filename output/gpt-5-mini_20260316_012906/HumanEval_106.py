
import numbers

def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    n = input[0]
    # reject booleans which are subclasses of Integral
    if isinstance(n, bool):
        return False
    if not isinstance(n, numbers.Integral):
        return False
    try:
        return int(n) >= 0
    except Exception:
        return False

def postcondition(input, output):
    # If precondition does not hold, do not constrain postcondition here
    if not precondition(input):
        return True
    n = int(input[0])
    # output must be a list of length n
    if not isinstance(output, list):
        return False
    if len(output) != n:
        return False
    for idx, val in enumerate(output):
        # elements should be integer-like (but not booleans)
        if isinstance(val, bool):
            return False
        if not isinstance(val, numbers.Integral):
            return False
        i = idx + 1
        if i % 2 == 0:
            # factorial of i
            expected = 1
            for k in range(1, i + 1):
                expected *= k
        else:
            # sum from 1 to i = i*(i+1)/2
            expected = i * (i + 1) // 2
        if int(val) != expected:
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
