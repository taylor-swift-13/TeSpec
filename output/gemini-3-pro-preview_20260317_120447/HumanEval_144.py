
def precondition(input_args):
    if not isinstance(input_args, tuple) or len(input_args) != 2:
        return False
    x, n = input_args
    if not (isinstance(x, str) and isinstance(n, str)):
        return False
    for s in [x, n]:
        parts = s.split('/')
        if len(parts) != 2:
            return False
        num_s, den_s = parts
        if not (num_s.isdigit() and den_s.isdigit()):
            return False
        num, den = int(num_s), int(den_s)
        if num <= 0 or den <= 0:
            return False
    return True

def postcondition(input_args, output):
    if not isinstance(output, bool):
        return False
    x, n = input_args
    x_parts = x.split('/')
    n_parts = n.split('/')
    x_num, x_den = int(x_parts[0]), int(x_parts[1])
    n_num, n_den = int(n_parts[0]), int(n_parts[1])
    
    total_numerator = x_num * n_num
    total_denominator = x_den * n_den
    expected = (total_numerator % total_denominator == 0)
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
