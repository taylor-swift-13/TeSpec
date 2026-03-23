def _orig_sort_array_spec(array, output):
    if not array:
        return output == []
    first = array[0]
    last_val = array[-1]
    sum_val = first + last_val
    if sorted(array) != sorted(output):
        return False
    if sum_val % 2 != 0:
        return output == sorted(array)
    else:
        return output == sorted(array, reverse=True)

def sort_array_spec(array, output):
    return bool(_orig_sort_array_spec(array, output))
