def sort_array_spec(array, res):
    if not array:
        return res == []
    
    first = array[0]
    last_val = array[-1]
    sum_val = first + last_val
    
    # Check if res is a permutation of array
    if sorted(array) != sorted(res):
        return False
        
    # Check sortedness based on the parity of sum_val
    if sum_val % 2 != 0:
        # Odd: sorted ascending (Z.le)
        return res == sorted(array)
    else:
        # Even: sorted descending (Z.ge)
        return res == sorted(array, reverse=True)
