from fractions import Fraction

# Old incorrect translation:
# def _orig_median_spec(l, output):
#     n = len(l)
#     if n == 0:
#         return False
#     sorted_l = sorted(l)
#     if n % 2 != 0:
#         expected = Fraction(sorted_l[n // 2])
#     else:
#         expected = Fraction(sorted_l[n // 2 - 1] + sorted_l[n // 2], 2)
#     return output == expected
def _orig_median_spec(l, output):
    n = len(l)
    if n == 0:
        return False
    if not all(type(x) is int for x in l):
        return False
    sorted_l = sorted(l)
    if n % 2 != 0:
        expected = sorted_l[n // 2]
    else:
        expected = (sorted_l[n // 2 - 1] + sorted_l[n // 2]) / 2
    return output == expected

def median_spec(l, output):
    return bool(_orig_median_spec(l, output))
