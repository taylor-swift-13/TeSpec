
def precondition(args):
    if len(args) != 1:
        return False
    text = args[0]
    if not isinstance(text, str):
        return False
    return True

def postcondition(args, output):
    if not isinstance(output, str):
        return False
    text = args[0]
    # Output should not contain spaces
    if ' ' in output:
        return False
    # Length should be reasonable (not longer than input, could be shorter or equal)
    # Each space or group of spaces becomes either _ or -
    # Check that non-space characters are preserved
    non_space_input = [c for c in text if c != ' ']
    non_space_output = [c for c in output if c not in ('_', '-')]
    # Non-space characters from input should appear in output in order
    # But underscores/dashes in original text complicate things, so just check length loosely
    if len(output) > len(text):
        return False
    return True

def _impl(text):
    """Given a string text, replace all spaces in it with underscores, 
    and if a string has more than 2 consecutive spaces, 
    then replace all consecutive spaces with - 

    fix_spaces("Example") == "Example"
    fix_spaces("Example 1") == "Example_1"
    fix_spaces(" Example 2") == "_Example_2"
    fix_spaces(" Example   3") == "_Example-3"
    """
    ans = text
    for i in range(len(text), 2, -1):
        ans = ans.replace(" " * i, "-")
    return ans.replace(" ", "_")

def fix_spaces(text):
    _input = (text,)
    assert precondition(_input)
    _output = _impl(text)
    assert postcondition(_input, _output)
    return _output
