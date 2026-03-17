from typing import List

def precondition(args: tuple) -> bool:
    if not isinstance(args[0], str):
        return False
    paren_string = args[0].replace(" ", "")
    if not all(c in "()" for c in paren_string):
        return False
    
    balance = 0
    for char in paren_string:
        if char == '(':
            balance += 1
        elif char == ')':
            balance -= 1
        if balance < 0:
            return False
    return balance == 0

def postcondition(args: tuple, output: list) -> bool:
    if not isinstance(output, list):
        return False
    if not all(isinstance(s, str) for s in output):
        return False
    
    paren_string = args[0].replace(" ", "")
    if "".join(output) != paren_string:
        return False
    
    for group in output:
        if not group:
            return False
        balance = 0
        for i, char in enumerate(group):
            if char == '(':
                balance += 1
            elif char == ')':
                balance -= 1
            
            if balance < 0:
                return False
            # A single group must only close at the very end
            if balance == 0 and i != len(group) - 1:
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
