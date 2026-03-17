
def precondition(input):
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
    nums = input[0]
    if not isinstance(output, list):
        return False
    if len(output) != len(nums):
        return False
    if sorted(output) != sorted(nums):
        return False
    def digit_sum(n):
        return sum(int(d) for d in str(abs(n)))
    for i in range(len(output) - 1):
        ds_i = digit_sum(output[i])
        ds_next = digit_sum(output[i + 1])
        if ds_i > ds_next:
            return False
        if ds_i == ds_next:
            if nums.index(output[i]) > nums.index(output[i + 1]):
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
