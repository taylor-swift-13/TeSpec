def fib4_spec(n: int, result: int) -> bool:
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
        return result == 0
    if n == 1:
        return result == 0
    if n == 2:
        return result == 2
    if n == 3:
        return result == 0
    
    # For n >= 4, the spec is always False due to the contradiction described above.
    if n >= 4:
        return False
        
    # For n < 0, the spec is not defined (False).
    return False
