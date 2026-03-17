
def precondition(input):
    (text,) = input
    return isinstance(text, str)

def postcondition(input, output):
    (text,) = input
    if not isinstance(output, str):
        return False
    vowels = set('aeiouAEIOU')
    # Output should not contain any vowels
    if any(c in vowels for c in output):
        return False
    # All characters in output should be from the original text and non-vowel
    non_vowel_chars = [c for c in text if c not in vowels]
    if output != ''.join(non_vowel_chars):
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
