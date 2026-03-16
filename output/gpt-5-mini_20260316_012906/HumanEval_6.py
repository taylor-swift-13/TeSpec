from typing import List

def precondition(input):
    # input should be a tuple with one element: the parentheses string
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    s = input[0]
    if not isinstance(s, str):
        return False
    # allow only parentheses and spaces (space ASCII 32)
    for ch in s:
        if ch not in ("(", ")", " "):
            return False
    return True

def postcondition(input, output):
    # input is a tuple with one string element (assumed checked by precondition)
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    s = input[0]
    # output must be a list of integers
    if not isinstance(output, list):
        return False
    # compute expected depths: split on whitespace (like str.split())
    groups = s.split()
    expected = []
    for g in groups:
        depth = 0
        maxd = 0
        for ch in g:
            if ch == "(":
                depth += 1
                if depth > maxd:
                    maxd = depth
            elif ch == ")":
                depth -= 1
            else:
                # if there are other chars, cannot validate
                return False
        expected.append(maxd)
    # Now compare lengths and values
    if len(expected) != len(output):
        return False
    for e, o in zip(expected, output):
        if not isinstance(o, int):
            return False
        if o != e:
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
