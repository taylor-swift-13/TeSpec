def problem_62_pre(xs: list) -> bool:
    """
    Precondition for the derivative problem.
    In the Coq specification, this is defined as True.
    """
    return True

def problem_62_spec(xs: list, ys: list) -> bool:
    """
    Specification for the derivative of a polynomial.
    xs: coefficients of the polynomial P(x) = xs[0] + xs[1]*x + xs[2]*x^2 + ...
    ys: coefficients of the derivative P'(x).
    
    The specification requires:
    1. len(ys) == max(0, len(xs) - 1)
    2. For all i in range(len(ys)), ys[i] == (i + 1) * xs[i + 1]
    """
    # Coq's Nat.sub (length xs) 1 returns 0 if length xs is 0 or 1.
    expected_len = max(0, len(xs) - 1)
    if len(ys) != expected_len:
        return False
    
    # Check the derivative rule: d/dx (a * x^n) = n * a * x^(n-1)
    for i in range(len(ys)):
        # ys[i] is the coefficient of x^i in the derivative.
        # It corresponds to the coefficient of x^(i+1) in the original polynomial.
        if ys[i] != (i + 1) * xs[i + 1]:
            return False
            
    return True

def derivative(xs: list) -> list:
    """
    xs represent coefficients of a polynomial.
    xs[0] + xs[1] * x + xs[2] * x^2 + ....
    Return derivative of this polynomial in the same form.
    
    >>> derivative([3, 1, 2, 4, 5])
    [1, 4, 12, 20]
    >>> derivative([1, 2, 3])
    [2, 6]
    """
    # If the polynomial is a constant (len <= 1), the derivative is 0 (empty list of coefficients).
    if len(xs) <= 1:
        return []
    
    # For a polynomial P(x) = sum(xs[i] * x^i), 
    # the derivative P'(x) = sum(i * xs[i] * x^(i-1)).
    # The new coefficient at index i is (i+1) * xs[i+1].
    return [(i + 1) * xs[i + 1] for i in range(len(xs) - 1)]
