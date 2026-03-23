def factorial(n: int) -> int:
    if n == 0:
        return 1
    return n * factorial(n - 1)

def sum_1_to_n(n: int) -> int:
    if n == 0:
        return 0
    return n + sum_1_to_n(n - 1)

def f_element(i: int) -> int:
    if i % 2 == 0:
        return factorial(i)
    else:
        return sum_1_to_n(i)

def f_list(n: int) -> list:
    if n == 0:
        return []
    return f_list(n - 1) + [f_element(n)]

def f_spec(n: int, result: list) -> bool:
    if result != f_list(n):
        return False
    if len(result) != n:
        return False
    for i in range(1, n + 1):
        val = result[i - 1] if 0 <= i - 1 < len(result) else 0
        if val != f_element(i):
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
