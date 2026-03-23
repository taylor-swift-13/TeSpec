def problem_42_pre(input):
    return True

def problem_42_spec(input, output):
    if len(input) != len(output):
        return False
    for i in range(len(output)):
        if output[i] != input[i] + 1:
            return False
    return True
