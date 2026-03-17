
def precondition(inp):
    return isinstance(inp[0], list)

def postcondition(inp, out):
    lst = inp[0]
    expected = sum(x**2 for x in lst if isinstance(x, int) and not isinstance(x, bool) and x >= 0 and x % 2 == 1)
    return out == expected

def _impl(lst):
    """Given a list of numbers, return the sum of squares of the numbers
    in the list that are odd. Ignore numbers that are negative or not integers.

    double_the_difference([1, 3, 2, 0]) == 1 + 9 + 0 + 0 = 10
    double_the_difference([-1, -2, 0]) == 0
    double_the_difference([9, -2]) == 81
    double_the_difference([0]) == 0  

    If the input list is empty, return 0."""
    ans = 0
    for num in lst:
        if num % 2 == 1 and num > 0 and "." not in str(num):
            ans += num ** 2
    return ans

def double_the_difference(lst):
    _input = (lst,)
    assert precondition(_input)
    _output = _impl(lst)
    assert postcondition(_input, _output)
    return _output
