
def precondition(input):
    (num,) = input
    if not isinstance(num, str):
        return False
    # All characters must be valid hexadecimal digits (0-9, A-F uppercase)
    for c in num:
        if c not in "0123456789ABCDEF":
            return False
    return True

def postcondition(input, output):
    (num,) = input
    if not isinstance(output, int):
        return False
    if output < 0:
        return False
    if output > len(num):
        return False
    # Verify the count of prime hex digits
    prime_hex_digits = set("2357BD")
    expected = sum(1 for c in num if c in prime_hex_digits)
    return output == expected

def _impl(num):
    """You have been tasked to write a function that receives 
    a hexadecimal number as a string and counts the number of hexadecimal 
    digits that are primes (prime number, or a prime, is a natural number 
    greater than 1 that is not a product of two smaller natural numbers).
    Hexadecimal digits are 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, A, B, C, D, E, F.
    Prime numbers are 2, 3, 5, 7, 11, 13, 17,...
    So you have to determine a number of the following digits: 2, 3, 5, 7, 
    B (=decimal 11), D (=decimal 13).
    Note: you may assume the input is always correct or empty string, 
    and symbols A,B,C,D,E,F are always uppercase.
    Examples:
    For num = "AB" the output should be 1.
    For num = "1077E" the output should be 2.
    For num = "ABED1A33" the output should be 4.
    For num = "123456789ABCDEF0" the output should be 6.
    For num = "2020" the output should be 2."""
    return len(list(filter(lambda x: x in "2357BD", num)))

def hex_key(num):
    _input = (num,)
    assert precondition(_input)
    _output = _impl(num)
    assert postcondition(_input, _output)
    return _output
