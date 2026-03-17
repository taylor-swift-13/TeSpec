from typing import List

def precondition(inputs: tuple) -> bool:
    if len(inputs) != 1:
        return False
    paren_string = inputs[0]
    if not isinstance(paren_string, str):
        return False
    if not all(c in '() ' for c in paren_string):
        return False
    for group in paren_string.split():
        count = 0
        for char in group:
            if char == '(':
                count += 1
            elif char == ')':
                count -= 1
            if count < 0:
                return False
        if count != 0:
            return False
    return True

def postcondition(inputs: tuple, output: list) -> bool:
    if len(inputs) != 1:
        return False
    paren_string = inputs[0]
    if not isinstance(output, (list, tuple)):
        return False
    groups = paren_string.split()
    if len(output) != len(groups):
        return False
    for group, max_depth in zip(groups, output):
        if not isinstance(max_depth, int):
            return False
        current_depth = 0
        actual_max_depth = 0
        for char in group:
            if char == '(':
                current_depth += 1
                if current_depth > actual_max_depth:
                    actual_max_depth = current_depth
            elif char == ')':
                current_depth -= 1
        if max_depth != actual_max_depth:
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
