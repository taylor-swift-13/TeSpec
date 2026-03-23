def _orig_problem_33_pre(input):
    return True

# def _orig_problem_33_spec(input, output):
#     if len(input) != len(output):
#         return False
#     if sorted(input) != sorted(output):
#         return False
#     for i in range(len(input)):
#         if i % 3 != 0:
#             if output[i] != input[i]:
#                 return False
#     div_3_vals = [output[i] for i in range(len(output)) if i % 3 == 0]
#     if div_3_vals != sorted(div_3_vals):
#         return False
#     return True

def _same_multiset(left, right):
    if len(left) != len(right):
        return False
    remaining = list(right)
    for item in left:
        for idx, candidate in enumerate(remaining):
            if candidate == item:
                del remaining[idx]
                break
        else:
            return False
    return not remaining

def _orig_problem_33_spec(input, output):
    if len(input) != len(output):
        return False
    if not _same_multiset(input, output):
        return False
    for i in range(len(input)):
        if i % 3 != 0 and output[i] != input[i]:
            return False
    div_3_vals = [output[i] for i in range(len(output)) if i % 3 == 0]
    if div_3_vals != sorted(div_3_vals):
        return False
    return True

def problem_33_pre(l):
    return bool(_orig_problem_33_pre(l))

def problem_33_spec(l, output):
    return bool(_orig_problem_33_spec(l, output))
