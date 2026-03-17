
def precondition(input):
    if len(input) != 2:
        return False
    a, b = input
    # Each argument must be int, float, or string
    for val in [a, b]:
        if not isinstance(val, (int, float, str)):
            return False
        if isinstance(val, bool):
            return False
        if isinstance(val, str):
            # String must represent a real number (with . or , as decimal separator)
            try:
                float(val.replace(",", "."))
            except (ValueError, AttributeError):
                return False
    return True


def postcondition(input, output):
    a, b = input

    def to_float(val):
        if isinstance(val, str):
            return float(val.replace(",", "."))
        return float(val)

    fa = to_float(a)
    fb = to_float(b)

    if fa == fb:
        return output is None
    elif fa > fb:
        # Should return a in its original type
        if output != a:
            return False
        if not isinstance(output, type(a)):
            return False
        return True
    else:
        # Should return b in its original type
        if output != b:
            return False
        if not isinstance(output, type(b)):
            return False
        return True

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
