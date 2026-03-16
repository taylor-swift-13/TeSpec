
def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) < 2:
        return False
    x, base = input[0], input[1]
    if not isinstance(x, int):
        return False
    if not isinstance(base, int):
        return False
    # require conventional positional bases: 2..9 (less than 10, at least binary)
    if base < 2 or base >= 10:
        return False
    return True

def postcondition(input, output):
    # If precondition does not hold, do not attempt strict checking here
    if not precondition(input):
        return True
    x, base = input[0], input[1]
    if not isinstance(output, str):
        return False
    try:
        # special case zero
        if x == 0:
            expected = '0'
        else:
            neg = x < 0
            n = abs(int(x))
            digits = []
            while n > 0:
                d = n % base
                # d must be a valid single digit for this base
                if d < 0 or d >= base:
                    return False
                digits.append(chr(ord('0') + d))
                n //= base
            expected = ''.join(reversed(digits))
            if neg:
                expected = '-' + expected
        return output == expected
    except Exception:
        return False

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
