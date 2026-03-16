
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

def postcondition(args, result):
    nums = args[0]
    if not isinstance(result, int):
        return False
    if len(nums) == 1:
        return result == nums[0]
    return True

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
