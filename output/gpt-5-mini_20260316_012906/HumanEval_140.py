
def precondition(input):
    # input must be a tuple with one positional argument which is a string
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    text = input[0]
    return isinstance(text, str)

def postcondition(input, output):
    # If precondition does not hold, do not enforce postcondition here
    if not precondition(input):
        return True
    text = input[0]
    # output must be a string
    if not isinstance(output, str):
        return False
    # Build expected output according to specification:
    # - sequences of spaces of length > 2 are replaced by a single '-'
    # - other spaces are replaced by the same number of underscores
    expected_parts = []
    i = 0
    n = len(text)
    while i < n:
        ch = text[i]
        if ch == ' ':
            j = i
            while j < n and text[j] == ' ':
                j += 1
            run_len = j - i
            if run_len > 2:
                expected_parts.append('-')
            else:
                expected_parts.append('_' * run_len)
            i = j
        else:
            expected_parts.append(ch)
            i += 1
    expected = ''.join(expected_parts)
    # The output must exactly match the expected transformation
    return output == expected

def _impl(text):
    """Given a string text, replace all spaces in it with underscores, 
    and if a string has more than 2 consecutive spaces, 
    then replace all consecutive spaces with - 

    fix_spaces("Example") == "Example"
    fix_spaces("Example 1") == "Example_1"
    fix_spaces(" Example 2") == "_Example_2"
    fix_spaces(" Example   3") == "_Example-3""""
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
