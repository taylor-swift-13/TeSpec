def problem_5_pre(input, output):
    return True

def problem_5_spec(input, output, d):
    if not input:
        return output == []

    n = len(input)
    if len(output) != 2 * n - 1:
        return False

    for i in range(len(output)):
        if i % 2 == 0:
            if output[i] != input[i // 2]:
                return False
        else:
            if output[i] != d:
                return False
                
    return True
