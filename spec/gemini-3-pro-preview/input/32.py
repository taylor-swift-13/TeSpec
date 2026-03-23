from fractions import Fraction

def poly(xs, x):
    res = 0
    for c in reversed(xs):
        res = c + x * res
    return res

def find_zero_spec(xs, res):
    if len(xs) % 2 == 0:
        last_val = xs[-1] if len(xs) > 0 else 0
        if last_val != 0:
            try:
                exact_xs = [Fraction(c) for c in xs]
                exact_res = Fraction(res)
                return poly(exact_xs, exact_res) == 0
            except Exception:
                return poly(xs, res) == 0
    return True
