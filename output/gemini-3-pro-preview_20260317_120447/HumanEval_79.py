
def precondition(inp):
    return isinstance(inp[0], int)

def postcondition(inp, out):
    if not isinstance(out, str):
        return False
    if len(out) < 4:
        return False
    if not out.startswith('db') or not out.endswith('db'):
        return False
    return all(c in '01' for c in out[2:-2])

def _impl(decimal):
    """You will be given a number in decimal form and your task is to convert it to
    binary format. The function should return a string, with each character representing a binary
    number. Each character in the string will be '0' or '1'.

    There will be an extra couple of characters 'db' at the beginning and at the end of the string.
    The extra characters are there to help with the format.

    Examples:
    decimal_to_binary(15)   # returns "db1111db"
    decimal_to_binary(32)   # returns "db100000db"
    """
    return "db" + bin(decimal)[2:] + "db"

def decimal_to_binary(decimal):
    _input = (decimal,)
    assert precondition(_input)
    _output = _impl(decimal)
    assert postcondition(_input, _output)
    return _output
