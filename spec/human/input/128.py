def _orig_problem_128_pre(arr):
    return True

def _orig_problem_128_spec(arr, output):
    if len(arr) == 0:
        return output is None
    sum_mags = sum((abs(x) for x in arr))
    prod_sgs = 1
    for x in arr:
        if x > 0:
            prod_sgs *= 1
        elif x < 0:
            prod_sgs *= -1
        else:
            prod_sgs *= 0
    expected = sum_mags * prod_sgs
    return output == expected

def problem_128_pre(arr):
    return bool(_orig_problem_128_pre(arr))

def problem_128_spec(arr, output):
    return bool(_orig_problem_128_spec(arr, output))
