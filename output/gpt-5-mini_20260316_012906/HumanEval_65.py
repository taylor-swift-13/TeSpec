
def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 2:
        return False
    x, shift = input
    return isinstance(x, int) and isinstance(shift, int)

def postcondition(input, output):
    if not precondition(input):
        return True
    x, shift = input
    if not isinstance(output, str):
        return False
    # allow an optional leading '-' in the output if x is negative
    out = output
    neg_out = False
    if out.startswith('-'):
        neg_out = True
        out = out[1:]
    digits = str(abs(x))
    n = len(digits)
    if n == 0:
        return out == ""
    if shift < 0:
        # unspecified for negative shifts; require output to be a permutation of the digits
        return sorted(out) == sorted(digits)
    # shift >= 0
    if shift > n:
        expected = digits[::-1]
    else:
        if shift == 0:
            expected = digits
        else:
            k = shift
            expected = digits[-k:] + digits[:-k]
    # Accept either signed or unsigned output for negative input
    if x < 0:
        return out == expected
    else:
        # x non-negative: do not allow a leading '-'
        if neg_out:
            return False
        return out == expected

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
