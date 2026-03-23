from fractions import Fraction
import math

def _orig_rescale_to_unit_spec(numbers, output):
    if not numbers:
        return False
    if len(numbers) != len(output):
        return False
    mi = min(numbers)
    ma = max(numbers)
    if mi == ma:
        return False
    expected = [(x - mi) / (ma - mi) for x in numbers]
    return all(math.isclose(a, b, rel_tol=1e-12, abs_tol=1e-12) for a, b in zip(output, expected))

def rescale_to_unit_spec(numbers, output):
    return bool(_orig_rescale_to_unit_spec(numbers, output))
