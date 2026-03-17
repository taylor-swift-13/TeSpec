
def precondition(input_args):
    if not isinstance(input_args, tuple) or len(input_args) != 1:
        return False
    xs = input_args[0]
    if not isinstance(xs, list):
        return False
    for x in xs:
        if not isinstance(x, (int, float)):
            return False
    return True

def postcondition(input_args, output):
    xs = input_args[0]
    if not isinstance(output, list):
        return False
    
    if len(xs) <= 1:
        return len(output) == 0
    
    if len(output) != len(xs) - 1:
        return False
    
    for i in range(len(output)):
        if output[i] != xs[i + 1] * (i + 1):
            return False
            
    return True

def _impl(xs: list):
    """xs represent coefficients of a polynomial.
    xs[0] + xs[1] * x + xs[2] * x^2 + ....
     Return derivative of this polynomial in the same form.
    [1, 4, 12, 20]
    [2, 6]"""
    return [xs[i] * i for i in range(1, len(xs))]

def derivative(xs: list):
    _input = (xs,)
    assert precondition(_input)
    _output = _impl(xs)
    assert postcondition(_input, _output)
    return _output
