def list_sum(l):
    """
    Computes the sum of a list of integers.
    Coq: fold_left Z.add l 0
    """
    return sum(l)

def problem_114_pre(nums):
    """
    Precondition: nums is not empty.
    Coq: nums <> []
    """
    return nums != []

def problem_114_spec(nums, min_sum):
    """
    Specification:
    1. Existence: There exists a non-empty sub-array with sum equal to min_sum.
    2. Minimality: For all non-empty sub-arrays, their sum is >= min_sum.
    
    This function returns True if min_sum is indeed the minimum sum of any 
    non-empty sub-array of nums, and False otherwise.
    """
    if not nums:
        return False

    # To verify the spec efficiently, we calculate the actual minimum subarray sum
    # using a variation of Kadane's algorithm and compare it to min_sum.
    
    current_min = nums[0]
    global_min = nums[0]
    
    for x in nums[1:]:
        # At each step, we decide whether to start a new subarray at x
        # or extend the existing subarray ending at the previous position.
        # We choose the one that gives a smaller sum.
        current_min = min(x, current_min + x)
        global_min = min(global_min, current_min)
        
    return global_min == min_sum

def _impl(nums):
    if all(x >= 0 for x in nums): return min(nums)
    s, ans = 0, 0
    for x in nums:
        s += x
        ans = min(ans, s)
        if s >= 0: s = 0
    return ans

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_114_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_114_spec(*input, output))

def minSubArraySum(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
