
def precondition(args):
    return len(args) == 1 and isinstance(args[0], str)

def postcondition(args, output):
    if not isinstance(output, str):
        return False
    message = args[0]
    if len(message) != len(output):
        return False
    
    vowels = "aeiouAEIOU"
    vowel_map = {
        'a': 'c', 'e': 'g', 'i': 'k', 'o': 'q', 'u': 'w',
        'A': 'C', 'E': 'G', 'I': 'K', 'O': 'Q', 'U': 'W'
    }
    
    for char_in, char_out in zip(message, output):
        if char_in in vowels:
            expected = vowel_map[char_in].swapcase()
        elif char_in.isalpha():
            expected = char_in.swapcase()
        else:
            expected = char_in
            
        if char_out != expected:
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
