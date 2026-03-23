def digit_counts(n, e, o):
    """
    Implements the inductive relation digit_counts.
    It checks if 'e' and 'o' correctly represent the counts of even and odd digits
    in the decimal representation of 'n'.
    The relation is defined for n >= 0.
    """
    if n < 0:
        return False

    # Convert number to string to iterate over digits
    s = str(n)
    calc_e = 0
    calc_o = 0

    for char in s:
        digit = int(char)
        if digit % 2 == 0:
            calc_e += 1
        else:
            calc_o += 1

    return calc_e == e and calc_o == o

def even_odd_count_spec(num, res):
    """
    Specification function that checks if 'res' (a tuple of (even_count, odd_count))
    matches the digit counts of the absolute value of 'num'.
    """
    even, odd = res
    return digit_counts(abs(num), even, odd)

def _impl(num):
    even, odd = 0, 0
    for ch in str(num):
        if ch in "02468": even += 1
        if ch in "13579": odd += 1
    return even, odd

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(even_odd_count_spec(*input, output))

def even_odd_count(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
