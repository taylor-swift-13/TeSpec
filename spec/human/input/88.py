def _orig_problem_88_pre(input):
    return True

def _orig_problem_88_spec(input, output):
    if sorted(input) != sorted(output):
        return False
    if len(input) == 0:
        return output == []
    elif len(input) == 1:
        return output == input
    else:
        h = input[0]
        last_elem = input[-1]
        if (h + last_elem) % 2 == 1:
            return output == sorted(input)
        else:
            return output == sorted(input, reverse=True)

def problem_88_pre(array):
    return bool(_orig_problem_88_pre(array))

def problem_88_spec(array, output):
    return bool(_orig_problem_88_spec(array, output))
