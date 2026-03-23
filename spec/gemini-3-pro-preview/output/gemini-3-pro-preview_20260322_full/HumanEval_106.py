def factorial(n):
    if n == 0:
        return 1
    return n * factorial(n - 1)

def sum_1_to_n(n):
    if n == 0:
        return 0
    return n + sum_1_to_n(n - 1)

def f_spec(n, result):
    if len(result) != n:
        return False
    for i in range(n):
        logical_index = i + 1
        val = result[i] if i < len(result) else 0
        if logical_index % 2 == 0:
            if val != factorial(logical_index):
                return False
        else:
            if val != sum_1_to_n(logical_index):
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
