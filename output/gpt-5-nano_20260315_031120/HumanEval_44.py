
def precondition(input):
    if not isinstance(input, tuple) or len(input) != 2:
        return False
    x, base = input
    if not isinstance(x, int) or not isinstance(base, int):
        return False
    if base < 2 or base > 9:
        return False
    return True

def postcondition(input, output):
    if not isinstance(input, tuple) or len(input) != 2:
        return False
    x, base = input
    if not isinstance(x, int) or not isinstance(base, int):
        return False
    if base < 2 or base > 9:
        return False
    if not isinstance(output, str):
        return False

    # Compute expected representation
    if x == 0:
        expected = "0"
    else:
        sign = '-' if x < 0 else ''
        n = abs(x)
        digits = []
        while n > 0:
            digits.append(str(n % base))
            n //= base
        expected = sign + ''.join(reversed(digits))

    return output == expected

def _impl(x: int, base: int):
    """Change numerical base of input number x to base.
    return string representation after the conversion.
    base numbers are less than 10.
    '22'
    '1000'
    '111'"""
    if x == 0: return "0"
    ret = ""
    while x != 0:
        ret = str(x % base) + ret
        x //= base
    return ret

def change_base(x: int, base: int):
    _input = (x, base)
    assert precondition(_input)
    _output = _impl(x, base)
    assert postcondition(_input, _output)
    return _output
