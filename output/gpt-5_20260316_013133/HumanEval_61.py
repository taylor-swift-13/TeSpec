
def precondition(input) -> bool:
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    s = input[0]
    if not isinstance(s, str):
        return False
    for ch in s:
        if ch not in ("(", ")"):
            return False
    return True

def postcondition(input, output) -> bool:
    if not isinstance(output, bool):
        return False
    if not precondition(input):
        return True
    s = input[0]
    opens = s.count("(")
    closes = s.count(")")
    if output:
        if opens > closes:
            return False
    return True

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
