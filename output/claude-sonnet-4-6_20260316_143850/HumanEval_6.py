from typing import List

def precondition(input) -> bool:
    if len(input) != 1:
        return False
    paren_string = input[0]
    if not isinstance(paren_string, str):
        return False
    # Allow empty string
    if paren_string == "":
        return True
    # Check that the string contains only '(', ')', and spaces
    for ch in paren_string:
        if ch not in ('(', ')', ' '):
            return False
    # Check that each group (split by spaces) has balanced parentheses
    groups = paren_string.split(' ')
    for group in groups:
        if group == "":
            continue
        depth = 0
        for ch in group:
            if ch == '(':
                depth += 1
            elif ch == ')':
                depth -= 1
                if depth < 0:
                    return False
        if depth != 0:
            return False
    return True


def postcondition(input, output) -> bool:
    if not isinstance(output, list):
        return False
    paren_string = input[0]
    if paren_string == "":
        return output == []
    groups = [g for g in paren_string.split(' ') if g != ""]
    if len(output) != len(groups):
        return False
    for i, group in enumerate(groups):
        if not isinstance(output[i], int):
            return False
        if output[i] < 0:
            return False
        # Compute expected max depth
        max_depth = 0
        depth = 0
        for ch in group:
            if ch == '(':
                depth += 1
                if depth > max_depth:
                    max_depth = depth
            elif ch == ')':
                depth -= 1
        if output[i] != max_depth:
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
