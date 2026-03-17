
def precondition(args):
    lst = args[0]
    # Input must be a list
    if not isinstance(lst, list):
        return False
    # All elements must be numbers (int or float)
    for item in lst:
        if not isinstance(item, (int, float)):
            return False
    return True


def postcondition(args, output):
    lst = args[0]
    # Output must be an integer or float
    if not isinstance(output, (int, float)):
        return False
    # Output must be non-negative (sum of squares)
    if output < 0:
        return False
    # Verify the computation
    expected = 0
    for item in lst:
        # Ignore negative numbers
        if item < 0:
            continue
        # Ignore non-integers (floats that are not whole numbers)
        if not isinstance(item, int):
            if isinstance(item, float) and item != int(item):
                continue
            elif isinstance(item, float) and item == int(item):
                item = int(item)
        # Check if odd
        if isinstance(item, int) and item % 2 == 1:
            expected += item * item
    return output == expected

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
