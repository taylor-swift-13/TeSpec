
def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    num = input[0]
    # require an integer in the allowed range; exclude booleans
    if not isinstance(num, int) or isinstance(num, bool):
        return False
    if not (1 <= num <= 1000):
        return False
    return True

def postcondition(input, output):
    # If precondition doesn't hold, we don't enforce postcondition here
    if not precondition(input):
        return True
    num = input[0]
    # output must be a string
    if not isinstance(output, str):
        return False
    # construct canonical roman numeral for num in lowercase
    mapping = [
        (1000, "m"),
        (900, "cm"),
        (500, "d"),
        (400, "cd"),
        (100, "c"),
        (90, "xc"),
        (50, "l"),
        (40, "xl"),
        (10, "x"),
        (9, "ix"),
        (5, "v"),
        (4, "iv"),
        (1, "i"),
    ]
    n = num
    parts = []
    for val, sym in mapping:
        if n <= 0:
            break
        count = n // val
        if count:
            parts.append(sym * count)
            n -= val * count
    expected = "".join(parts)
    return output == expected

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
