
def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    nums = input[0]
    if not isinstance(nums, list):
        return False
    for v in nums:
        if not isinstance(v, int):
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

    def digit_sum(n):
        n = abs(n)
        s = 0
        if n == 0:
            return 0
        while n:
            s += n % 10
            n //= 10
        return s

    sums = [digit_sum(n) for n in nums]
    sorted_indices = sorted(range(len(nums)), key=lambda i: (sums[i], i))
    expected = [nums[i] for i in sorted_indices]
    return output == expected

def _impl(nums):
    """
    Write a function which sorts the given list of integers
    in ascending order according to the sum of their digits.
    Note: if there are several items with similar sum of their digits,
    order them based on their index in original list.

    For example:
    """
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
