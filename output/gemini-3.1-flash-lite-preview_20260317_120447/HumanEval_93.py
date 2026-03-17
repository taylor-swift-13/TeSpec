
def precondition(input):
    message = input[0]
    return isinstance(message, str) and message.isalpha()

def postcondition(input, output):
    message = input[0]
    vowels = "aeiouAEIOU"
    
    if not isinstance(output, str):
        return False
    if len(output) != len(message):
        return False
        
    for i in range(len(message)):
        char = message[i]
        swapped = char.swapcase()
        if swapped in vowels:
            expected = chr(ord(swapped) + 2)
            if output[i] != expected:
                return False
        else:
            if output[i] != swapped:
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
