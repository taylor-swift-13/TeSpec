def unit_digit(n):
    # In Coq, Z.modulo (n mod 10) with a positive divisor 10 
    # returns a result in [0, 10).
    # For example, -13 mod 10 = 7.
    # Z.abs then keeps it 7.
    # In Python 3, n % 10 also returns a result in [0, 10).
    # For example, -13 % 10 = 7.
    # Thus, abs(n % 10) matches the Coq behavior.
    return abs(n % 10)

def multiply_spec(a, b, result):
    return result == unit_digit(a) * unit_digit(b)
