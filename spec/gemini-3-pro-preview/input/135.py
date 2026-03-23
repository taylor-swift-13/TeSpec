def _orig_can_arrange_spec(arr, output):
    if output == -1:
        for i in range(1, len(arr)):
            if arr[i] < arr[i - 1]:
                return False
        return True
    elif 0 < output < len(arr):
        if arr[output] < arr[output - 1]:
            for k in range(output + 1, len(arr)):
                if arr[k] < arr[k - 1]:
                    return False
            return True
    return False

def can_arrange_spec(arr, output):
    return bool(_orig_can_arrange_spec(arr, output))
