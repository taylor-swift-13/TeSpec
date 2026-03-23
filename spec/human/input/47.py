def _orig_problem_47_pre(input):
    return len(input) > 0

def _orig_problem_47_spec(input, output):
    if len(input) == 0:
        return True
    sorted_input = sorted(input)
    n = len(input)
    halflen = n // 2

    def nth(lst, idx, default=0.0):
        if 0 <= idx < len(lst):
            return lst[idx]
        return default
    if n % 2 == 1:
        expected = nth(sorted_input, halflen, 0.0)
    else:
        idx1 = halflen
        idx2 = max(0, halflen - 1)
        expected = (nth(sorted_input, idx1, 0.0) + nth(sorted_input, idx2, 0.0)) / 2.0
    return float(output) == expected

def problem_47_pre(l):
    return bool(_orig_problem_47_pre(l))

def problem_47_spec(l, output):
    return bool(_orig_problem_47_spec(l, output))
