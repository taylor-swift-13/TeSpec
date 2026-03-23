from typing import List

def below_zero_spec(operations, result):
    expected = False
    current_sum = 0
    for op in operations:
        current_sum += op
        if current_sum < 0:
            expected = True
            break
    return result == expected

def _impl(operations: List[int]) -> bool:
    account = 0
    for operation in operations:
        account += operation
        if account < 0:
            return True
    return False

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(below_zero_spec(*input, output))

def below_zero(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
