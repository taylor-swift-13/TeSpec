
def precondition(input) -> bool:
    if len(input) != 1:
        return False
    number = input[0]
    if not isinstance(number, int):
        return False
    if number < 1 or number > 1000:
        return False
    return True


def postcondition(input, output) -> bool:
    if not isinstance(output, str):
        return False
    if output != output.lower():
        return False
    valid_chars = set('ivxlcdm')
    if not all(c in valid_chars for c in output):
        return False
    if len(output) == 0:
        return False
    roman_values = {
        'i': 1, 'v': 5, 'x': 10, 'l': 50,
        'c': 100, 'd': 500, 'm': 1000,
        'iv': 4, 'ix': 9, 'xl': 40, 'xc': 90,
        'cd': 400, 'cm': 900
    }
    def roman_to_int(s):
        total = 0
        i = 0
        while i < len(s):
            if i + 1 < len(s) and s[i:i+2] in roman_values:
                total += roman_values[s[i:i+2]]
                i += 2
            elif s[i] in roman_values:
                total += roman_values[s[i]]
                i += 1
            else:
                return None
        return total
    number = input[0]
    reconstructed = roman_to_int(output)
    if reconstructed != number:
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
