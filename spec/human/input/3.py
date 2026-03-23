def _orig_problem_3_pre(l):
    return True

def _orig_problem_3_spec(l, output):
    balance = 0
    below_zero = False
    for x in l:
        balance += x
        if balance < 0:
            below_zero = True
            break
    return below_zero == output

def problem_3_pre(operations):
    return bool(_orig_problem_3_pre(operations))

def problem_3_spec(operations, output):
    return bool(_orig_problem_3_spec(operations, output))
