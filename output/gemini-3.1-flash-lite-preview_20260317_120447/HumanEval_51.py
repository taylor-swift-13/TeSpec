
def precondition(input):
    text = input[0]
    return isinstance(text, str)

def postcondition(input, output):
    text = input[0]
    vowels = "aeiouAEIOU"
    
    # Check that output contains no vowels
    for char in output:
        if char in vowels:
            return False
            
    # Check that output preserves relative order of non-vowels
    filtered_text = "".join([c for c in text if c not in vowels])
    return output == filtered_text

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
