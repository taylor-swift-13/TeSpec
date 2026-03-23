import math

def sum_squares_spec(lst, res):
    # Coq's 'up' function is defined by the archimed axiom:
    # IZR (up r) > r and IZR (up r) - r <= 1.
    # Thus, up(x) is the unique integer strictly greater than x.
    # This is exactly math.floor(x) + 1.
    # The variable name 'ceil_x' in the Coq code is a misnomer.
    expected = 0
    for x in lst:
        ceil_x = math.floor(x) + 1
        expected += ceil_x * ceil_x
    return res == expected
