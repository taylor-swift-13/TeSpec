
def precondition(input):
    x, shift = input
    return isinstance(x, int) and x >= 0 and isinstance(shift, int) and shift >= 0

def postcondition(input, output):
    x, shift = input
    s = str(x)
    n = len(s)
    if shift > n:
        return output == s[::-1]
    else:
        k = shift % n
        expected = s[-k:] + s[:-k]
        return output == expected

def _impl(x, shift):
    """Circular shift the digits of the integer x, shift the digits right by shift
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
