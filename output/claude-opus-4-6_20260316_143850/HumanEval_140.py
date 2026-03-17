
def precondition(input):
    args = input
    if len(args) != 1:
        return False
    text = args[0]
    if not isinstance(text, str):
        return False
    return True


def postcondition(input, output):
    text = input[0]
    if not isinstance(output, str):
        return False
    
    # Output should only contain characters from original text (with spaces replaced by _ or -)
    # No spaces should remain in output
    if ' ' in output:
        return False
    
    # The non-space characters should be preserved in order
    original_non_space = [c for c in text if c != ' ']
    output_non_space = [c for c in output if c not in ('_', '-')]
    if original_non_space != output_non_space:
        return False
    
    # Output should only contain original non-space chars plus '_' and '-'
    allowed_chars = set(text.replace(' ', '')) | {'_', '-'}
    if not all(c in allowed_chars for c in output):
        return False
    
    # Reconstruct: split text into groups of spaces and non-spaces, verify replacements
    # Each consecutive group of spaces of length > 2 should become '-'
    # Each consecutive group of spaces of length 1 or 2 should become that many '_'
    import re
    parts = re.findall(r' +|[^ ]+', text)
    reconstructed = ''
    for part in parts:
        if part[0] == ' ':
            if len(part) > 2:
                reconstructed += '-'
            else:
                reconstructed += '_' * len(part)
        else:
            reconstructed += part
    
    if output != reconstructed:
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
