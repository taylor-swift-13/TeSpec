from fractions import Fraction

def poly(xs, x):
    output = 0
    for c in reversed(xs):
        output = c + x * output
    return output

def _orig_find_zero_spec(xs, output):
    if len(xs) % 2 == 0:
        last_val = xs[-1] if len(xs) > 0 else 0
        if last_val != 0:
            try:
                exact_xs = [Fraction(c) for c in xs]
                exact_res = Fraction(output)
                return poly(exact_xs, exact_res) == 0
            except Exception:
                return poly(xs, output) == 0
    return True

def find_zero_spec(xs, output):
    return bool(_orig_find_zero_spec(xs, output))
