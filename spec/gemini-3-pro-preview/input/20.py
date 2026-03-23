def _orig_find_closest_elements_spec(numbers, output):
    if len(numbers) < 2:
        return True
    (a, b) = output
    if a > b:
        return False
    n = len(numbers)
    found = False
    for i in range(n):
        for j in range(n):
            if i != j and numbers[i] == a and (numbers[j] == b):
                found = True
                break
        if found:
            break
    if not found:
        return False
    for i in range(n):
        for j in range(n):
            if i != j:
                if b - a > abs(numbers[i] - numbers[j]):
                    return False
    return True

def find_closest_elements_spec(numbers, output):
    return bool(_orig_find_closest_elements_spec(numbers, output))
