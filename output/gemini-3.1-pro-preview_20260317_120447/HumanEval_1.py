from typing import List

def precondition(inp: tuple) -> bool:
    if len(inp) != 1:
        return False
    paren_string = inp[0]
    if not isinstance(paren_string, str):
        return False
    balance = 0
    for char in paren_string:
        if char == '(':
            balance += 1
        elif char == ')':
            balance -= 1
        elif char != ' ':
            return False
        if balance < 0:
            return False
    return balance == 0

def postcondition(inp: tuple, out) -> bool:
    paren_string = inp[0]
    if not isinstance(out, list):
        return False
    if not all(isinstance(x, str) for x in out):
        return False
    
    if "".join(out).replace(" ", "") != paren_string.replace(" ", ""):
        return False
        
    for s in out:
        s_clean = s.replace(" ", "")
        if not s_clean:
            return False
        balance = 0
        for i, char in enumerate(s_clean):
            if char == '(':
                balance += 1
            elif char == ')':
                balance -= 1
            else:
                return False
            if balance < 0:
                return False
            if balance == 0 and i != len(s_clean) - 1:
                return False
        if balance != 0:
            return False
            
    return True

def _impl(paren_string: str) -> List[str]:
    """Input to this function is a string containing multiple groups of nested parentheses. Your goal is to
    separate those group into separate strings and return the list of those.
    Separate groups are balanced (each open brace is properly closed) and not nested within each other
    Ignore any spaces in the input string.
    ['()', '(())', '(()())']"""
    cnt, group, results = 0, "", []
    for ch in paren_string:
        if ch == "(": cnt += 1
        if ch == ")": cnt -= 1
        if ch != " ": group += ch
        if cnt == 0:
            if group != "": results.append(group)
            group = ""
    return results

def separate_paren_groups(paren_string: str) -> List[str]:
    _input = (paren_string,)
    assert precondition(_input)
    _output = _impl(paren_string)
    assert postcondition(_input, _output)
    return _output
