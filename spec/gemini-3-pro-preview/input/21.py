from fractions import Fraction

def rescale_to_unit_spec(numbers, result):
    if not numbers:
        return False

    try:
        # Use Fraction for exact arithmetic to match Coq's Real semantics
        # and avoid floating point rounding errors.
        nums_frac = [Fraction(x) for x in numbers]
        res_frac = [Fraction(x) for x in result]
    except (ValueError, TypeError, OverflowError):
        return False

    mi = min(nums_frac)
    ma = max(nums_frac)

    if mi == ma:
        return False

    if len(nums_frac) != len(res_frac):
        return False

    try:
        scale = Fraction(1) / (ma - mi)
        expected = [(x - mi) * scale for x in nums_frac]
        return res_frac == expected
    except ZeroDivisionError:
        return False
