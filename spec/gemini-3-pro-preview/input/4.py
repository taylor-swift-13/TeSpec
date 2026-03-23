from fractions import Fraction

def sum_R(l):
    res = Fraction(0)
    for h in l:
        res += h
    return res

def Rdiv(x, y):
    # In Coq's Reals, division x / y is defined as x * /y.
    # Since 0 * r = 0 for any real r, 0 / 0 = 0 * /0 = 0.
    if y == 0:
        return Fraction(0)
    return x / y

def mean_absolute_deviation_spec(numbers, result):
    def to_frac(x):
        if isinstance(x, float):
            # Convert float to string first to recover exact decimal representation
            # (e.g., 0.1 becomes 1/10 instead of its binary float approximation).
            return Fraction(str(x))
        return Fraction(x)

    f_numbers = [to_frac(x) for x in numbers]
    f_result = to_frac(result)
    
    f_len = Fraction(len(f_numbers))
    
    mean = Rdiv(sum_R(f_numbers), f_len)
    
    diffs = [abs(x - mean) for x in f_numbers]
    
    expected = Rdiv(sum_R(diffs), f_len)
    
    return f_result == expected
