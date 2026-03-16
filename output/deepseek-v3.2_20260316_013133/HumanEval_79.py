
def precondition(input):
    decimal, = input
    return isinstance(decimal, int) and decimal >= 0

def postcondition(input, output):
    decimal, = input
    if not isinstance(output, str):
        return False
    if not output.startswith('db') or not output.endswith('db'):
        return False
    binary_part = output[2:-2]
    if not all(c in '01' for c in binary_part):
        return False
    if binary_part == '':
        return decimal == 0
    try:
        return int(binary_part, 2) == decimal
    except ValueError:
        return False

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
