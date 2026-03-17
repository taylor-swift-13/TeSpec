
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
    vowels = set('aeiouAEIOU')
    # output should not contain any vowels
    for ch in output:
        if ch in vowels:
            return False
    # output should only contain characters from input that are not vowels
    expected = ''.join(ch for ch in text if ch not in vowels)
    if output != expected:
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
