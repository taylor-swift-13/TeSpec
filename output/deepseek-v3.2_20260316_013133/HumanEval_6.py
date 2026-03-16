from typing import List

def precondition(input):
    paren_string = input[0]
    if not isinstance(paren_string, str):
        return False
    stack = 0
    for ch in paren_string:
        if ch == '(':
            stack += 1
        elif ch == ')':
            if stack == 0:
                return False
            stack -= 1
        elif ch == ' ':
            if stack != 0:
                return False
        else:
            return False
    return stack == 0

def postcondition(input, output):
    if not isinstance(output, list):
        return False
    paren_string = input[0]
    groups = paren_string.split()
    if len(groups) != len(output):
        return False
    for i, group in enumerate(groups):
        if not isinstance(output[i], int):
            return False
        if output[i] < 0:
            return False
        stack = 0
        max_depth = 0
        for ch in group:
            if ch == '(':
                stack += 1
                if stack > max_depth:
                    max_depth = stack
            elif ch == ')':
                stack -= 1
        if max_depth != output[i]:
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
