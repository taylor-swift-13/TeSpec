
def precondition(input):
    # input is a tuple of positional arguments. Expect exactly one argument: number
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    num = input[0]
    if not isinstance(num, int):
        return False
    return 1 <= num <= 1000

def postcondition(input, output):
    # verify input validity
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    num = input[0]
    if not isinstance(num, int):
        return False
    if not (1 <= num <= 1000):
        return False
    # output must be a string
    if not isinstance(output, str):
        return False

    # helper to compute roman numeral
    def roman(n):
        vals = [
            (1000, 'M'), (900, 'CM'), (500, 'D'), (400, 'CD'),
            (100, 'C'), (90, 'XC'), (50, 'L'), (40, 'XL'),
            (10, 'X'), (9, 'IX'), (5, 'V'), (4, 'IV'), (1, 'I')
        ]
        res = []
        for val, sym in vals:
            while n >= val:
                res.append(sym)
                n -= val
        return ''.join(res)

    expected = roman(num).lower()
    return output == expected

def _impl(number):
    """
    Given a positive integer, obtain its roman numeral equivalent as a string,
    and return it in lowercase.
    Restrictions: 1 <= num <= 1000

    Examples:
    """
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
