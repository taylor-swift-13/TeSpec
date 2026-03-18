
def precondition(input) -> bool:
    # input is expected to be a tuple of (x, base)
    if not isinstance(input, tuple) or len(input) != 2:
        return False
    x, base = input
    if not isinstance(x, int) or not isinstance(base, int):
        return False
    # base must be an integer in [2, 9]
    if not (2 <= base < 10):
        return False
    return True

def postcondition(input, output) -> bool:
    # Validate input shape and types
    if not isinstance(input, tuple) or len(input) != 2:
        return False
    x, base = input
    if not isinstance(x, int) or not isinstance(base, int):
        return False
    if not isinstance(output, str):
        return False
    if not (2 <= base < 10):
        return False

    def to_base(n, b):
        if n == 0:
            return '0'
        sign = '-' if n < 0 else ''
        n = abs(n)
        digits = []
        while n:
            digits.append(str(n % b))
            n //= b
        return sign + ''.join(reversed(digits))

    expected = to_base(x, base)
    return output == expected

def _impl(x: int, base: int):
    """
    Change numerical base of input number x to base.
    return string representation after the conversion.
    base numbers are less than 10.
    '22'
    '1000'
    '111'
    """
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
