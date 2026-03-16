
def precondition(input):
    x, base = input
    if not isinstance(x, int) or not isinstance(base, int):
        return False
    if base < 2 or base > 9:
        return False
    if x < 0:
        return False
    return True

def postcondition(input, output):
    if not isinstance(output, str):
        return False
    x, base = input
    if x == 0:
        return output == "0"
    digits = "0123456789"[:base]
    for ch in output:
        if ch not in digits:
            return False
    try:
        reconstructed = 0
        for ch in output:
            reconstructed = reconstructed * base + int(ch)
        return reconstructed == x
    except:
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
