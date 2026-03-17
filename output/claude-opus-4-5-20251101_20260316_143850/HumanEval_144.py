
def precondition(input):
    if len(input) != 2:
        return False
    x, n = input
    if not isinstance(x, str) or not isinstance(n, str):
        return False
    
    # Check x format
    if '/' not in x:
        return False
    parts_x = x.split('/')
    if len(parts_x) != 2:
        return False
    try:
        num_x = int(parts_x[0])
        den_x = int(parts_x[1])
        if num_x < 0 or den_x <= 0:
            return False
    except ValueError:
        return False
    
    # Check n format
    if '/' not in n:
        return False
    parts_n = n.split('/')
    if len(parts_n) != 2:
        return False
    try:
        num_n = int(parts_n[0])
        den_n = int(parts_n[1])
        if num_n < 0 or den_n <= 0:
            return False
    except ValueError:
        return False
    
    return True


def postcondition(input, output):
    if not isinstance(output, bool):
        return False
    
    x, n = input
    parts_x = x.split('/')
    num_x = int(parts_x[0])
    den_x = int(parts_x[1])
    
    parts_n = n.split('/')
    num_n = int(parts_n[0])
    den_n = int(parts_n[1])
    
    # x * n = (num_x * num_n) / (den_x * den_n)
    # This is a whole number if (num_x * num_n) % (den_x * den_n) == 0
    numerator = num_x * num_n
    denominator = den_x * den_n
    
    is_whole = (numerator % denominator == 0)
    
    return output == is_whole

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
