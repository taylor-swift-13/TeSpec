
def precondition(args):
    message = args[0]
    # Check that message is a string
    if not isinstance(message, str):
        return False
    # Check that message contains only letters (as per "Assume only letters")
    if not message.replace(' ', '').isalpha() and message.replace(' ', '') != '':
        # Allow spaces based on example 'tHKS KS C MGSSCGG'
        for char in message:
            if not (char.isalpha() or char == ' '):
                return False
    return True


def postcondition(args, output):
    message = args[0]
    # Check that output is a string
    if not isinstance(output, str):
        return False
    # Check that output has the same length as input
    if len(output) != len(message):
        return False
    # Verify the transformation
    vowels_lower = 'aeiou'
    vowels_upper = 'AEIOU'
    for i, char in enumerate(message):
        if char == ' ':
            if output[i] != ' ':
                return False
        elif char.isalpha():
            # Check case swap
            if char.isupper():
                # Should become lowercase (then vowel replacement)
                swapped = char.lower()
            else:
                # Should become uppercase (then vowel replacement)
                swapped = char.upper()
            # Check vowel replacement (after case swap)
            if swapped in vowels_lower:
                expected = chr(ord(swapped) + 2)
            elif swapped in vowels_upper:
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
