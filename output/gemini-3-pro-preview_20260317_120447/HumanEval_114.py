
def precondition(input_args):
    if not isinstance(input_args, tuple) or len(input_args) != 1:
        return False
    nums = input_args[0]
    if not isinstance(nums, (list, tuple)) or len(nums) == 0:
        return False
    return all(isinstance(x, int) for x in nums)

def postcondition(input_args, output):
    nums = input_args[0]
    if not isinstance(output, int):
        return False
    
    n = len(nums)
    found_sum = False
    for i in range(n):
        current_sum = 0
        for j in range(i, n):
            current_sum += nums[j]
            if current_sum < output:
                return False
            if current_sum == output:
                found_sum = True
    
    return found_sum

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
