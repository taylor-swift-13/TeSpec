
def precondition(input_args):
    if not isinstance(input_args, tuple) or len(input_args) != 1:
        return False
    num = input_args[0]
    return isinstance(num, int) and 1 <= num <= 1000

def postcondition(input_args, output):
    if not isinstance(output, str):
        return False
    if len(output) == 0:
        return False
    valid_chars = set('ivxlcdm')
    for char in output:
        if char not in valid_chars:
            return False
    return output.islower()

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
