
def precondition(input):
    if len(input) != 1:
        return False
    message = input[0]
    if not isinstance(message, str):
        return False
    for ch in message:
        if not ch.isalpha() and ch != ' ':
            return False
    return True

def postcondition(input, output):
    if not isinstance(output, str):
        return False
    message = input[0]
    if len(output) != len(message):
        return False
    vowels_lower = set('aeiou')
    vowels_upper = set('AEIOU')
    for i, ch in enumerate(message):
        out_ch = output[i]
        if ch == ' ':
            if out_ch != ' ':
                return False
        elif ch in vowels_lower:
            expected = chr(ord(ch.upper()) + 2)
            if out_ch != expected:
                return False
        elif ch in vowels_upper:
            expected = chr(ord(ch.lower()) + 2)
            if out_ch != expected:
                return False
        elif ch.islower():
            if out_ch != ch.upper():
                return False
        elif ch.isupper():
            if out_ch != ch.lower():
                return False
    return True

def _impl(message):
    """Write a function that takes a message, and encodes in such a 
    way that it swaps case of all letters, replaces all vowels in 
    the message with the letter that appears 2 places ahead of that 
    vowel in the english alphabet. 
    Assume only letters. 

    Examples:
    'TGST'
    'tHKS KS C MGSSCGG'"""
    def switch_case(ch):
        if ord("A") <= ord(ch) <= ord("Z"):
            return chr(ord(ch) + 32)
        elif ord("a") <= ord(ch) <= ord("z"):
            return chr(ord(ch) - 32)
        else:
            return ch

    def vowel_change(ch):
        return ch if ch not in "aeiouAEIOU" else chr(ord(ch) + 2)

    m = "".join(map(switch_case, message))
    return "".join(map(vowel_change, m))

def encode(message):
    _input = (message,)
    assert precondition(_input)
    _output = _impl(message)
    assert postcondition(_input, _output)
    return _output
