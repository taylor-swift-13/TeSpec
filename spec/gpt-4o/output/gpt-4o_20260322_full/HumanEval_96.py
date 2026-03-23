def count_up_to_spec(n, ans):
    """
    Python implementation of the Coq specification count_up_to_spec.
    The specification defines that 'ans' is a list containing exactly the prime numbers
    in the range [2, n).
    """
    
    def is_prime_helper(x):
        """
        Checks the primality condition defined in the spec:
        (forall d, 2 <= d < x -> x mod d <> 0)
        """
        # For x < 2, the range 2 <= d < x is empty, so the condition is vacuously true.
        # However, the spec only applies this to x where 2 <= x < n.
        for d in range(2, x):
            if x % d == 0:
                return False
        return True

    # Part 1: (forall x, In x ans -> 2 <= x < n /\ (forall d, 2 <= d < x -> x mod d <> 0))
    # Every element in the list 'ans' must be a prime number and must be in the range [2, n).
    for x in ans:
        if not (2 <= x < n):
            return False
        if not is_prime_helper(x):
            return False

    # Part 2: (forall x, 2 <= x < n -> (forall d, 2 <= d < x -> x mod d <> 0) -> In x ans)
    # Every prime number in the range [2, n) must be present in the list 'ans'.
    for x in range(2, n):
        if is_prime_helper(x):
            if x not in ans:
                return False
    
    return True

def _impl(n):
    ans = []
    isprime = [True] * (n + 1)
    for i in range(2, n):
        if isprime[i]:
            ans.append(i)
            for j in range(i + i, n, i):
                isprime[j] = False
    return ans

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(count_up_to_spec(*input, output))

def count_up_to(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
