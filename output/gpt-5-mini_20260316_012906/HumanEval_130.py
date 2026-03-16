
def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) < 1:
        return False
    n = input[0]
    if not isinstance(n, int) or isinstance(n, bool):
        return False
    return n >= 0

def postcondition(input, output):
    if not precondition(input):
        return False
    n = input[0]
    if not isinstance(output, list):
        return False
    if len(output) != n + 1:
        return False
    # elements should be integers (not booleans)
    for x in output:
        if not isinstance(x, int) or isinstance(x, bool):
            return False
    for i in range(0, n + 1):
        val = output[i]
        # base rule for index 1
        if i == 1:
            if val != 3:
                return False
        # even rule: tri(i) = 1 + i/2  (i even)
        if i % 2 == 0:
            if val != 1 + (i // 2):
                return False
        else:
            # odd rule: tri(i) = tri(i-1) + tri(i-2) + tri(i+1)
            # can only check when tri(i-1), tri(i-2), tri(i+1) are present in output
            if i + 1 <= n:
                # if i-2 < 0 (only possible for i==1) we've already validated tri(1)
                if i - 2 < 0:
                    continue
                if val != output[i - 1] + output[i - 2] + output[i + 1]:
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
