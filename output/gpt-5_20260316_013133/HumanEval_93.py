
def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    message = input[0]
    return isinstance(message, str)


def postcondition(input, output):
    if not precondition(input):
        return True
    if not isinstance(output, str):
        return False

    message = input[0]

    def encode(msg):
        res_chars = []
        for ch in msg:
            if ch in "aeiou":
                res_chars.append(chr(ord(ch) + 2))
            elif ch in "AEIOU":
                res_chars.append(chr(ord(ch) + 2))
            else:
                res_chars.append(ch)
        replaced = "".join(res_chars)
        return replaced.swapcase()

    expected = encode(message)
    return output == expected

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
