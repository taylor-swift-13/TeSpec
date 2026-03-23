def digits(x: int) -> int:
    abs_x = abs(x)
    if abs_x < 10:
        return 1
    elif abs_x < 100:
        return 2
    elif abs_x < 1000:
        return 3
    elif abs_x < 10000:
        return 4
    else:
        return 5

def has_at_most_two_digits(x: int) -> bool:
    return digits(x) <= 2

def firstn_Z(n: int, l: list) -> list:
    if n <= 0:
        return []
    return l[:n]

def filter_sum(f, l: list) -> int:
    return sum(x for x in l if f(x))

def _orig_add_elements_spec(arr: list, k: int, output: int) -> bool:
    return output == filter_sum(has_at_most_two_digits, firstn_Z(k, arr))

def add_elements_spec(arr, k, output):
    return bool(_orig_add_elements_spec(arr, k, output))
