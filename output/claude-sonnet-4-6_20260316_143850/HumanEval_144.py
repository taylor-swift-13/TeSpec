
import re

def precondition(args):
    if len(args) != 2:
        return False
    x, n = args
    if not isinstance(x, str) or not isinstance(n, str):
        return False
    pattern = r'^\d+/[1-9]\d*$'
    if not re.match(pattern, x) or not re.match(pattern, n):
        return False
    x_num, x_den = x.split('/')
    n_num, n_den = n.split('/')
    if int(x_num) <= 0 or int(x_den) <= 0 or int(n_num) <= 0 or int(n_den) <= 0:
        return False
    return True

def postcondition(args, output):
    if not isinstance(output, bool):
        return False
    x, n = args
    x_num, x_den = x.split('/')
    n_num, n_den = n.split('/')
    numerator = int(x_num) * int(n_num)
    denominator = int(x_den) * int(n_den)
    expected = (numerator % denominator == 0)
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
