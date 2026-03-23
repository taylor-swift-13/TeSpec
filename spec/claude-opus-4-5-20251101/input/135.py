def nth_Z(l, n, default):
    """
    Returns the element at index n in list l, or default if out of bounds.
    """
    if 0 <= n < len(l):
        return l[n]
    return default

def is_valid_index(arr, i):
    """
    Checks if i is a valid index where the array is decreasing.
    (i > 0) /\ (i < length arr) /\ arr[i] < arr[i-1]
    """
    if not (i > 0 and i < len(arr)):
        return False
    return nth_Z(arr, i, 0) < nth_Z(arr, i - 1, 0)

def no_larger_valid_index(arr, i):
    """
    Checks if there are no valid indices j greater than i.
    forall j > i, j < length arr -> arr[j] >= arr[j-1]
    """
    for j in range(i + 1, len(arr)):
        if not (nth_Z(arr, j, 0) >= nth_Z(arr, j - 1, 0)):
            return False
    return True

def no_valid_index(arr):
    """
    Checks if there are no valid indices at all.
    forall i > 0, i < length arr -> arr[i] >= arr[i-1]
    """
    for i in range(1, len(arr)):
        if not (nth_Z(arr, i, 0) >= nth_Z(arr, i - 1, 0)):
            return False
    return True

def can_arrange_spec(arr, result):
    """
    Returns True if result is the largest valid index i, or -1 if no valid index exists.
    """
    # Case 1: exists i such that is_valid_index arr i /\ no_larger_valid_index arr i /\ result = i
    for i in range(1, len(arr)):
        if is_valid_index(arr, i) and no_larger_valid_index(arr, i):
            if result == i:
                return True
    
    # Case 2: no_valid_index arr /\ result = -1
    if no_valid_index(arr) and result == -1:
        return True
        
    return False
