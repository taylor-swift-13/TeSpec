def problem_0_pre(threshold):
    return threshold >= 0

def problem_0_spec(numbers, threshold, output):
    exists_close = False
    n = len(numbers)
    for i in range(n):
        for j in range(i + 1, n):
            if abs(numbers[i] - numbers[j]) <= threshold:
                exists_close = True
                break
        if exists_close:
            break
    return exists_close == output
