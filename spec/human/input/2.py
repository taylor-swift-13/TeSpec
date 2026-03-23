import math

def problem_2_pre(x: float) -> bool:
    """
    Definition problem_2_pre(x : R) : Prop :=
      x > 0.
    """
    return x > 0

def problem_2_spec(x: float, frac: float) -> bool:
    """
    Definition problem_2_spec (x frac : R) : Prop :=
      frac = x - IZR (floor x) /\
      0 <= frac < 1.
    """
    # In Coquelicot/Reals, floor(x) is the largest integer n such that n <= x.
    # Python's math.floor(x) provides the same behavior.
    expected_frac = x - math.floor(x)
    # We use strict equality to match the Coq '=' operator.
    return frac == expected_frac and 0 <= frac < 1

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
