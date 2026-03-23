def sum_list(l):
    res = 0
    for x in l:
        res += x
    return res

def _orig_minSubArraySum_spec(nums, output):
    if not nums:
        return False
    min_ending_here = nums[0]
    min_so_far = nums[0]
    for x in nums[1:]:
        min_ending_here = min(x, min_ending_here + x)
        min_so_far = min(min_so_far, min_ending_here)
    return min_so_far == output

def minSubArraySum_spec(nums, output):
    return bool(_orig_minSubArraySum_spec(nums, output))
