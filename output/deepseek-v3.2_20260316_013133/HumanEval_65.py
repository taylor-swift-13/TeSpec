
def precondition(input):
    x, shift = input
    if not isinstance(x, int):
        return False
    if not isinstance(shift, int):
        return False
    if shift < 0:
        return False
    return True

def postcondition(input, output):
    x, shift = input
    if not isinstance(output, str):
        return False
    if not output.isdigit() and output != "":
        return False
    if x == 0:
        return output == "0"
    digits = str(abs(x))
    n = len(digits)
    if shift >= n:
        expected = digits[::-1]
    else:
        expected = digits[-shift:] + digits[:-shift]
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
