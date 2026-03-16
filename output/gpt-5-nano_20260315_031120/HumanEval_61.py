
def precondition(input) -> bool:
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    brackets = input[0]
    if not isinstance(brackets, str):
        return False
    if any((c != '(' and c != ')') for c in brackets):
        return False
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    brackets = input[0]
    if not isinstance(brackets, str):
        return False
    if any((c != '(' and c != ')') for c in brackets):
        return False
    if not isinstance(output, bool):
        return False

    balance = 0
    ok = True
    for ch in brackets:
        if ch == '(':
            balance += 1
        else:  # ch == ')'
            balance -= 1
            if balance < 0:
                ok = False
                break
    balanced = ok and balance == 0
    return output == balanced

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
