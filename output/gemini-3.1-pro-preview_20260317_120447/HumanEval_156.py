
def precondition(inp):
    return isinstance(inp[0], int) and 1 <= inp[0] <= 1000

def postcondition(inp, out):
    return isinstance(out, str) and len(out) > 0 and all(c in 'ivxlcdm' for c in out)

def _impl(number):
    """Given a positive integer, obtain its roman numeral equivalent as a string,
    and return it in lowercase.
    Restrictions: 1 <= num <= 1000

    Examples:"""
    m = ["", "m"]
    c = ["", "c", "cc", "ccc", "cd", "d", "dc", "dcc", "dccc", "cm"]
    x = ["", "x", "xx", "xxx", "xl", "l", "lx", "lxx", "lxxx", "xc"]
    i = ["", "i", "ii", "iii", "iv", "v", "vi", "vii", "viii", "ix"]
    thousands = m[number // 1000]
    hundreds = c[(number % 1000) // 100]
    tens = x[(number % 100) // 10]
    ones = i[number % 10]
    return thousands + hundreds + tens + ones

def int_to_mini_roman(number):
    _input = (number,)
    assert precondition(_input)
    _output = _impl(number)
    assert postcondition(_input, _output)
    return _output
