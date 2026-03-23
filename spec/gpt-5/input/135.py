def _orig_can_arrange_spec(arr, output):
    n = len(arr)
    if output == -1:
        for i in range(1, n):
            if arr[i] < arr[i - 1]:
                return False
        return True
    elif 1 <= output <= n - 1:
        if arr[output] >= arr[output - 1]:
            return False
        for j in range(output + 1, n):
            if arr[j] < arr[j - 1]:
                return False
        return True
    else:
        return False

def can_arrange_spec(arr, output):
    return bool(_orig_can_arrange_spec(arr, output))
