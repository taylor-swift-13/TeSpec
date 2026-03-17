
def precondition(input):
    if len(input) != 2:
        return False
    x, y = input
    # Both x and y should be positive numbers (integers or floats that represent valid range bounds)
    if not isinstance(x, (int, float)) or not isinstance(y, (int, float)):
        return False
    if isinstance(x, bool) or isinstance(y, bool):
        return False
    # Both should be positive
    if x <= 0 or y <= 0:
        return False
    return True


def postcondition(input, output):
    x, y = input
    
    # Output should be an integer
    if not isinstance(output, int):
        return False
    if isinstance(output, bool):
        return False
    
    # If x > y, there's no valid range, should return -1
    if x > y:
        return output == -1
    
    # Convert to integers for range checking
    x_int = int(x) if x == int(x) else int(x) + 1
    y_int = int(y)
    
    # Find all even integers in range [x, y]
    even_numbers = [i for i in range(x_int, y_int + 1) if i % 2 == 0 and i >= x and i <= y]
    
    if not even_numbers:
        # No even number in range, should return -1
        return output == -1
    else:
        # Should return the biggest even number
        return output == max(even_numbers)

def _impl(x, y):
    """This function takes two positive numbers x and y and returns the
    biggest even integer number that is in the range [x, y] inclusive. If 
    there's no such number, then the function should return -1.

    For example:
    choose_num(12, 15) = 14
    choose_num(13, 12) = -1"""
    if x > y: return -1
    if x == y: return y if y % 2 == 0 else -1
    return y if y % 2 == 0 else y - 1

def choose_num(x, y):
    _input = (x, y)
    assert precondition(_input)
    _output = _impl(x, y)
    assert postcondition(_input, _output)
    return _output
