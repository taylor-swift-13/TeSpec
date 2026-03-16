from typing import List

def precondition(input):
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    s = input[0]
    if not isinstance(s, str):
        return False
    for ch in s:
        if ch not in ' ()':
            return False
    t = s.replace(' ', '')
    depth = 0
    for ch in t:
        if ch == '(':
            depth += 1
        elif ch == ')':
            depth -= 1
            if depth < 0:
                return False
        else:
            return False
    if depth != 0:
        return False
    return True

def postcondition(input, output):
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    if not isinstance(output, list):
        return False
    s = input[0]
    if not isinstance(s, str):
        return False
    t = s.replace(' ', '')
    for ch in t:
        if ch not in '()':
            return False
    groups = []
    i = 0
    n = len(t)
    while i < n:
        if t[i] != '(':
            return False
        depth = 1
        j = i + 1
        while j < n and depth > 0:
            if t[j] == '(':
                depth += 1
            elif t[j] == ')':
                depth -= 1
            else:
                return False
            j += 1
        if depth != 0:
            return False
        groups.append(t[i:j])
        i = j
    return output == groups

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
