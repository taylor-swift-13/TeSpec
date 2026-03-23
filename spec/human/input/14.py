def _orig_problem_14_pre(input: str) -> bool:
    return True

def _orig_problem_14_spec(input: str, output: list) -> bool:
    if len(input) == 0:
        return output == []
    else:
        if len(output) != len(input):
            return False
        for i in range(len(input)):
            if len(output[i]) != i + 1:
                return False
            if not input.startswith(output[i]):
                return False
        return True

def problem_14_pre(string):
    return bool(_orig_problem_14_pre(string))

def problem_14_spec(string, output):
    return bool(_orig_problem_14_spec(string, output))
