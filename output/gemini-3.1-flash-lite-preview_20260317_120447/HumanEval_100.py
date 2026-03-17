
def precondition(input):
    n = input[0]
    return isinstance(n, int) and n > 0

def postcondition(input, output):
    n = input[0]
    if not isinstance(output, list) or len(output) != n:
        return False
    
    if output[0] != n:
        return False
    
    for i in range(1, n):
        expected = output[i-1] + 2
        if output[i] != expected:
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
