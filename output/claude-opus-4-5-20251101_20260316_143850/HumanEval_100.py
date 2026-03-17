
def precondition(args):
    n = args[0]
    # n must be a positive integer
    if not isinstance(n, int):
        return False
    if isinstance(n, bool):
        return False
    if n <= 0:
        return False
    return True

def postcondition(args, output):
    n = args[0]
    # Output must be a list
    if not isinstance(output, list):
        return False
    # Output must have exactly n elements (n levels)
    if len(output) != n:
        return False
    # All elements must be positive integers
    for stone in output:
        if not isinstance(stone, int):
            return False
        if stone <= 0:
            return False
    # First level must have n stones
    if output[0] != n:
        return False
    # Check parity: all elements must have same parity as n
    expected_parity = n % 2
    for stone in output:
        if stone % 2 != expected_parity:
            return False
    # Each subsequent level must have 2 more stones than previous
    for i in range(1, len(output)):
        if output[i] != output[i-1] + 2:
            return False
    return True

def _impl(n):
    """Given a positive integer n, you have to make a pile of n levels of stones.
    The first level has n stones.
    The number of stones in the next level is:
        - the next odd number if n is odd.
        - the next even number if n is even.
    Return the number of stones in each level in a list, where element at index
    i represents the number of stones in the level (i+1).

    Examples:
    [3, 5, 7]"""
    ans, num = [], n
    for _ in range(n):
        ans.append(num)
        num += 2
    return ans

def make_a_pile(n):
    _input = (n,)
    assert precondition(_input)
    _output = _impl(n)
    assert postcondition(_input, _output)
    return _output
