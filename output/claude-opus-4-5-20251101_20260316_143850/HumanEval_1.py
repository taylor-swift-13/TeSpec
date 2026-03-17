from typing import List

def precondition(input):
    if len(input) != 1:
        return False
    paren_string = input[0]
    if not isinstance(paren_string, str):
        return False
    # Check that string only contains '(', ')', and spaces
    for char in paren_string:
        if char not in '() ':
            return False
    return True


def postcondition(input, output):
    paren_string = input[0]
    
    # Output must be a list
    if not isinstance(output, list):
        return False
    
    # All elements must be strings
    if not all(isinstance(s, str) for s in output):
        return False
    
    # Each group must be balanced and non-empty
    for group in output:
        if not group:
            return False
        # Should only contain parentheses (no spaces)
        if not all(c in '()' for c in group):
            return False
        # Must be balanced
        depth = 0
        for c in group:
            if c == '(':
                depth += 1
            elif c == ')':
                depth -= 1
            if depth < 0:
                return False
        if depth != 0:
            return False
        # Must be a single group (depth returns to 0 only at the end)
        depth = 0
        for i, c in enumerate(group):
            if c == '(':
                depth += 1
            elif c == ')':
                depth -= 1
            if depth == 0 and i < len(group) - 1:
                return False
    
    # Concatenation of output should equal input with spaces removed
    cleaned_input = paren_string.replace(' ', '')
    concatenated_output = ''.join(output)
    if concatenated_output != cleaned_input:
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
