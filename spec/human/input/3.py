def problem_3_pre(l):
    return True

def problem_3_spec(l, output):
    balance = 0
    below_zero = False
    for x in l:
        balance += x
        if balance < 0:
            below_zero = True
            break
    return below_zero == output
