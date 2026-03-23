def _orig_problem_9_pre():
    return True

def _orig_problem_9_spec(input, output):
    if len(input) != len(output):
        return False
    for i in range(len(output)):
        for j in range(i + 1):
            if input[j] > output[i]:
                return False
        found = False
        for j in range(i + 1):
            if input[j] == output[i]:
                found = True
                break
        if not found:
            return False
    return True

def problem_9_pre(numbers):
    return bool(_orig_problem_9_pre())

def problem_9_spec(numbers, output):
    return bool(_orig_problem_9_spec(numbers, output))
