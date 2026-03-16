from typing import List

def precondition(input) -> bool:
    try:
        if not isinstance(input, tuple):
            return False
        if len(input) < 1:
            return False
        ops = input[0]
        if not isinstance(ops, (list, tuple)):
            return False
        for x in ops:
            if not isinstance(x, int):
                return False
        return True
    except Exception:
        return False

def postcondition(input, output) -> bool:
    if not precondition(input):
        return True
    ops = input[0]
    bal = 0
    fell_below = False
    for x in ops:
        bal += x
        if bal < 0:
            fell_below = True
            break
    expected = fell_below
    return isinstance(output, bool) and output == expected

def _impl(operations: List[int]) -> bool:
    """You're given a list of deposit and withdrawal operations on a bank account that starts with
    zero balance. Your task is to detect if at any point the balance of account fallls below zero, and
    at that point function should return True. Otherwise it should return False.
    False
    True"""
    account = 0
    for operation in operations:
        account += operation
        if account < 0:
            return True
    return False

def below_zero(operations: List[int]) -> bool:
    _input = (operations,)
    assert precondition(_input)
    _output = _impl(operations)
    assert postcondition(_input, _output)
    return _output
