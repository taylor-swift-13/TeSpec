
def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    n = input[0]
    if isinstance(n, bool):
        return False
    if not isinstance(n, int):
        return False
    if n < 0:
        return False
    return True

def postcondition(input, output):
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    n = input[0]
    if isinstance(n, bool):
        return False
    if not isinstance(n, int):
        return False
    if n < 0:
        return False
    if not isinstance(output, list):
        return False
    if len(output) != n + 1:
        return False

    tri = [0] * (n + 1)
    tri[0] = 1
    if n >= 1:
        tri[1] = 3
    for k in range(2, n + 1):
        if k % 2 == 0:
            tri[k] = 1 + k // 2
        else:
            tri[k] = tri[k - 1] + tri[k - 2] + (1 + (k + 1) // 2)
    if tri != output:
        return False
    return True

def _impl(n):
    """
    Everyone knows Fibonacci sequence, it was studied deeply by mathematicians in 
    the last couple centuries. However, what people don't know is Tribonacci sequence.
    Tribonacci sequence is defined by the recurrence:
    tri(1) = 3
    tri(n) = 1 + n / 2, if n is even.
    tri(n) =  tri(n - 1) + tri(n - 2) + tri(n + 1), if n is odd.
    For example:
    tri(2) = 1 + (2 / 2) = 2
    tri(4) = 3
    tri(3) = tri(2) + tri(1) + tri(4)
           = 2 + 3 + 3 = 8 
    You are given a non-negative integer number n, you have to a return a list of the 
    first n + 1 numbers of the Tribonacci sequence.
    Examples:
    tri(3) = [1, 3, 2, 8]
    """
    if n == 0: return [1]
    if n == 1: return [1, 3]
    ans = [1, 3]
    for i in range(2, n + 1):
        if i % 2 == 0:
            ans.append(1 + i / 2)
        else:
            ans.append(ans[-1] + ans[-2] + 1 + (i + 1) / 2)
    return ans

def tri(n):
    _input = (n,)
    assert precondition(_input)
    _output = _impl(n)
    assert postcondition(_input, _output)
    return _output
