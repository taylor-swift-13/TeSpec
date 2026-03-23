def is_subarray(sub, arr):
    n = len(sub)
    m = len(arr)
    if n == 0:
        return True
    for i in range(m - n + 1):
        if arr[i:i+n] == sub:
            return True
    return False

def non_empty(l):
    return len(l) > 0

def sum_list(l):
    return sum(l)

def minSubArraySum_spec(nums, result):
    if not nums:
        return False
    
    min_ending_here = min_so_far = nums[0]
    for x in nums[1:]:
        min_ending_here = min(x, min_ending_here + x)
        min_so_far = min(min_so_far, min_ending_here)
        
    return min_so_far == result

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
