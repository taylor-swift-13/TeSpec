m_numerals = ["", "m"]
c_numerals = ["", "c", "cc", "ccc", "cd", "d", "dc", "dcc", "dccc", "cm"]
x_numerals = ["", "x", "xx", "xxx", "xl", "l", "lx", "lxx", "lxxx", "xc"]
i_numerals = ["", "i", "ii", "iii", "iv", "v", "vi", "vii", "viii", "ix"]

def nth_default(default, l, n):
    if 0 <= n < len(l):
        return l[n]
    return default

def int_to_mini_roman_spec(number, result):
    if not (1 <= number <= 1000):
        return False
    
    thousands = nth_default("", m_numerals, number // 1000)
    hundreds = nth_default("", c_numerals, (number % 1000) // 100)
    tens = nth_default("", x_numerals, (number % 100) // 10)
    ones = nth_default("", i_numerals, number % 10)
    
    expected = thousands + hundreds + tens + ones
    return result == expected

def _impl(number):
    m = ["", "m"]
    c = ["", "c", "cc", "ccc", "cd", "d", "dc", "dcc", "dccc", "cm"]
    x = ["", "x", "xx", "xxx", "xl", "l", "lx", "lxx", "lxxx", "xc"]
    i = ["", "i", "ii", "iii", "iv", "v", "vi", "vii", "viii", "ix"]
    thousands = m[number // 1000]
    hundreds = c[(number % 1000) // 100]
    tens = x[(number % 100) // 10]
    ones = i[number % 10]
    return thousands + hundreds + tens + ones

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(int_to_mini_roman_spec(*input, output))

def int_to_mini_roman(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
