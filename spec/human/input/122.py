def is_at_most_two_digits(n: int) -> bool:
    return -100 < n < 100

def problem_122_pre(arr: list, k: int) -> bool:
    return 1 <= len(arr) <= 100 and 1 <= k <= len(arr)

def problem_122_spec(arr: list, k: int, result: int) -> bool:
    first_k_elements = arr[:k]
    filtered_elements = [x for x in first_k_elements if is_at_most_two_digits(x)]
    return result == sum(filtered_elements)
