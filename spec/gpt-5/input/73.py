def _orig_smallest_change_spec(arr, output):
    half = len(arr) // 2
    first = arr[:half]
    rfirst = list(reversed(arr))[:half]
    mismatches = sum((1 for (p1, p2) in zip(first, rfirst) if p1 != p2))
    return output == mismatches

def smallest_change_spec(arr, output):
    return bool(_orig_smallest_change_spec(arr, output))
