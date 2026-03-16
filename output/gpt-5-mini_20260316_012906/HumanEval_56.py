
def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    s = input[0]
    if not isinstance(s, str):
        return False
    for ch in s:
        if ch not in ("<", ">"):
            return False
    return True

def postcondition(input, output):
    # If precondition not met, do not enforce postcondition here.
    if not precondition(input):
        return True
    if not isinstance(output, bool):
        return False
    s = input[0]
    # Check that every opening '<' has a corresponding closing '>' later.
    opens = 0
    for ch in s:
        if ch == "<":
            opens += 1
        elif ch == ">":
            if opens > 0:
                opens -= 1
    all_openings_closed = (opens == 0)
    # If function claims True, the property must hold. If False, accept either.
    if output:
        return all_openings_closed
    return True

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
