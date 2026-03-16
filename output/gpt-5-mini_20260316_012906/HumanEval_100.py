
def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    n = input[0]
    # must be an integer greater than 0, exclude booleans
    if not isinstance(n, int) or isinstance(n, bool):
        return False
    if n <= 0:
        return False
    return True

def postcondition(input, output):
    # Postcondition only required when precondition holds
    if not precondition(input):
        return True
    n = input[0]
    # output must be a list of length n
    if not isinstance(output, list):
        return False
    if len(output) != n:
        return False
    # all elements must be positive integers (exclude booleans)
    for x in output:
        if not isinstance(x, int) or isinstance(x, bool):
            return False
        if x <= 0:
            return False
    # first element must equal n
    if output[0] != n:
        return False
    # all elements must have same parity as n and increase by 2 each level
    parity = n % 2
    for i in range(n):
        if output[i] % 2 != parity:
            return False
        if i > 0 and output[i] != output[i-1] + 2:
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
