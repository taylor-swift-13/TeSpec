
def precondition(input):
    a, b = input
    if not isinstance(a, (int, float, str)):
        return False
    if not isinstance(b, (int, float, str)):
        return False
    if isinstance(a, str):
        try:
            float(a.replace(',', '.'))
        except ValueError:
            return False
    if isinstance(b, str):
        try:
            float(b.replace(',', '.'))
        except ValueError:
            return False
    return True

def postcondition(input, output):
    a, b = input
    if output is None:
        try:
            a_val = float(a) if not isinstance(a, str) else float(a.replace(',', '.'))
            b_val = float(b) if not isinstance(b, str) else float(b.replace(',', '.'))
            return abs(a_val - b_val) < 1e-12
        except (ValueError, TypeError):
            return False
    else:
        if not isinstance(output, type(a)) and not isinstance(output, type(b)):
            return False
        try:
            a_val = float(a) if not isinstance(a, str) else float(a.replace(',', '.'))
            b_val = float(b) if not isinstance(b, str) else float(b.replace(',', '.'))
            out_val = float(output) if not isinstance(output, str) else float(output.replace(',', '.'))
            if a_val > b_val:
                return abs(out_val - a_val) < 1e-12 and isinstance(output, type(a))
            else:
                return abs(out_val - b_val) < 1e-12 and isinstance(output, type(b))
        except (ValueError, TypeError):
            return False

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
