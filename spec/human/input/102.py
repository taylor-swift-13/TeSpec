def problem_102_pre(x: int, y: int) -> bool:
    return x > 0 and y > 0

def problem_102_spec(x: int, y: int, res: int) -> bool:
    if x > y:
        expected = -1
    else:
        largest_even = y if y % 2 == 0 else y - 1
        if largest_even >= x:
            expected = largest_even
        else:
            expected = -1
    return res == expected
