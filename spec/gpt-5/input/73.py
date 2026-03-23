def smallest_change_spec(arr, res):
    half = len(arr) // 2
    first = arr[:half]
    rfirst = list(reversed(arr))[:half]
    
    mismatches = sum(1 for p1, p2 in zip(first, rfirst) if p1 != p2)
    return res == mismatches
