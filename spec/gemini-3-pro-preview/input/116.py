from collections import Counter

def count_set_bits_pos(p):
    return bin(p).count('1')

def count_set_bits(z):
    return bin(abs(z)).count('1')

def sort_criteria(x, y):
    cx = count_set_bits(x)
    cy = count_set_bits(y)
    return (cx < cy) or (cx == cy and x <= y)

def sort_array_spec(arr, res):
    if Counter(arr) != Counter(res):
        return False
    for i in range(len(res)):
        for j in range(i + 1, len(res)):
            if not sort_criteria(res[i], res[j]):
                return False
    return True
