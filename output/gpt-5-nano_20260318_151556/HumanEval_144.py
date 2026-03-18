
def precondition(input):
    if not isinstance(input, tuple) or len(input) != 2:
        return False
    x, n = input
    if not isinstance(x, str) or not isinstance(n, str):
        return False
    try:
        a_str, b_str = x.strip().split('/')
        c_str, d_str = n.strip().split('/')
    except Exception:
        return False
    try:
        a = int(a_str)
        b = int(b_str)
        c = int(c_str)
        d = int(d_str)
    except Exception:
        return False
    if a <= 0 or b <= 0 or c <= 0 or d <= 0:
        return False
    return True

def postcondition(input, output):
    if not isinstance(output, bool):
        return False
    if not precondition(input):
        return False
    x, n = input
    a_str, b_str = x.strip().split('/')
    c_str, d_str = n.strip().split('/')
    a = int(a_str)
    b = int(b_str)
    c = int(c_str)
    d = int(d_str)
    is_integer = ((a * c) % (b * d) == 0)
    return output == is_integer

def _impl(x, n):
    """
    Your task is to implement a function that will simplify the expression
    x * n. The function returns True if x * n evaluates to a whole number and False
    otherwise. Both x and n, are string representation of a fraction, and have the following format,
    <numerator>/<denominator> where both numerator and denominator are positive whole numbers.

    You can assume that x, and n are valid fractions, and do not have zero as denominator.

    simplify("1/5", "5/1") = True
    simplify("1/6", "2/1") = False
    simplify("7/10", "10/2") = False
    """
    x1, x2 = map(int, x.split("/"))
    n1, n2 = map(int, n.split("/"))
    return (x1 * n1) % (x2 * n2) == 0

def simplify(x, n):
    _input = (x, n)
    assert precondition(_input)
    _output = _impl(x, n)
    assert postcondition(_input, _output)
    return _output
