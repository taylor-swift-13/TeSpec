def _orig_fib4_spec(n: int, output: int) -> bool:
    """
    Python implementation of the Coq fib4_spec.
    
    The Coq specification defines the valid results for inputs n=0, 1, 2, 3 explicitly.
    For n >= 4, the specification contains a logical contradiction:
    It asserts the existence of a, b, c, d initialized to 0, 0, 2, 0, and then requires
    that for all k (4 <= k <= n), these fixed values satisfy the update equations:
    (a, b, c, d) = (b, c, d, a+b+c+d).
    Substituting the values: (0, 0, 2, 0) = (0, 2, 0, 2).
    This implies 0 = 2, which is false.
    Therefore, the specification is unsatisfiable (always False) for n >= 4.
    """
    if n == 0:
        return output == 0
    if n == 1:
        return output == 0
    if n == 2:
        return output == 2
    if n == 3:
        return output == 0
    if n >= 4:
        return False
    return False

def fib4_spec(n, output):
    return bool(_orig_fib4_spec(n, output))
