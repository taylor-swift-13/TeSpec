
def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    s = input[0]
    if not isinstance(s, str):
        return False
    for ch in s:
        if ch not in '()':
            return False
    return True

def postcondition(input, output):
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    s = input[0]
    if not isinstance(s, str):
        return False
    bal = 0
    for ch in s:
        if ch == '(':
            bal += 1
        elif ch == ')':
            bal -= 1
            if bal < 0:
                return (not bool(output))
        else:
            return False
    expected = (bal == 0)
    return (bool(output) == expected)

def _impl(brackets: str):
    """
    brackets is a string of "(" and ")".
    return True if every opening bracket has a corresponding closing bracket.

    False
    True
    True
    False
    """
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
