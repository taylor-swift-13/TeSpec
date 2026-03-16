
def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 2:
        return False
    for part in input:
        if not isinstance(part, str):
            return False
        if '/' not in part:
            return False
        pieces = part.split('/')
        if len(pieces) != 2:
            return False
        num_s, den_s = pieces
        if not num_s.isdigit() or not den_s.isdigit():
            return False
        try:
            num = int(num_s)
            den = int(den_s)
        except Exception:
            return False
        if num < 1 or den < 1:
            return False
    return True

def postcondition(input, output):
    if not precondition(input):
        return True
    if not isinstance(output, bool):
        return False
    x_s, n_s = input
    ax_s, bx_s = x_s.split('/')
    an_s, bn_s = n_s.split('/')
    try:
        a = int(ax_s)
        b = int(bx_s)
        c = int(an_s)
        d = int(bn_s)
    except Exception:
        return False
    product_num = a * c
    product_den = b * d
    if product_den == 0:
        return False
    expected = (product_num % product_den == 0)
    return output is expected

def _impl(x, n):
    """Your task is to implement a function that will simplify the expression
    x * n. The function returns True if x * n evaluates to a whole number and False
    otherwise. Both x and n, are string representation of a fraction, and have the following format,
    <numerator>/<denominator> where both numerator and denominator are positive whole numbers.

    You can assume that x, and n are valid fractions, and do not have zero as denominator.

    simplify("1/5", "5/1") = True
    simplify("1/6", "2/1") = False
    simplify("7/10", "10/2") = False"""
    x1, x2 = map(int, x.split("/"))
    n1, n2 = map(int, n.split("/"))
    return (x1 * n1) % (x2 * n2) == 0

def simplify(x, n):
    _input = (x, n)
    assert precondition(_input)
    _output = _impl(x, n)
    assert postcondition(_input, _output)
    return _output
