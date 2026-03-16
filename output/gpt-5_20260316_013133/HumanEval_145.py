
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
    if not precondition(input):
        return True
    nums = input[0]
    if not isinstance(output, list):
        return False
    if len(output) != len(nums):
        return False
    for x in output:
        if not isinstance(x, int):
            return False
    def digit_sum(n):
        return sum(int(d) for d in str(abs(n)))
    # Multiset equality
    def counts(lst):
        c = {}
        for v in lst:
            c[v] = c.get(v, 0) + 1
        return c
    if counts(nums) != counts(output):
        return False
    # Ascending by digit sum
    for i in range(len(output) - 1):
        if digit_sum(output[i]) > digit_sum(output[i + 1]):
            return False
    # Stability by original index when digit sums are equal
    expected = [nums[i] for i in sorted(range(len(nums)), key=lambda i: (digit_sum(nums[i]), i))]
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
