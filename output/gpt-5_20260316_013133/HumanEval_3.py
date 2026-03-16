from typing import List

def precondition(input) -> bool:
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    ops = input[0]
    if not isinstance(ops, list):
        return False
    for x in ops:
        if isinstance(x, bool) or not isinstance(x, int):
            return False
    return True

def postcondition(input, output) -> bool:
    if not isinstance(output, bool):
        return False
    ops = input[0]
    balance = 0
    expected = False
    for x in ops:
        balance += x
        if balance < 0:
            expected = True
            break
    return output == expected

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
