
def precondition(input):
    if len(input) != 2:
        return False
    a, b = input
    
    # Check that a and b are valid types (int, float, or str)
    valid_types = (int, float, str)
    if not isinstance(a, valid_types) or not isinstance(b, valid_types):
        return False
    
    # Exclude bool (which is a subclass of int)
    if isinstance(a, bool) or isinstance(b, bool):
        return False
    
    # If string, check it represents a valid real number
    def is_valid_number_string(s):
        if not isinstance(s, str):
            return True
        # Replace comma with dot for parsing
        s_normalized = s.replace(',', '.')
        try:
            float(s_normalized)
            return True
        except (ValueError, TypeError):
            return False
    
    if not is_valid_number_string(a) or not is_valid_number_string(b):
        return False
    
    return True


def postcondition(input, output):
    a, b = input
    
    # Helper to get numeric value
    def get_value(x):
        if isinstance(x, str):
            return float(x.replace(',', '.'))
        return float(x)
    
    val_a = get_value(a)
    val_b = get_value(b)
    
    # If values are equal, output should be None
    if val_a == val_b:
        return output is None
    
    # Otherwise, output should be the larger one in its original type
    if output is None:
        return False
    
    # Determine which is larger
    if val_a > val_b:
        larger = a
    else:
        larger = b
    
    # Output should be exactly the larger input (same type and value)
    if output != larger:
        return False
    
    # Check type is preserved
    if type(output) != type(larger):
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
