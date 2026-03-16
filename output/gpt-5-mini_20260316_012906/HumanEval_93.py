
def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    msg = input[0]
    if not isinstance(msg, str):
        return False
    # allow ASCII letters and spaces (conservative)
    for ch in msg:
        o = ord(ch)
        if ch == ' ':
            continue
        # A-Z:65-90, a-z:97-122
        if not (65 <= o <= 90 or 97 <= o <= 122):
            return False
    return True

def postcondition(input, output):
    if not precondition(input):
        return False
    msg = input[0]
    if not isinstance(output, str):
        return False
    # expected transformation:
    # - swap case of all letters
    # - replace all vowels (a,e,i,o,u) with letter 2 places ahead in alphabet
    # These operations commute; final rule:
    #   if char is vowel -> shifted-by-2 (preserving case)
    #   elif char is ASCII letter -> swapcase
    #   else (e.g., space) -> unchanged
    lower_map = {'a':'c','e':'g','i':'k','o':'q','u':'w'}
    upper_map = {k.upper():v.upper() for k,v in lower_map.items()}
    expected_chars = []
    for ch in msg:
        if ch == ' ':
            expected_chars.append(ch)
        elif ch in lower_map:
            expected_chars.append(lower_map[ch])
        elif ch in upper_map:
            expected_chars.append(upper_map[ch])
        else:
            # ASCII letter consonant: swap case
            expected_chars.append(ch.swapcase())
    expected = ''.join(expected_chars)
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
