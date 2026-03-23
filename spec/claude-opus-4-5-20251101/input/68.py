def is_even(n):
    """Returns True if n is even, False otherwise."""
    return n % 2 == 0

def is_odd(n):
    """Returns True if n is odd, False otherwise."""
    return n % 2 != 0

def all_odd(arr):
    """Returns True if all elements in arr are odd."""
    return all(is_odd(x) for x in arr)

def has_even(arr):
    """Returns True if there is at least one even element in arr."""
    return any(is_even(x) for x in arr)

def is_smallest_even(arr, v):
    """Returns True if v is the smallest even element in arr."""
    if v not in arr:
        return False
    if not is_even(v):
        return False
    for x in arr:
        if is_even(x):
            if v > x:
                return False
    return True

def is_first_index_of(arr, v, idx):
    """Returns True if idx is the first index of v in arr."""
    if not isinstance(idx, int) or idx < 0:
        return False
    if idx >= len(arr):
        return False
    if arr[idx] != v:
        return False
    for j in range(idx):
        if arr[j] == v:
            return False
    return True

def _orig_pluck_spec(arr, output):
    """
    Returns True if output satisfies the pluck specification for arr.
    The spec states:
    1. If arr is empty, output must be empty.
    2. If arr is not empty and all elements are odd, output must be empty.
    3. If arr is not empty and has an even element, output must be [min_even, first_index_of_min_even].
    """
    if arr == []:
        if output != []:
            return False
    if arr != []:
        if all_odd(arr):
            if output != []:
                return False
    if arr != []:
        if has_even(arr):
            if not isinstance(output, list) or len(output) != 2:
                return False
            min_even_candidate = output[0]
            idx_candidate = output[1]
            if not is_smallest_even(arr, min_even_candidate):
                return False
            if not is_first_index_of(arr, min_even_candidate, idx_candidate):
                return False
    return True

def pluck_spec(arr, output):
    return bool(_orig_pluck_spec(arr, output))
