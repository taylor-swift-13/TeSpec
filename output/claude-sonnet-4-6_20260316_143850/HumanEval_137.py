
def precondition(input):
    if len(input) != 2:
        return False
    a, b = input
    def is_valid(x):
        if isinstance(x, (int, float)):
            return True
        if isinstance(x, str):
            try:
                float(x.replace(',', '.'))
                return True
            except ValueError:
                return False
        return False
    return is_valid(a) and is_valid(b)


def postcondition(input, output):
    a, b = input
    def to_float(x):
        if isinstance(x, str):
            return float(x.replace(',', '.'))
        return float(x)
    fa, fb = to_float(a), to_float(b)
    if fa == fb:
        return output is None
    elif fa > fb:
        return output == a and type(output) == type(a)
    else:
        return output == b and type(output) == type(b)

def _impl(a, b):
    """Create a function that takes integers, floats, or strings representing
    real numbers, and returns the larger variable in its given variable type.
    Return None if the values are equal.
    Note: If a real number is represented as a string, the floating point might be . or ,

    compare_one(1, 2.5) ➞ 2.5
    compare_one(1, "2,3") ➞ "2,3"
    compare_one("5,1", "6") ➞ "6"
    compare_one("1", 1) ➞ None"""
    num_a = float(str(a).replace(",", "."))
    num_b = float(str(b).replace(",", "."))
    if num_a == num_b:
        return None
    return a if num_a > num_b else b

def compare_one(a, b):
    _input = (a, b)
    assert precondition(_input)
    _output = _impl(a, b)
    assert postcondition(_input, _output)
    return _output
