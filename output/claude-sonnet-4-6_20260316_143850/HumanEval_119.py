
def precondition(args):
    if len(args) != 1:
        return False
    lst = args[0]
    if not isinstance(lst, list):
        return False
    if len(lst) != 2:
        return False
    for s in lst:
        if not isinstance(s, str):
            return False
        for c in s:
            if c not in ('(', ')'):
                return False
    return True


def postcondition(args, output):
    if not isinstance(output, str):
        return False
    if output not in ('Yes', 'No'):
        return False
    lst = args[0]
    
    def is_balanced(s):
        count = 0
        for c in s:
            if c == '(':
                count += 1
            else:
                count -= 1
            if count < 0:
                return False
        return count == 0
    
    s1 = lst[0] + lst[1]
    s2 = lst[1] + lst[0]
    
    can_yes = is_balanced(s1) or is_balanced(s2)
    
    if can_yes:
        return output == 'Yes'
    else:
        return output == 'No'

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
