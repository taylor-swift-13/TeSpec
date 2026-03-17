
def precondition(input):
    if len(input) != 2:
        return False
    x, shift = input
    if not isinstance(x, int):
        return False
    if not isinstance(shift, int):
        return False
    if x < 0:
        return False
    if shift < 0:
        return False
    return True

def postcondition(input, output):
    if not isinstance(output, str):
        return False
    x, shift = input
    digits = str(x)
    if len(output) != len(digits):
        return False
    if sorted(output) != sorted(digits):
        return False
    if shift > len(digits):
        if output != digits[::-1]:
            return False
    else:
        effective_shift = shift % len(digits)
        expected = digits[-effective_shift:] + digits[:-effective_shift] if effective_shift > 0 else digits
        if output != expected:
            return False
    return True

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
