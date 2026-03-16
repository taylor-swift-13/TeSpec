
def precondition(input):
    # input should be a tuple (x, shift)
    if not isinstance(input, tuple) or len(input) != 2:
        return False
    x, shift = input
    if not isinstance(x, int) or not isinstance(shift, int):
        return False
    if shift < 0:
        return False
    return True

def postcondition(input, output):
    # output should be a string representing the rotated digits of abs(x)
    if not isinstance(input, tuple) or len(input) != 2:
        return False
    if not isinstance(output, str):
        return False
    x, shift = input
    if not isinstance(x, int) or not isinstance(shift, int) or shift < 0:
        return False
    digits = str(abs(x))
    n = len(digits)
    if n == 0:
        return output == ""
    if shift > n:
        expected = digits[::-1]
    else:
        if shift == 0:
            expected = digits
        else:
            expected = digits[-shift:] + digits[:-shift]
    return output == expected

def _impl(x, shift):
    """Circular shift the digits of the integer x, shift the digits right by shift
    and return the result as a string.
    If shift > number of digits, return digits reversed.
    "21"
    "12""""
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
