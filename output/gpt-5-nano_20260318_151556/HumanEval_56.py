
def precondition(input) -> bool:
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    brackets = input[0]
    if not isinstance(brackets, str):
        return False
    return True

def postcondition(input, output) -> bool:
    if not isinstance(output, bool):
        return False
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    brackets = input[0]
    if not isinstance(brackets, str):
        return False
    balance = 0
    for ch in brackets:
        if ch == '<':
            balance += 1
        elif ch == '>':
            balance -= 1
            if balance < 0:
                return output is False
        else:
            return False
    expected = (balance == 0)
    return output is expected

def _impl(brackets: str):
    """
    brackets is a string of "<" and ">".
    return True if every opening bracket has a corresponding closing bracket.

    False
    True
    True
    False
    """
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
