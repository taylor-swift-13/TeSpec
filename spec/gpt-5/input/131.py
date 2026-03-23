def val10(ds):
    output = 0
    multiplier = 1
    for d in ds:
        output += d * multiplier
        multiplier *= 10
    return output

def digit(d):
    return 0 <= d < 10

def digits_range(ds):
    return all(digit(d) for d in ds)

def prod_odd(ds):
    output = 1
    for d in ds:
        if d % 2 != 0:
            output *= d
    return output

def has_oddb(ds):
    for d in ds:
        if d % 2 != 0:
            return True
    return False

def decimal_digits(n, ds):
    return n > 0 and val10(ds) == n and digits_range(ds)

def _orig_digits_spec(n, output):
    if n <= 0:
        return False
    temp = n
    ds = []
    while temp > 0:
        ds.append(temp % 10)
        temp //= 10
    expected_res = prod_odd(ds) if has_oddb(ds) else 0
    return output == expected_res

def digits_spec(n, output):
    return bool(_orig_digits_spec(n, output))
