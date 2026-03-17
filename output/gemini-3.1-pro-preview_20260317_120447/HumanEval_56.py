
def precondition(inputs: tuple) -> bool:
    if len(inputs) != 1:
        return False
    brackets = inputs[0]
    if not isinstance(brackets, str):
        return False
    return True

def postcondition(inputs: tuple, output: bool) -> bool:
    if len(inputs) != 1:
        return False
    brackets = inputs[0]
    if not isinstance(output, bool):
        return False
    
    balance = 0
    is_valid = True
    for char in brackets:
        if char == '<':
            balance += 1
        elif char == '>':
            balance -= 1
        
        if balance < 0:
            is_valid = False
            break
            
    if balance != 0:
        is_valid = False
        
    return output == is_valid

def _impl(brackets: str):
    """brackets is a string of "<" and ">".
    return True if every opening bracket has a corresponding closing bracket.

    False
    True
    True
    False"""
    cnt = 0
    for x in brackets:
        if x == "<": cnt += 1
        if x == ">": cnt -= 1
        if cnt < 0: return False
    return cnt == 0

def correct_bracketing(brackets: str):
    _input = (brackets,)
    assert precondition(_input)
    _output = _impl(brackets)
    assert postcondition(_input, _output)
    return _output
