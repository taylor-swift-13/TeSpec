def _orig_rolling_max_spec(numbers, output):
    if len(numbers) != len(output):
        return False
    for i in range(len(numbers)):
        prefix = numbers[:i + 1]
        current_max = output[i]
        if current_max not in prefix:
            return False
        for x in prefix:
            if x > current_max:
                return False
    return True

def rolling_max_spec(numbers, output):
    return bool(_orig_rolling_max_spec(numbers, output))
