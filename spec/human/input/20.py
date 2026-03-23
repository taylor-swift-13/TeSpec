def _orig_problem_20_pre(input):
    return len(input) >= 2

def _orig_problem_20_spec(input, output):
    (output1, output2) = output
    if len(input) < 2:
        return False
    if output1 not in input or output2 not in input:
        return False
    if output1 > output2:
        return False
    diff = abs(output1 - output2)
    for i in range(len(input)):
        for j in range(len(input)):
            if i != j:
                if diff > abs(input[i] - input[j]):
                    return False
    return True

def problem_20_pre(numbers):
    return bool(_orig_problem_20_pre(numbers))

def problem_20_spec(numbers, output):
    return bool(_orig_problem_20_spec(numbers, output))
