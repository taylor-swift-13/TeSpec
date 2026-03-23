def problem_26_pre(input):
    return True

def problem_26_spec(input, output):
    expected = [x for x in input if input.count(x) == 1]
    return output == expected
