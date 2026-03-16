
def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) < 1:
        return False
    nums = input[0]
    if not isinstance(nums, (list, tuple)):
        return False
    if len(nums) == 0:
        return False
    for x in nums:
        if isinstance(x, bool):
            return False
        if not isinstance(x, int):
            return False
    return True

def postcondition(input, output):
    if not precondition(input):
        return False
    nums = input[0]
    if isinstance(output, bool):
        return False
    if not isinstance(output, int):
        return False
    # compute expected minimum subarray sum (non-empty) using Kadane-like algorithm for minima
    it = iter(nums)
    try:
        first = next(it)
    except StopIteration:
        return False
    min_ending = first
    min_so_far = first
    for x in it:
        # x is int by precondition
        if x < min_ending + x:
            min_ending = x
        else:
            min_ending = min_ending + x
        if min_ending < min_so_far:
            min_so_far = min_ending
    return output == min_so_far

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
