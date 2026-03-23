def simplify_spec(x1, x2, n1, n2, result):
    if x2 * n2 == 0:
        return True
    return bool(result) == (((x1 * n1) % (x2 * n2)) == 0)

def _impl(x, n):
    x1, x2 = map(int, x.split("/"))
    n1, n2 = map(int, n.split("/"))
    return (x1 * n1) % (x2 * n2) == 0

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(simplify_spec(*input, output))

def simplify(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
