def problem_100_pre(n: int) -> bool:
    return n > 0

def problem_100_spec(n: int, out: list) -> bool:
    if len(out) != n:
        return False
    for i in range(n):
        if out[i] != n + 2 * i:
            return False
    return True

def _impl(n):
    ans, num = [], n
    for _ in range(n):
        ans.append(num)
        num += 2
    return ans

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_100_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_100_spec(*input, output))

def make_a_pile(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
