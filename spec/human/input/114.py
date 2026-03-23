def list_sum(l):
    """
    Computes the sum of a list of integers.
    Coq: fold_left Z.add l 0
    """
    return sum(l)

def _orig_problem_114_pre(nums):
    """
    Precondition: nums is not empty.
    Coq: nums <> []
    """
    return nums != []

def _orig_problem_114_spec(nums, min_sum):
    """
    Specification:
    1. Existence: There exists a non-empty sub-array with sum equal to min_sum.
    2. Minimality: For all non-empty sub-arrays, their sum is >= min_sum.
    
    This function returns True if min_sum is indeed the minimum sum of any 
    non-empty sub-array of nums, and False otherwise.
    """
    if not nums:
        return False
    current_min = nums[0]
    global_min = nums[0]
    for x in nums[1:]:
        current_min = min(x, current_min + x)
        global_min = min(global_min, current_min)
    return global_min == min_sum

def problem_114_pre(nums):
    return bool(_orig_problem_114_pre(nums))

def problem_114_spec(nums, output):
    return bool(_orig_problem_114_spec(nums, output))
