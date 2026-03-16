
from collections import Counter

def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    nums = input[0]
    if not isinstance(nums, list):
        return False
    for x in nums:
        if not isinstance(x, int):
            return False
    return True

def postcondition(input, output):
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    nums = input[0]
    if not isinstance(nums, list):
        return False
    if not isinstance(output, list):
        return False
    if len(output) != len(nums):
        return False
    if not all(isinstance(x, int) for x in output):
        return False
    if Counter(output) != Counter(nums):
        return False

    def sum_digits(n):
        s = 0
        m = abs(n)
        if m == 0:
            return 0
        while m:
            s += m % 10
            m //= 10
        return s

    expected = sorted(nums, key=sum_digits)
    if output != expected:
        return False

    return True

def _impl(nums):
    """Write a function which sorts the given list of integers
    in ascending order according to the sum of their digits.
    Note: if there are several items with similar sum of their digits,
    order them based on their index in original list.

    For example:"""
    def weight(x):
        x_list = list(str(x))
        if x_list[0] == "-":
            x_list = x_list[1:]
            x_list = list(map(int, x_list))
            x_list[0] = -x_list[0]
        else:
            x_list = list(map(int, x_list))
        return sum(x_list)
    return sorted(nums, key=weight)

def order_by_points(nums):
    _input = (nums,)
    assert precondition(_input)
    _output = _impl(nums)
    assert postcondition(_input, _output)
    return _output
