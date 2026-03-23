def _orig_problem_5_pre(input, output):
    return True

# 旧版本参数顺序错误：把 output 和 d 传反了。
# def _orig_problem_5_spec(input, output, d):
#     if not input:
#         return output == []
#     n = len(input)
#     if len(output) != 2 * n - 1:
#         return False
#     for i in range(len(output)):
#         if i % 2 == 0:
#             if output[i] != input[i // 2]:
#                 return False
#         elif output[i] != d:
#             return False
#     return True

def _orig_problem_5_spec(input, d, output):
    if not input:
        return output == []
    n = len(input)
    if len(output) != 2 * n - 1:
        return False
    for i in range(len(output)):
        if i % 2 == 0:
            if output[i] != input[i // 2]:
                return False
        elif output[i] != d:
            return False
    return True

def problem_5_pre(numbers, delimeter):
    return bool(_orig_problem_5_pre(numbers, delimeter))

def problem_5_spec(numbers, delimeter, output):
    return bool(_orig_problem_5_spec(numbers, delimeter, output))
