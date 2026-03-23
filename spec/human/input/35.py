def problem_35_pre(input):
    return len(input) > 0

def problem_35_spec(input, output):
    return (output in input) and all(x <= output for x in input)
