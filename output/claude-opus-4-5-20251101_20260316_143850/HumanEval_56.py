
def precondition(input):
    if len(input) != 1:
        return False
    brackets = input[0]
    if not isinstance(brackets, str):
        return False
    for char in brackets:
        if char not in ('<', '>'):
            return False
    return True

def postcondition(input, output):
    if not isinstance(output, bool):
        return False
    brackets = input[0]
    # Verify the output by checking if brackets are balanced
    # '<' is opening, '>' is closing
    count = 0
    for char in brackets:
        if char == '<':
            count += 1
        elif char == '>':
            count -= 1
        if count < 0:
            # More closing brackets than opening at some point
            return output == False
    # At the end, count should be 0 for balanced brackets
    expected = (count == 0)
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
