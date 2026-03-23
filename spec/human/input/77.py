def _orig_problem_77_pre(a: int) -> bool:
    return True

def _orig_problem_77_spec(a: int, b: bool) -> bool:
    abs_a = abs(a)
    low = 0
    high = abs_a
    is_c = False
    while low <= high:
        mid = (low + high) // 2
        mid3 = mid * mid * mid
        if mid3 == abs_a:
            is_c = True
            break
        elif mid3 < abs_a:
            low = mid + 1
        else:
            high = mid - 1
    return b == is_c

def problem_77_pre(a):
    return bool(_orig_problem_77_pre(a))

def problem_77_spec(a, output):
    return bool(_orig_problem_77_spec(a, output))
