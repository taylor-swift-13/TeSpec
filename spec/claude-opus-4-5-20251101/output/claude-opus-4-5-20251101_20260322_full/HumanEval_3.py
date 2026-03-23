from typing import List

def prefix_sums(ops, acc):
    res = []
    for op in ops:
        acc += op
        res.append(acc)
    return res

def below_zero_spec(operations, result):
    balances = prefix_sums(operations, 0)
    has_negative = any(bal < 0 for bal in balances)
    return bool(result) == has_negative

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
