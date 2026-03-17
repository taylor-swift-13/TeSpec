
def precondition(lst_tuple):
    if not isinstance(lst_tuple, tuple) or len(lst_tuple) != 1:
        return False
    lst = lst_tuple[0]
    if not isinstance(lst, list) or len(lst) != 2:
        return False
    if not all(isinstance(s, str) for s in lst):
        return False
    for s in lst:
        for char in s:
            if char not in '()':
                return False
    return True

def postcondition(lst_tuple, output):
    if output not in ['Yes', 'No']:
        return False
    
    lst = lst_tuple[0]
    s1, s2 = lst[0], lst[1]
    
    def is_balanced(s):
        balance = 0
        for char in s:
            if char == '(':
                balance += 1
            elif char == ')':
                balance -= 1
            if balance < 0:
                return False
        return balance == 0
    
    possible = is_balanced(s1 + s2) or is_balanced(s2 + s1)
    expected = 'Yes' if possible else 'No'
    return output == expected

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
