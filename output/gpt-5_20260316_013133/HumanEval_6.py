from typing import List

def precondition(input):
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    s = input[0]
    if not isinstance(s, str):
        return False
    groups = s.split()
    if len(groups) == 0:
        return False
    for g in groups:
        if g == "":
            return False
        for ch in g:
            if ch not in ("(", ")"):
                return False
        bal = 0
        for ch in g:
            if ch == "(":
                bal += 1
            else:
                bal -= 1
            if bal < 0:
                return False
        if bal != 0:
            return False
    return True

def postcondition(input, output):
    if not precondition(input):
        return True
    s = input[0]
    groups = s.split()
    def max_depth(g):
        bal = 0
        m = 0
        for ch in g:
            if ch == "(":
                bal += 1
                if bal > m:
                    m = bal
            else:
                bal -= 1
        return m
    if not isinstance(output, (list, tuple)):
        return False
    if len(output) != len(groups):
        return False
    for v in output:
        if not isinstance(v, int) or v < 0:
            return False
    expected = [max_depth(g) for g in groups]
    return list(output) == expected

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
