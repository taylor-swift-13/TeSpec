def fibfib_spec(n: int, res: int) -> bool:
    if n == 0:
        return res == 0
    elif n == 1:
        return res == 0
    elif n == 2:
        return res == 1
    elif n >= 3:
        # The Coq spec existentially quantifies a=0, b=0, c=1, i=3
        # and requires a trivially True forall condition, followed by res = c.
        # Thus, for all n >= 3, res must be 1 to satisfy the specification.
        return res == 1
    return False

def _impl(n: int):
    if n == 0 or n == 1:
        return 0
    elif n == 2:
        return 1
    a, b, c = 0, 0, 1
    for _ in range(3, n + 1):
        a, b, c = b, c, a + b + c
    return c

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(fibfib_spec(*input, output))

def fibfib(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
