
def precondition(input):
    brackets = input[0]
    return isinstance(brackets, str) and all(c in "<>" for c in brackets)

def postcondition(input, output):
    brackets = input[0]
    balance = 0
    for char in brackets:
        if char == "<":
            balance += 1
        else:
            balance -= 1
        if balance < 0:
            return output == False
    return output == (balance == 0)

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
