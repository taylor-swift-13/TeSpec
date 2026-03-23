def _orig_problem_74_pre(lst1, lst2):
    return True

def _orig_problem_74_spec(lst1, lst2, output):
    sum1 = sum((len(s) for s in lst1))
    sum2 = sum((len(s) for s in lst2))
    if sum1 <= sum2:
        return output == lst1
    else:
        return output == lst2

def problem_74_pre(lst1, lst2):
    return bool(_orig_problem_74_pre(lst1, lst2))

def problem_74_spec(lst1, lst2, output):
    return bool(_orig_problem_74_spec(lst1, lst2, output))
