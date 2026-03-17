
def precondition(inp):
    try:
        num = inp[0]
        if not isinstance(num, str):
            return False
        return all(c in "0123456789ABCDEF" for c in num)
    except Exception:
        return False

def postcondition(inp, out):
    try:
        num = inp[0]
        if not isinstance(out, int):
            return False
        return out == sum(1 for c in num if c in "2357BD")
    except Exception:
        return False

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
