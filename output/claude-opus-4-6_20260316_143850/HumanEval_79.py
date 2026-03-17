
def precondition(input):
    (decimal,) = input
    # The input should be an integer
    if not isinstance(decimal, int):
        return False
    # Booleans are technically ints in Python, but we accept them
    return True


def postcondition(input, output):
    (decimal,) = input
    # Output must be a string
    if not isinstance(output, str):
        return False
    # Output must start with "db" and end with "db"
    if not output.startswith("db") or not output.endswith("db"):
        return False
    # Extract the binary part
    binary_part = output[2:-2]
    # Handle the case of 0: binary part should be "0"
    # Handle negative numbers: binary part may start with "-"
    if decimal < 0:
        if not binary_part.startswith("-"):
            return False
        digits = binary_part[1:]
    else:
        digits = binary_part
    # The digits portion should be non-empty and consist only of '0' and '1'
    if len(digits) == 0:
        return False
    if not all(c in ('0', '1') for c in digits):
        return False
    # No leading zeros (unless the number itself is 0)
    if len(digits) > 1 and digits[0] == '0':
        return False
    # The binary part should correspond to the correct value
    if decimal < 0:
        expected_value = -int(digits, 2)
    else:
        expected_value = int(digits, 2)
    if expected_value != decimal:
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
