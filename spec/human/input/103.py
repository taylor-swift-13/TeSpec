def to_binary_p(p: int) -> str:
    if p == 1:
        return "1"
    elif p % 2 == 0:
        return to_binary_p(p // 2) + "0"
    else:
        return to_binary_p(p // 2) + "1"

def to_binary(n: int) -> str:
    if n == 0:
        return "0b0"
    elif n > 0:
        return "0b" + to_binary_p(n)
    else:
        return "Error: Negative numbers not supported"

def rounded_avg_impl(n: int, m: int):
    if n > m:
        return -1
    else:
        return to_binary(round((n + m) / 2))

def _orig_problem_103_pre(n: int, m: int) -> bool:
    return n > 0 and m > 0

def _orig_problem_103_spec(n: int, m: int, output) -> bool:
    return output == rounded_avg_impl(n, m)

def problem_103_pre(n, m):
    return bool(_orig_problem_103_pre(n, m))

def problem_103_spec(n, m, output):
    return bool(_orig_problem_103_spec(n, m, output))
