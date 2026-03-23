def problem_33_pre(input):
    return True

def problem_33_spec(input, output):
    # 1. input and output must have the same length
    if len(input) != len(output):
        return False
        
    # 1. input must be a permutation of output
    if sorted(input) != sorted(output):
        return False

    # 2. If index i is not divisible by 3, output[i] must equal input[i]
    for i in range(len(input)):
        if i % 3 != 0:
            if output[i] != input[i]:
                return False

    # 3. Elements in output at indices divisible by 3 must be sorted (non-decreasing)
    div_3_vals = [output[i] for i in range(len(output)) if i % 3 == 0]
    if div_3_vals != sorted(div_3_vals):
        return False

    return True
