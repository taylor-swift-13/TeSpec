
def precondition(args):
    n = args[0]
    return isinstance(n, int) and n >= 0

def postcondition(args, result):
    n = args[0]
    if not isinstance(result, list):
        return False
    if len(result) != n:
        return False
    for i in range(1, n + 1):
        if i % 2 == 0:
            fact = 1
            for j in range(1, i + 1):
                fact *= j
            if result[i - 1] != fact:
                return False
        else:
            total = 0
            for j in range(1, i + 1):
                total += j
            if result[i - 1] != total:
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
