
def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    return isinstance(input[0], str)

def postcondition(input, output):
    if not precondition(input):
        return True
    if not isinstance(output, str):
        return False

    text = input[0]

    def transform(s):
        res = []
        i = 0
        n = len(s)
        while i < n:
            if s[i] == ' ':
                j = i
                while j < n and s[j] == ' ':
                    j += 1
                count = j - i
                if count >= 3:
                    res.append('-')
                else:
                    res.append('_' * count)
                i = j
            else:
                res.append(s[i])
                i += 1
        return ''.join(res)

    expected = transform(text)
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
