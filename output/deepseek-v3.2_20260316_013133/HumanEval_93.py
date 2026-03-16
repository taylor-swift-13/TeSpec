
def precondition(input):
    message, = input
    if not isinstance(message, str):
        return False
    if not message.isalpha():
        return False
    return True

def postcondition(input, output):
    message, = input
    if not isinstance(output, str):
        return False
    if len(output) != len(message):
        return False
    vowels = set('aeiouAEIOU')
    for i, (in_char, out_char) in enumerate(zip(message, output)):
        if not out_char.isalpha():
            return False
        expected_case = in_char.swapcase()
        if in_char in vowels:
            base = ord(in_char.lower())
            shifted = ((base - ord('a') + 2) % 26) + ord('a')
            expected_char = chr(shifted)
            if in_char.isupper():
                expected_char = expected_char.upper()
            if out_char != expected_char:
                return False
        else:
            if out_char != expected_case:
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
