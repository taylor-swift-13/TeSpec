def _orig_rolling_max_spec(numbers, output):
    if len(numbers) != len(output):
        return False
    current_max = 0
    for i in range(len(numbers)):
        current_max = max(current_max, numbers[i])
        if output[i] != current_max:
            return False
    return True

def rolling_max_spec(numbers, output):
    return bool(_orig_rolling_max_spec(numbers, output))
