from typing import List

def precondition(input):
    paren_string = input[0]
    return isinstance(paren_string, str)

def postcondition(input, output):
    paren_string = input[0]
    if not isinstance(output, list):
        return False
    if not all(isinstance(s, str) for s in output):
        return False
    
    # Check that concatenating all strings in output gives original without spaces
    no_spaces = ''.join(paren_string.split())
    if ''.join(output) != no_spaces:
        return False
    
    # Check each string is balanced parentheses
    for s in output:
        balance = 0
        for ch in s:
            if ch == '(':
                balance += 1
            elif ch == ')':
                balance -= 1
                if balance < 0:
                    return False
        if balance != 0:
            return False
    
    # Check groups are not nested within each other
    # This is implied by the concatenation check above
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
