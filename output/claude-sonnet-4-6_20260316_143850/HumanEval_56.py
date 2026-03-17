
def precondition(input) -> bool:
    brackets = input[0]
    if not isinstance(brackets, str):
        return False
    for c in brackets:
        if c not in ('<', '>'):
            return False
    return True

def postcondition(input, output) -> bool:
    brackets = input[0]
    if not isinstance(output, bool):
        return False
    count = 0
    for c in brackets:
        if c == '<':
            count += 1
        else:
            count -= 1
        if count < 0:
            return output == False
    return output == (count == 0)

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
