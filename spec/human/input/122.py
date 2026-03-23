def is_at_most_two_digits(n: int) -> bool:
    return -100 < n < 100

def _orig_problem_122_pre(arr: list, k: int) -> bool:
    return 1 <= len(arr) <= 100 and 1 <= k <= len(arr)

def _orig_problem_122_spec(arr: list, k: int, output: int) -> bool:
    first_k_elements = arr[:k]
    filtered_elements = [x for x in first_k_elements if is_at_most_two_digits(x)]
    return output == sum(filtered_elements)

def problem_122_pre(arr, k):
    return bool(_orig_problem_122_pre(arr, k))

def problem_122_spec(arr, k, output):
    return bool(_orig_problem_122_spec(arr, k, output))
