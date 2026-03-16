
def precondition(input):
    text = input[0]
    return isinstance(text, str)

def postcondition(input, output):
    text = input[0]
    if not isinstance(output, str):
        return False
    if not isinstance(text, str):
        return True
    if text == "":
        return output == ""
    i = 0
    j = 0
    while i < len(text) and j < len(output):
        if text[i] == " ":
            space_count = 0
            while i < len(text) and text[i] == " ":
                space_count += 1
                i += 1
            if space_count > 2:
                if j >= len(output) or output[j] != "-":
                    return False
                j += 1
            else:
                for _ in range(space_count):
                    if j >= len(output) or output[j] != "_":
                        return False
                    j += 1
        else:
            if j >= len(output) or text[i] != output[j]:
                return False
            i += 1
            j += 1
    return i == len(text) and j == len(output)

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
