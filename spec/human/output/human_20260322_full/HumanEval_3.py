from typing import List

def problem_3_pre(l):
    return True

def problem_3_spec(l, output):
    balance = 0
    below_zero = False
    for x in l:
        balance += x
        if balance < 0:
            below_zero = True
            break
    return below_zero == output

def _impl(operations: List[int]) -> bool:
    account = 0
    for operation in operations:
        account += operation
        if account < 0:
            return True
    return False

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_3_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_3_spec(*input, output))

def below_zero(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
