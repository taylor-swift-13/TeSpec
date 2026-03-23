def can_arrange_spec(arr, res):
    if res == -1:
        for i in range(1, len(arr)):
            if arr[i] < arr[i - 1]:
                return False
        return True
    elif 0 < res < len(arr):
        if arr[res] < arr[res - 1]:
            for k in range(res + 1, len(arr)):
                if arr[k] < arr[k - 1]:
                    return False
            return True
    return False
