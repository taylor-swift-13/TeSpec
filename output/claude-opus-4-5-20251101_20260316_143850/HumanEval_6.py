from typing import List

def precondition(input):
    if len(input) != 1:
        return False
    paren_string = input[0]
    if not isinstance(paren_string, str):
        return False
    # Check that string only contains valid characters: parentheses and spaces
    for char in paren_string:
        if char not in '() ':
            return False
    # Check that each space-separated group has balanced parentheses
    groups = paren_string.split()
    for group in groups:
        if len(group) == 0:
            continue
        # Check balanced parentheses
        depth = 0
        for char in group:
            if char == '(':
                depth += 1
            elif char == ')':
                depth -= 1
            if depth < 0:
                return False
        if depth != 0:
            return False
    return True


def postcondition(input, output):
    paren_string = input[0]
    # Output should be a list
    if not isinstance(output, list):
        return False
    # Get non-empty groups
    groups = [g for g in paren_string.split() if len(g) > 0]
    # Output length should match number of groups
    if len(output) != len(groups):
        return False
    # Each element should be a non-negative integer
    for i, val in enumerate(output):
        if not isinstance(val, int):
            return False
        if val < 0:
            return False
    # Verify each depth is correct
    for i, group in enumerate(groups):
        max_depth = 0
        current_depth = 0
        for char in group:
            if char == '(':
                current_depth += 1
                if current_depth > max_depth:
                    max_depth = current_depth
            elif char == ')':
                current_depth -= 1
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
