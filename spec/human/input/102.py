def _orig_problem_102_pre(x: int, y: int) -> bool:
    return x > 0 and y > 0

def _orig_problem_102_spec(x: int, y: int, output: int) -> bool:
    if x > y:
        expected = -1
    else:
        largest_even = y if y % 2 == 0 else y - 1
        if largest_even >= x:
            expected = largest_even
        else:
            expected = -1
    return output == expected

def problem_102_pre(x, y):
    return bool(_orig_problem_102_pre(x, y))

def problem_102_spec(x, y, output):
    return bool(_orig_problem_102_spec(x, y, output))
