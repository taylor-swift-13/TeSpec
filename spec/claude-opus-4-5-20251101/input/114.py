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

def _orig_minSubArraySum_spec(nums, output):
    if not nums:
        return False
    min_ending_here = min_so_far = nums[0]
    for x in nums[1:]:
        min_ending_here = min(x, min_ending_here + x)
        min_so_far = min(min_so_far, min_ending_here)
    return min_so_far == output

def minSubArraySum_spec(nums, output):
    return bool(_orig_minSubArraySum_spec(nums, output))
