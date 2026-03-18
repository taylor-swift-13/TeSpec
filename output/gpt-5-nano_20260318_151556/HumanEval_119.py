
def precondition(input):
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    lst = input[0]
    if not isinstance(lst, (list, tuple)) or len(lst) != 2:
        return False
    a, b = lst
    if not isinstance(a, str) or not isinstance(b, str):
        return False
    if any(ch not in '()' for ch in a) or any(ch not in '()' for ch in b):
        return False
    return True

def postcondition(input, output):
    if not isinstance(output, str):
        return False
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    lst = input[0]
    if not isinstance(lst, (list, tuple)) or len(lst) != 2:
        # invalid input; cannot verify
        return True
    s1, s2 = lst
    if not isinstance(s1, str) or not isinstance(s2, str):
        return True
    if any(ch not in '()' for ch in s1) or any(ch not in '()' for ch in s2):
        return True

    def is_balanced(s):
        bal = 0
        for ch in s:
            if ch == '(':
                bal += 1
            else:
                bal -= 1
            if bal < 0:
                return False
        return bal == 0

    ok = is_balanced(s1 + s2) or is_balanced(s2 + s1)
    expected = 'Yes' if ok else 'No'
    return output == expected

def _impl(lst):
    """
    You are given a list of two strings, both strings consist of open
    parentheses '(' or close parentheses ')' only.
    Your job is to check if it is possible to concatenate the two strings in
    some order, that the resulting string will be good.
    A string S is considered to be good if and only if all parentheses in S
    are balanced. For example: the string '(())()' is good, while the string
    '())' is not.
    Return 'Yes' if there's a way to make a good string, and return 'No' otherwise.

    Examples:
    match_parens(['()(', ')']) == 'Yes'
    match_parens([')', ')']) == 'No'
    """
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
