def _orig_problem_120_pre(arr, k):
    if not 1 <= len(arr) <= 1000:
        return False
    if not all((-1000 <= z <= 1000 for z in arr)):
        return False
    if not 0 <= k <= len(arr):
        return False
    return True

def _orig_problem_120_spec(arr, k, output):
    if len(output) != k:
        return False
    if output != sorted(output):
        return False
    expected_res = sorted(arr)[len(arr) - k:] if k > 0 else []
    return output == expected_res

def problem_120_pre(arr, k):
    return bool(_orig_problem_120_pre(arr, k))

def problem_120_spec(arr, k, output):
    return bool(_orig_problem_120_spec(arr, k, output))
