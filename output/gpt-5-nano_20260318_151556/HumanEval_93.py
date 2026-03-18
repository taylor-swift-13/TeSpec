
def precondition(input) -> bool:
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    msg = input[0]
    if not isinstance(msg, str):
        return False
    if not msg.isalpha():
        return False
    return True

def postcondition(input, output) -> bool:
    if not precondition(input):
        return False

    msg = input[0]

    def encode(s: str) -> str:
        res = []
        for ch in s:
            swapped = ch.swapcase()
            if swapped.lower() in 'aeiou':
                if swapped.isupper():
                    swapped = {'A': 'C', 'E': 'G', 'I': 'K', 'O': 'Q', 'U': 'W'}[swapped]
                else:
                    swapped = {'a': 'c', 'e': 'g', 'i': 'k', 'o': 'q', 'u': 'w'}[swapped]
            res.append(swapped)
        return ''.join(res)

    expected = encode(msg)
    return expected == output

def _impl(message):
    """
    Write a function that takes a message, and encodes in such a 
    way that it swaps case of all letters, replaces all vowels in 
    the message with the letter that appears 2 places ahead of that 
    vowel in the english alphabet. 
    Assume only letters. 

    Examples:
    'TGST'
    'tHKS KS C MGSSCGG'
    """
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
