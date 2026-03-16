
def precondition(input):
    # Expect exactly one positional argument and it must be a string.
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    return isinstance(input[0], str)

def postcondition(input, output):
    # Only check when precondition holds.
    if not precondition(input):
        return False
    s = input[0]
    if not isinstance(output, str):
        return False
    vowels = set("aeiouAEIOU")
    expected = "".join(ch for ch in s if ch not in vowels)
    return output == expected

def _impl(text):
    """remove_vowels is a function that takes string and returns string without vowels.
        ''
    ghijklm")
        'bcdf
    ghjklm'
        'bcdf'
        ''
        'B'
        'zbcd'"""
    return "".join(list(filter(lambda ch: ch not in "aeiouAEIOU", text)))

def remove_vowels(text):
    _input = (text,)
    assert precondition(_input)
    _output = _impl(text)
    assert postcondition(_input, _output)
    return _output
