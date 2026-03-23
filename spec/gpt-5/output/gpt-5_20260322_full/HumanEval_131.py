def val10(ds):
    res = 0
    multiplier = 1
    for d in ds:
        res += d * multiplier
        multiplier *= 10
    return res

def digit(d):
    return 0 <= d < 10

def digits_range(ds):
    return all(digit(d) for d in ds)

def prod_odd(ds):
    res = 1
    for d in ds:
        if d % 2 != 0:
            res *= d
    return res

def has_oddb(ds):
    for d in ds:
        if d % 2 != 0:
            return True
    return False

def decimal_digits(n, ds):
    return n > 0 and val10(ds) == n and digits_range(ds)

def digits_spec(n, res):
    if n <= 0:
        return False
    
    temp = n
    ds = []
    while temp > 0:
        ds.append(temp % 10)
        temp //= 10
        
    expected_res = prod_odd(ds) if has_oddb(ds) else 0
    return res == expected_res

def _impl(n):
    has_odd, prod = False, 1
    for ch in str(n):
        if int(ch) % 2 == 1:
            has_odd = True
            prod *= int(ch)
    return 0 if not has_odd else prod

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(digits_spec(*input, output))

def digits(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
