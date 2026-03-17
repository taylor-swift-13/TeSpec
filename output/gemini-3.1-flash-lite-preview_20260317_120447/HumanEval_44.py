
def precondition(input):
    x, base = input
    return isinstance(x, int) and isinstance(base, int) and 2 <= base <= 9 and x >= 0

def postcondition(input, output):
    x, base = input
    if not isinstance(output, str):
        return False
    if not all(c.isdigit() and int(c) < base for c in output):
        return False
    return int(output, base) == x

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
