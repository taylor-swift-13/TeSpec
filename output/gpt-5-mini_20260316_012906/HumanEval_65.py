
def precondition(input):
    if not isinstance(input, tuple) or len(input) != 2:
        return False
    x, shift = input
    return isinstance(x, int) and x >= 0 and isinstance(shift, int) and shift >= 0

def postcondition(input, output):
    if not isinstance(input, tuple) or len(input) != 2:
        return False
    x, shift = input
    if not (isinstance(x, int) and x >= 0 and isinstance(shift, int) and shift >= 0):
        return False
    if not isinstance(output, str):
        return False
    digits = str(x)
    n = len(digits)
    if n == 0:
        return False
    if shift > n:
        expected = digits[::-1]
    else:
        # rotate right by shift (works for shift == 0 and shift == n)
        expected = digits[-shift:] + digits[:-shift] if shift != 0 else digits
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
