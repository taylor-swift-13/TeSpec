def generate_integers_spec(a, b, res):
    lo = min(a, b)
    hi = min(max(a, b), 9)
    
    if lo <= hi:
        # List.seq lo (S (Nat.sub hi lo)) generates numbers from lo to hi inclusive.
        # List.filter (fun i => Nat.even i) keeps only even numbers.
        expected = [i for i in range(lo, hi + 1) if i % 2 == 0]
    else:
        expected = []
        
    return res == expected

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
