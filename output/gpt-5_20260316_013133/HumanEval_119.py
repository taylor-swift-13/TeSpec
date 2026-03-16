
def precondition(input):
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    lst = input[0]
    if not isinstance(lst, list) or len(lst) != 2:
        return False
    for s in lst:
        if not isinstance(s, str):
            return False
        for ch in s:
            if ch not in ("(", ")"):
                return False
    return True

def postcondition(input, output):
    if not precondition(input):
        return True

    def is_balanced(s):
        bal = 0
        for ch in s:
            if ch == "(":
                bal += 1
            else:
                bal -= 1
            if bal < 0:
                return False
        return bal == 0

    lst = input[0]
    s1, s2 = lst[0], lst[1]
    expected_yes = is_balanced(s1 + s2) or is_balanced(s2 + s1)
    expected = "Yes" if expected_yes else "No"
    return isinstance(output, str) and output == expected

def _impl(lst):
    """You are given a list of two strings, both strings consist of open
    parentheses '(' or close parentheses ')' only.
    Your job is to check if it is possible to concatenate the two strings in
    some order, that the resulting string will be good.
    A string S is considered to be good if and only if all parentheses in S
    are balanced. For example: the string '(())()' is good, while the string
    '())' is not.
    Return 'Yes' if there's a way to make a good string, and return 'No' otherwise.

    Examples:
    match_parens(['()(', ')']) == 'Yes'
    match_parens([')', ')']) == 'No'"""
    def valid_parens(s: str) -> bool:
        cnt = 0
        for ch in s:
            cnt = cnt + 1 if ch == "(" else cnt - 1
            if cnt < 0: return False
        return cnt == 0
    return "Yes" if valid_parens(lst[0] + lst[1]) or valid_parens(lst[1] + lst[0]) else "No"

def match_parens(lst):
    _input = (lst,)
    assert precondition(_input)
    _output = _impl(lst)
    assert postcondition(_input, _output)
    return _output
