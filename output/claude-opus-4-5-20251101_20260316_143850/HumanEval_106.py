
def precondition(args: tuple) -> bool:
    n = args[0]
    # n must be an integer and non-negative
    if not isinstance(n, int):
        return False
    if isinstance(n, bool):
        return False
    if n < 0:
        return False
    return True


def postcondition(args: tuple, output) -> bool:
    n = args[0]
    
    # Output must be a list
    if not isinstance(output, list):
        return False
    
    # Output must have size n
    if len(output) != n:
        return False
    
    # Check each element
    for i in range(1, n + 1):
        idx = i - 1  # 0-based index in the output list
        
        if i % 2 == 0:
            # i is even: factorial of i
            factorial = 1
            for j in range(1, i + 1):
                factorial *= j
            expected = factorial
        else:
            # i is odd: sum of numbers from 1 to i
            expected = i * (i + 1) // 2
        
        if output[idx] != expected:
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
