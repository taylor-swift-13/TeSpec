
def precondition(input):
    message = input[0]
    if not isinstance(message, str):
        return False
    # Assume only letters and spaces (based on examples)
    for c in message:
        if not (c.isalpha() or c == ' '):
            return False
    return True


def postcondition(input, output):
    message = input[0]
    if not isinstance(output, str):
        return False
    if len(output) != len(message):
        return False
    
    vowels_lower = 'aeiou'
    vowels_upper = 'AEIOU'
    
    for i, c in enumerate(message):
        if c == ' ':
            if output[i] != ' ':
                return False
        elif c.isalpha():
            # First swap case
            if c.islower():
                swapped = c.upper()
            else:
                swapped = c.lower()
            
            # Then replace vowels (after swap) with letter 2 places ahead
            if swapped in vowels_lower or swapped in vowels_upper:
                expected = chr(ord(swapped) + 2)
            else:
                expected = swapped
            
            if output[i] != expected:
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
