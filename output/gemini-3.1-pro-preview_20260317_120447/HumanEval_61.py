
def precondition(inputs: tuple) -> bool:
    if len(inputs) != 1:
        return False
    brackets = inputs[0]
    if not isinstance(brackets, str):
        return False
    return all(c in "()" for c in brackets)

def postcondition(inputs: tuple, output) -> bool:
    if len(inputs) != 1:
        return False
    brackets = inputs[0]
    if not isinstance(output, bool):
        return False
    
    count = 0
    for c in brackets:
        if c == '(':
            count += 1
        elif c == ')':
            count -= 1
        if count < 0:
            return output is False
            
    return output is (count == 0)

def _impl(brackets: str):
    """brackets is a string of "(" and ")".
    return True if every opening bracket has a corresponding closing bracket.

    False
    True
    True
    False"""
    cnt = 0
    for x in brackets:
        if x == "(": cnt += 1
        if x == ")": cnt -= 1
        if cnt < 0: return False
    return cnt == 0

def correct_bracketing(brackets: str):
    _input = (brackets,)
    assert precondition(_input)
    _output = _impl(brackets)
    assert postcondition(_input, _output)
    return _output
