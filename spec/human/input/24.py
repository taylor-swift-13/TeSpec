def _orig_problem_24_pre(input: int) -> bool:
    return input >= 2

def _orig_problem_24_spec(input: int, output: int) -> bool:
    if input < 0 or output < 0:
        return False
    if output == 0:
        return False
    if input % output != 0:
        return False
    if not output < input:
        return False
    for i in range(1, input):
        if input % i == 0:
            if i > output:
                return False
    return True

def problem_24_pre(n):
    return bool(_orig_problem_24_pre(n))

def problem_24_spec(n, output):
    return bool(_orig_problem_24_spec(n, output))
