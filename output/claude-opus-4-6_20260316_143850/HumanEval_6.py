from typing import List

def precondition(input):
    paren_string = input[0]
    if not isinstance(paren_string, str):
        return False
    # String should only contain '(', ')', and spaces
    if not all(c in '() ' for c in paren_string):
        return False
    # Split into groups by spaces, filter empty strings
    groups = [g for g in paren_string.split() if g]
    # Each group should be a valid balanced parentheses string
    for group in groups:
        if len(group) == 0:
            return False
        # Check that group only contains parens
        if not all(c in '()' for c in group):
            return False
        # Check balanced parentheses
        depth = 0
        for c in group:
            if c == '(':
                depth += 1
            elif c == ')':
                depth -= 1
            if depth < 0:
                return False
        if depth != 0:
            return False
    return True


def postcondition(input, output):
    paren_string = input[0]
    if not isinstance(output, list):
        return False
    # Split into groups
    groups = [g for g in paren_string.split() if g]
    # Output length should match number of groups
    if len(output) != len(groups):
        return False
    # Each element should be a non-negative integer
    if not all(isinstance(x, int) and x >= 0 for x in output):
        return False
    # Verify each output is the maximum nesting depth of the corresponding group
    for i, group in enumerate(groups):
        max_depth = 0
        depth = 0
        for c in group:
            if c == '(':
                depth += 1
                if depth > max_depth:
                    max_depth = depth
            elif c == ')':
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
