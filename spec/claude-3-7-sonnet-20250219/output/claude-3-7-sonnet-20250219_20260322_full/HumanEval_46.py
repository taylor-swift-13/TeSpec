def fib4_spec(n: int, result: int) -> bool:
    """
    Python implementation of the Coq fib4_spec.
    The specification defines fib4_spec(n, result) as a proposition.
    This function returns True if the proposition holds for the given n and result, and False otherwise.
    """
    # Case: n = 0
    if n == 0:
        return result == 0
    
    # Case: n = 1
    if n == 1:
        return result == 0
    
    # Case: n = 2
    if n == 2:
        return result == 2
    
    # Case: n = 3
    if n == 3:
        return result == 0
    
    # Case: n >= 4
    if n >= 4:
        # The Coq specification for n >= 4 is:
        # exists a b c d i, a = 0 /\ b = 0 /\ c = 2 /\ d = 0 /\ i = 4 /\
        # (forall k, 4 <= k <= n -> exists a' b' c' d',
        #   a' = b /\ b' = c /\ c' = d /\ d' = a + b + c + d /\
        #   (a, b, c, d) = (a', b', c', d')) /\ d = result
        #
        # Analysis:
        # 1. a, b, c, d are fixed to 0, 0, 2, 0 respectively.
        # 2. For any k such that 4 <= k <= n, there must exist a', b', c', d' such that:
        #    a' = b = 0
        #    b' = c = 2
        #    c' = d = 0
        #    d' = a + b + c + d = 0 + 0 + 2 + 0 = 2
        #    AND (a, b, c, d) = (a', b', c', d')
        # 3. Substituting the values, (0, 0, 2, 0) = (0, 2, 0, 2) must hold.
        # 4. Since (0, 0, 2, 0) != (0, 2, 0, 2), the condition is False for any k >= 4.
        # 5. Since n >= 4, there is at least one such k (k=4).
        # 6. Therefore, the entire exists clause is False for all n >= 4.
        return False

    # For any other n (e.g., n < 0), the spec does not provide a branch, so it is False.
    return False

def _impl(n: int):
    if n == 0:
        return 0
    elif n == 1:
        return 0
    elif n == 2:
        return 2
    elif n == 3:
        return 0
    else:
        a, b, c, d = 0, 0, 2, 0
        for i in range(4, n + 1):
            a, b, c, d = b, c, d, a + b + c + d
        return d

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(fib4_spec(*input, output))

def fib4(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
