from typing import List

def precondition(input):
    operations = input[0]
    return isinstance(operations, list) and all(isinstance(x, int) for x in operations)

def postcondition(input, output):
    operations = input[0]
    balance = 0
    expected = False
    for op in operations:
        balance += op
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
