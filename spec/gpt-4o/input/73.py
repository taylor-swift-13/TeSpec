def smallest_change_spec(arr, cnt):
    arr_reversed = arr[::-1]
    diff_count = 0
    for i in range(len(arr) // 2):
        if arr[i] != arr_reversed[i]:
            diff_count += 1
    return cnt == diff_count
