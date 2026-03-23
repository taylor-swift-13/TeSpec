def factorial(k):
    res = 1
    for i in range(1, k + 1):
        res *= i
    return res

def sum_1_to_i(i):
    res = 0
    for j in range(1, i + 1):
        res += j
    return res

def f_spec(n, l):
    if len(l) != n:
        return False
    for i in range(1, n + 1):
        if i % 2 == 0:
            expected = factorial(i)
        else:
            expected = sum_1_to_i(i)
            
        if l[i - 1] != expected:
            return False
    return True

def _impl(n):
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

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(f_spec(*input, output))

def f(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
