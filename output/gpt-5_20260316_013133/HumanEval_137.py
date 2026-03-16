
def precondition(input) -> bool:
    if not isinstance(input, tuple) or len(input) != 2:
        return False

    def is_valid(x):
        import math
        from decimal import Decimal
        if type(x) is bool:
            return False
        if isinstance(x, int):
            return True
        if isinstance(x, float):
            return math.isfinite(x)
        if isinstance(x, str):
            s = x.strip()
            if s == "":
                return False
            s2 = s.replace(",", ".")
            try:
                Decimal(s2)
                return True
            except Exception:
                return False
        return False

    return is_valid(input[0]) and is_valid(input[1])


def postcondition(input, output) -> bool:
    if not precondition(input):
        return True

    from decimal import Decimal

    def to_decimal(x):
        if isinstance(x, int):
            return Decimal(x)
        if isinstance(x, float):
            return Decimal(str(x))
        if isinstance(x, str):
            return Decimal(x.strip().replace(",", "."))
        # Should not reach here due to precondition
        raise ValueError

    a, b = input
    da = to_decimal(a)
    db = to_decimal(b)

    if da == db:
        return output is None

    if da > db:
        expected = a
    else:
        expected = b

    return (output == expected) and (type(output) is type(expected))

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
