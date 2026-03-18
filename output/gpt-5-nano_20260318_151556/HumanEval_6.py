from typing import List

def precondition(input) -> bool:
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    paren_string = input[0]
    if not isinstance(paren_string, str):
        return False
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    s = input[0]
    if not isinstance(s, str):
        return False
    if not isinstance(output, (list, tuple)):
        return False

    groups = [g for g in s.split() if g != ""]
    if len(output) != len(groups):
        return False

    expected = []
    for g in groups:
        depth = 0
        max_depth = 0
        for ch in g:
            if ch == '(':
                depth += 1
                if depth > max_depth:
                    max_depth = depth
            elif ch == ')':
                depth -= 1
        expected.append(max_depth)

    for val, exp in zip(output, expected):
        if not isinstance(val, int):
            return False
        if val != exp:
            return False
        if val < 0:
            return False

    return True

def _impl(paren_string: str) -> List[int]:
    """
    Input to this function is a string represented multiple groups for nested parentheses separated by spaces.
    For each of the group, output the deepest level of nesting of parentheses.
    E.g. (()()) has maximum two levels of nesting while ((())) has three.

    [2, 3, 1, 3]
    """
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
