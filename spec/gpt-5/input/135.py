def can_arrange_spec(arr, res):
    n = len(arr)
    if res == -1:
        for i in range(1, n):
            if arr[i] < arr[i - 1]:
                return False
        return True
    elif 1 <= res <= n - 1:
        if arr[res] >= arr[res - 1]:
            return False
        for j in range(res + 1, n):
            if arr[j] < arr[j - 1]:
                return False
        return True
    else:
        return False
