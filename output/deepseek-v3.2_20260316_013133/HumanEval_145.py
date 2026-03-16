
def precondition(input):
    nums, = input
    return isinstance(nums, list) and all(isinstance(x, int) for x in nums)

def postcondition(input, output):
    nums, = input
    if not isinstance(output, list):
        return False
    if len(output) != len(nums):
        return False
    if set(output) != set(nums):
        return False
    def digit_sum(n):
        return sum(int(d) for d in str(abs(n)))
    for i in range(len(output) - 1):
        si = digit_sum(output[i])
        sj = digit_sum(output[i + 1])
        if si > sj:
            return False
        if si == sj:
            idx_i = nums.index(output[i])
            idx_j = nums.index(output[i + 1])
            if idx_i > idx_j:
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
