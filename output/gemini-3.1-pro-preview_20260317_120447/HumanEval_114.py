
def precondition(inp):
    if not isinstance(inp, tuple) or len(inp) != 1:
        return False
    nums = inp[0]
    if not isinstance(nums, list) or len(nums) == 0:
        return False
    return all(isinstance(x, int) for x in nums)

def postcondition(inp, out):
    if not isinstance(inp, tuple) or len(inp) != 1:
        return False
    nums = inp[0]
    if not isinstance(nums, list) or len(nums) == 0:
        return False
    if not isinstance(out, (int, float)):
        return False
    
    min_ending_here = min_so_far = nums[0]
    for x in nums[1:]:
        min_ending_here = min(x, min_ending_here + x)
        min_so_far = min(min_so_far, min_ending_here)
        
    return out == min_so_far

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
