def tri(n: int) -> int:
    if n == 0:
        return 1
    elif n == 1:
        return 3
    else:
        if n % 2 == 0:
            return 1 + n // 2
        else:
            t_prev = 1 + (n - 1) // 2
            t_next = 1 + (n + 1) // 2
            return t_prev + tri(n - 2) + t_next

def problem_130_pre(n: int) -> bool:
    return True

def problem_130_spec(n: int, l: list) -> bool:
    if len(l) != n + 1:
        return False
    for i in range(n + 1):
        if l[i] != tri(i):
            return False
    return True

def _impl(n):
    if n == 0: return [1]
    if n == 1: return [1, 3]
    ans = [1, 3]
    for i in range(2, n + 1):
        if i % 2 == 0:
            ans.append(1 + i / 2)
        else:
            ans.append(ans[-1] + ans[-2] + 1 + (i + 1) / 2)
    return ans

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_130_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_130_spec(*input, output))

def tri(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
