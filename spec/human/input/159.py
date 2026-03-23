def _orig_problem_159_pre(number, need, remaining):
    return 0 <= number <= 1000 and 0 <= need <= 1000 and (0 <= remaining <= 1000)

def _orig_problem_159_spec(number, need, remaining, output):
    if remaining >= need:
        return output == [number + need, remaining - need]
    else:
        return output == [number + remaining, 0]

def problem_159_pre(number, need, remaining):
    return bool(_orig_problem_159_pre(number, need, remaining))

def problem_159_spec(number, need, remaining, output):
    return bool(_orig_problem_159_spec(number, need, remaining, output))
