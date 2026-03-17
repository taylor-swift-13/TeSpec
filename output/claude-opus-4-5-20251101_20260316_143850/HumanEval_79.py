
def precondition(args):
    decimal = args[0]
    # Input must be a non-negative integer
    if not isinstance(decimal, int):
        return False
    if isinstance(decimal, bool):
        return False
    if decimal < 0:
        return False
    return True

def postcondition(args, output):
    decimal = args[0]
    # Output must be a string
    if not isinstance(output, str):
        return False
    # Output must start with 'db' and end with 'db'
    if not output.startswith('db') or not output.endswith('db'):
        return False
    # Extract the binary part (between the 'db' markers)
    binary_part = output[2:-2]
    # Binary part must only contain '0' and '1'
    if not all(c in '01' for c in binary_part):
        return False
    # Handle special case: decimal 0 should have binary part '0'
    if decimal == 0:
        if binary_part != '0':
            return False
    else:
        # Binary part should not have leading zeros (except for 0 itself)
        if len(binary_part) > 1 and binary_part[0] == '0':
            return False
        # Binary part should not be empty for non-zero numbers
        if len(binary_part) == 0:
            return False
    # Verify the binary representation is correct
    if binary_part:
        try:
            converted_value = int(binary_part, 2)
            if converted_value != decimal:
                return False
        except ValueError:
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
    decimal_to_binary(32)   # returns "db100000db"
    """
    return "db" + bin(decimal)[2:] + "db"

def decimal_to_binary(decimal):
    _input = (decimal,)
    assert precondition(_input)
    _output = _impl(decimal)
    assert postcondition(_input, _output)
    return _output
