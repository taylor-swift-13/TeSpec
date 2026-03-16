from typing import List

def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    s = input[0]
    if not isinstance(s, str):
        return False
    for ch in s:
        if ch != ' ' and ch not in ('(', ')'):
            return False
    return True

def postcondition(input, output):
    if not isinstance(output, list):
        return False
    s = input[0]
    stripped = ''.join(ch for ch in s if ch in ('(', ')'))

    # Helper to check primitive balanced parentheses string
    def is_primitive_balanced(t):
        if not isinstance(t, str):
            return False
        if t == '':
            return False
        count = 0
        for i, ch in enumerate(t):
            if ch == '(':
                count += 1
            elif ch == ')':
                count -= 1
            else:
                return False
            if count < 0:
                return False
            if count == 0 and i < len(t) - 1:
                return False
        return count == 0

    # Each element must be a primitive balanced parentheses string
    for elem in output:
        if not is_primitive_balanced(elem):
            return False

    # Concatenation must equal the input without spaces
    concat = ''.join(output)
    if concat != stripped:
        return False

    # If input has no parentheses, output should be empty
    if stripped == '' and len(output) != 0:
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
