
def precondition(input):
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    text = input[0]
    if not isinstance(text, str):
        return False
    return True

def postcondition(input, output):
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    text = input[0]
    if not isinstance(text, str) or not isinstance(output, str):
        return False

    def expected(t):
        res = []
        i = 0
        n = len(t)
        while i < n:
            if t[i] == ' ':
                j = i
                while j < n and t[j] == ' ':
                    j += 1
                run = j - i
                if run <= 2:
                    res.append('_' * run)
                else:
                    res.append('-')
                i = j
            else:
                res.append(t[i])
                i += 1
        return ''.join(res)

    return expected(text) == output

def _impl(text):
    """
    Given a string text, replace all spaces in it with underscores, 
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
