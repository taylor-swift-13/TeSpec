
def precondition(input):
    (number,) = input
    if not isinstance(number, int):
        return False
    if number < 1 or number > 1000:
        return False
    return True

def postcondition(input, output):
    (number,) = input
    if not isinstance(output, str):
        return False
    # Output should be lowercase
    if output != output.lower():
        return False
    # Output should only contain valid roman numeral characters
    valid_chars = set('ivxlcdm')
    if not all(c in valid_chars for c in output):
        return False
    if len(output) == 0:
        return False
    # Verify by converting the roman numeral back to integer
    roman_values = {'i': 1, 'v': 5, 'x': 10, 'l': 50, 'c': 100, 'd': 500, 'm': 1000}
    total = 0
    for i in range(len(output)):
        if output[i] not in roman_values:
            return False
        val = roman_values[output[i]]
        if i + 1 < len(output) and roman_values[output[i + 1]] > val:
            total -= val
        else:
            total += val
    if total != number:
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
