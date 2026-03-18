
def precondition(input):
    # input is a tuple of positional arguments in order: l (list), t (int)
    if not isinstance(input, tuple) or len(input) != 2:
        return False
    l, t = input
    if not isinstance(l, list):
        return False
    if not isinstance(t, int):
        return False
    return True

def postcondition(input, output):
    l, t = input
    # If precondition does not hold, postcondition is not required to constrain.
    if not isinstance(l, list) or not isinstance(t, int):
        return True
    # Ensure all elements are numeric for comparison
    for x in l:
        if not isinstance(x, (int, float)):
            return False
    expected = all(x < t for x in l)
    return isinstance(output, bool) and output == expected

def _impl(l: list, t: int):
    """
    Return True if all numbers in the list l are below threshold t.
    True
    False
    """
    return all(x < t for x in l)

def below_threshold(l: list, t: int):
    _input = (l, t)
    assert precondition(_input)
    _output = _impl(l, t)
    assert postcondition(_input, _output)
    return _output
