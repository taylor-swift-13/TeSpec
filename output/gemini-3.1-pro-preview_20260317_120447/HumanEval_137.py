
def precondition(args):
    if len(args) != 2:
        return False
    a, b = args
    def is_valid(x):
        if type(x) in (int, float):
            return True
        if type(x) is str:
            try:
                float(x.replace(',', '.'))
                return True
            except ValueError:
                return False
        return False
    return is_valid(a) and is_valid(b)

def postcondition(args, result):
    if len(args) != 2:
        return False
    a, b = args
    def to_float(val):
        if type(val) is str:
            return float(val.replace(',', '.'))
        return float(val)
    
    try:
        val_a = to_float(a)
        val_b = to_float(b)
    except Exception:
        return True
        
    if val_a == val_b:
        return result is None
    elif val_a > val_b:
        return result is a or (result == a and type(result) is type(a))
    else:
        return result is b or (result == b and type(result) is type(b))

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
