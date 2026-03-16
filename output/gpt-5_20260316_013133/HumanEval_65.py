
def precondition(input) -> bool:
    try:
        if not isinstance(input, tuple) or len(input) != 2:
            return False
        x, shift = input
        if not isinstance(x, int) or not isinstance(shift, int):
            return False
        if shift < 0:
            return False
        return True
    except Exception:
        return False

def postcondition(input, output) -> bool:
    try:
        if not precondition(input):
            return True
        x, shift = input
        if not isinstance(output, str):
            return False
        s = str(abs(x))
        n = len(s)
        has_minus = output.startswith('-')
        if x >= 0 and has_minus:
            return False
        digits_out = output[1:] if has_minus else output
        if len(digits_out) != n:
            return False
        if any(not ('0' <= ch <= '9') for ch in digits_out):
            return False
        if shift > n:
            expected = s[::-1]
        else:
            k = shift % n if n > 0 else 0
            expected = s[-k:] + s[:-k] if k != 0 else s
        return digits_out == expected
    except Exception:
        return False

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
