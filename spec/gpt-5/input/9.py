def max_prefix_at(numbers, i):
    prefix = numbers[:i+1]
    if not prefix:
        return None
    return max(prefix)

def _orig_rolling_max_spec(numbers, output):
    if len(output) != len(numbers):
        return False
    for i in range(len(numbers)):
        if output[i] != max_prefix_at(numbers, i):
            return False
    return True

def rolling_max_spec(numbers, output):
    return bool(_orig_rolling_max_spec(numbers, output))
