def make_a_pile_spec(n, pile):
    if len(pile) != n:
        return False
    for i in range(n):
        if pile[i] != n + 2 * i:
            return False
    return True

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
