def max_prefix_at(numbers, i):
    prefix = numbers[:i+1]
    if not prefix:
        return None
    return max(prefix)

def rolling_max_spec(numbers, result):
    if len(result) != len(numbers):
        return False
    for i in range(len(numbers)):
        if result[i] != max_prefix_at(numbers, i):
            return False
    return True
