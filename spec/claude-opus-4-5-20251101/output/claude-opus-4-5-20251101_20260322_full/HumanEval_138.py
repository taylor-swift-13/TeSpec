def is_equal_to_sum_even_spec(n: int, result: bool) -> bool:
    """
    Implementation of the Coq specification:
    result = true <-> (n >= 8 /\ Z.even n = true /\ 
      exists a b c d : Z, a > 0 /\ b > 0 /\ c > 0 /\ d > 0 /\
                          Z.even a = true /\ Z.even b = true /\ 
                          Z.even c = true /\ Z.even d = true /\
                          n = a + b + c + d)
    """
    
    # Analysis of the condition:
    # 1. a, b, c, d are positive even integers, so each must be at least 2.
    # 2. If such a, b, c, d exist, their sum n = a + b + c + d must be at least 2 + 2 + 2 + 2 = 8.
    # 3. Since a, b, c, d are even, their sum n must also be even.
    # 4. Conversely, if n is even and n >= 8, we can always find such a, b, c, d.
    #    For example, let a = 2, b = 2, c = 2, and d = n - 6.
    #    Since n is even, n - 6 is even. Since n >= 8, n - 6 >= 2.
    #    Thus, a, b, c, d are all positive even integers that sum to n.
    #
    # Therefore, the condition (n >= 8 /\ Z.even n = true /\ exists a b c d ...)
    # is equivalent to (n >= 8 and n % 2 == 0).

    condition = (n >= 8 and n % 2 == 0)
    
    # The spec result = true <-> condition is equivalent to result == condition in Python.
    return result == condition

def _impl(n):
    return n >= 8 and n % 2 == 0

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(is_equal_to_sum_even_spec(*input, output))

def is_equal_to_sum_even(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
