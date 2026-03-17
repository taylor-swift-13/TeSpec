
def precondition(input):
    nums = input[0]
    return isinstance(nums, list) and len(nums) > 0 and all(isinstance(x, int) for x in nums)

def postcondition(input, output):
    nums = input[0]
    
    # Check if output is an integer
    if not isinstance(output, int):
        return False
    
    # Check if output is actually a sum of some subarray
    found = False
    for i in range(len(nums)):
        current_sum = 0
        for j in range(i, len(nums)):
            current_sum += nums[j]
            if current_sum == output:
                found = True
                break
        if found:
            break
    
    if not found:
        return False
        
    # Check if output is indeed the minimum
    for i in range(len(nums)):
        current_sum = 0
        for j in range(i, len(nums)):
            current_sum += nums[j]
            if current_sum < output:
                return False
                
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
