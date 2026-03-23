def string_of_nat(n: int) -> str:
    return str(n)

def seq_string(start: int, limit: int) -> str:
    return " ".join(str(i) for i in range(start, start + limit + 1))

def string_sequence_impl(n: int) -> str:
    return seq_string(0, n)

def problem_15_pre(n: int) -> bool:
    return True

def problem_15_spec(n: int, output: str) -> bool:
    return output == string_sequence_impl(n)

def _impl(n: int) -> str:
    return " ".join(map(str, range(n + 1)))

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_15_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_15_spec(*input, output))

def string_sequence(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
