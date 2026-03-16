
def precondition(input):
    if not isinstance(input, tuple) or len(input) != 2:
        return False
    x, n = input
    if not isinstance(x, str) or not isinstance(n, str):
        return False

    def is_positive_fraction(s):
        if not isinstance(s, str):
            return False
        s = s.strip()
        parts = s.split('/')
        if len(parts) != 2:
            return False
        num, den = parts[0].strip(), parts[1].strip()
        if num == "" or den == "":
            return False
        if not num.isdigit() or not den.isdigit():
            return False
        # positive whole numbers, denominator not zero
        try:
            num_v = int(num)
            den_v = int(den)
        except Exception:
            return False
        if num_v <= 0 or den_v <= 0:
            return False
        return True

    return is_positive_fraction(x) and is_positive_fraction(n)


def postcondition(input, output):
    if not precondition(input):
        # Do not constrain behavior if inputs do not meet precondition
        return isinstance(output, bool)
    x, n = input
    x = x.strip()
    n = n.strip()
    ax, bx = x.split('/')
    ay, by = n.split('/')
    try:
        ax_i = int(ax.strip())
        bx_i = int(bx.strip())
        ay_i = int(ay.strip())
        by_i = int(by.strip())
    except Exception:
        return False
    num = ax_i * ay_i
    den = bx_i * by_i
    expected = (num % den == 0)
    return isinstance(output, bool) and (output == expected)

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
