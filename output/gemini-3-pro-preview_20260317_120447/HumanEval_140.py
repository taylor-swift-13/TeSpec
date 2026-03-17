
def precondition(args):
    return isinstance(args[0], str)

def postcondition(args, output):
    if not isinstance(output, str):
        return False
    
    text = args[0]
    expected = ""
    i = 0
    while i < len(text):
        if text[i] == ' ':
            start = i
            while i < len(text) and text[i] == ' ':
                i += 1
            count = i - start
            if count > 2:
                expected += '-'
            else:
                expected += '_' * count
        else:
            expected += text[i]
            i += 1
            
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
