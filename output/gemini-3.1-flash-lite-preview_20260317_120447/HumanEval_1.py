from typing import List

def precondition(input):
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    paren_string = input[0]
    if not isinstance(paren_string, str):
        return False
    return True

def postcondition(input, output):
    if not isinstance(output, list):
        return False
    for s in output:
        if not isinstance(s, str):
            return False
        balance = 0
        for char in s:
            if char == '(':
                balance += 1
            elif char == ')':
                balance -= 1
            if balance < 0:
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
