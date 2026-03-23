from collections import Counter

def count_set_bits_pos(p):
    return bin(p).count('1')

def count_set_bits(z):
    return bin(abs(z)).count('1')

def sort_criteria(x, y):
    cx = count_set_bits(x)
    cy = count_set_bits(y)
    return (cx < cy) or (cx == cy and x <= y)

def _orig_sort_array_spec(arr, output):
    if Counter(arr) != Counter(output):
        return False
    for i in range(len(output)):
        for j in range(i + 1, len(output)):
            if not sort_criteria(output[i], output[j]):
                return False
    return True

def sort_array_spec(arr, output):
    return bool(_orig_sort_array_spec(arr, output))
