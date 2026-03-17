
def precondition(args):
    nums = args[0]
    if not isinstance(nums, list):
        return False
    if len(nums) == 0:
        return False
    for x in nums:
        if not isinstance(x, int):
            return False
    return True


def postcondition(args, output):
    nums = args[0]
    if not isinstance(output, int):
        return False
    # output must be <= every element (since single elements are valid subarrays)
    if output > min(nums):
        return False
    # output must be achievable as some subarray sum
    n = len(nums)
    for i in range(n):
        s = 0
        for j in range(i, n):
            s += nums[j]
            if s == output:
                return True
    return False

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
