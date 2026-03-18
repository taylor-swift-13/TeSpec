
def precondition(input):
    if not isinstance(input, tuple) or len(input) != 2:
        return False
    x, shift = input
    if not isinstance(x, int) or not isinstance(shift, int):
        return False
    if x < 0 or shift < 0:
        return False
    return True

def postcondition(input, output):
    if not isinstance(input, tuple) or len(input) != 2:
        return False
    x, shift = input
    if not isinstance(x, int) or not isinstance(shift, int):
        return False
    if x < 0 or shift < 0:
        return False
    if not isinstance(output, str):
        return False
    s = str(x)
    n = len(s)
    if shift <= n:
        expected = s[-shift:] + s[:-shift]
    else:
        expected = s[::-1]
    return output == expected

def _impl(x, shift):
    """
    Circular shift the digits of the integer x, shift the digits right by shift
    and return the result as a string.
    If shift > number of digits, return digits reversed.
    "21"
    "12"
    """
    s = str(x)
    if shift > len(s): return s[::-1]
    shift %= len(s)
    if shift == 0:
        return s
    else:
        return s[len(s) - shift:] + s[:len(s) - shift]

def circular_shift(x, shift):
    _input = (x, shift)
    assert precondition(_input)
    _output = _impl(x, shift)
    assert postcondition(_input, _output)
    return _output
