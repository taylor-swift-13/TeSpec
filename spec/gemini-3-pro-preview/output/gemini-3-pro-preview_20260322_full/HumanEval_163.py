def generate_integers_spec(a, b, l):
    lower = min(a, b)
    upper = max(a, b)
    
    # The spec requires the list `l` to be strictly sorted (Sorted Z.lt)
    # and to contain exactly those integers `x` that satisfy:
    # 1. lower <= x <= upper
    # 2. x < 10
    # 3. x is even (Z.even x = true)
    
    # Since the list must be strictly sorted, there is only one such list.
    # We construct this expected list and compare it with `l`.
    
    # The condition x < 10 is equivalent to x <= 9 for integers.
    # So the effective upper bound is min(upper, 9).
    limit = min(upper, 9)
    
    expected = []
    if lower <= limit:
        for x in range(lower, limit + 1):
            if x % 2 == 0:
                expected.append(x)
                
    return l == expected

def _impl(a, b):
    if a > b: a, b = b, a
    return [i for i in range(a, min(b + 1, 10)) if i % 2 == 0]

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(generate_integers_spec(*input, output))

def generate_integers(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
