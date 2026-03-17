
def precondition(input_args):
    return len(input_args) == 1 and isinstance(input_args[0], str)

def postcondition(input_args, output):
    if not isinstance(output, str):
        return False
    text = input_args[0]
    vowels = "aeiouAEIOU"
    expected = "".join(c for c in text if c not in vowels)
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
