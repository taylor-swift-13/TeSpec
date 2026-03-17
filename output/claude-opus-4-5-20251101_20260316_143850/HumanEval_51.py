
def precondition(input):
    if len(input) != 1:
        return False
    text = input[0]
    if not isinstance(text, str):
        return False
    return True

def postcondition(input, output):
    if not isinstance(output, str):
        return False
    text = input[0]
    vowels = set('aeiouAEIOU')
    # Output should not contain any vowels
    for char in output:
        if char in vowels:
            return False
    # Output should only contain characters from input (excluding vowels)
    # and preserve order
    output_idx = 0
    for char in text:
        if char not in vowels:
            if output_idx >= len(output):
                return False
            if output[output_idx] != char:
                return False
            output_idx += 1
    # All characters in output should be accounted for
    if output_idx != len(output):
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
