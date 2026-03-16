
def precondition(input):
    return isinstance(input, tuple) and len(input) == 1 and isinstance(input[0], int)

def postcondition(input, output):
    if not isinstance(output, bool):
        return False
    a = input[0]
    def is_perfect_cube(n):
        if n == 0:
            return True
        m = n if n >= 0 else -n
        b = m.bit_length()
        g = 1 << ((b + 2) // 3)
        if g == 0:
            g = 1
        while True:
            g2 = (2 * g + m // (g * g)) // 3
            if g2 >= g:
                break
            g = g2
        while (g + 1) * (g + 1) * (g + 1) <= m:
            g += 1
        while g * g * g > m:
            g -= 1
        return g * g * g == m
    expected = is_perfect_cube(a)
    return output == expected

def _impl(a):
    """Write a function that takes an integer a and returns True 
    if this ingeger is a cube of some integer number.
    Note: you may assume the input is always valid.
    Examples:
    iscube(1) ==> True
    iscube(2) ==> False
    iscube(-1) ==> True
    iscube(64) ==> True
    iscube(0) ==> True
    iscube(180) ==> False"""
    a = abs(a)
    return int(round(a ** (1. / 3))) ** 3 == a

def iscube(a):
    _input = (a,)
    assert precondition(_input)
    _output = _impl(a)
    assert postcondition(_input, _output)
    return _output
