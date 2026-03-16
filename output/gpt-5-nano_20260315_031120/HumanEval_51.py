
def precondition(input):
    # input is expected to be a tuple of positional arguments for the function
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    text = input[0]
    return isinstance(text, str)

def postcondition(input, output):
    # Validate inputs
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    text = input[0]
    if not isinstance(text, str):
        return False
    if not isinstance(output, str):
        return False
    vowels = set('aeiouAEIOU')
    expected = ''.join(ch for ch in text if ch not in vowels)
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
