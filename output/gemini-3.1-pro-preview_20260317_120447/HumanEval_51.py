
def precondition(input) -> bool:
    if len(input) != 1:
        return False
    text = input[0]
    if not isinstance(text, str):
        return False
    return True

def postcondition(input, output) -> bool:
    if not isinstance(output, str):
        return False
    text = input[0]
    if len(output) > len(text):
        return False
    vowels = set("aeiouAEIOU")
    if any(c in vowels for c in output):
        return False
    return True

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
