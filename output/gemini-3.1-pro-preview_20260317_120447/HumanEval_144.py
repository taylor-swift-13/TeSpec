
def precondition(args):
    if len(args) != 2:
        return False
    x, n = args
    if not isinstance(x, str) or not isinstance(n, str):
        return False
    for s in (x, n):
        if s.count('/') != 1:
            return False
        num, den = s.split('/')
        if not num.isdigit() or not den.isdigit():
            return False
        if int(num) <= 0 or int(den) <= 0:
            return False
    return True

def postcondition(args, output):
    if not isinstance(output, bool):
        return False
    x, n = args
    num_x, den_x = map(int, x.split('/'))
    num_n, den_n = map(int, n.split('/'))
    expected = (num_x * num_n) % (den_x * den_n) == 0
    return output == expected

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
