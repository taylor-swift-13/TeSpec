from typing import List

def precondition(input):
    paren_string = input[0]
    if not isinstance(paren_string, str):
        return False
    # String should only contain '(', ')', and spaces
    for ch in paren_string:
        if ch not in ('(', ')', ' '):
            return False
    # After removing spaces, parentheses should be balanced overall
    stripped = paren_string.replace(' ', '')
    depth = 0
    for ch in stripped:
        if ch == '(':
            depth += 1
        elif ch == ')':
            depth -= 1
        if depth < 0:
            return False
    if depth != 0:
        return False
    return True


def postcondition(input, output):
    paren_string = input[0]
    if not isinstance(output, list):
        return False
    # Each element should be a string
    for group in output:
        if not isinstance(group, str):
            return False
    # Each group should be balanced and non-empty
    for group in output:
        if len(group) == 0:
            return False
        depth = 0
        for ch in group:
            if ch == '(':
                depth += 1
            elif ch == ')':
                depth -= 1
            if depth < 0:
                return False
        if depth != 0:
            return False
    # Each group should be a top-level group (starts at depth 0, ends at depth 0, 
    # and only returns to depth 0 at the very end)
    for group in output:
        depth = 0
        for i, ch in enumerate(group):
            if ch == '(':
                depth += 1
            elif ch == ')':
                depth -= 1
            if depth == 0 and i < len(group) - 1:
                return False
    # Concatenation of all groups should equal the stripped input
    stripped = paren_string.replace(' ', '')
    concatenated = ''.join(output)
    if concatenated != stripped:
        return False
    # No group should contain spaces
    for group in output:
        if ' ' in group:
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
