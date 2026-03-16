
def precondition(input):
    n, = input
    return isinstance(n, int) and n > 0

def postcondition(input, output):
    n, = input
    if not isinstance(output, list):
        return False
    if len(output) != n:
        return False
    if n == 0:
        return False
    for stones in output:
        if not isinstance(stones, int) or stones <= 0:
            return False
    for i in range(n):
        if i == 0:
            if output[i] != n:
                return False
        else:
            if output[i] % 2 != (n + i) % 2:
                return False
            if output[i] <= output[i-1]:
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
