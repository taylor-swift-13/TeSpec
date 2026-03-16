
def precondition(input):
    brackets, = input
    if not isinstance(brackets, str):
        return False
    for c in brackets:
        if c not in "()":
            return False
    return True

def postcondition(input, output):
    if not isinstance(output, bool):
        return False
    brackets, = input
    if not precondition(input):
        return False
    # Conservative check: if output is True, brackets must be balanced
    if output:
        count = 0
        for c in brackets:
            if c == '(':
                count += 1
            else:  # c == ')'
                count -= 1
                if count < 0:
                    return False
        return count == 0
    # If output is False, we can't guarantee anything about brackets
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
