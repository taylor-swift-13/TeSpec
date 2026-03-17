
def precondition(input):
    x, base = input
    if not isinstance(x, int) or not isinstance(base, int):
        return False
    if base < 2 or base >= 10:
        return False
    if x < 0:
        return False
    return True

def postcondition(input, output):
    x, base = input
    if not isinstance(output, str):
        return False
    # All characters should be valid digits for the given base
    for ch in output:
        if not ch.isdigit():
            return False
        if int(ch) >= base:
            return False
    # The string should not have leading zeros unless the number is zero
    if len(output) > 1 and output[0] == '0':
        return False
    if x == 0 and output != '0':
        return False
    # Convert back from the base representation to verify correctness
    value = 0
    for ch in output:
        value = value * base + int(ch)
    if value != x:
        return False
    return True

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
