from typing import List

def precondition(input):
    paren_string = input[0]
    if not isinstance(paren_string, str):
        return False
    groups = paren_string.split(' ')
    for group in groups:
        if not group:
            continue
        balance = 0
        for char in group:
            if char == '(':
                balance += 1
            elif char == ')':
                balance -= 1
            if balance < 0:
                return False
        if balance != 0:
            return False
    return True

def postcondition(input, output):
    if not isinstance(output, int):
        return False
    if output < 0:
        return False
    return True

def _impl(paren_string: str) -> List[int]:
    """Input to this function is a string represented multiple groups for nested parentheses separated by spaces.
    For each of the group, output the deepest level of nesting of parentheses.
    E.g. (()()) has maximum two levels of nesting while ((())) has three.

    [2, 3, 1, 3]"""
    def count_depth(s: str) -> int:
        max_depth, cnt = 0, 0
        for ch in s:
            if ch == "(": cnt += 1
            if ch == ")": cnt -= 1
            max_depth = max(max_depth, cnt)
        return max_depth

    return [count_depth(s) for s in paren_string.split(" ") if s != ""]

def parse_nested_parens(paren_string: str) -> List[int]:
    _input = (paren_string,)
    assert precondition(_input)
    _output = _impl(paren_string)
    assert postcondition(_input, _output)
    return _output
