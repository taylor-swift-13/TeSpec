def match_at(i, input, substr):
    if len(substr) == 0:
        return False
    if i + len(substr) > len(input):
        return False
    for j in range(len(substr)):
        if input[i + j] != substr[j]:
            return False
    return True

def _orig_problem_18_pre(input, substring):
    return True

def _orig_problem_18_spec(input, substring, output):
    count = 0
    if len(substring) > 0:
        for i in range(len(input) - len(substring) + 1):
            if match_at(i, input, substring):
                count += 1
    return output == count

def problem_18_pre(string, substring):
    return bool(_orig_problem_18_pre(string, substring))

def problem_18_spec(string, substring, output):
    return bool(_orig_problem_18_spec(string, substring, output))
