def problem_120_pre(arr, k):
    if not (1 <= len(arr) <= 1000):
        return False
    if not all(-1000 <= z <= 1000 for z in arr):
        return False
    if not (0 <= k <= len(arr)):
        return False
    return True

def problem_120_spec(arr, k, res):
    if len(res) != k:
        return False
    if res != sorted(res):
        return False
    
    expected_res = sorted(arr)[len(arr) - k:] if k > 0 else []
    return res == expected_res
