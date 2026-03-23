def make_a_pile_aux(n, current, fuel):
    result = []
    for _ in range(fuel):
        result.append(current)
        current += 2
    return result

def make_a_pile_spec(n, result):
    if n <= 0:
        return True
    if len(result) != n:
        return False
    for i in range(n):
        if result[i] != n + 2 * i:
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
