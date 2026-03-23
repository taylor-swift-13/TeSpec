def count_diff(l1, l2, acc):
    for x, y in zip(l1, l2):
        if x != y:
            acc += 1
    return acc

def smallest_change_impl(arr):
    length = len(arr)
    half_len = length // 2
    first_half = arr[:half_len]
    second_half = arr[length - half_len:]
    return count_diff(first_half, list(reversed(second_half)), 0)

def _orig_problem_73_pre(arr):
    return True

def _orig_problem_73_spec(arr, n):
    return n == smallest_change_impl(arr)

def problem_73_pre(arr):
    return bool(_orig_problem_73_pre(arr))

def problem_73_spec(arr, output):
    return bool(_orig_problem_73_spec(arr, output))
