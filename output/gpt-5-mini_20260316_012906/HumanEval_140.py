
def precondition(input) -> bool:
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    text = input[0]
    return isinstance(text, str)

def postcondition(input, output) -> bool:
    if not precondition(input):
        return False
    text = input[0]
    if not isinstance(output, str):
        return False
    # build expected output: runs of spaces of length >=3 -> '-' else each space -> '_'
    n = len(text)
    i = 0
    parts = []
    while i < n:
        ch = text[i]
        if ch == ' ':
            j = i + 1
            while j < n and text[j] == ' ':
                j += 1
            run_len = j - i
            if run_len >= 3:
                parts.append('-')
            else:
                parts.append('_' * run_len)
            i = j
        else:
            parts.append(ch)
            i += 1
    expected = ''.join(parts)
    return output == expected

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
