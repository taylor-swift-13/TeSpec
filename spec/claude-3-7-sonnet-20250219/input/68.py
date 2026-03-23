def is_even(n):
    return n % 2 == 0

def pluck_spec(arr, result):
    evens = [(x, i) for i, x in enumerate(arr) if is_even(x)]
    if not evens:
        return result == []
    
    min_even, idx = min(evens, key=lambda pair: (pair[0], pair[1]))
    return result == [min_even, idx]
