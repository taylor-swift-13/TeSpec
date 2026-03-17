from typing import List

def precondition(input):
    operations = input[0]
    # operations must be a list of integers
    if not isinstance(operations, list):
        return False
    for op in operations:
        if not isinstance(op, int):
            return False
    return True


def postcondition(input, output):
    operations = input[0]
    # output must be a boolean
    if not isinstance(output, bool):
        return False
    # Verify correctness: check if balance ever goes below zero
    balance = 0
    went_below_zero = False
    for op in operations:
        balance += op
        if balance < 0:
            went_below_zero = True
            break
    return output == went_below_zero

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
