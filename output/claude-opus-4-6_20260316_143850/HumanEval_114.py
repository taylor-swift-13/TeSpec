
def precondition(input):
    nums = input[0]
    if not isinstance(nums, list):
        return False
    if len(nums) == 0:
        return False
    for x in nums:
        if not isinstance(x, (int, float)):
            return False
    return True

def postcondition(input, output):
    nums = input[0]
    if not isinstance(output, (int, float)):
        return False
    n = len(nums)
    # output must equal the minimum sum over all non-empty contiguous sub-arrays
    min_sum = None
    for i in range(n):
        current_sum = 0
        for j in range(i, n):
            current_sum += nums[j]
            if min_sum is None or current_sum < min_sum:
                min_sum = current_sum
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
