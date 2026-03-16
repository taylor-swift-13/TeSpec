
def precondition(input):
    # input is a tuple of positional arguments
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    nums = input[0]
    if not isinstance(nums, (list, tuple)):
        return False
    if len(nums) < 1:
        return False
    for x in nums:
        if not isinstance(x, int):
            return False
    return True

def postcondition(input, output):
    # Validate input shape
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    nums = input[0]
    if not isinstance(nums, (list, tuple)) or len(nums) < 1:
        return False
    if not isinstance(output, int):
        return False

    n = len(nums)
    min_sum = None
    for i in range(n):
        s = 0
        for j in range(i, n):
            s += nums[j]
            if min_sum is None or s < min_sum:
                min_sum = s
    if min_sum is None:
        return False
    return output == min_sum

def _impl(nums):
    """Given an array of integers nums, find the minimum sum of any non-empty sub-array
    of nums.
    Example
    minSubArraySum([2, 3, 4, 1, 2, 4]) == 1
    minSubArraySum([-1, -2, -3]) == -6"""
    if all(x >= 0 for x in nums): return min(nums)
    s, ans = 0, 0
    for x in nums:
        s += x
        ans = min(ans, s)
        if s >= 0: s = 0
    return ans

def minSubArraySum(nums):
    _input = (nums,)
    assert precondition(_input)
    _output = _impl(nums)
    assert postcondition(_input, _output)
    return _output
