from typing import List, Union

from fractions import Fraction

def mean_absolute_deviation(l: List[float]) -> Union[float, Fraction]:
    if not l:
        return 0.0
        
    l_frac = [Fraction(x) for x in l]
    n = len(l)
    mu = sum(l_frac) / n
    mad = sum(abs(x - mu) for x in l_frac) / n
    
    return mad

def _orig_problem_4_pre(l: List[float]) -> bool:
    return len(l) > 0

def _orig_problem_4_spec(l: List[float], mad: Union[float, Fraction]) -> bool:
    n = len(l)
    if n == 0:
        return Fraction(mad) == Fraction(0)
    l_frac = [Fraction(x) for x in l]
    mu = sum(l_frac) / n
    acc = sum((abs(x - mu) for x in l_frac))
    expected_mad = acc / n
    return Fraction(mad) == expected_mad

def problem_4_pre(numbers):
    return bool(_orig_problem_4_pre(numbers))

def problem_4_spec(numbers, output):
    return bool(_orig_problem_4_spec(numbers, output))
