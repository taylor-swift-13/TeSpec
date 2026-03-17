
def precondition(input):
    if len(input) != 1:
        return False
    text = input[0]
    if not isinstance(text, str):
        return False
    return True


def postcondition(input, output):
    if not isinstance(output, str):
        return False
    text = input[0]
    
    # Output should not contain spaces
    if ' ' in output:
        return False
    
    # Output should only contain characters from input plus underscores and dashes
    allowed_chars = set(text.replace(' ', '')) | {'_', '-'}
    if not all(c in allowed_chars for c in output):
        return False
    
    # Non-space characters should be preserved in order
    input_non_space = [c for c in text if c != ' ']
    output_non_space = [c for c in output if c not in ('_', '-')]
    if input_non_space != output_non_space:
        return False
    
    # Check that replacements are correct by simulating the transformation
    result = []
    i = 0
    while i < len(text):
        if text[i] == ' ':
            count = 0
            while i < len(text) and text[i] == ' ':
                count += 1
                i += 1
            if count > 2:
                result.append('-')
            else:
                result.append('_' * count)
        else:
            result.append(text[i])
            i += 1
    expected = ''.join(result)
    
    if output != expected:
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
