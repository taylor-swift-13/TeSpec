
def precondition(input_args) -> bool:
    return len(input_args) == 1 and isinstance(input_args[0], (list, tuple))

def postcondition(input_args, output) -> bool:
    lst = input_args[0]
    expected_sum = 0
    for x in lst:
        if isinstance(x, int) and x >= 0 and x % 2 != 0:
            expected_sum += x**2
    return output == expected_sum

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
