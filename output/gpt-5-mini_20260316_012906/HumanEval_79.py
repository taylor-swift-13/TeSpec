
def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    n = input[0]
    # require a non-negative integer (exclude bool)
    if not isinstance(n, int) or isinstance(n, bool):
        return False
    if n < 0:
        return False
    return True

def postcondition(input, output):
    if not precondition(input):
        return False
    n = input[0]
    if not isinstance(output, str):
        return False
    if not output.startswith("db") or not output.endswith("db"):
        return False
    mid = output[2:-2]
    # there must be at least one binary digit
    if len(mid) < 1:
        return False
    # all characters in the middle must be '0' or '1'
    if any(c not in ("0", "1") for c in mid):
        return False
    # must match standard binary representation without prefix
    if mid != bin(n)[2:]:
        return False
    return True

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
