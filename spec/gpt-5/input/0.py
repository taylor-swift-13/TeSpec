def _orig_has_close_elements_spec(numbers, threshold, output):
    p_holds = False
    n = len(numbers)
    for i in range(n):
        for j in range(i + 1, n):
            if abs(numbers[i] - numbers[j]) < threshold:
                p_holds = True
                break
        if p_holds:
            break
    return output == p_holds

def has_close_elements_spec(numbers, threshold, output):
    return bool(_orig_has_close_elements_spec(numbers, threshold, output))
