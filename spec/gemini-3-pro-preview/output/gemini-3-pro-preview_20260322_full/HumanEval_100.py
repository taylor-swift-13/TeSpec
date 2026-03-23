def make_a_pile_spec(n: int, res: list) -> bool:
    expected = [n + 2 * i for i in range(max(0, n))]
    return res == expected

def _impl(n):
    ans, num = [], n
    for _ in range(n):
        ans.append(num)
        num += 2
    return ans

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(make_a_pile_spec(*input, output))

def make_a_pile(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
