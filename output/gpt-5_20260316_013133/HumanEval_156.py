
def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    n = input[0]
    if isinstance(n, bool) or not isinstance(n, int):
        return False
    if not (1 <= n <= 1000):
        return False
    return True

def postcondition(input, output):
    if not isinstance(output, str):
        return False
    if output == "":
        return False
    if output != output.lower():
        return False
    allowed = set("ivxlcdm")
    if any(c not in allowed for c in output):
        return False

    vals = {'i': 1, 'v': 5, 'x': 10, 'l': 50, 'c': 100, 'd': 500, 'm': 1000}
    subtract_pairs = {'iv', 'ix', 'xl', 'xc', 'cd', 'cm'}

    s = output
    total = 0
    i = 0
    while i < len(s):
        if i + 1 < len(s) and vals[s[i]] < vals[s[i + 1]]:
            pair = s[i] + s[i + 1]
            if pair not in subtract_pairs:
                return False
            total += vals[s[i + 1]] - vals[s[i]]
            i += 2
        else:
            total += vals[s[i]]
            i += 1

    n = input[0]
    if isinstance(n, bool) or not isinstance(n, int):
        return False
    if not (1 <= n <= 1000):
        return False
    return total == n

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
