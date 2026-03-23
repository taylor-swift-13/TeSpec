def factorial(n: int) -> int:
    if n == 0:
        return 1
    return n * factorial(n - 1)

def sum_upto(n: int) -> int:
    if n == 0:
        return 0
    return sum_upto(n - 1) + n

def f_spec(n: int, ans: list) -> bool:
    if len(ans) != n:
        return False
    for i in range(1, n + 1):
        expected = factorial(i) if i % 2 == 0 else sum_upto(i)
        if ans[i - 1] != expected:
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
