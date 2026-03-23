def is_palindrome(arr):
    return arr == arr[::-1]

def count_mismatches(l1, l2, n):
    mismatches = 0
    for i in range(min(n, len(l1), len(l2))):
        if l1[i] != l2[i]:
            mismatches += 1
    return mismatches

def smallest_change_spec(arr, result):
    arr_reversed = arr[::-1]
    half_len = len(arr) // 2
    return result == count_mismatches(arr, arr_reversed, half_len)
