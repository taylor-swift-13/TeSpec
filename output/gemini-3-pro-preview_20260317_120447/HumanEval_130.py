
def precondition(input_args: tuple) -> bool:
    if len(input_args) != 1:
        return False
    n = input_args[0]
    return isinstance(n, int) and n >= 0

def postcondition(input_args: tuple, output: list) -> bool:
    n = input_args[0]
    if not isinstance(output, list) or len(output) != n + 1:
        return False
    
    def get_tri(k):
        if k == 1:
            return 3
        if k % 2 == 0:
            return 1 + k // 2
        # For odd k, tri(k) = tri(k-1) + tri(k-2) + tri(k+1)
        # Since k is odd, k-1, k-2, and k+1 are even or 1.
        # tri(k-1) = 1 + (k-1)//2 if k-1 != 1 else 3
        # tri(k-2) = 1 + (k-2)//2 if k-2 != 1 else 3
        # tri(k+1) = 1 + (k+1)//2 (k+1 is always even and > 1)
        
        t_prev1 = 3 if k - 1 == 1 else (1 + (k - 1) // 2)
        t_prev2 = 3 if k - 2 == 1 else (1 + (k - 2) // 2)
        t_next = 1 + (k + 1) // 2
        return t_prev1 + t_prev2 + t_next

    for i in range(n + 1):
        if output[i] != get_tri(i):
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
