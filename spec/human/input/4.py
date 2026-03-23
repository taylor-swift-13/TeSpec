from typing import List, Union
from fractions import Fraction

def problem_4_pre(l: List[float]) -> bool:
    return len(l) > 0

def problem_4_spec(l: List[float], mad: Union[float, Fraction]) -> bool:
    n = len(l)
    if n == 0:
        return Fraction(mad) == Fraction(0)

    l_frac = [Fraction(x) for x in l]
    
    # Calculate mean
    # Coq: fold_right Rplus 0 l / INR n
    # Fraction addition is associative and commutative, so sum() is equivalent to fold_right.
    mu = sum(l_frac) / n
    
    # Calculate MAD
    # Coq: fold_right (fun x acc => acc + Rabs (x - mu)) 0 l / INR n
    acc = sum(abs(x - mu) for x in l_frac)
    expected_mad = acc / n
    
    return Fraction(mad) == expected_mad

def mean_absolute_deviation(l: List[float]) -> Union[float, Fraction]:
    if not l:
        return 0.0
        
    l_frac = [Fraction(x) for x in l]
    n = len(l)
    mu = sum(l_frac) / n
    mad = sum(abs(x - mu) for x in l_frac) / n
    
    return mad
