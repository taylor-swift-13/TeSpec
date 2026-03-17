
def precondition(input):
    if len(input) != 1:
        return False
    nums = input[0]
    if not isinstance(nums, list):
        return False
    if len(nums) == 0:
        return False
    for x in nums:
        if not isinstance(x, int):
            return False
    return True

def postcondition(input, output):
    nums = input[0]
    if not isinstance(output, int):
        return False
    # Output must be achievable by some non-empty subarray
    found = False
    for i in range(len(nums)):
        current_sum = 0
        for j in range(i, len(nums)):
            current_sum += nums[j]
            if current_sum == output:
                found = True
            # Output should be <= all subarray sums (it's the minimum)
            if current_sum < output:
                return False
    return found

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
