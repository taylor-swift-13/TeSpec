from typing import List

def precondition(input):
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    paren_string = input[0]
    if not isinstance(paren_string, str):
        return False
    stripped = paren_string.replace(' ', '')
    for ch in stripped:
        if ch not in ('(', ')'):
            return False
    depth = 0
    for ch in stripped:
        if ch == '(':
            depth += 1
        else:
            depth -= 1
        if depth < 0:
            return False
    if depth != 0:
        return False
    return True

def postcondition(input, output):
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    paren_string = input[0]
    if not isinstance(paren_string, str):
        return False
    if not isinstance(output, list):
        return False
    stripped = paren_string.replace(' ', '')
    groups = []
    i = 0
    n = len(stripped)
    while i < n:
        if stripped[i] != '(':
            return False
        depth = 0
        j = i
        while j < n:
            if stripped[j] == '(':
                depth += 1
            else:
                depth -= 1
            if depth == 0:
                groups.append(stripped[i:j+1])
                i = j + 1
                break
            j += 1
        else:
            return False
    if ''.join(groups) != stripped:
        return False
    if len(output) != len(groups):
        return False
    for o, g in zip(output, groups):
        if not isinstance(o, str) or o != g:
            return False
    return True

def _impl(paren_string: str) -> List[str]:
    """
    Input to this function is a string containing multiple groups of nested parentheses. Your goal is to
    separate those group into separate strings and return the list of those.
    Separate groups are balanced (each open brace is properly closed) and not nested within each other
    Ignore any spaces in the input string.
    ['()', '(())', '(()())']
    """
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
