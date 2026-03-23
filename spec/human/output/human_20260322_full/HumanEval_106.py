import math

def problem_106_pre(n):
    return True

def problem_106_spec(n, l):
    if len(l) != n:
        return False
    for i in range(1, n + 1):
        if i % 2 == 0:
            expected = math.factorial(i)
        else:
            expected = (i * (i + 1)) // 2
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
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_106_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_106_spec(*input, output))

def f(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
