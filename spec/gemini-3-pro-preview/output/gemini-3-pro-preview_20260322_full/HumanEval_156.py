m_table = ["", "m"]
c_table = ["", "c", "cc", "ccc", "cd", "d", "dc", "dcc", "dccc", "cm"]
x_table = ["", "x", "xx", "xxx", "xl", "l", "lx", "lxx", "lxxx", "xc"]
i_table = ["", "i", "ii", "iii", "iv", "v", "vi", "vii", "viii", "ix"]

def nth(l, n, default):
    if 0 <= n < len(l):
        return l[n]
    return default

def int_to_mini_roman_spec(number: int, result: str) -> bool:
    if not (1 <= number <= 1000):
        return True
    
    thousands_idx = number // 1000
    hundreds_idx = (number % 1000) // 100
    tens_idx = (number % 100) // 10
    ones_idx = number % 10
    
    thousands = nth(m_table, thousands_idx, "")
    hundreds = nth(c_table, hundreds_idx, "")
    tens = nth(x_table, tens_idx, "")
    ones = nth(i_table, ones_idx, "")
    
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
