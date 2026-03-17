from typing import List

def precondition(input):
    paren_string = input[0]
    if not isinstance(paren_string, str):
        return False
    # Check that string only contains '(', ')', and spaces
    for c in paren_string:
        if c not in '() ':
            return False
    # Check that parentheses are balanced overall
    count = 0
    for c in paren_string:
        if c == '(':
            count += 1
        elif c == ')':
            count -= 1
        if count < 0:
            return False
    if count != 0:
        return False
    return True


def postcondition(input, output):
    paren_string = input[0]
    if not isinstance(output, list):
        return False
    # Each element must be a string
    for item in output:
        if not isinstance(item, str):
            return False
    # Each group must be non-empty
    for item in output:
        if len(item) == 0:
            return False
    # Each group must be balanced and not contain spaces
    for item in output:
        for c in item:
            if c not in '()':
                return False
        count = 0
        for c in item:
            if c == '(':
                count += 1
            elif c == ')':
                count -= 1
            if count < 0:
                return False
        if count != 0:
            return False
    # Each group must start with '(' and end with ')'
    for item in output:
        if item[0] != '(' or item[-1] != ')':
            return False
    # The concatenation of all groups (ignoring spaces) must equal the input without spaces
    input_no_spaces = paren_string.replace(' ', '')
    output_concat = ''.join(output)
    if input_no_spaces != output_concat:
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
