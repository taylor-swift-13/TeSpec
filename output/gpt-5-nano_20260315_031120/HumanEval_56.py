
def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    s = input[0]
    if not isinstance(s, str):
        return False
    for c in s:
        if c not in "<>":
            return False
    return True

def postcondition(input, output):
    if not isinstance(output, bool):
        return False
    if not precondition(input):
        return False
    s = input[0]
    depth = 0
    valid = True
    for ch in s:
        if ch == '<':
            depth += 1
        else:  # ch == '>'
            depth -= 1
            if depth < 0:
                valid = False
                break
    expected = valid and (depth == 0)
    return output == expected

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
