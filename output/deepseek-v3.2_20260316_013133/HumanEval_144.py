
def precondition(args):
    x, n = args
    if not isinstance(x, str) or not isinstance(n, str):
        return False
    if '/' not in x or '/' not in n:
        return False
    x_num_str, x_den_str = x.split('/')
    n_num_str, n_den_str = n.split('/')
    if not (x_num_str.isdigit() and x_den_str.isdigit() and n_num_str.isdigit() and n_den_str.isdigit()):
        return False
    x_num, x_den, n_num, n_den = int(x_num_str), int(x_den_str), int(n_num_str), int(n_den_str)
    if x_den == 0 or n_den == 0:
        return False
    if x_num <= 0 or x_den <= 0 or n_num <= 0 or n_den <= 0:
        return False
    return True

def postcondition(args, result):
    if not isinstance(result, bool):
        return False
    if not precondition(args):
        return False
    x, n = args
    x_num_str, x_den_str = x.split('/')
    n_num_str, n_den_str = n.split('/')
    x_num, x_den, n_num, n_den = int(x_num_str), int(x_den_str), int(n_num_str), int(n_den_str)
    numerator = x_num * n_num
    denominator = x_den * n_den
    if denominator == 0:
        return False
    is_whole = (numerator % denominator == 0)
    return result == is_whole

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
