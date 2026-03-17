
def precondition(args):
    n = args[0]
    # n must be a non-negative integer
    if not isinstance(n, int):
        return False
    if isinstance(n, bool):
        return False
    if n < 0:
        return False
    return True

def postcondition(args, output):
    n = args[0]
    # Output must be a list
    if not isinstance(output, list):
        return False
    # Output must have exactly n + 1 elements
    if len(output) != n + 1:
        return False
    # All elements must be numbers (int or float)
    for elem in output:
        if not isinstance(elem, (int, float)):
            return False
    # Check tri(0) = 1 if n >= 0
    if n >= 0:
        if output[0] != 1:
            return False
    # Check tri(1) = 3 if n >= 1
    if n >= 1:
        if output[1] != 3:
            return False
    # Check even indices: tri(n) = 1 + n / 2
    for i in range(2, n + 1):
        if i % 2 == 0:
            expected = 1 + i / 2
            if output[i] != expected:
                return False
    # Check odd indices: tri(n) = tri(n-1) + tri(n-2) + tri(n+1)
    # For odd n >= 3, tri(n) = tri(n-1) + tri(n-2) + tri(n+1)
    # Since tri(n+1) for odd n means n+1 is even, so tri(n+1) = 1 + (n+1)/2
    for i in range(3, n + 1):
        if i % 2 == 1:
            # tri(i) = tri(i-1) + tri(i-2) + tri(i+1)
            # tri(i+1) = 1 + (i+1)/2 since i+1 is even
            tri_i_plus_1 = 1 + (i + 1) / 2
            expected = output[i - 1] + output[i - 2] + tri_i_plus_1
            if output[i] != expected:
                return False
    return True

def _impl(n):
    """Everyone knows Fibonacci sequence, it was studied deeply by mathematicians in 
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
    tri(3) = [1, 3, 2, 8]"""
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
