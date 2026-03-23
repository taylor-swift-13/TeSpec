def foldl_Z(f, acc, l):
    for x in l:
        acc = f(acc, x)
    return acc

def eval_digits(base, ds):
    return foldl_Z(lambda acc, d: acc * base + d, 0, ds)

def string_of_digits(ds):
    res = []
    for d in ds:
        # Z.to_nat d is 0 if d < 0, else d
        nat_d = d if d >= 0 else 0
        # ascii_of_nat takes n mod 256
        code = (48 + nat_d) % 256
        res.append(chr(code))
    return "".join(res)

def digits_range(base, ds):
    return all(0 <= t < base for t in ds)

def _orig_change_base_spec(x, base, output):
    if not 0 <= x:
        return False
    if not 2 <= base <= 9:
        return False
    if x == 0:
        return output == '0'
    else:
        if not output:
            return False
        digits = []
        for c in output:
            digits.append(ord(c) - 48)
        if not digits:
            return False
        d = digits[0]
        ds = digits[1:]
        if not 1 <= d < base:
            return False
        if not digits_range(base, ds):
            return False
        if eval_digits(base, digits) != x:
            return False
        return True

def change_base_spec(x, base, output):
    return bool(_orig_change_base_spec(x, base, output))
