from typing import List

def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    ops = input[0]
    if not isinstance(ops, list):
        return False
    for x in ops:
        if not isinstance(x, int):
            return False
    return True

def postcondition(input, output):
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    ops = input[0]
    if not isinstance(ops, list):
        return False
    for x in ops:
        if not isinstance(x, int):
            return False
    if not isinstance(output, bool):
        return False
    bal = 0
    for v in ops:
        bal += v
        if bal < 0:
            return output == True
    return output == False

def _impl(operations: List[int]) -> bool:
    """
    You're given a list of deposit and withdrawal operations on a bank account that starts with
    zero balance. Your task is to detect if at any point the balance of account fallls below zero, and
    at that point function should return True. Otherwise it should return False.
    False
    True
    """
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
