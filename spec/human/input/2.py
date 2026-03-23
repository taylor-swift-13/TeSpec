import math

def truncate_number(x: float) -> float:
    """
    Given a positive floating point number, it can be decomposed into
    an integer part (largest integer smaller than given number) and decimals
    (leftover part always smaller than 1).

    Return the decimal part of the number.
    >>> truncate_number(3.5)
    0.5
    """
    # The integer part (largest integer <= x) is math.floor(x).
    # The decimal part is the leftover: x - floor(x).
    return x - math.floor(x)

def _orig_problem_2_pre(x: float) -> bool:
    """
    Definition problem_2_pre(x : R) : Prop :=
      x > 0.
    """
    return x > 0

def _orig_problem_2_spec(x: float, frac: float) -> bool:
    """
    Definition problem_2_spec (x frac : R) : Prop :=
      frac = x - IZR (floor x) /      0 <= frac < 1.
    """
    expected_frac = x - math.floor(x)
    return frac == expected_frac and 0 <= frac < 1

def problem_2_pre(number):
    return bool(_orig_problem_2_pre(number))

def problem_2_spec(number, output):
    return bool(_orig_problem_2_spec(number, output))
