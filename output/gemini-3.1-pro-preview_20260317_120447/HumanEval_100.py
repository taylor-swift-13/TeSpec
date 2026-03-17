
def precondition(inp):
    n, = inp
    return type(n) is int and n > 0

def postcondition(inp, out):
    n, = inp
    if type(out) is not list:
        return False
    return out == [n + 2 * i for i in range(n)]

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
