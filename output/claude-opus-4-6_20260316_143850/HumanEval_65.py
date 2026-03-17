
def precondition(input):
    x, shift = input
    # x should be a non-negative integer, shift should be a non-negative integer
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
    x, shift = input
    # Output should be a string
    if not isinstance(output, str):
        return False
    digits = str(x)
    num_digits = len(digits)
    # Output should have the same length as the digit string of x
    if len(output) != num_digits:
        return False
    # Output should contain only digit characters
    if not output.isdigit() and len(output) > 0:
        return False
    # Output should contain the same digits (as a multiset) as x
    if sorted(output) != sorted(digits):
        return False
    # Check the actual logic
    if shift > num_digits:
        # Should return reversed digits
        if output != digits[::-1]:
            return False
    else:
        # Circular right shift by 'shift' positions
        expected = digits[num_digits - shift:] + digits[:num_digits - shift]
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
