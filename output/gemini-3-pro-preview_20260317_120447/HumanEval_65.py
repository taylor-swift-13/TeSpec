
def precondition(args) -> bool:
    if not (isinstance(args, tuple) and len(args) == 2):
        return False
    x, shift = args
    return isinstance(x, int) and isinstance(shift, int) and shift >= 0

def postcondition(args, output) -> bool:
    if not isinstance(output, str):
        return False
    x, shift = args
    s = str(abs(x))
    n = len(s)
    if n == 0:
        return output == ""
    if shift > n:
        return output == s[::-1]
    else:
        # Circular shift right by 'shift'
        # If shift == n, it results in the original string
        k = shift % n if n > 0 else 0
        if k == 0:
            expected = s
        else:
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
