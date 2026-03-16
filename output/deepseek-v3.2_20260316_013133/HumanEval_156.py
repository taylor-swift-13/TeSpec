
def precondition(input):
    num, = input
    return isinstance(num, int) and 1 <= num <= 1000

def postcondition(input, output):
    num, = input
    if not isinstance(output, str):
        return False
    if not output.islower():
        return False
    # Basic sanity check: output should be non-empty string
    if len(output) == 0:
        return False
    # Check that output contains only valid roman numeral characters
    valid_chars = set('ivxlcdm')
    if not all(c in valid_chars for c in output):
        return False
    return True

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
