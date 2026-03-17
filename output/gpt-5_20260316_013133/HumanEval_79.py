
def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    x = input[0]
    if not isinstance(x, int):
        return False
    if x < 0:
        return False
    return True

def postcondition(input, output):
    if not precondition(input):
        return True
    x = input[0]
    if not isinstance(output, str):
        return False
    if len(output) < 4:
        return False
    if not (output.startswith('db') and output.endswith('db')):
        return False
    core = output[2:-2]
    if core == "":
        return False
    for ch in core:
        if ch not in ("0", "1"):
            return False
    try:
        value = int(core, 2)
    except Exception:
        return False
    return value == x

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
