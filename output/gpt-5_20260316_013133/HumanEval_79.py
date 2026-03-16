
def precondition(input):
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    x = input[0]
    try:
        if hasattr(x, "__index__"):
            n = x.__index__()
        elif isinstance(x, int):
            n = x
        else:
            return False
    except Exception:
        return False
    return isinstance(n, int) and n >= 0

def postcondition(input, output):
    if not precondition(input):
        return True
    x = input[0]
    try:
        n = x.__index__() if hasattr(x, "__index__") else x
    except Exception:
        return False
    if not isinstance(n, int) or n < 0:
        return False
    if not isinstance(output, str):
        return False
    if not (output.startswith("db") and output.endswith("db")):
        return False
    inner = output[2:-2]
    expected_inner = bin(n)[2:]
    if inner != expected_inner:
        return False
    return all(c in "01" for c in inner)

def _impl(decimal):
    """You will be given a number in decimal form and your task is to convert it to
    binary format. The function should return a string, with each character representing a binary
    number. Each character in the string will be '0' or '1'.

    There will be an extra couple of characters 'db' at the beginning and at the end of the string.
    The extra characters are there to help with the format.

    Examples:
    decimal_to_binary(15)   # returns "db1111db"
    decimal_to_binary(32)   # returns "db100000db""""
    return "db" + bin(decimal)[2:] + "db"

def decimal_to_binary(decimal):
    _input = (decimal,)
    assert precondition(_input)
    _output = _impl(decimal)
    assert postcondition(_input, _output)
    return _output
