
def precondition(input):
    x, n = input
    for s in [x, n]:
        if not isinstance(s, str) or "/" not in s:
            return False
        parts = s.split("/")
        if len(parts) != 2 or not all(p.isdigit() and int(p) > 0 for p in parts):
            return False
    return True

def postcondition(input, output):
    return isinstance(output, bool)

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
