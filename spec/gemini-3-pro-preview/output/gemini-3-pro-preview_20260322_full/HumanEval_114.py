def sum_list(l):
    res = 0
    for x in l:
        res += x
    return res

def minSubArraySum_spec(nums, ans):
    if not nums:
        return False
    
    min_ending_here = nums[0]
    min_so_far = nums[0]
    
    for x in nums[1:]:
        min_ending_here = min(x, min_ending_here + x)
        min_so_far = min(min_so_far, min_ending_here)
        
    return min_so_far == ans

def _impl(nums):
    if all(x >= 0 for x in nums): return min(nums)
    s, ans = 0, 0
    for x in nums:
        s += x
        ans = min(ans, s)
        if s >= 0: s = 0
    return ans

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(minSubArraySum_spec(*input, output))

def minSubArraySum(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
