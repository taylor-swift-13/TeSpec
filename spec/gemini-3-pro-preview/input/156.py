m_table = ["", "m"]

c_table = ["", "c", "cc", "ccc", "cd", "d", "dc", "dcc", "dccc", "cm"]

x_table = ["", "x", "xx", "xxx", "xl", "l", "lx", "lxx", "lxxx", "xc"]

i_table = ["", "i", "ii", "iii", "iv", "v", "vi", "vii", "viii", "ix"]

def nth(l, n, default):
    if 0 <= n < len(l):
        return l[n]
    return default

def _orig_int_to_mini_roman_spec(number: int, output: str) -> bool:
    if not 1 <= number <= 1000:
        return True
    thousands_idx = number // 1000
    hundreds_idx = number % 1000 // 100
    tens_idx = number % 100 // 10
    ones_idx = number % 10
    thousands = nth(m_table, thousands_idx, '')
    hundreds = nth(c_table, hundreds_idx, '')
    tens = nth(x_table, tens_idx, '')
    ones = nth(i_table, ones_idx, '')
    expected = thousands + hundreds + tens + ones
    return output == expected

def int_to_mini_roman_spec(number, output):
    return bool(_orig_int_to_mini_roman_spec(number, output))
