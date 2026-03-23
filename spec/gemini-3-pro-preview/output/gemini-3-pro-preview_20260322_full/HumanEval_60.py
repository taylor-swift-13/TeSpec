def sum_to_n_spec(n, res):
    return res == (n + 1) * n // 2

def _impl(n: int):
    return (n + 1) * n // 2

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(sum_to_n_spec(*input, output))

def sum_to_n(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
