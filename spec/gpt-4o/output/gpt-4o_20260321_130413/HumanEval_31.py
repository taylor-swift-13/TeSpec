def is_prime_spec(n: int, result: bool) -> bool:
    # (n <= 1 -> result = false)
    if n <= 1:
        return result == False
    
    # (n > 1 -> (exists i, 2 <= i < n /\ n mod i = 0 -> result = false) /\
    #           (forall i, 2 <= i < n -> n mod i <> 0 -> result = true))
    
    # Part 1: exists i, (2 <= i < n /\ n mod i = 0) -> result = false
    # In Coq, the implication (P -> Q) is True if P is False.
    # For any n > 1, we can pick i = 0. 
    # The condition (2 <= 0 < n /\ n mod 0 = 0) is False.
    # Thus, (False -> result = false) is True.
    # So the 'exists' part is always True for any n > 1.
    part1 = True
    
    # Part 2: forall i, 2 <= i < n -> (n mod i <> 0 -> result = true)
    # This means if there is any i in [2, n) such that n % i != 0, then result must be True.
    part2 = True
    for i in range(2, n):
        if n % i != 0:
            if result != True:
                part2 = False
                break
    
    return part1 and part2

def _impl(n):
    if n <= 1: return False
    n_sqrt = 1
    while n_sqrt ** 2 < n: n_sqrt += 1
    for i in range(2, min(n_sqrt + 1, n)):
        if n % i == 0:
            return False
    return True

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(is_prime_spec(*input, output))

def is_prime(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
