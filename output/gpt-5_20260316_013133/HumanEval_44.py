
def precondition(input):
    try:
        if not isinstance(input, tuple) or len(input) != 2:
            return False
        x, base = input
        if not isinstance(x, int):
            return False
        if not isinstance(base, int):
            return False
        if base < 2 or base > 9:
            return False
        return True
    except Exception:
        return False

def postcondition(input, output):
    if not precondition(input):
        return True
    x, base = input
    if not isinstance(output, str):
        return False
    if x == 0:
        return output == "0"
    s = output
    negative = x < 0
    if negative:
        if not s or s[0] != "-":
            return False
        mag = s[1:]
        if mag == "":
            return False
    else:
        if not s:
            return False
        if s[0] == "+":
            mag = s[1:]
            if mag == "":
                return False
        else:
            mag = s
    allowed = "0123456789"[:base]
    if any(ch not in allowed for ch in mag):
        return False
    if len(mag) > 1 and mag[0] == "0":
        return False
    val = 0
    for ch in mag:
        val = val * base + (ord(ch) - ord("0"))
    if negative:
        val = -val
    return val == x

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
